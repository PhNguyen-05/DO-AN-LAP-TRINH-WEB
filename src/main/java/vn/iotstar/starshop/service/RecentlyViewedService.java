package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.*;

import java.util.List;

public interface RecentlyViewedService {
    void addViewedProduct(User user, Product product);
    List<Product> getRecentlyViewed(User user);
}
