//package vn.iotstar.starshop.controller;
//
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.Jws;
//import io.jsonwebtoken.JwtException;
//import vn.iotstar.starshop.entity.User;
//import vn.iotstar.starshop.service.UserService;
//import vn.iotstar.starshop.util.EmailUtil;
//import vn.iotstar.starshop.util.JwtUtil;
//
//import java.time.Instant;
//import java.util.HashMap;
//import java.util.Map;
//
//@Controller
//@RequestMapping("/auth")
//public class AuthController {
//
//    @Autowired
//    private UserService userService;
//
//    @Autowired
//    private JwtUtil jwtUtil;
//    
//    @Autowired
//    private EmailUtil emailUtil; // ✅ tiện ích gửi mail (bạn sẽ có file này riêng)
//
//    // ========== LOGIN ==========
//    @GetMapping("/login")
//    public String showLoginPage(@RequestParam(value = "error", required = false) String error,
//                                Model model) {
//        if (error != null) {
//            model.addAttribute("message", error);
//        }
//        return "login"; // ✅ chỉ cần tên file, không thêm đường dẫn
//    }
//
//    @PostMapping("/login")
//    public String handleLogin(@RequestParam("identifier") String identifier,
//                              @RequestParam("password") String password,
//                              HttpServletRequest request,
//                              HttpServletResponse response,
//                              Model model) {
//
//        User user = userService.authenticate(identifier, password);
//
//        if (user == null) {
//            model.addAttribute("message", "⚠️ Email hoặc mật khẩu không đúng hoặc tài khoản bị khóa.");
//            return "login"; // ✅
//        }
//
//        // Sinh JWT token
//        Map<String, Object> claims = new HashMap<>();
//        claims.put("role", user.getRole());
//        claims.put("userId", user.getId());
//        String token = jwtUtil.generateToken(user.getEmail(), claims);
//
//        // Lưu JWT cookie HttpOnly
//        Cookie jwtCookie = new Cookie("starshop-jwt", token);
//        jwtCookie.setHttpOnly(true);
//        jwtCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
//        jwtCookie.setMaxAge(3600);
//        response.addCookie(jwtCookie);
//
//        // Lưu session
//        HttpSession session = request.getSession(true);
//        session.setAttribute("currentUser", user);
//
//        // Điều hướng
//        switch (user.getRole()) {
//            case "Admin":
//                return "redirect:/admin/dashboard";
//            case "Employee":
//                return "redirect:/admin/products";
//            default:
//                return "redirect:/home";
//        }
//    }
//
//    // ========== LOGOUT ==========
//    @GetMapping("/logout")
//    public String handleLogout(HttpServletRequest request, HttpServletResponse response) {
//        HttpSession session = request.getSession(false);
//        if (session != null) {
//            session.invalidate();
//        }
//
//        Cookie jwtCookie = new Cookie("starshop-jwt", "");
//        jwtCookie.setHttpOnly(true);
//        jwtCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
//        jwtCookie.setMaxAge(0);
//        response.addCookie(jwtCookie);
//
//        return "redirect:/auth/login";
//    }
//
//    // ========== REGISTER ==========
//    @GetMapping("/register")
//    public String showRegisterPage(Model model) {
//        model.addAttribute("user", new User());
//        return "register"; // ✅ chỉ cần tên view
//    }
//
//    @PostMapping("/register")
//    public String handleRegister(@ModelAttribute("user") User user, Model model) {
//        try {
//            userService.register(user);
//            model.addAttribute("success", "🎉 Đăng ký thành công! Vui lòng đăng nhập.");
//            return "redirect:/auth/login";
//        } catch (IllegalArgumentException e) {
//            model.addAttribute("message", e.getMessage());
//            return "register"; // ✅
//        } catch (Exception e) {
//            model.addAttribute("message", "❌ Lỗi không xác định: " + e.getMessage());
//            return "register"; // ✅
//        }
//    }
//    
// // =================== QUÊN MẬT KHẨU ===================
//    @GetMapping("/forgot-password")
//    public String showForgotPasswordPage() {
//        return "forgot-password";
//    }
//
//    @PostMapping("/forgot-password")
//    public String handleForgotPassword(@RequestParam("email") String email,
//                                       HttpServletRequest request,
//                                       Model model) {
//
//        User user = userService.findByEmail(email);
//        if (user == null) {
//            model.addAttribute("message", "❌ Email không tồn tại trong hệ thống.");
//            return "forgot-password";
//        }
//
//     // Sinh JWT reset token có hạn 5 phút
//        Map<String, Object> claims = new HashMap<>();
//        claims.put("purpose", "reset-password");
//        claims.put("generatedAt", Instant.now().toString());
//        long expireMillis = 5 * 60 * 1000L;
//        String token = jwtUtil.generateToken(email, claims, expireMillis);
//        
//        // ✅ Tạo link reset
//        String baseUrl = request.getRequestURL().toString()
//                .replace(request.getRequestURI(), request.getContextPath());
//        String resetLink = baseUrl + "/auth/reset-password?token=" + token;
//
//        // ✅ Gửi email (nếu bạn có EmailUtil)
//        emailUtil.sendPasswordResetEmail(email, resetLink);
//
//        model.addAttribute("success",
//                "✅ Một liên kết đặt lại mật khẩu đã được gửi đến email của bạn. Liên kết có hiệu lực trong 5 phút.");
//        model.addAttribute("expireSeconds", expireMillis / 1000);
//        return "forgot-password";
//    }
//
//    // =================== HIỂN THỊ TRANG ĐẶT LẠI MẬT KHẨU ===================
//    @GetMapping("/reset-password")
//    public String showResetPasswordPage(@RequestParam("token") String token, Model model) {
//        try {
//            Jws<Claims> parsed = jwtUtil.validateToken(token);
//            Claims claims = parsed.getBody();
//
//            if (!"reset-password".equals(claims.get("purpose"))) {
//                throw new JwtException("Mục đích token không hợp lệ.");
//            }
//
//            model.addAttribute("token", token);
//            model.addAttribute("email", claims.getSubject());
//            return "reset-password";
//
//        } catch (JwtException e) {
//            model.addAttribute("message", "❌ Liên kết không hợp lệ hoặc đã hết hạn.");
//            return "forgot-password";
//        }
//    }
//
//    // =================== XỬ LÝ LƯU MẬT KHẨU MỚI ===================
//    @PostMapping("/reset-password")
//    public String handleResetPassword(@RequestParam("token") String token,
//                                      @RequestParam("newPassword") String newPassword,
//                                      HttpSession session,
//                                      Model model) {
//        try {
//            Jws<Claims> parsed = jwtUtil.validateToken(token);
//            Claims claims = parsed.getBody();
//
//            if (!"reset-password".equals(claims.get("purpose"))) {
//                throw new JwtException("Mục đích token không hợp lệ.");
//            }
//
//            String email = claims.getSubject();
//            User user = userService.findByEmail(email);
//
//            if (user == null) {
//                model.addAttribute("message", "❌ Không tìm thấy tài khoản.");
//                return "reset-password";
//            }
//
//            // ✅ Cập nhật mật khẩu (nếu có PasswordEncoder thì encode)
//            user.setPasswordHash(newPassword);
//            userService.save(user);
//
//            model.addAttribute("success", "🎉 Mật khẩu của bạn đã được thay đổi thành công.");
//            return "redirect:/auth/login";
//
//        } catch (JwtException e) {
//            model.addAttribute("message", "❌ Liên kết không hợp lệ hoặc đã hết hạn.");
//            return "reset-password";
//        }
//    }
//}








// File: AuthController.java
package vn.iotstar.starshop.controller;

import java.time.Instant;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.util.EmailUtil;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailUtil emailUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ======================= ĐĂNG NHẬP =======================
    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "error", required = false) String error,
                                @RequestParam(value = "logout", required = false) String logout,
                                @RequestParam(value = "registered", required = false) String registered,
                                Model model) {
        if (error != null) model.addAttribute("message", "❌ Sai thông tin đăng nhập hoặc tài khoản bị khóa.");
        if (logout != null) model.addAttribute("message", "✅ Đăng xuất thành công!");
        if (registered != null) model.addAttribute("message", "🎉 Đăng ký thành công! Hãy đăng nhập.");
        return "login";
    }

    // ======================= ĐĂNG KÝ =======================
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("user") User user, HttpSession session, Model model) {
        try {
            user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash()));
            user.setActive(false);

            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("otp_register", otp);
            session.setAttribute("pending_user", user);
            session.setAttribute("otp_expire", Instant.now().plusSeconds(300));

            emailUtil.sendOtpEmail(user.getEmail(), otp);

            model.addAttribute("message", "📩 Mã OTP đã được gửi đến email của bạn. Vui lòng nhập để kích hoạt tài khoản.");
            return "verify-otp";
        } catch (Exception e) {
            model.addAttribute("message", "❌ Lỗi: " + e.getMessage());
            return "register";
        }
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("otp") String otp, HttpSession session, Model model) {
        String sessionOtp = (String) session.getAttribute("otp_register");
        Instant expire = (Instant) session.getAttribute("otp_expire");
        User pendingUser = (User) session.getAttribute("pending_user");

        if (pendingUser == null || sessionOtp == null) {
            model.addAttribute("message", "❌ Phiên đăng ký không hợp lệ. Vui lòng đăng ký lại.");
            return "register";
        }

        if (Instant.now().isAfter(expire)) {
            model.addAttribute("message", "⏰ Mã OTP đã hết hạn. Vui lòng đăng ký lại.");
            return "register";
        }

        if (!otp.equals(sessionOtp)) {
            model.addAttribute("message", "❌ Mã OTP không chính xác.");
            return "verify-otp";
        }

        pendingUser.setActive(true);
        userService.save(pendingUser);

        session.removeAttribute("otp_register");
        session.removeAttribute("pending_user");
        session.removeAttribute("otp_expire");

        return "redirect:/auth/login?registered";
    }

    // ======================= QUÊN MẬT KHẨU — BƯỚC 1 =======================
    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email, HttpSession session, Model model) {
        User user = userService.findByEmail(email);
        if (user == null) {
            model.addAttribute("message", "❌ Email không tồn tại trong hệ thống.");
            return "forgot-password";
        }

        String otp = String.format("%06d", new Random().nextInt(999999));
        session.setAttribute("otp_reset", otp);
        session.setAttribute("reset_email", email);
        session.setAttribute("otp_expire", Instant.now().plusSeconds(300));

        emailUtil.sendOtpEmail(email, otp);

        model.addAttribute("email", email);
        model.addAttribute("message", "📩 Mã OTP đặt lại mật khẩu đã được gửi đến email của bạn.");
        return "verify-reset-otp";
    }

    // ======================= QUÊN MẬT KHẨU — BƯỚC 2: XÁC NHẬN OTP =======================
    @PostMapping("/verify-reset-otp")
    public String verifyResetOtp(@RequestParam("otp") String otp, HttpSession session, Model model) {
        String sessionOtp = (String) session.getAttribute("otp_reset");
        String email = (String) session.getAttribute("reset_email");
        Instant expire = (Instant) session.getAttribute("otp_expire");

        if (email == null || sessionOtp == null) {
            model.addAttribute("message", "❌ Phiên không hợp lệ. Vui lòng thử lại.");
            return "forgot-password";
        }

        if (Instant.now().isAfter(expire)) {
            model.addAttribute("message", "⏰ Mã OTP đã hết hạn. Vui lòng thử lại.");
            return "forgot-password";
        }

        if (!otp.equals(sessionOtp)) {
            model.addAttribute("message", "❌ Mã OTP không chính xác.");
            model.addAttribute("email", email);
            return "verify-reset-otp";
        }

        // OTP đúng -> chuyển sang trang đặt lại mật khẩu
        model.addAttribute("email", email);
        return "reset-password";
    }

    // ======================= QUÊN MẬT KHẨU — BƯỚC 3: LƯU MẬT KHẨU MỚI =======================
    @PostMapping("/reset-password")
    public String handleResetPassword(@RequestParam("email") String email,
                                      @RequestParam("newPassword") String newPassword,
                                      HttpSession session,
                                      Model model) {
        try {
            User user = userService.findByEmail(email);
            if (user == null) {
                model.addAttribute("message", "❌ Không tìm thấy tài khoản.");
                return "reset-password";
            }

            user.setPasswordHash(passwordEncoder.encode(newPassword));
            userService.save(user);

            session.removeAttribute("otp_reset");
            session.removeAttribute("reset_email");
            session.removeAttribute("otp_expire");

            model.addAttribute("message", "✅ Mật khẩu của bạn đã được thay đổi thành công!");
            return "redirect:/auth/login";
        } catch (Exception e) {
            model.addAttribute("message", "❌ Lỗi: " + e.getMessage());
            return "reset-password";
        }
    }
}





