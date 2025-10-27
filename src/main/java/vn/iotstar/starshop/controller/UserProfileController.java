//package vn.iotstar.starshop.controller;
//
//import jakarta.servlet.http.HttpSession;
//
//import java.time.ZoneId;
//import java.util.Date;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//import vn.iotstar.starshop.entity.Customer;
//import vn.iotstar.starshop.entity.User;
//import vn.iotstar.starshop.service.CustomerService;
//
//
//@Controller
//@RequestMapping("/user/profile")
//public class UserProfileController {
//
//    @Autowired
//    private CustomerService customersService;
//
//    // ====== Xem profile ======
//    // ====== Xem profile ======
//    @GetMapping
//    public String viewProfile(HttpSession session, Model model) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) {
//            return "redirect:/auth/login";
//        }
//
//        Customer kh = customersService.findByUserId(currentUser.getId());
//
//        if (kh == null) {
//            return "redirect:/user/profile/edit";
//        }
//
//        // ✅ Chuyển đổi LocalDateTime → Date (để fmt:formatDate không lỗi)
//        if (currentUser.getCreatedAt() != null) {
//            Date createdDate = Date.from(currentUser.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant());
//            model.addAttribute("createdDate", createdDate);
//        }
//
//        model.addAttribute("customer", kh);
//        model.addAttribute("user", currentUser);
//
//        return "user/profile";
//    }
//    // ====== Trang chỉnh sửa profile ======
//    @GetMapping("/edit")
//    public String editProfile(HttpSession session, Model model) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) {
//            return "redirect:/auth/login";
//        }
//
//        Customer kh = customersService.findByUserId(currentUser.getId());
//
//        model.addAttribute("customer", kh);
//
//        return "user/profile-edit"; // /WEB-INF/views/user/profile-edit.jsp
//    }
//
//    // ====== Cập nhật profile ======
//    @PostMapping("/update")
//    public String updateProfile(@RequestParam("fullName") String fullName,
//                                @RequestParam(value = "phone", required = false) String phone,
//                                @RequestParam(value = "defaultAddress", required = false) String defaultAddress,
//                                HttpSession session) {
//
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) {
//            return "redirect:/auth/login";
//        }
//
//
//        Customer kh = customersService.findByUserId(currentUser.getId());
//        if (kh == null) {
//            // Nếu chưa có record KhachHang, tạo mới
//            kh = new Customer();
//            kh.setUserId(currentUser.getId()); // Bạn cần thêm field userId trong entity
//        }
//
//        kh.setFullName(fullName);
//        kh.setPhone(phone);
//        kh.setDefaultAddress(defaultAddress);
//
//        customersService.save(kh);
//
//        return "redirect:/user/profile";
//    }
//}





//package vn.iotstar.starshop.controller;
//
//import java.time.ZoneId;
//import java.util.Date;
//
//import org.springframework.security.core.annotation.AuthenticationPrincipal;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//import vn.iotstar.starshop.entity.Address;
//import vn.iotstar.starshop.entity.Customer;
//import vn.iotstar.starshop.entity.User;
//import vn.iotstar.starshop.security.CustomUserDetails;
//import vn.iotstar.starshop.service.CustomerService;
//
//@Controller
//@RequestMapping("/user/profile")
//public class UserProfileController {
//
//    private final CustomerService customerService;
//
//    public UserProfileController(CustomerService customerService) {
//        this.customerService = customerService;
//    }
//
//    // ====== Xem profile ======
//    @GetMapping
//    public String viewProfile(@AuthenticationPrincipal CustomUserDetails customUser, Model model) {
//        if (customUser == null) return "redirect:/auth/login";
//
//        User currentUser = customUser.getUser();
//        Customer customer = customerService.findByUserId(currentUser.getId());
//
//        if (customer == null) return "redirect:/user/profile/edit";
//
//        Date createdDate = null;
//        if (currentUser.getCreatedAt() != null) {
//            createdDate = Date.from(currentUser.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant());
//        }
//
//        model.addAttribute("customer", customer);
//        model.addAttribute("user", currentUser);
//        model.addAttribute("createdDate", createdDate);
//
//        return "user/profile"; // profile.jsp
//    }
//
//    // ====== Trang chỉnh sửa profile ======
//    @GetMapping("/edit")
//    public String editProfile(@AuthenticationPrincipal CustomUserDetails customUser, Model model) {
//        if (customUser == null) return "redirect:/auth/login";
//
//        User currentUser = customUser.getUser();
//        Customer customer = customerService.findByUserId(currentUser.getId());
//
//        if (customer == null) {
//            customer = new Customer();
//            customer.setUserId(currentUser.getId());
//        }
//
//        model.addAttribute("customer", customer);
//        model.addAttribute("user", currentUser);
//
//        return "user/profile-edit"; // profile-edit.jsp
//    }
//
//    // ====== Cập nhật profile ======
//    @PostMapping("/update")
//    public String updateProfile(@AuthenticationPrincipal CustomUserDetails customUser,
//                                @RequestParam("fullName") String fullName,
//                                @RequestParam(value = "phone", required = false) String phone,
//                                @RequestParam(value = "defaultAddress", required = false) String defaultAddress) {
//        if (customUser == null) return "redirect:/auth/login";
//
//        User currentUser = customUser.getUser();
//        Customer customer = customerService.findByUserId(currentUser.getId());
//
//        if (customer == null) {
//            customer = new Customer();
//            customer.setUserId(currentUser.getId());
//        }
//
//        customer.setFullName(fullName);
//        customer.setPhone(phone);
//        customer.setDefaultAddress(defaultAddress);
//
//        customerService.save(customer);
//
//        return "redirect:/user/profile";
//    }
//
//    // ====== Trang thêm/chỉnh sửa địa chỉ ======
//    @GetMapping("/address/edit")
//    public String editAddress(@RequestParam(value = "id", required = false) Integer id,
//                              @AuthenticationPrincipal CustomUserDetails customUser,
//                              Model model) {
//        if (customUser == null) return "redirect:/auth/login";
//
//        Customer customer = customerService.findByUserId(customUser.getUser().getId());
//        if (customer == null) return "redirect:/user/profile/edit";
//
//        Address address = null;
//        if (id != null) {
//            address = customer.getAddressList().stream()
//                    .filter(a -> a.getId().equals(id))
//                    .findFirst()
//                    .orElse(null);
//        }
//        if (address == null) {
//            address = new Address();
//        }
//
//        model.addAttribute("address", address);
//        model.addAttribute("customer", customer);
//
//        return "user/address-edit"; // address-edit.jsp
//    }
//    
// // ====== Xóa địa chỉ ======
//    @GetMapping("/address/delete/{id}")
//    public String deleteAddress(@PathVariable("id") Integer id,
//                                @AuthenticationPrincipal CustomUserDetails customUser) {
//        if (customUser == null) return "redirect:/auth/login";
//
//        Customer customer = customerService.findByUserId(customUser.getUser().getId());
//        if (customer == null) return "redirect:/user/profile/edit";
//
//        // Xóa địa chỉ theo id
//        customer.getAddressList().removeIf(a -> a.getId().equals(id));
//
//        // Cập nhật lại Customer
//        customerService.save(customer);
//
//        return "redirect:/user/profile";
//    }
//
//    // ====== Lưu địa chỉ ======
//    @PostMapping("/address/save")
//    public String saveAddress(@AuthenticationPrincipal CustomUserDetails customUser,
//                              @ModelAttribute Address address) {
//        if (customUser == null) return "redirect:/auth/login";
//
//        Customer customer = customerService.findByUserId(customUser.getUser().getId());
//        if (customer == null) return "redirect:/user/profile/edit";
//
//        // Liên kết customer
//        address.setCustomer(customer);
//
//        // Xóa nếu trùng id (update)
//        customer.getAddressList().removeIf(a -> a.getId() != null && a.getId().equals(address.getId()));
//        customer.getAddressList().add(address);
//
//        customerService.save(customer);
//
//        return "redirect:/user/profile";
//    }
//}


package vn.iotstar.starshop.controller;

import java.time.ZoneId;
import java.util.Date;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.service.CustomerService;


import vn.iotstar.starshop.entity.Address;
import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.security.CustomUserDetails;
import vn.iotstar.starshop.service.CustomerService;


@Controller
@RequestMapping("/user/profile")
public class UserProfileController {


    @Autowired
    private CustomerService customersService;

    private final CustomerService customerService;

    public UserProfileController(CustomerService customerService) {
        this.customerService = customerService;
    }


    // ====== Xem profile ======
    @GetMapping
    public String viewProfile(@AuthenticationPrincipal CustomUserDetails customUser, Model model) {
        if (customUser == null) return "redirect:/auth/login";

        Customer kh = customersService.findByUserId(currentUser.getId());

        if (kh == null) {
            return "redirect:/user/profile/edit";
        }

        User currentUser = customUser.getUser();
        Customer customer = customerService.findByUserId(currentUser.getId());


        if (customer == null) return "redirect:/user/profile/edit";

        Date createdDate = null;
        if (currentUser.getCreatedAt() != null) {
            createdDate = Date.from(currentUser.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant());
        }

        model.addAttribute("customer", customer);
        model.addAttribute("user", currentUser); // Truy cập user trong JSP
        model.addAttribute("createdDate", createdDate);

        return "user/profile"; // profile.jsp
    }

    // ====== Trang chỉnh sửa profile ======
    @GetMapping("/edit")
    public String editProfile(@AuthenticationPrincipal CustomUserDetails customUser, Model model) {
        if (customUser == null) return "redirect:/auth/login";

        User currentUser = customUser.getUser();
        Customer customer = customerService.findByUserId(currentUser.getId());

        if (customer == null) {
            customer = new Customer();
            customer.setUserId(currentUser.getId());
        }


        Customer kh = customersService.findByUserId(currentUser.getId());

        model.addAttribute("customer", kh);

        model.addAttribute("customer", customer);
        model.addAttribute("user", currentUser);


        return "user/profile-edit"; // profile-edit.jsp
    }

    // ====== Cập nhật profile ======
    @PostMapping("/update")
    public String updateProfile(@AuthenticationPrincipal CustomUserDetails customUser,
                                @RequestParam("fullName") String fullName,
                                @RequestParam(value = "phone", required = false) String phone,
                                @RequestParam(value = "defaultAddress", required = false) String defaultAddress) {
        if (customUser == null) return "redirect:/auth/login";

        User currentUser = customUser.getUser();
        Customer customer = customerService.findByUserId(currentUser.getId());

        if (customer == null) {
            customer = new Customer();
            customer.setUserId(currentUser.getId());
        }


        customer.setFullName(fullName);
        customer.setPhone(phone);
        customer.setDefaultAddress(defaultAddress);

        customerService.save(customer);

        return "redirect:/user/profile";
    }

    // ====== Trang thêm/chỉnh sửa địa chỉ ======
    @GetMapping("/address/edit")
    public String editAddress(@RequestParam(value = "id", required = false) Integer id,
                              @AuthenticationPrincipal CustomUserDetails customUser,
                              Model model) {
        if (customUser == null) return "redirect:/auth/login";

        Customer customer = customerService.findByUserId(customUser.getUser().getId());
        if (customer == null) return "redirect:/user/profile/edit";

        Address address = null;
        if (id != null) {
            address = customer.getAddressList().stream()
                    .filter(a -> a.getId().equals(id))
                    .findFirst()
                    .orElse(null);
        }
        if (address == null) {
            address = new Address();

        }

        model.addAttribute("address", address);
        model.addAttribute("customer", customer);

        return "user/address-edit"; // address-edit.jsp
    }

    // ====== Lưu địa chỉ ======
    @PostMapping("/address/save")
    public String saveAddress(@AuthenticationPrincipal CustomUserDetails customUser,
                              @ModelAttribute Address address) {
        if (customUser == null) return "redirect:/auth/login";

        Customer customer = customerService.findByUserId(customUser.getUser().getId());
        if (customer == null) return "redirect:/user/profile/edit";

        address.setCustomer(customer);

        // Cập nhật hoặc thêm mới
        customer.getAddressList().removeIf(a -> a.getId() != null && a.getId().equals(address.getId()));
        customer.getAddressList().add(address);

        customerService.save(customer);

        return "redirect:/user/profile";
    }

    // ====== Xóa địa chỉ ======
    @GetMapping("/address/delete/{id}")
    public String deleteAddress(@PathVariable("id") Integer id,
                                @AuthenticationPrincipal CustomUserDetails customUser) {
        if (customUser == null) return "redirect:/auth/login";

        Customer customer = customerService.findByUserId(customUser.getUser().getId());
        if (customer == null) return "redirect:/user/profile/edit";

        customer.getAddressList().removeIf(a -> a.getId().equals(id));
        customerService.save(customer);

        return "redirect:/user/profile";
    }
}



