package vn.iotstar.starshop.service;


import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Customer;


import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import vn.iotstar.starshop.entity.Customer;
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
    
 
    
    
    
    /**
     * Tìm đơn hàng theo bộ lọc động (status và vendorId)
     */
    List<Order> searchOrders(String status, Integer vendorId);

    /**
     * Cập nhật trạng thái của một đơn hàng
     */
    void updateOrderStatus(Integer orderId, String status);

    /**
     * Tìm đơn hàng theo ID (dùng cho trang chi tiết)
     */
    Optional<Order> findById(Integer id);
    
    /**
     * Tìm đơn hàng theo khách hàng (dùng cho trang lịch sử)
     */
    List<Order> findByCustomer(Customer customer);
    Order placeOrder(Customer customer, String shippingAddress, String phoneNumber, String note, Integer discountCodeId);
}

