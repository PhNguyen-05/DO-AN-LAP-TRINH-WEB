//package vn.iotstar.starshop.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.domain.Sort;
//import org.springframework.http.ResponseEntity;
//import org.springframework.http.HttpStatus;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//import jakarta.servlet.http.HttpSession;
//
//import vn.iotstar.starshop.entity.*;
//import vn.iotstar.starshop.service.*;
//
//import java.util.List;
//import java.util.Optional;
//
//@Controller
//@RequestMapping("/vendor")
//public class PromotionController {
//
//    @Autowired
//    private PromotionService promotionService;
//
//    @Autowired
//    private VendorService vendorService;
//
//    // ==============================
//    // 🏪 VENDOR - Manage own promotions
//    // ==============================
//
//    // 🎁 Manage promotions with pagination
//    @GetMapping("/promotions")
//    public String managePromotions(
//            Model model,
//            HttpSession session,
//            @RequestParam(defaultValue = "0") int page,
//            @RequestParam(defaultValue = "10") int size,
//            @RequestParam(defaultValue = "createdAt,desc") String sort) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) return "redirect:/auth/login";
//
//        String email = currentUser.getEmail();
//        Vendor vendor = vendorService.findByEmail(email);
//        if (vendor == null) return "redirect:/vendor/register";
//
//        // Parse sort parameter (e.g., "createdAt,desc")
//        String[] sortParts = sort.split(",");
//        String sortField = sortParts[0];
//        Sort.Direction sortDirection = sortParts.length > 1 && "asc".equalsIgnoreCase(sortParts[1]) ? Sort.Direction.ASC : Sort.Direction.DESC;
//
//        Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sortField));
//        Page<Promotion> promotionPage = promotionService.findByVendor(vendor, pageable);
//
//        model.addAttribute("promotions", promotionPage.getContent());
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPages", promotionPage.getTotalPages());
//        model.addAttribute("totalItems", promotionPage.getTotalElements());
//        model.addAttribute("pageSize", size);
//        model.addAttribute("sort", sort);
//        model.addAttribute("title", "Promotions");
//
//        return "vendor/promotions";
//    }
//
//    // 🎁 Add promotion
//    @PostMapping("/promotions/add")
//    public ResponseEntity<String> addPromotion(@ModelAttribute Promotion promotion, HttpSession session) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
//
//        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
//        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
//
//        try {
//            if (promotion.getPromotionName() == null || promotion.getPromotionName().isEmpty()) {
//                return new ResponseEntity<>("Promotion name is required", HttpStatus.BAD_REQUEST);
//            }
//            if (promotion.getStartDate() == null || promotion.getEndDate() == null) {
//                return new ResponseEntity<>("Start and end dates are required", HttpStatus.BAD_REQUEST);
//            }
//            if (promotion.getStartDate().isAfter(promotion.getEndDate())) {
//                return new ResponseEntity<>("Start date must be before end date", HttpStatus.BAD_REQUEST);
//            }
//
//            promotion.setVendor(vendor);
//            promotionService.save(promotion);
//        } catch (Exception e) {
//            return new ResponseEntity<>("Error saving promotion: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//
//        return new ResponseEntity<>("Success", HttpStatus.OK);
//    }
//
//    // 🎁 Edit promotion
//    @PostMapping("/promotions/edit/{id}")
//    public ResponseEntity<String> editPromotion(@PathVariable Integer id, @ModelAttribute Promotion promotion, HttpSession session) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
//
//        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
//        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
//
//        try {
//            Optional<Promotion> optionalPromotion = promotionService.findById(id);
//            if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
//                return new ResponseEntity<>("Promotion not found", HttpStatus.NOT_FOUND);
//            }
//
//            Promotion existingPromotion = optionalPromotion.get();
//
//            if (promotion.getPromotionName() != null && !promotion.getPromotionName().isEmpty()) {
//                existingPromotion.setPromotionName(promotion.getPromotionName());
//            }
//            if (promotion.getDescription() != null) {
//                existingPromotion.setDescription(promotion.getDescription());
//            }
//            if (promotion.getDiscountValue() != null) {
//                existingPromotion.setDiscountValue(promotion.getDiscountValue());
//            }
//            if (promotion.getStartDate() != null) {
//                existingPromotion.setStartDate(promotion.getStartDate());
//            }
//            if (promotion.getEndDate() != null) {
//                existingPromotion.setEndDate(promotion.getEndDate());
//            }
//            if (promotion.getActive() != null) {
//                existingPromotion.setActive(promotion.getActive());
//            }
//
//            if (existingPromotion.getStartDate() != null && existingPromotion.getEndDate() != null &&
//                existingPromotion.getStartDate().isAfter(existingPromotion.getEndDate())) {
//                return new ResponseEntity<>("Start date must be before end date", HttpStatus.BAD_REQUEST);
//            }
//
//            promotionService.save(existingPromotion);
//        } catch (Exception e) {
//            return new ResponseEntity<>("Error updating promotion: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//
//        return new ResponseEntity<>("Success", HttpStatus.OK);
//    }
//
//    // 🎁 Delete promotion
//    @PostMapping("/promotions/delete/{id}")
//    public ResponseEntity<String> deletePromotion(@PathVariable Integer id, HttpSession session) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
//
//        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
//        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
//
//        try {
//            Optional<Promotion> optionalPromotion = promotionService.findById(id);
//            if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
//                return new ResponseEntity<>("Promotion not found", HttpStatus.NOT_FOUND);
//            }
//            promotionService.delete(id);
//        } catch (Exception e) {
//            return new ResponseEntity<>("Error deleting promotion: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//
//        return new ResponseEntity<>("Success", HttpStatus.OK);
//    }
//}


package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.service.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/vendor")
public class PromotionController {

    @Autowired
    private PromotionService promotionService;

    @Autowired
    private VendorService vendorService;

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    // ==============================
    // 🏪 VENDOR - Manage own promotions
    // ==============================

    // 🎁 Manage promotions with pagination
    @GetMapping("/promotions")
    public String managePromotions(
            Model model,
            HttpSession session,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt,desc") String sort) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/auth/login";

        String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) return "redirect:/vendor/register";

        // Parse sort parameter (e.g., "createdAt,desc")
        String[] sortParts = sort.split(",");
        String sortField = sortParts[0];
        Sort.Direction sortDirection = sortParts.length > 1 && "asc".equalsIgnoreCase(sortParts[1]) ? Sort.Direction.ASC : Sort.Direction.DESC;

        Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sortField));
        Page<Promotion> promotionPage = promotionService.findByVendor(vendor, pageable);

        model.addAttribute("promotions", promotionPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", promotionPage.getTotalPages());
        model.addAttribute("totalItems", promotionPage.getTotalElements());
        model.addAttribute("pageSize", size);
        model.addAttribute("sort", sort);
        model.addAttribute("title", "Promotions");
        model.addAttribute("vendorProducts", productService.findByVendor(vendor)); // Thêm sản phẩm
        model.addAttribute("vendorCategories", categoryService.findByVendor(vendor)); // Thêm danh mục

        return "vendor/promotions";
    }

    // 🎁 Show form to add promotion
    @GetMapping("/add-promotion")
    public String showAddPromotionForm(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/auth/login";

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null) return "redirect:/vendor/register";

        model.addAttribute("vendorProducts", productService.findByVendor(vendor));
        model.addAttribute("vendorCategories", categoryService.findByVendor(vendor));
        return "vendor/add-promotion";
    }

    // 🎁 Add promotion
    @PostMapping("/promotions/add")
    public ResponseEntity<String> addPromotion(
            @RequestParam String promotionName,
            @RequestParam BigDecimal discountValue,
            @RequestParam Promotion.DiscountType discountType,
            @RequestParam(required = false) String description,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam(required = false) Boolean active,
            @RequestParam(required = false) List<Integer> productIds,
            @RequestParam(required = false) List<Integer> categoryIds,
            HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            if (promotionName == null || promotionName.isEmpty()) {
                return new ResponseEntity<>("Promotion name is required", HttpStatus.BAD_REQUEST);
            }
            if (discountValue == null || discountValue.compareTo(BigDecimal.ZERO) <= 0) {
                return new ResponseEntity<>("Discount value must be positive", HttpStatus.BAD_REQUEST);
            }
            if (discountType == null) {
                return new ResponseEntity<>("Discount type is required", HttpStatus.BAD_REQUEST);
            }
            LocalDateTime start = LocalDateTime.parse(startDate);
            LocalDateTime end = LocalDateTime.parse(endDate);
            if (start.isAfter(end)) {
                return new ResponseEntity<>("Start date must be before end date", HttpStatus.BAD_REQUEST);
            }

            Promotion promotion = Promotion.builder()
                    .promotionName(promotionName)
                    .description(description)
                    .discountValue(discountValue)
                    .discountType(discountType)
                    .startDate(start)
                    .endDate(end)
                    .active(active != null ? active : true)
                    .vendor(vendor)
                    .createdAt(LocalDateTime.now())
                    .build();

            // Gắn sản phẩm và danh mục
            if (productIds != null && !productIds.isEmpty()) {
                List<Product> products = productService.findByIdsAndVendor(productIds, vendor);
                promotion.setProducts(products);
            }
            if (categoryIds != null && !categoryIds.isEmpty()) {
                List<Category> categories = categoryService.findByIdsAndVendor(categoryIds, vendor);
                promotion.setCategories(categories);
            }

            promotionService.save(promotion);
        } catch (Exception e) {
            return new ResponseEntity<>("Error saving promotion: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

    // 🎁 Show form to edit promotion
    @GetMapping("/edit-promotion")
    public String showEditPromotionForm(@RequestParam Integer id, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/auth/login";

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null) return "redirect:/vendor/register";

        Optional<Promotion> optionalPromotion = promotionService.findById(id);
        if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
            return "redirect:/vendor/promotions";
        }

        Promotion promotion = optionalPromotion.get();
        model.addAttribute("promotion", promotion);
        model.addAttribute("vendorProducts", productService.findByVendor(vendor));
        model.addAttribute("vendorCategories", categoryService.findByVendor(vendor));
        return "vendor/edit-promotion";
    }

    // 🎁 Edit promotion
    @PostMapping("/promotions/edit/{id}")
    public ResponseEntity<String> editPromotion(
            @PathVariable Integer id,
            @RequestParam String promotionName,
            @RequestParam BigDecimal discountValue,
            @RequestParam Promotion.DiscountType discountType,
            @RequestParam(required = false) String description,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam(required = false) Boolean active,
            @RequestParam(required = false) List<Integer> productIds,
            @RequestParam(required = false) List<Integer> categoryIds,
            HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            Optional<Promotion> optionalPromotion = promotionService.findById(id);
            if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
                return new ResponseEntity<>("Promotion not found or unauthorized", HttpStatus.NOT_FOUND);
            }

            Promotion existingPromotion = optionalPromotion.get();

            if (promotionName != null && !promotionName.isEmpty()) {
                existingPromotion.setPromotionName(promotionName);
            }
            if (description != null) {
                existingPromotion.setDescription(description);
            }
            if (discountValue != null && discountValue.compareTo(BigDecimal.ZERO) > 0) {
                existingPromotion.setDiscountValue(discountValue);
            }
            if (discountType != null) {
                existingPromotion.setDiscountType(discountType);
            }
            LocalDateTime start = LocalDateTime.parse(startDate);
            LocalDateTime end = LocalDateTime.parse(endDate);
            if (start != null && end != null && start.isAfter(end)) {
                return new ResponseEntity<>("Start date must be before end date", HttpStatus.BAD_REQUEST);
            }
            existingPromotion.setStartDate(start);
            existingPromotion.setEndDate(end);
            existingPromotion.setActive(active != null ? active : existingPromotion.getActive());

            // Cập nhật sản phẩm và danh mục
            if (productIds != null) {
                List<Product> products = productService.findByIdsAndVendor(productIds, vendor);
                existingPromotion.setProducts(products);
            }
            if (categoryIds != null) {
                List<Category> categories = categoryService.findByIdsAndVendor(categoryIds, vendor);
                existingPromotion.setCategories(categories);
            }

            promotionService.save(existingPromotion);
        } catch (Exception e) {
            return new ResponseEntity<>("Error updating promotion: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

// // 🟢 [1] Hiển thị form sửa (GET)
//    @GetMapping("/edit/{id}")
//    public String showEditForm(@PathVariable Integer id, Model model, HttpSession session) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) return "redirect:/login";
//
//        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
//        if (vendor == null) return "redirect:/error";
//
//        Optional<Promotion> optionalPromotion = promotionService.findById(id);
//        if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
//            return "redirect:/vendor/promotions";
//        }
//
//        Promotion promotion = optionalPromotion.get();
//
//        // ✅ Format LocalDateTime sang chuỗi cho input datetime-local
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
//        model.addAttribute("formattedStartDate", promotion.getStartDate() != null ? promotion.getStartDate().format(formatter) : "");
//        model.addAttribute("formattedEndDate", promotion.getEndDate() != null ? promotion.getEndDate().format(formatter) : "");
//        model.addAttribute("promotion", promotion);
//
//        // Load danh sách sản phẩm và danh mục của vendor
//        model.addAttribute("vendorProducts", productService.findByVendor(vendor));
//        model.addAttribute("vendorCategories", categoryService.findByVendor(vendor));
//
//        return "vendor/edit-promotion";
//    }
//
//    // 🟢 [2] Xử lý cập nhật (POST)
//    @PostMapping("/edit/{id}")
//    public ResponseEntity<String> editPromotion(
//            @PathVariable Integer id,
//            @RequestParam String promotionName,
//            @RequestParam BigDecimal discountValue,
//            @RequestParam Promotion.DiscountType discountType,
//            @RequestParam(required = false) String description,
//            @RequestParam String startDate,
//            @RequestParam String endDate,
//            @RequestParam(required = false) Boolean active,
//            @RequestParam(required = false) List<Integer> productIds,
//            @RequestParam(required = false) List<Integer> categoryIds,
//            HttpSession session) {
//
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null)
//            return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
//
//        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
//        if (vendor == null)
//            return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
//
//        try {
//            Optional<Promotion> optionalPromotion = promotionService.findById(id);
//            if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
//                return new ResponseEntity<>("Promotion not found or unauthorized", HttpStatus.NOT_FOUND);
//            }
//
//            Promotion existingPromotion = optionalPromotion.get();
//
//            // Cập nhật các trường cơ bản
//            if (promotionName != null && !promotionName.isEmpty()) {
//                existingPromotion.setPromotionName(promotionName);
//            }
//            if (description != null) {
//                existingPromotion.setDescription(description);
//            }
//            if (discountValue != null && discountValue.compareTo(BigDecimal.ZERO) > 0) {
//                existingPromotion.setDiscountValue(discountValue);
//            }
//            if (discountType != null) {
//                existingPromotion.setDiscountType(discountType);
//            }
//
//            // ✅ Parse LocalDateTime từ form input
//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
//            LocalDateTime start = LocalDateTime.parse(startDate, formatter);
//            LocalDateTime end = LocalDateTime.parse(endDate, formatter);
//
//            if (start.isAfter(end)) {
//                return new ResponseEntity<>("Start date must be before end date", HttpStatus.BAD_REQUEST);
//            }
//
//            existingPromotion.setStartDate(start);
//            existingPromotion.setEndDate(end);
//            existingPromotion.setActive(active != null ? active : existingPromotion.getActive());
//
//            // ✅ Cập nhật sản phẩm & danh mục
//            if (productIds != null) {
//                List<Product> products = productService.findByIdsAndVendor(productIds, vendor);
//                existingPromotion.setProducts(products);
//            }
//            if (categoryIds != null) {
//                List<Category> categories = categoryService.findByIdsAndVendor(categoryIds, vendor);
//                existingPromotion.setCategories(categories);
//            }
//
//            promotionService.save(existingPromotion);
//            return new ResponseEntity<>("Success", HttpStatus.OK);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>("Error updating promotion: " + e.getMessage(),
//                    HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }

    
//    // 🎁 Delete promotion
//    @PostMapping("/promotions/delete/{id}")
//    public ResponseEntity<String> deletePromotion(@PathVariable Integer id, HttpSession session) {
//        User currentUser = (User) session.getAttribute("currentUser");
//        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
//
//        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
//        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
//
//        try {
//            Optional<Promotion> optionalPromotion = promotionService.findById(id);
//            if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
//                return new ResponseEntity<>("Promotion not found", HttpStatus.NOT_FOUND);
//            }
//            promotionService.delete(id); // Sửa lại thành deleteById
//        } catch (Exception e) {
//            return new ResponseEntity<>("Error deleting promotion: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//
//        return new ResponseEntity<>("Success", HttpStatus.OK);
//    }
    
    
 // 🎁 Xóa khuyến mãi (AJAX)
    @PostMapping("/promotions/delete/{id}")
    @ResponseBody
    public ResponseEntity<String> deletePromotion(@PathVariable Integer id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null)
            return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null)
            return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            Optional<Promotion> optionalPromotion = promotionService.findById(id);
            if (optionalPromotion.isEmpty() ||
                !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
                return new ResponseEntity<>("Promotion not found", HttpStatus.NOT_FOUND);
            }

            promotionService.delete(id);
            return new ResponseEntity<>("Success", HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>("Error deleting promotion: " + e.getMessage(),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
