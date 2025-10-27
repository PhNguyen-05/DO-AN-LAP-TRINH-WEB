package vn.iotstar.starshop.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.WishlistRepository;
import vn.iotstar.starshop.service.WishlistService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class WishlistServiceImpl implements WishlistService {

    private final WishlistRepository wishlistRepo;

    @Override
    public List<Product> getWishlistByUser(User user) {
        return wishlistRepo.findByUser(user)
                .stream()
                .map(Wishlist::getProduct)
                .collect(Collectors.toList());
    }

    @Override
    public boolean toggleWishlist(User user, Product product) {
        var existing = wishlistRepo.findByUserAndProduct(user, product);
        if (existing.isPresent()) {
            wishlistRepo.delete(existing.get());
            return false; // Bỏ yêu thích
        } else {
            Wishlist wishlist = new Wishlist(new WishlistId(user.getId(), product.getId()), user, product, null);
            wishlistRepo.save(wishlist);
            return true; // Thêm yêu thích
        }
    }

    @Override
    public boolean isFavorite(User user, Product product) {
        return wishlistRepo.findByUserAndProduct(user, product).isPresent();
    }
}
