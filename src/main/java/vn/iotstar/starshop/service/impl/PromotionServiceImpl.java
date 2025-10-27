package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.PromotionRepository;
import vn.iotstar.starshop.service.PromotionService;

import java.util.List;
import java.util.Optional;

@Service
public class PromotionServiceImpl implements PromotionService {

    @Autowired
    private PromotionRepository promotionRepository;

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
    public void save(Promotion promotion) {
        promotionRepository.save(promotion);
    }

    @Override
    public void delete(Integer id) {
        promotionRepository.deleteById(id);
    }
    
    
    @Override
    public Page<Promotion> findActiveByVendor(Vendor vendor, Pageable pageable) {
        return promotionRepository.findActiveByVendor(vendor, pageable);
    }
}