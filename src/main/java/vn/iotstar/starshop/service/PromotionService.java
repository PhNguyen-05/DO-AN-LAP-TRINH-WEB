package vn.iotstar.starshop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.entity.Vendor;

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
}