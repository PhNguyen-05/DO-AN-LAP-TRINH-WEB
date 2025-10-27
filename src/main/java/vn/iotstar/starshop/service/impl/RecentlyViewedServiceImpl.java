package vn.iotstar.starshop.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.RecentlyViewedRepository;
import vn.iotstar.starshop.service.RecentlyViewedService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecentlyViewedServiceImpl implements RecentlyViewedService {

    private final RecentlyViewedRepository repo;

    @Override
    public void addViewedProduct(User user, Product product) {
        var existing = repo.findByUserAndProduct(user, product);
        RecentlyViewed record = existing.orElseGet(() -> new RecentlyViewed(null, user, product, null));
        record.setViewedAt(java.time.LocalDateTime.now());
        repo.save(record);
    }

    @Override
    public List<Product> getRecentlyViewed(User user) {
        return repo.findTop10ByUserOrderByViewedAtDesc(user)
                .stream()
                .map(RecentlyViewed::getProduct)
                .collect(Collectors.toList());
    }
}
