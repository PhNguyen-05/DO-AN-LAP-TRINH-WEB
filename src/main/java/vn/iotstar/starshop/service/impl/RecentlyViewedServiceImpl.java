package vn.iotstar.starshop.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
<<<<<<< HEAD
=======
import org.springframework.transaction.annotation.Transactional;

>>>>>>> origin/PhuongNguyen
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.RecentlyViewedRepository;
import vn.iotstar.starshop.service.RecentlyViewedService;

<<<<<<< HEAD
=======
import java.time.LocalDateTime;
>>>>>>> origin/PhuongNguyen
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
<<<<<<< HEAD
=======
@Transactional
>>>>>>> origin/PhuongNguyen
public class RecentlyViewedServiceImpl implements RecentlyViewedService {

    private final RecentlyViewedRepository repo;

    @Override
    public void addViewedProduct(User user, Product product) {
<<<<<<< HEAD
        var existing = repo.findByUserAndProduct(user, product);
        RecentlyViewed record = existing.orElseGet(() -> new RecentlyViewed(null, user, product, null));
        record.setViewedAt(java.time.LocalDateTime.now());
=======
        // Kiểm tra nếu đã tồn tại → cập nhật viewedAt
        var existing = repo.findByUserAndProduct(user, product);
        RecentlyViewed record = existing.orElseGet(() -> new RecentlyViewed(null, user, product, null));
        record.setViewedAt(LocalDateTime.now());
>>>>>>> origin/PhuongNguyen
        repo.save(record);
    }

    @Override
    public List<Product> getRecentlyViewed(User user) {
        return repo.findTop10ByUserOrderByViewedAtDesc(user)
<<<<<<< HEAD
                .stream()
                .map(RecentlyViewed::getProduct)
                .collect(Collectors.toList());
=======
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
>>>>>>> origin/PhuongNguyen
    }
}
