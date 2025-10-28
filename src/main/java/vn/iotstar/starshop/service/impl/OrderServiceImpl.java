package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.OrderRepository;
import vn.iotstar.starshop.service.OrderService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.domain.Page;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
    
    @Override
    public List<Order> findByCustomer(Customer customer) {
        return orderRepository.findByCustomerOrderByOrderDateDesc(customer);
    }
    
    
    /**
     * HÀM 1: TÌM KIẾM ĐƠN HÀNG (Dùng Specification)
     */
    @Override
    public List<Order> searchOrders(String status, Integer vendorId) {
        
        // 1. Tạo một Specification
        Specification<Order> spec = (Root<Order> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            
            // Tạo một danh sách các điều kiện (Predicate)
            List<Predicate> predicates = new ArrayList<>();

            // 2. Thêm điều kiện lọc theo 'status' (nếu có)
            if (status != null && !status.isEmpty()) {
                predicates.add(cb.equal(root.get("status"), status));
            }

            // 3. Thêm điều kiện lọc theo 'vendorId' (nếu có)
            if (vendorId != null) {
                // Giả sử Order entity có trường "vendor", 
                // và chúng ta lọc theo "id" của vendor đó
                predicates.add(cb.equal(root.get("vendor").get("id"), vendorId));
            }

            // 4. Kết hợp tất cả điều kiện bằng "AND"
            return cb.and(predicates.toArray(new Predicate[0]));
        };

        // 5. Sắp xếp (luôn xếp đơn hàng mới nhất lên đầu)
        Sort sort = Sort.by(Sort.Direction.DESC, "orderDate");

        // 6. Trả về kết quả
        return orderRepository.findAll(spec, sort);
    }

    /**
     * HÀM 2: CẬP NHẬT TRẠNG THÁI
     */
    @Override
    public void updateOrderStatus(Integer orderId, String status) {
        // 1. Tìm đơn hàng
        Optional<Order> orderOpt = orderRepository.findById(orderId);

        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            // 2. Cập nhật trạng thái
            order.setStatus(status);
            // 3. Lưu lại
            orderRepository.save(order);
        } else {
            // Báo lỗi nếu controller không tìm thấy
            throw new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId);
        }
    }

    /**
     * CÁC HÀM KHÁC MÀ CONTROLLER CẦN
     */
     
    @Override
    public Optional<Order> findById(Integer id) {
        return orderRepository.findById(id);
    }


}
