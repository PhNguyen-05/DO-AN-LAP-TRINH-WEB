package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.OrderRepository;
import vn.iotstar.starshop.service.OrderService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;


import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    // === ADMIN FUNCTIONS ===
    @Override
    public long countOrders() {
        return orderRepository.count();
    }

    @Override
    public List<Object[]> findRecentOrders() {
        return orderRepository.findRecentOrders();
    }

    @Override
    public List<Object[]> getRevenueLast6Months() {
        return orderRepository.getRevenueLast6Months();
    }

    @Override
    public List<Object[]> getTopSellingProducts() {
        return orderRepository.getTopSellingProducts();
    }

    // === VENDOR FUNCTIONS ===
    @Override
    public long countByVendorAndCreatedAtBetween(Vendor vendor, LocalDateTime start, LocalDateTime end) {
        return orderRepository.countByVendorAndCreatedAtBetween(vendor, start, end);
    }
    
    
    


    @Override
    public List<Order> getRecentOrdersByVendor(Vendor vendor, int limit) {
        Pageable pageable = PageRequest.of(0, limit);
        return orderRepository.getRecentOrdersByVendor(vendor, pageable);
    }


    @Override
    public List<Order> findByVendor(Vendor vendor) {
        return orderRepository.findByVendor(vendor);
    }
}
