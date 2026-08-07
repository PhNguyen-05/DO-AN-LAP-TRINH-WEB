package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.iotstar.starshop.dto.CategoryDTO;
import vn.iotstar.starshop.dto.ProductDTO;
import vn.iotstar.starshop.dto.PromotionDTO;
import vn.iotstar.starshop.dto.VendorDTO;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.*;
import vn.iotstar.starshop.service.PromotionService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PromotionServiceImpl implements PromotionService {

    @Autowired
    private PromotionRepository promotionRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private VendorRepository vendorRepository;

    // ==========================
    //        FIND METHODS
    // ==========================

    @Override
    public long countActiveByVendor(Vendor vendor) {
        return promotionRepository.countByVendorAndActiveTrue(vendor);
    }

    @Override
    public Page<Promotion> findByVendor(Vendor vendor, Pageable pageable) {
        return promotionRepository.findByVendor(vendor, pageable);
    }

    @Override
    public List<Promotion> getRecentByVendor(Vendor vendor, int limit) {
        Pageable pageable = PageRequest.of(0, limit, Sort.by("createdAt").descending());
        return promotionRepository.findByVendor(vendor, pageable).getContent();
    }

    @Override
    public Optional<Promotion> findById(Integer id) {
        return promotionRepository.findById(id);
    }

    @Override
    public Page<Promotion> findActiveByVendor(Vendor vendor, Pageable pageable) {
        return promotionRepository.findActiveByVendor(vendor, pageable);
    }

    @Override
    public Page<Promotion> findAll(Pageable pageable) {
        return promotionRepository.findAll(pageable);
    }

    @Override
    public Page<Promotion> findByVendorAndPromotionNameContaining(Vendor vendor, String name, Pageable pageable) {
        return promotionRepository.findByVendorAndPromotionNameContaining(vendor, name, pageable);
    }

    @Override
    public Page<Promotion> findByPromotionNameContaining(String name, Pageable pageable) {
        return promotionRepository.findByPromotionNameContaining(name, pageable);
    }

    // ==========================
    //       CRUD METHODS
    // ==========================

    @Override
    public void save(Promotion promotion) {
        promotionRepository.save(promotion);
    }

    @Override
    public void delete(Integer id) {
        promotionRepository.deleteById(id);
    }

    @Override
    public void deletePromotion(Integer id) {
        promotionRepository.deleteById(id);
    }

    @Override
    public List<Promotion> getAllPromotions() {
        return promotionRepository.findAll();
    }

    @Override
    public Optional<Promotion> getPromotionById(Integer id) {
        return promotionRepository.findById(id);
    }

    // ==========================
    //     CREATE / UPDATE
    // ==========================

    @Override
    public Promotion createPromotion(Promotion promotion, Vendor vendor, List<Integer> productIds, List<Integer> categoryIds) {

        if (vendor == null) {
            throw new RuntimeException("Vendor is required");
        }

        promotion.setVendor(vendor);
        promotion.setCreatedAt(LocalDateTime.now());
        promotion.setActive(true);

        // Gắn sản phẩm
        if (productIds != null && !productIds.isEmpty()) {
            List<Product> products = productRepository.findAllById(productIds);
            promotion.setProducts(products);
        }

        // Gắn danh mục
        if (categoryIds != null && !categoryIds.isEmpty()) {
            List<Category> categories = categoryRepository.findAllById(categoryIds);
            promotion.setCategories(categories);
        }

        return promotionRepository.save(promotion);
    }


    @Override
    public Promotion updatePromotion(Integer id, Promotion updatedPromotion,
                                     List<Integer> productIds, List<Integer> categoryIds) {

        Promotion existing = promotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Promotion not found"));

        existing.setPromotionName(updatedPromotion.getPromotionName());
        existing.setDescription(updatedPromotion.getDescription());
        existing.setDiscountValue(updatedPromotion.getDiscountValue());
        existing.setDiscountType(updatedPromotion.getDiscountType());
        existing.setStartDate(updatedPromotion.getStartDate());
        existing.setEndDate(updatedPromotion.getEndDate());
        existing.setActive(updatedPromotion.getActive());

        if (productIds != null) {
            List<Product> products = productRepository.findAllById(productIds);
            existing.setProducts(products);
        }

        if (categoryIds != null) {
            List<Category> categories = categoryRepository.findAllById(categoryIds);
            existing.setCategories(categories);
        }

        return promotionRepository.save(existing);
    }

    // ==========================
    //        DISCOUNT LOGIC
    // ==========================

    @Override
    public BigDecimal getDiscountForProduct(Product product) {
        List<Promotion> promotions = promotionRepository.findByProductsIdAndActiveTrue(product.getId());
        promotions.addAll(promotionRepository.findByCategoriesIdAndActiveTrue(product.getCategory().getId()));

        BigDecimal maxDiscount = BigDecimal.ZERO;
        for (Promotion promo : promotions) {
            BigDecimal discount = promo.calculateDiscount(product.getPrice());
            if (discount.compareTo(maxDiscount) > 0) {
                maxDiscount = discount;
            }
        }
        return maxDiscount;
    }

    @Override
    public BigDecimal getSalePriceForProduct(Product product) {
        BigDecimal discount = getDiscountForProduct(product);
        return product.getPrice().subtract(discount);
    }

    // ==========================
    //        AUTO DEACTIVATE
    // ==========================

    @Override
    public void deactivateExpiredPromotions() {
        LocalDate now = LocalDate.now();
        List<Promotion> expired = promotionRepository.findByEndDateBeforeAndActiveTrue(now);

        for (Promotion promo : expired) {
            promo.setActive(false);
            promotionRepository.save(promo);
        }
    }
    
    @Override
    public PromotionDTO toDTO(Promotion promotion) {
        if (promotion == null) {
            return null;
        }

        PromotionDTO dto = new PromotionDTO();
        dto.setId(promotion.getId());
        dto.setPromotionName(promotion.getPromotionName());
        dto.setDescription(promotion.getDescription());
        dto.setDiscountValue(promotion.getDiscountValue());
        dto.setDiscountType(promotion.getDiscountType().name());
        dto.setStartDate(promotion.getStartDate());
        dto.setEndDate(promotion.getEndDate());
        dto.setActive(promotion.getActive());

        // Map Vendor to VendorDTO
        if (promotion.getVendor() != null) {
            VendorDTO vendorDTO = new VendorDTO();
            vendorDTO.setId(promotion.getVendor().getId());
            vendorDTO.setShopName(promotion.getVendor().getShopName());
            dto.setVendor(vendorDTO);
        }

        // Map Products to ProductDTOs
        if (promotion.getProducts() != null) {
            List<ProductDTO> productDTOs = promotion.getProducts().stream()
                    .map(product -> {
                        ProductDTO productDTO = new ProductDTO();
                        productDTO.setId(product.getId());
                        productDTO.setName(product.getName());
                        return productDTO;
                    })
                    .collect(Collectors.toList());
            dto.setProducts(productDTOs);
        }

        // Map Categories to CategoryDTOs
        if (promotion.getCategories() != null) {
            List<CategoryDTO> categoryDTOs = promotion.getCategories().stream()
                    .map(category -> {
                        CategoryDTO categoryDTO = new CategoryDTO();
                        categoryDTO.setId(category.getId());
                        categoryDTO.setName(category.getName());
                        return categoryDTO;
                    })
                    .collect(Collectors.toList());
            dto.setCategories(categoryDTOs);
        }

        return dto;
    } 
    
    @Override
    @Transactional(readOnly = true) // <-- RẤT QUAN TRỌNG: Sửa lỗi LazyInitializationException
    public Map<String, Object> getPromotionDetails(Integer id, Vendor vendor) {
        
        // 1. Tìm khuyến mãi và kiểm tra quyền sở hữu
        Optional<Promotion> opt = promotionRepository.findById(id); 
        
        if (opt.isEmpty() || !opt.get().getVendor().getId().equals(vendor.getId())) {
            // Ném lỗi để Controller bắt được
            throw new RuntimeException("Promotion not found or access denied"); 
        }
        
        Promotion promotion = opt.get();

        // 2. Lấy danh sách (Giờ đã an toàn vì @Transactional đang mở)
        // ĐÂY CHÍNH LÀ LOGIC BẠN MUỐN TÁI SỬ DỤNG
        List<String> productNames = promotion.getProducts().stream()
                                            .map(Product::getName)
                                            .collect(Collectors.toList());
        
        List<String> categoryNames = promotion.getCategories().stream()
                                            .map(Category::getName)
                                            .collect(Collectors.toList());

        // 3. Tạo Map để trả về
        Map<String, Object> response = new HashMap<>();
        response.put("productNames", productNames);
        response.put("categoryNames", categoryNames); // (JavaScript của bạn chưa dùng, nhưng có sẵn để dùng sau)
        
        return response;
    }
    
    @Override
    @Transactional // <-- CHÌA KHÓA SỬA LỖI LƯU (SAVE)
    public void updatePromotion(Integer id, Vendor vendor, Promotion updatedData, 
                                List<Integer> productIds, List<Integer> categoryIds) {

        // 1. Tìm khuyến mãi và kiểm tra quyền sở hữu
        Promotion existing = promotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Promotion not found"));

        if (!existing.getVendor().getId().equals(vendor.getId())) {
            throw new RuntimeException("Access denied");
        }

        // 2. Cập nhật các trường đơn giản
        existing.setPromotionName(updatedData.getPromotionName());
        existing.setDescription(updatedData.getDescription());
        existing.setDiscountValue(updatedData.getDiscountValue());
        existing.setDiscountType(updatedData.getDiscountType());
        existing.setStartDate(updatedData.getStartDate());
        existing.setEndDate(updatedData.getEndDate());
        existing.setActive(updatedData.getActive()); // Lấy giá trị active đã xử lý (false nếu null)

        // 3. XỬ LÝ LƯU SẢN PHẨM (ĐÂY LÀ LOGIC BỊ LỖI CỦA BẠN)
        if (productIds != null && !productIds.isEmpty()) {
            // Nếu có danh sách gửi lên -> tìm và gán
            List<Product> products = productRepository.findAllById(productIds);
            // (Bạn có thể thêm bước kiểm tra xem product này có thuộc vendor không nếu cần)
            existing.setProducts(products);
        } else {
            // Nếu gửi lên danh sách rỗng (hoặc null) -> Xóa tất cả
            existing.getProducts().clear(); 
        }

        // 4. XỬ LÝ LƯU DANH MỤC (Tương tự)
        if (categoryIds != null && !categoryIds.isEmpty()) {
            List<Category> categories = categoryRepository.findAllById(categoryIds);
            existing.setCategories(categories);
        } else {
            existing.getCategories().clear();
        }

        // 5. Lưu lại
        // Vì hàm này @Transactional, Hibernate sẽ tự động lưu các thay đổi
        // vào bảng join (promotion_products)
        promotionRepository.save(existing);
    }

    
 // 🆕 Thêm hàm này
    @Override
    public List<Promotion> getActivePromotions() {
        LocalDate today = LocalDate.now();
        return promotionRepository.findByStartDateBeforeAndEndDateAfterAndActiveTrue(today, today);
    }
    
    @Override
    public Promotion getActivePromotionForProduct(Integer productId) {
        return promotionRepository
                .findActivePromotionByProductId(productId, LocalDate.now())
                .orElse(null);
    }

}