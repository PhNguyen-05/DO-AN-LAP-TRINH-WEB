package vn.iotstar.starshop.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.RecentlyViewedRepository;
import vn.iotstar.starshop.service.RecentlyViewedService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class RecentlyViewedServiceImpl implements RecentlyViewedService {

    private final RecentlyViewedRepository repo;

    @Override
    public void addViewedProduct(User user, Product product) {
        // Kiểm tra nếu đã tồn tại → cập nhật viewedAt
        var existing = repo.findByUserAndProduct(user, product);
        RecentlyViewed record = existing.orElseGet(() -> new RecentlyViewed(null, user, product, null));
        record.setViewedAt(LocalDateTime.now());
        repo.save(record);
    }

    @Override
    public List<Product> getRecentlyViewed(User user) {
        return repo.findTop10ByUserOrderByViewedAtDesc(user)
                   .stream()
                   .map(RecentlyViewed::getProduct)
                   .collect(Collectors.toList());
    }

    @Override
    public void removeViewedProduct(User user, Product product) {
        repo.deleteByUserAndProduct(user, product);
    }

    @Override
    public void clearRecentlyViewed(User user) {
        repo.deleteByUser(user);
    }
}
