package vn.iotstar.starshop.service;

import java.time.LocalDateTime;
import java.util.List;

import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Vendor;

public interface OrderService {

    long countOrders();

    List<Object[]> findRecentOrders();

    List<Object[]> getRevenueLast6Months();

    List<Object[]> getTopSellingProducts();
    
    
    
    
    long countByVendorAndCreatedAtBetween(Vendor vendor, LocalDateTime start, LocalDateTime end);

    List<Order> getRecentOrdersByVendor(Vendor vendor, int limit);

    List<Order> findByVendor(Vendor vendor);
}