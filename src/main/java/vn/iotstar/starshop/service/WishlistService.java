package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.*;

import java.util.List;

public interface WishlistService {
    List<Product> getWishlistByUser(User user);

    boolean toggleWishlist(User user, Product product); // Thêm hoặc gỡ yêu thích

    boolean isFavorite(User user, Product product);
    
 // ✅ Kiểm tra sản phẩm đã có trong wishlist chưa
    default boolean isInWishlist(User user, Product product) {
        return getWishlistByUser(user).stream()
                .anyMatch(p -> p.getId().equals(product.getId()));
    }
}
