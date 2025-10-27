package vn.iotstar.starshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.entity.Vendor;

import java.util.List;

@Repository
public interface PromotionRepository extends JpaRepository<Promotion, Integer> {

    long countByVendorAndActiveTrue(Vendor vendor);

    Page<Promotion> findByVendor(Vendor vendor, Pageable pageable);

    List<Promotion> findTop5ByVendorOrderByCreatedAtDesc(Vendor vendor);
    
    
    Page<Promotion> findActiveByVendor(Vendor vendor, Pageable pageable);
}