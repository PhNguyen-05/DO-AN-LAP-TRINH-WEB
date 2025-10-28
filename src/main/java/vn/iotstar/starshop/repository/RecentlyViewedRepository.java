package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.iotstar.starshop.entity.*;

import java.util.List;
import java.util.Optional;

@Repository
public interface RecentlyViewedRepository extends JpaRepository<RecentlyViewed, Integer> {


    // Lấy 10 sản phẩm gần nhất theo thời gian xem
    List<RecentlyViewed> findTop10ByUserOrderByViewedAtDesc(User user);

    // Tìm sản phẩm đã tồn tại cho user
    Optional<RecentlyViewed> findByUserAndProduct(User user, Product product);

    // Xóa sản phẩm đã xem
    void deleteByUserAndProduct(User user, Product product);

    // Xóa tất cả sản phẩm đã xem
    void deleteByUser(User user);

}
