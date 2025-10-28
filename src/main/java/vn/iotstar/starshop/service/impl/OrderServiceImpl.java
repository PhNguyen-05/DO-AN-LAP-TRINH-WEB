package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
<<<<<<< HEAD
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.*;
import vn.iotstar.starshop.service.CartService;
import vn.iotstar.starshop.service.OrderService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
=======
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
>>>>>>> origin/PhuongNguyen

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
<<<<<<< HEAD
    private CartService cartService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private DiscountCodeRepository discountCodeRepository;

    @Transactional
    @Override
    public Order placeOrder(Customer customer, String shippingAddress, String phoneNumber, String note, Integer discountCodeId) {

        Cart cart = cartService.getCartByCustomerId(customer.getId());
        if (cart == null || cart.getCartItems().isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống, không thể đặt hàng!");
        }

        // Tính tổng tiền
        BigDecimal totalAmount = cart.getCartItems().stream()
                .map(item -> item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        DiscountCode discountCode = null;
        if (discountCodeId != null) {
            discountCode = discountCodeRepository.findById(discountCodeId).orElse(null);
            if (discountCode != null) {
                if ("percent".equalsIgnoreCase(discountCode.getDiscount_type())) {
                    BigDecimal discount = totalAmount.multiply(discountCode.getDiscount_value()).divide(BigDecimal.valueOf(100));
                    totalAmount = totalAmount.subtract(discount);
                } else if ("fixed".equalsIgnoreCase(discountCode.getDiscount_type())) {
                    totalAmount = totalAmount.subtract(discountCode.getDiscount_value());
                }
                if (totalAmount.compareTo(BigDecimal.ZERO) < 0) totalAmount = BigDecimal.ZERO;
            }
        }

        // Lưu Order
        Order order = Order.builder()
                .customer(customer)
                .shippingAddress(shippingAddress)
                .phoneNumber(phoneNumber)
                .status("Pending")
                .totalAmount(totalAmount)
                .orderDate(LocalDateTime.now())
                .discountCode(discountCode)
                .note(note)
                .build();
        orderRepository.save(order);

        // Lưu OrderDetail
        for (CartItem item : cart.getCartItems()) {
            OrderDetail detail = OrderDetail.builder()
                    .order(order)
                    .product(item.getProduct())
                    .quantity(item.getQuantity())
                    .unitPrice(item.getProduct().getPrice())
                    .createdAt(LocalDateTime.now())
                    .build();
            orderDetailRepository.save(detail);
        }

        cartService.clearCart(customer.getId());
        return order;
    }
=======
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


>>>>>>> origin/PhuongNguyen
}
