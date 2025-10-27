package vn.iotstar.starshop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.starshop.dto.PromotionDTO;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.entity.Vendor;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface PromotionService {
    long countActiveByVendor(Vendor vendor);

    Page<Promotion> findByVendor(Vendor vendor, Pageable pageable);

    List<Promotion> getRecentByVendor(Vendor vendor, int limit);

    Optional<Promotion> findById(Integer id);

    void delete(Integer id);
    void save(Promotion promotion);
    

    Page<Promotion> findActiveByVendor(Vendor vendor, Pageable pageable);
    
    Page<Promotion> findAll(Pageable pageable);

    void deletePromotion(Integer id);

    List<Promotion> getAllPromotions();

    Optional<Promotion> getPromotionById(Integer id);

    BigDecimal getDiscountForProduct(Product product);

    BigDecimal getSalePriceForProduct(Product product);

    void deactivateExpiredPromotions();
    Page<Promotion> findByVendorAndPromotionNameContaining(Vendor vendor, String name, Pageable pageable);
 // THÊM MỚI
    Page<Promotion> findByPromotionNameContaining(String name, Pageable pageable);
    Promotion updatePromotion(Integer id, Promotion updatedPromotion,  List<Integer> productIds, List<Integer> categoryIds);
    Promotion createPromotion(Promotion promotion, Vendor vendor, List<Integer> productIds, List<Integer> categoryIds);
    PromotionDTO toDTO(Promotion promotion);
}