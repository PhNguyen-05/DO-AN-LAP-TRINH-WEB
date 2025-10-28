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
import org.springframework.data.domain.*;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.security.CustomUserDetails;
import vn.iotstar.starshop.service.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

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

	// =====================================================
	// 🎁 GIAO DIỆN QUẢN LÝ KHUYẾN MÃI CHO VENDOR
	// =====================================================
	@GetMapping("/promotions")
	public String managePromotions(Model model, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size, @RequestParam(defaultValue = "createdAt,desc") String sort) {

		// ✅ Lấy user đang đăng nhập từ Spring Security thay vì session
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
			return "redirect:/auth/login";
		}

		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
		User currentUser = userDetails.getUser();
		Vendor vendor = vendorService.findByEmail(currentUser.getEmail());

		if (vendor == null) {
			return "redirect:/vendor/register";
		}

		// ✅ Xử lý sắp xếp và phân trang
		String[] sortParts = sort.split(",");
		String sortField = sortParts[0];
		Sort.Direction sortDirection = sortParts.length > 1 && "asc".equalsIgnoreCase(sortParts[1]) ? Sort.Direction.ASC
				: Sort.Direction.DESC;

		Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sortField));
		Page<Promotion> promotionPage = promotionService.findByVendor(vendor, pageable);

		// ✅ Truyền dữ liệu sang JSP
		model.addAttribute("promotions", promotionPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", promotionPage.getTotalPages());
		model.addAttribute("totalItems", promotionPage.getTotalElements());
		model.addAttribute("pageSize", size);
		model.addAttribute("sort", sort);
		model.addAttribute("title", "Quản lý khuyến mãi");
		model.addAttribute("vendorProducts", productService.findByVendor(vendor));
		model.addAttribute("vendorCategories", categoryService.findByVendor(vendor));

		return "vendor/promotions";
	}

	// =====================================================
	// 🎁 FORM THÊM KHUYẾN MÃI
	// =====================================================
	@GetMapping("/add-promotion")
	public String showAddPromotionForm(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
			return "redirect:/auth/login";
		}

		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
		Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());

		if (vendor == null)
			return "redirect:/vendor/register";

		model.addAttribute("vendorProducts", productService.findByVendor(vendor));
		model.addAttribute("vendorCategories", categoryService.findByVendor(vendor));
		return "vendor/add-promotion";
	}

	// =====================================================
	// 🎁 THÊM KHUYẾN MÃI (AJAX)
	// =====================================================
	@PostMapping("/promotions/add")
	@ResponseBody
	public ResponseEntity<String> addPromotion(@RequestParam String promotionName,
			@RequestParam BigDecimal discountValue, @RequestParam Promotion.DiscountType discountType,
			@RequestParam(required = false) String description, @RequestParam String startDate,
			@RequestParam String endDate, @RequestParam(required = false) Boolean active,
			@RequestParam(required = false) List<Integer> productIds,
			@RequestParam(required = false) List<Integer> categoryIds) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
			return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
		}

		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
		Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());
		if (vendor == null)
			return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

		try {
			LocalDate start = LocalDate.parse(startDate);
			LocalDate end = LocalDate.parse(endDate);
			if (start.isAfter(end))
				return new ResponseEntity<>("Ngày bắt đầu phải trước ngày kết thúc", HttpStatus.BAD_REQUEST);

			Promotion promotion = Promotion.builder().promotionName(promotionName).description(description)
					.discountValue(discountValue).discountType(discountType).startDate(start).endDate(end)
					.active(active != null ? active : true).vendor(vendor).createdAt(LocalDateTime.now()).build();

			if (productIds != null && !productIds.isEmpty()) {
				List<Product> products = productService.findByIdsAndVendor(productIds, vendor);
				promotion.setProducts(products);
			}

			if (categoryIds != null && !categoryIds.isEmpty()) {
				List<Category> categories = categoryService.findByIdsAndVendor(categoryIds, vendor);
				promotion.setCategories(categories);
			}

			promotionService.save(promotion);
			return new ResponseEntity<>("Success", HttpStatus.OK);

		} catch (Exception e) {
			return new ResponseEntity<>("Lỗi khi lưu khuyến mãi: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// =====================================================
	// 🎁 FORM CHỈNH SỬA KHUYẾN MÃI
	// =====================================================
	@GetMapping("/edit-promotion")
	public String showEditPromotionForm(@RequestParam Integer id, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
			return "redirect:/auth/login";
		}

		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
		Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());
		if (vendor == null)
			return "redirect:/vendor/register";

		Optional<Promotion> opt = promotionService.findById(id);
		if (opt.isEmpty() || !opt.get().getVendor().getId().equals(vendor.getId())) {
			return "redirect:/vendor/promotions";
		}

		model.addAttribute("promotion", opt.get());
		model.addAttribute("vendorProducts", productService.findByVendor(vendor));
		model.addAttribute("vendorCategories", categoryService.findByVendor(vendor));
		return "vendor/edit-promotion";
	}

	// =====================================================
	// 🎁 CẬP NHẬT KHUYẾN MÃI (AJAX)
	// =====================================================
//	@PostMapping("/promotions/edit/{id}")
//	@ResponseBody
//	public ResponseEntity<String> editPromotion(@PathVariable Integer id, @RequestParam String promotionName,
//			@RequestParam BigDecimal discountValue, @RequestParam Promotion.DiscountType discountType,
//			@RequestParam(required = false) String description, @RequestParam String startDate,
//			@RequestParam String endDate, @RequestParam(required = false) Boolean active,
//			@RequestParam(required = false) List<Integer> productIds,
//			@RequestParam(required = false) List<Integer> categoryIds) {
//
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
//			return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
//		}
//
//		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
//		Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());
//		if (vendor == null)
//			return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
//
//		try {
//			Optional<Promotion> optionalPromotion = promotionService.findById(id);
//			if (optionalPromotion.isEmpty() || !optionalPromotion.get().getVendor().getId().equals(vendor.getId())) {
//				return new ResponseEntity<>("Promotion not found", HttpStatus.NOT_FOUND);
//			}
//
//			Promotion existingPromotion = optionalPromotion.get();
//			LocalDate start = LocalDate.parse(startDate);
//			LocalDate end = LocalDate.parse(endDate);
//			if (start.isAfter(end))
//				return new ResponseEntity<>("Ngày bắt đầu phải trước ngày kết thúc", HttpStatus.BAD_REQUEST);
//
//			existingPromotion.setPromotionName(promotionName);
//			existingPromotion.setDescription(description);
//			existingPromotion.setDiscountValue(discountValue);
//			existingPromotion.setDiscountType(discountType);
//			existingPromotion.setStartDate(start);
//			existingPromotion.setEndDate(end);
//			existingPromotion.setActive(active != null ? active : existingPromotion.getActive());
//
//			if (productIds != null)
//				existingPromotion.setProducts(productService.findByIdsAndVendor(productIds, vendor));
//			if (categoryIds != null)
//				existingPromotion.setCategories(categoryService.findByIdsAndVendor(categoryIds, vendor));
//
//			promotionService.save(existingPromotion);
//			return new ResponseEntity<>("Success", HttpStatus.OK);
//
//		} catch (Exception e) {
//			return new ResponseEntity<>("Lỗi cập nhật khuyến mãi: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}

	@PostMapping("/promotions/edit/{id}")
	@ResponseBody
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
	        @RequestParam(required = false) List<Integer> categoryIds) {

	    // 1. Xác thực vendor (vẫn giữ nguyên)
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
	        return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
	    }
	    CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
	    Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());
	    if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

	    
	    try {
	        // 2. TẠO một đối tượng Promotion "tạm" chỉ để chứa dữ liệu mới
	        // (Chúng ta không load nó ở đây nữa)
	        Promotion updatedData = new Promotion();
	        updatedData.setPromotionName(promotionName);
	        updatedData.setDescription(description);
	        updatedData.setDiscountValue(discountValue);
	        updatedData.setDiscountType(discountType);
	        updatedData.setStartDate(LocalDate.parse(startDate));
	        updatedData.setEndDate(LocalDate.parse(endDate));
	        updatedData.setActive(active != null && active); // <-- Sửa lỗi: nếu active là null, nó phải là false

	        // 3. GỌI HÀM SERVICE MỚI (sẽ được bọc @Transactional)
	        // Service sẽ lo toàn bộ việc tìm, cập nhật, và lưu
	        promotionService.updatePromotion(id, vendor, updatedData, productIds, categoryIds);

	        return new ResponseEntity<>("Success", HttpStatus.OK);

	    } catch (RuntimeException e) {
	        return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>("Lỗi cập nhật khuyến mãi: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	// =====================================================
	// 🎁 XÓA KHUYẾN MÃI (AJAX)
	// =====================================================
	@PostMapping("/promotions/delete/{id}")
	@ResponseBody
	public ResponseEntity<String> deletePromotion(@PathVariable Integer id) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
			return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
		}

		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
		Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());
		if (vendor == null)
			return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

		try {
			Optional<Promotion> opt = promotionService.findById(id);
			if (opt.isEmpty() || !opt.get().getVendor().getId().equals(vendor.getId())) {
				return new ResponseEntity<>("Promotion not found", HttpStatus.NOT_FOUND);
			}

			promotionService.delete(id);
			return new ResponseEntity<>("Success", HttpStatus.OK);

		} catch (Exception e) {
			return new ResponseEntity<>("Error deleting promotion: " + e.getMessage(),
					HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// =====================================================
	// 🎁 LẤY CHI TIẾT SẢN PHẨM CỦA KHUYẾN MÃI (AJAX)
	// =====================================================
	@GetMapping("/promotions/details/{id}")
	@ResponseBody 
	public ResponseEntity<?> getPromotionDetails(@PathVariable Integer id) {
	    
	    // 1. Xác thực vendor (vẫn giữ nguyên)
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth == null || !(auth.getPrincipal() instanceof CustomUserDetails)) {
	        return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
	    }
	    CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
	    Vendor vendor = vendorService.findByEmail(userDetails.getUser().getEmail());
	    if (vendor == null) {
	        return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);
	    }

	    // 2. SỬA LẠI: Gọi hàm Service mới (đã có @Transactional)
	    try {
	        // Hàm service mới sẽ xử lý TẤT CẢ logic, bao gồm cả .getProducts()
	        Map<String, Object> details = promotionService.getPromotionDetails(id, vendor);
	        
	        // Trả về Map (Spring tự động chuyển thành JSON)
	        return ResponseEntity.ok(details); 
	        
	    } catch (RuntimeException e) {
	        // Bắt lỗi "Not found" từ service
	        return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
	    } catch (Exception e) {
	        // Bắt các lỗi khác (ví dụ: LazyInit)
	        e.printStackTrace(); // In lỗi ra console server để debug
	        return new ResponseEntity<>("Server Error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
}
