package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.*;

import java.util.List;


/**
 * Service quản lý sản phẩm đã xem của user
 */
public interface RecentlyViewedService {

    /**
     * Thêm hoặc cập nhật sản phẩm đã xem
     * @param user User đang xem
     * @param product Sản phẩm được xem
     */
    void addViewedProduct(User user, Product product);

    /**
     * Lấy danh sách sản phẩm đã xem gần nhất của user (top 10)
     * @param user User
     * @return Danh sách sản phẩm
     */
    List<Product> getRecentlyViewed(User user);

    /**
     * Xóa 1 sản phẩm khỏi danh sách đã xem
     * @param user User
     * @param product Sản phẩm
     */
    void removeViewedProduct(User user, Product product);

    /**
     * Xóa tất cả sản phẩm đã xem của user
     * @param user User
     */
    void clearRecentlyViewed(User user);

 
}
