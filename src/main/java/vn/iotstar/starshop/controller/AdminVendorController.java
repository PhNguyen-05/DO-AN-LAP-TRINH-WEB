//package vn.iotstar.starshop.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import vn.iotstar.starshop.entity.User;
//import vn.iotstar.starshop.entity.Vendor;
//import vn.iotstar.starshop.service.UserService;
//import vn.iotstar.starshop.service.VendorService;
//
//import java.time.LocalDateTime;
//import java.util.List;
//import java.util.Optional;
//
//@Controller
//@RequestMapping("/admin/vendors")
//public class AdminVendorController {
//
//	@Autowired
//	private VendorService vendorService;
//
//	@Autowired
//	private UserService userService;
//
//	// 📋 Danh sách vendor
//	@GetMapping
//	public String listVendors(Model model) {
//		List<Vendor> vendors = vendorService.findAll();
//		model.addAttribute("vendors", vendors);
//		model.addAttribute("title", "Quản lý Chủ Shop");
//		return "admin/vendor/vendors"; // -> JSP list
//	}
//
//	// 🧾 API lấy thông tin vendor (AJAX dùng cho modal)
//	@GetMapping("/{id}")
//	@ResponseBody
//	public ResponseEntity<Vendor> getVendorById(@PathVariable Integer id) {
//		Optional<Vendor> vendorOpt = vendorService.findById(id);
//		return vendorOpt.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
//	}
//
//	// 💾 Lưu vendor (thêm hoặc sửa)
////    @PostMapping("/save")
////    public String saveVendor(@ModelAttribute Vendor vendor,
////                             @RequestParam("userId") Integer userId) {
////
////        User user = userService.findById(userId).orElse(null);
////        if (user != null) {
////            vendor.setUser(user);
////            vendor.setEmail(user.getEmail());
////        }
////        if (vendor.getCreatedAt() == null)
////            vendor.setCreatedAt(LocalDateTime.now());
////
////        vendorService.save(vendor);
////        return "redirect:/admin/vendor";
////    }
//
//	@PostMapping("/save")
//	public String saveVendor(@ModelAttribute Vendor vendor, RedirectAttributes redirectAttrs) {
//	    try {
//	        vendorService.createVendor(vendor);
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
//	        return "redirect:/admin/vendors";
//	    }
//	    return "redirect:/admin/vendors";
//	}
//	
//	
//
//	// 🗑️ Xóa vendor
//	@PostMapping("/delete/{id}")
//	public ResponseEntity<String> deleteVendor(@PathVariable Integer id) {
//		try {
//			vendorService.deleteById(id);
//			return new ResponseEntity<>("Success", HttpStatus.OK);
//		} catch (Exception e) {
//			return new ResponseEntity<>("Error deleting vendor: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//}


package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.service.VendorService;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/admin/vendors")
public class AdminVendorController {

    @Autowired
    private VendorService vendorService;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 📋 Danh sách vendor
    @GetMapping
    public String listVendors(Model model) {
        List<Vendor> vendors = vendorService.findAll();
        model.addAttribute("vendors", vendors);
        model.addAttribute("title", "Quản lý Chủ Shop");
        return "admin/vendor/vendors";
    }

    // 🧾 API lấy thông tin vendor (AJAX dùng cho modal)
    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Vendor> getVendorById(@PathVariable Integer id) {
        Optional<Vendor> vendorOpt = vendorService.findById(id);
        return vendorOpt.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    /**
     * 💾 LƯU VENDOR (THÊM MỚI HOẶC CẬP NHẬT)
     * Đã cập nhật để khớp với User.java (dùng passwordHash, phone, role)
     */
    @PostMapping("/save")
    public String saveVendor(@ModelAttribute Vendor vendor, RedirectAttributes redirectAttrs) {
        try {
            User user;
            
            if (vendor.getId() == null) {
                // --- 1. TẠO MỚI VENDOR ---
                
                if (userService.findByEmail(vendor.getEmail()) != null) {
                    redirectAttrs.addFlashAttribute("error", "Email đã tồn tại. Không thể thêm.");
                    return "redirect:/admin/vendors";
                }
                
                // (Bạn cũng nên kiểm tra SĐT nếu nó là unique)
                // if (userService.findByPhone(vendor.getPhone()) != null) { ... }

                user = new User();
                user.setEmail(vendor.getEmail()); 
                user.setPhone(vendor.getPhone()); 
                user.setPasswordHash(passwordEncoder.encode("123456")); 
                user.setActive(true); // Set status = "Active"
                user.setRole("Vendor"); // Set vai trò
                
            } else {
                // --- 2. CẬP NHẬT VENDOR ---
                
                Vendor existingVendor = vendorService.findById(vendor.getId())
                        .orElseThrow(() -> new RuntimeException("Không tìm thấy vendor"));
                user = existingVendor.getUser();
                
                if (!user.getEmail().equals(vendor.getEmail())) {
                    user.setEmail(vendor.getEmail());
                }
                if (!user.getPhone().equals(vendor.getPhone())) {
                    user.setPhone(vendor.getPhone());
                }
                
                vendor.setCreatedAt(existingVendor.getCreatedAt());
            }

            // --- 3. LƯU USER VÀ VENDOR ---
            User savedUser = userService.save(user); 
            vendor.setUser(savedUser); 
            vendorService.save(vendor); 
            
            redirectAttrs.addFlashAttribute("success", "Lưu chủ shop thành công!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
        }
        return "redirect:/admin/vendors";
    }
    
    

    /**
     * 🗑️ Xóa vendor
     * SỬA: Dùng @GetMapping để khớp với thẻ <a href...> trong file JSP
     */
    @GetMapping("/delete/{id}")
    public String deleteVendor(@PathVariable Integer id, RedirectAttributes redirectAttrs) {
        try {
            Optional<Vendor> vendorOpt = vendorService.findById(id);
            if (vendorOpt.isPresent()) {
                User user = vendorOpt.get().getUser();
                
                // 1. Xóa vendor
                vendorService.deleteById(id); 
                
                // 2. Khóa tài khoản User (thay vì xóa)
                User userToUpdate = userService.findById(user.getId()).orElse(null);
                if(userToUpdate != null) {
                    userToUpdate.setActive(false); // Set status = "Inactive"
                    userService.save(userToUpdate);
                }
                redirectAttrs.addFlashAttribute("success", "Xóa và vô hiệu hóa chủ shop thành công.");
            } else {
                redirectAttrs.addFlashAttribute("error", "Không tìm thấy chủ shop để xóa.");
            }
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Lỗi khi xóa: " + e.getMessage());
        }
        return "redirect:/admin/vendors";
    }
    
    
    @GetMapping("/detail/{id}")
    public String viewVendorDetail(@PathVariable Integer id, Model model) {
        Vendor vendor = vendorService.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy vendor với ID = " + id));
        model.addAttribute("vendor", vendor);
        model.addAttribute("title", "Chi tiết Chủ Shop");
        return "admin/vendor/vendor-detail"; // JSP chi tiết
    }

}
