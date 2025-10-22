package vn.iotstar.starshop.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.util.JwtUtil;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

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
}
