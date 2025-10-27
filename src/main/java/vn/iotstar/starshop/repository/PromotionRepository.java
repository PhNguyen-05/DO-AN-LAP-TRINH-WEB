package vn.iotstar.starshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.entity.Vendor;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PromotionRepository extends JpaRepository<Promotion, Integer> {

    long countByVendorAndActiveTrue(Vendor vendor);

    Page<Promotion> findByVendor(Vendor vendor, Pageable pageable);

    List<Promotion> findTop5ByVendorOrderByCreatedAtDesc(Vendor vendor);
    
    
    Page<Promotion> findActiveByVendor(Vendor vendor, Pageable pageable);
    
    
    
    Page<Promotion> findByVendorAndActiveTrue(Vendor vendor, Pageable pageable);

    // Tìm promotion áp dụng cho sản phẩm cụ thể
    List<Promotion> findByProductsIdAndActiveTrue(Integer productId);
    
    // Tìm promotion áp dụng cho category
    List<Promotion> findByCategoriesIdAndActiveTrue(Integer categoryId);
    
    @Query("SELECT p FROM Promotion p WHERE p.vendor = :vendor AND LOWER(p.promotionName) LIKE LOWER(CONCAT('%', :name, '%'))")
    Page<Promotion> findByVendorAndPromotionNameContaining(@Param("vendor") Vendor vendor, @Param("name") String name, Pageable pageable);
    
    @Query("SELECT p FROM Promotion p WHERE LOWER(p.promotionName) LIKE LOWER(CONCAT('%', :name, '%'))")
    Page<Promotion> findByPromotionNameContaining(@Param("name") String name, Pageable pageable);
    
    // Updated to use LocalDate instead of LocalDateTime
    List<Promotion> findByEndDateBeforeAndActiveTrue(LocalDate endDate);
}