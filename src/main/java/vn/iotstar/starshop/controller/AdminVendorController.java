
package vn.iotstar.starshop.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.service.VendorService;
import vn.iotstar.starshop.repository.VendorRepository;
import vn.iotstar.starshop.repository.UserRepository;

@Controller
@RequestMapping("/admin/vendors")
public class AdminVendorController {

    @Autowired
    private VendorService vendorService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private VendorRepository vendorRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    // 📋 Danh sách vendor
    @GetMapping
    public String listVendors(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        List<Vendor> vendors;

        if (keyword != null && !keyword.trim().isEmpty()) {
            vendors = vendorService.searchByKeyword(keyword.trim());
        } else {
            vendors = vendorService.findAll();
        }

        model.addAttribute("vendors", vendors);
        model.addAttribute("keyword", keyword);
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
    
    @GetMapping("/toggleStatus/{id}")
    public String toggleStatus(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        Optional<Vendor> optVendor = vendorRepository.findById(id);
        if (optVendor.isPresent()) {
            Vendor vendor = optVendor.get();
            User user = vendor.getUser(); // vendor liên kết tới user
            user.setActive(!user.isActive()); // đảo trạng thái true <-> false
            userRepository.save(user);
            redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy chủ shop!");
        }
        return "redirect:/admin/vendors"; // quay lại danh sách
    }



}
