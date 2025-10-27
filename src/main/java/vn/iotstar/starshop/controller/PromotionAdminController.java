//package vn.iotstar.starshop.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.domain.Sort;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//import vn.iotstar.starshop.dto.PromotionDTO;
//import vn.iotstar.starshop.entity.Promotion;
//import vn.iotstar.starshop.entity.Vendor;
//import vn.iotstar.starshop.service.CategoryService;
//import vn.iotstar.starshop.service.ProductService;
//import vn.iotstar.starshop.service.PromotionService;
//import vn.iotstar.starshop.service.VendorService;
//
//import java.util.List;
//import java.util.Optional;
//
//@Controller
//@RequestMapping("/admin/promotions")
//public class PromotionAdminController {
//
//    @Autowired
//    private PromotionService promotionService;
//
//    @Autowired
//    private VendorService vendorService;
//
//    @Autowired
//    private ProductService productService;
//
//    @Autowired
//    private CategoryService categoryService;
//
//    @GetMapping
//    public String getAll(
//            @RequestParam(required = false) String promotionName,
//            @RequestParam(required = false) Integer vendorId,
//            @RequestParam(defaultValue = "0") int page,
//            @RequestParam(defaultValue = "10") int size,
//            @RequestParam(defaultValue = "createdAt,desc") String sort,
//            Model model) {
//        Pageable pageable = PageRequest.of(page, size, Sort.by(parseSort(sort)));
//        Page<Promotion> promotions;
//        if (vendorId != null && vendorId > 0) {
//            Vendor vendor = vendorService.findById(vendorId).orElseThrow(() -> new RuntimeException("Vendor not found"));
//            if (promotionName != null && !promotionName.trim().isEmpty()) {
//                promotions = promotionService.findByVendorAndPromotionNameContaining(vendor, promotionName, pageable);
//            } else {
//                promotions = promotionService.findByVendor(vendor, pageable);
//            }
//        } else {
//            if (promotionName != null && !promotionName.trim().isEmpty()) {
//                promotions = promotionService.findByPromotionNameContaining(promotionName, pageable);
//            } else {
//                promotions = promotionService.findAll(pageable);
//            }
//        }
//
//        model.addAttribute("promotions", promotions.getContent());
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPages", promotions.getTotalPages());
//        model.addAttribute("vendors", vendorService.findAll());
//        model.addAttribute("categories", categoryService.findAllWithProducts());
//        model.addAttribute("promotion", new Promotion());
//
//        return "admin/promotion/promotions";
//    }
//
//    // Updated to return PromotionDTO
//    @GetMapping("/{id}")
//    @ResponseBody
//    public ResponseEntity<PromotionDTO> getPromotionById(@PathVariable Integer id) {
//        try {
//            Optional<Promotion> optionalPromotion = promotionService.getPromotionById(id);
//            if (optionalPromotion.isPresent()) {
//                Promotion promotion = optionalPromotion.get();
//                // Convert to DTO to avoid circular references
//                PromotionDTO promotionDTO = promotionService.toDTO(promotion);
//                return ResponseEntity.ok(promotionDTO);
//            } else {
//                return ResponseEntity.notFound().build();
//            }
//        } catch (Exception e) {
//            return ResponseEntity.internalServerError().build();
//        }
//    }
//
//    @GetMapping("/detail/{id}")
//    public String getDetail(@PathVariable Integer id, Model model) {
//        Optional<Promotion> promotion = promotionService.getPromotionById(id);
//        if (promotion.isPresent()) {
//            model.addAttribute("promotion", promotion.get());
//            return "admin/promotion/promotion-detail";
//        } else {
//            return "redirect:/admin/promotions";
//        }
//    }
//
//    @PostMapping("/add")
//    public String addPromotion(@ModelAttribute Promotion promotion,
//                               @RequestParam(required = false) List<Integer> productIds,
//                               @RequestParam(required = false) List<Integer> categoryIds,
//                               @RequestParam Integer vendorId,
//                               Model model) {
//        try {
//            Vendor vendor = vendorService.findById(vendorId).orElseThrow(() -> new RuntimeException("Vendor not found"));
//            promotionService.createPromotion(promotion, vendor, productIds, categoryIds);
//            return "redirect:/admin/promotions";
//        } catch (Exception e) {
//            model.addAttribute("error", "Lỗi tạo khuyến mãi: " + e.getMessage());
//            model.addAttribute("vendors", vendorService.findAll());
//            model.addAttribute("categories", categoryService.findAllWithProducts());
//            model.addAttribute("promotion", promotion);
//            return "admin/promotion/promotions";
//        }
//    }
//
//    @PostMapping("/edit/{id}")
//    public String editPromotion(@PathVariable Integer id,
//                                @ModelAttribute Promotion promotion,
//                                @RequestParam(required = false) List<Integer> productIds,
//                                @RequestParam(required = false) List<Integer> categoryIds,
//                                Model model) {
//        try {
//            promotionService.updatePromotion(id, promotion, productIds, categoryIds);
//            return "redirect:/admin/promotions";
//        } catch (Exception e) {
//            model.addAttribute("error", "Lỗi cập nhật: " + e.getMessage());
//            Optional<Promotion> oldPromotion = promotionService.getPromotionById(id);
//            model.addAttribute("promotion", oldPromotion.orElse(promotion));
//            model.addAttribute("vendors", vendorService.findAll());
//            model.addAttribute("categories", categoryService.findAllWithProducts());
//            return "admin/promotion/promotions";
//        }
//    }
//
//    @GetMapping("/delete/{id}")
//    public String deletePromotion(@PathVariable Integer id, Model model) {
//        try {
//            promotionService.deletePromotion(id);
//        } catch (Exception e) {
//            model.addAttribute("error", "Lỗi xóa: " + e.getMessage());
//        }
//        return "redirect:/admin/promotions";
//    }
//
//    @PostMapping("/deactivate-expired")
//    public String deactivateExpired() {
//        promotionService.deactivateExpiredPromotions();
//        return "redirect:/admin/promotions";
//    }
//
//    private Sort.Order[] parseSort(String sort) {
//        String[] parts = sort.split(",");
//        if (parts.length == 2) {
//            return new Sort.Order[]{new Sort.Order(Sort.Direction.fromString(parts[1]), parts[0])};
//        }
//        return new Sort.Order[]{Sort.Order.desc("createdAt")};
//    }
//}


package vn.iotstar.starshop.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.dto.PromotionDTO;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.service.CategoryService;
import vn.iotstar.starshop.service.ProductService;
import vn.iotstar.starshop.service.PromotionService;
import vn.iotstar.starshop.service.VendorService;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/promotions")
public class PromotionAdminController {

    private static final Logger logger = LoggerFactory.getLogger(PromotionAdminController.class);

    @Autowired
    private PromotionService promotionService;

    @Autowired
    private VendorService vendorService;

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String getAll(
            @RequestParam(required = false) String promotionName,
            @RequestParam(required = false) Integer vendorId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt,desc") String sort,
            Model model) {
        logger.info("Received GET request to /admin/promotions with promotionName: {}, vendorId: {}, page: {}", 
                    promotionName, vendorId, page);
        Pageable pageable = PageRequest.of(page, size, Sort.by(parseSort(sort)));
        Page<Promotion> promotions;
        if (vendorId != null && vendorId > 0) {
            Vendor vendor = vendorService.findById(vendorId).orElseThrow(() -> new RuntimeException("Vendor not found"));
            if (promotionName != null && !promotionName.trim().isEmpty()) {
                promotions = promotionService.findByVendorAndPromotionNameContaining(vendor, promotionName, pageable);
            } else {
                promotions = promotionService.findByVendor(vendor, pageable);
            }
        } else {
            if (promotionName != null && !promotionName.trim().isEmpty()) {
                promotions = promotionService.findByPromotionNameContaining(promotionName, pageable);
            } else {
                promotions = promotionService.findAll(pageable);
            }
        }

        model.addAttribute("promotions", promotions.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", promotions.getTotalPages());
        model.addAttribute("vendors", vendorService.findAll());
        model.addAttribute("categories", categoryService.findAllWithProducts());
        model.addAttribute("promotion", new Promotion());
        return "admin/promotion/promotions";
    }

    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<PromotionDTO> getPromotionById(@PathVariable Integer id) {
        logger.info("Received GET request to /admin/promotions/{}", id);
        try {
            Optional<Promotion> optionalPromotion = promotionService.getPromotionById(id);
            if (optionalPromotion.isPresent()) {
                Promotion promotion = optionalPromotion.get();
                PromotionDTO promotionDTO = promotionService.toDTO(promotion);
                return ResponseEntity.ok(promotionDTO);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            logger.error("Error fetching promotion {}: {}", id, e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/detail/{id}")
    public String getDetail(@PathVariable Integer id, Model model) {
        logger.info("Received GET request to /admin/promotions/detail/{}", id);
        Optional<Promotion> promotion = promotionService.getPromotionById(id);
        if (promotion.isPresent()) {
            model.addAttribute("promotion", promotion.get());
            return "admin/promotion/promotion-detail";
        } else {
            return "redirect:/admin/promotions";
        }
    }

    @PostMapping("/add")
    public String addPromotion(@ModelAttribute Promotion promotion,
                               @RequestParam(required = false) List<Integer> productIds,
                               @RequestParam(required = false) List<Integer> categoryIds,
                               Model model) {
        try {
            Integer vendorId = promotion.getVendor() != null ? promotion.getVendor().getId() : null; // Sửa: Check null
            if (vendorId == null) {
                throw new RuntimeException("Vendor ID is required");
            }
            Vendor vendor = vendorService.findById(vendorId)
                    .orElseThrow(() -> new RuntimeException("Vendor not found"));
            promotionService.createPromotion(promotion, vendor, productIds, categoryIds);
            return "redirect:/admin/promotions";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi tạo khuyến mãi: " + e.getMessage());
            model.addAttribute("vendors", vendorService.findAll());
            model.addAttribute("categories", categoryService.findAllWithProducts());
            model.addAttribute("promotion", promotion);
            return "admin/promotion/promotions";
        }
    }


    @PostMapping("/edit/{id}")
    public String editPromotion(
            @PathVariable Integer id,
            @ModelAttribute Promotion promotion,
            @RequestParam(required = false) List<Integer> productIds,
            @RequestParam(required = false) List<Integer> categoryIds,
            Model model) {
        logger.info("Received POST request to /admin/promotions/edit/{}", id);
        try {
            promotionService.updatePromotion(id, promotion, productIds, categoryIds);
            return "redirect:/admin/promotions";
        } catch (Exception e) {
            logger.error("Error updating promotion {}: {}", id, e.getMessage());
            model.addAttribute("error", "Lỗi cập nhật: " + e.getMessage());
            Optional<Promotion> oldPromotion = promotionService.getPromotionById(id);
            model.addAttribute("promotion", oldPromotion.orElse(promotion));
            model.addAttribute("vendors", vendorService.findAll());
            model.addAttribute("categories", categoryService.findAllWithProducts());
            return "admin/promotion/promotions";
        }
    }

    @GetMapping("/delete/{id}")
    public String deletePromotion(@PathVariable Integer id, Model model) {
        logger.info("Received GET request to /admin/promotions/delete/{}", id);
        try {
            promotionService.deletePromotion(id);
        } catch (Exception e) {
            logger.error("Error deleting promotion {}: {}", id, e.getMessage());
            model.addAttribute("error", "Lỗi xóa: " + e.getMessage());
        }
        return "redirect:/admin/promotions";
    }

    @PostMapping("/deactivate-expired")
    public String deactivateExpired() {
        logger.info("Received POST request to /admin/promotions/deactivate-expired");
        promotionService.deactivateExpiredPromotions();
        return "redirect:/admin/promotions";
    }

    private Sort.Order[] parseSort(String sort) {
        String[] parts = sort.split(",");
        if (parts.length == 2) {
            return new Sort.Order[]{new Sort.Order(Sort.Direction.fromString(parts[1]), parts[0])};
        }
        return new Sort.Order[]{Sort.Order.desc("createdAt")};
    }
}