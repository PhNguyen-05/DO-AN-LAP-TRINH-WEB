package vn.iotstar.starshop.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.util.EmailUtil;
import vn.iotstar.starshop.util.JwtUtil;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private EmailUtil emailUtil; // ✅ tiện ích gửi mail (bạn sẽ có file này riêng)

    // ========== LOGIN ==========
    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "error", required = false) String error,
                                Model model) {
        if (error != null) {
            model.addAttribute("message", error);
        }
        return "login"; // ✅ chỉ cần tên file, không thêm đường dẫn
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam("identifier") String identifier,
                              @RequestParam("password") String password,
                              HttpServletRequest request,
                              HttpServletResponse response,
                              Model model) {

        User user = userService.authenticate(identifier, password);

        if (user == null) {
            model.addAttribute("message", "⚠️ Email hoặc mật khẩu không đúng hoặc tài khoản bị khóa.");
            return "login"; // ✅
        }

        // Sinh JWT token
        Map<String, Object> claims = new HashMap<>();
        claims.put("role", user.getRole());
        claims.put("userId", user.getId());
        String token = jwtUtil.generateToken(user.getEmail(), claims);

        // Lưu JWT cookie HttpOnly
        Cookie jwtCookie = new Cookie("starshop-jwt", token);
        jwtCookie.setHttpOnly(true);
        jwtCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        jwtCookie.setMaxAge(3600);
        response.addCookie(jwtCookie);

        // Lưu session
        HttpSession session = request.getSession(true);
        session.setAttribute("currentUser", user);

        // Điều hướng
        switch (user.getRole()) {
            case "Admin":
                return "redirect:/admin/dashboard";
            case "Employee":
                return "redirect:/admin/products";
            default:
                return "redirect:/home";
        }
    }

    // ========== LOGOUT ==========
    @GetMapping("/logout")
    public String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Cookie jwtCookie = new Cookie("starshop-jwt", "");
        jwtCookie.setHttpOnly(true);
        jwtCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        jwtCookie.setMaxAge(0);
        response.addCookie(jwtCookie);

        return "redirect:/auth/login";
    }

    // ========== REGISTER ==========
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("user", new User());
        return "register"; // ✅ chỉ cần tên view
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("user") User user, Model model) {
        try {
            userService.register(user);
            model.addAttribute("success", "🎉 Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/auth/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("message", e.getMessage());
            return "register"; // ✅
        } catch (Exception e) {
            model.addAttribute("message", "❌ Lỗi không xác định: " + e.getMessage());
            return "register"; // ✅
        }
    }
    
 // =================== QUÊN MẬT KHẨU ===================
    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email,
                                       HttpServletRequest request,
                                       Model model) {

        User user = userService.findByEmail(email);
        if (user == null) {
            model.addAttribute("message", "❌ Email không tồn tại trong hệ thống.");
            return "forgot-password";
        }

     // Sinh JWT reset token có hạn 5 phút
        Map<String, Object> claims = new HashMap<>();
        claims.put("purpose", "reset-password");
        claims.put("generatedAt", Instant.now().toString());
        long expireMillis = 5 * 60 * 1000L;
        String token = jwtUtil.generateToken(email, claims, expireMillis);
        
        // ✅ Tạo link reset
        String baseUrl = request.getRequestURL().toString()
                .replace(request.getRequestURI(), request.getContextPath());
        String resetLink = baseUrl + "/auth/reset-password?token=" + token;

        // ✅ Gửi email (nếu bạn có EmailUtil)
        emailUtil.sendPasswordResetEmail(email, resetLink);

        model.addAttribute("success",
                "✅ Một liên kết đặt lại mật khẩu đã được gửi đến email của bạn. Liên kết có hiệu lực trong 5 phút.");
        model.addAttribute("expireSeconds", expireMillis / 1000);
        return "forgot-password";
    }

    // =================== HIỂN THỊ TRANG ĐẶT LẠI MẬT KHẨU ===================
    @GetMapping("/reset-password")
    public String showResetPasswordPage(@RequestParam("token") String token, Model model) {
        try {
            Jws<Claims> parsed = jwtUtil.validateToken(token);
            Claims claims = parsed.getBody();

            if (!"reset-password".equals(claims.get("purpose"))) {
                throw new JwtException("Mục đích token không hợp lệ.");
            }

            model.addAttribute("token", token);
            model.addAttribute("email", claims.getSubject());
            return "reset-password";

        } catch (JwtException e) {
            model.addAttribute("message", "❌ Liên kết không hợp lệ hoặc đã hết hạn.");
            return "forgot-password";
        }
    }

    // =================== XỬ LÝ LƯU MẬT KHẨU MỚI ===================
    @PostMapping("/reset-password")
    public String handleResetPassword(@RequestParam("token") String token,
                                      @RequestParam("newPassword") String newPassword,
                                      HttpSession session,
                                      Model model) {
        try {
            Jws<Claims> parsed = jwtUtil.validateToken(token);
            Claims claims = parsed.getBody();

            if (!"reset-password".equals(claims.get("purpose"))) {
                throw new JwtException("Mục đích token không hợp lệ.");
            }

            String email = claims.getSubject();
            User user = userService.findByEmail(email);

            if (user == null) {
                model.addAttribute("message", "❌ Không tìm thấy tài khoản.");
                return "reset-password";
            }

            // ✅ Cập nhật mật khẩu (nếu có PasswordEncoder thì encode)
            user.setPasswordHash(newPassword);
            userService.save(user);

            model.addAttribute("success", "🎉 Mật khẩu của bạn đã được thay đổi thành công.");
            return "redirect:/auth/login";

        } catch (JwtException e) {
            model.addAttribute("message", "❌ Liên kết không hợp lệ hoặc đã hết hạn.");
            return "reset-password";
        }
    }
}
