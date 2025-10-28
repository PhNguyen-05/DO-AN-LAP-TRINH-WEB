package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.*;
import vn.iotstar.starshop.service.CartService;
import vn.iotstar.starshop.service.OrderService;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
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
}
