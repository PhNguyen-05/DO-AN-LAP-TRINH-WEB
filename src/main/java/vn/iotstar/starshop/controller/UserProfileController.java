package vn.iotstar.starshop.controller;

import jakarta.servlet.http.HttpSession;

import java.time.ZoneId;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.service.CustomerService;


@Controller
@RequestMapping("/user/profile")
public class UserProfileController {

    @Autowired
    private CustomerService customersService;

    // ====== Xem profile ======
    // ====== Xem profile ======
    @GetMapping
    public String viewProfile(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        Customer kh = customersService.findByUserId(currentUser.getId());
        if (kh == null) {
            return "redirect:/user/profile/edit";
        }

        // ✅ Chuyển đổi LocalDateTime → Date (để fmt:formatDate không lỗi)
        if (currentUser.getCreatedAt() != null) {
            Date createdDate = Date.from(currentUser.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant());
            model.addAttribute("createdDate", createdDate);
        }

        model.addAttribute("customer", kh);
        model.addAttribute("user", currentUser);

        return "user/profile";
    }
    // ====== Trang chỉnh sửa profile ======
    @GetMapping("/edit")
    public String editProfile(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        Customer kh = customersService.findByUserId(currentUser.getId());
        model.addAttribute("customer", kh);

        return "user/profile-edit"; // /WEB-INF/views/user/profile-edit.jsp
    }

    // ====== Cập nhật profile ======
    @PostMapping("/update")
    public String updateProfile(@RequestParam("fullName") String fullName,
                                @RequestParam(value = "phone", required = false) String phone,
                                @RequestParam(value = "defaultAddress", required = false) String defaultAddress,
                                HttpSession session) {

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        Customer kh = customersService.findByUserId(currentUser.getId());
        if (kh == null) {
            // Nếu chưa có record KhachHang, tạo mới
            kh = new Customer();
            kh.setUserId(currentUser.getId()); // Bạn cần thêm field userId trong entity
        }

        kh.setFullName(fullName);
        kh.setPhone(phone);
        kh.setDefaultAddress(defaultAddress);

        customersService.save(kh);

        return "redirect:/user/profile";
    }
}
