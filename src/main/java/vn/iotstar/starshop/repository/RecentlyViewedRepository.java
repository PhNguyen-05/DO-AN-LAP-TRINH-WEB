package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.iotstar.starshop.entity.*;

import java.util.List;
import java.util.Optional;

@Repository
public interface RecentlyViewedRepository extends JpaRepository<RecentlyViewed, Integer> {
    List<RecentlyViewed> findTop10ByUserOrderByViewedAtDesc(User user);
    Optional<RecentlyViewed> findByUserAndProduct(User user, Product product);
}
