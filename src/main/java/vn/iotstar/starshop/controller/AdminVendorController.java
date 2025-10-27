package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.service.VendorService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/vendors")
public class AdminVendorController {

    @Autowired
    private VendorService vendorService;

    @Autowired
    private UserService userService;

    // 📋 Danh sách vendor
    @GetMapping
    public String listVendors(Model model) {
        List<Vendor> vendors = vendorService.findAll();
        model.addAttribute("vendors", vendors);
        model.addAttribute("title", "Quản lý Chủ Shop");
        return "admin/vendor/vendors"; // -> JSP list
    }

    // 🧾 API lấy thông tin vendor (AJAX dùng cho modal)
    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Vendor> getVendorById(@PathVariable Integer id) {
        Optional<Vendor> vendorOpt = vendorService.findById(id);
        return vendorOpt.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // 💾 Lưu vendor (thêm hoặc sửa)
    @PostMapping("/save")
    public String saveVendor(@ModelAttribute Vendor vendor,
                             @RequestParam("userId") Integer userId) {

        User user = userService.findById(userId).orElse(null);
        if (user != null) {
            vendor.setUser(user);
            vendor.setEmail(user.getEmail());
        }
        if (vendor.getCreatedAt() == null)
            vendor.setCreatedAt(LocalDateTime.now());

        vendorService.save(vendor);
        return "redirect:/admin/vendor";
    }

    // 🗑️ Xóa vendor
    @PostMapping("/delete/{id}")
    public ResponseEntity<String> deleteVendor(@PathVariable Integer id) {
        try {
            vendorService.deleteById(id);
            return new ResponseEntity<>("Success", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error deleting vendor: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
