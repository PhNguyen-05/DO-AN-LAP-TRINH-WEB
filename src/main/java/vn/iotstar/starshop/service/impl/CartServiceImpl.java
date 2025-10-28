package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.*;
import vn.iotstar.starshop.service.CartService;
import java.math.BigDecimal;
import java.util.Iterator;

@Service
@Transactional
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;
<<<<<<< HEAD
    

    @Override
    @Transactional
=======

    @Override
>>>>>>> origin/PhuongNguyen
    public void addToCart(Integer customerId, Integer productId, Integer quantity) {
        // 1️⃣ Tìm khách hàng
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

<<<<<<< HEAD
        // 2️⃣ Tìm giỏ hàng của khách, nếu chưa có thì tạo mới
=======
        // 2️⃣ Tìm giỏ hàng của khách
>>>>>>> origin/PhuongNguyen
        Cart cart = cartRepository.findByCustomerId(customerId)
                .orElseGet(() -> {
                    Cart newCart = Cart.builder()
                            .customer(customer)
                            .build();
                    return cartRepository.save(newCart);
                });

        // 3️⃣ Tìm sản phẩm
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // 4️⃣ Kiểm tra xem sản phẩm đã có trong giỏ chưa
<<<<<<< HEAD
        CartItem existingItem = cartItemRepository.findByCartIdAndProductId(cart.getId(), productId)
                .orElse(null);

        if (existingItem != null) {
            // ✅ Nếu có rồi thì cộng thêm số lượng
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            existingItem.setUnitPrice(product.getPrice());
            cartItemRepository.save(existingItem);
        } else {
            // ✅ Nếu chưa có thì thêm mới
            CartItem newItem = CartItem.builder()
                    .cart(cart)
                    .product(product)
                    .quantity(quantity)
                    .unitPrice(product.getPrice())
                    .selected(true)
                    .build();
            cartItemRepository.save(newItem);
        }
    }


=======
        CartItem item = cartItemRepository.findByCartIdAndProductId(cart.getId(), productId)
                .orElseGet(() -> {
                    CartItem newItem = CartItem.builder()
                            .cart(cart)
                            .product(product)
                            .quantity(0)
                            .unitPrice(product.getPrice())
                            .build();
                    return newItem;
                });

        // 5️⃣ Cộng thêm số lượng
        item.setQuantity(item.getQuantity() + quantity);
        item.setUnitPrice(product.getPrice());

        // 6️⃣ Lưu item
        cartItemRepository.save(item);
    }

>>>>>>> origin/PhuongNguyen
    @Override
    public Cart getCartByCustomerId(Integer customerId) {
        return cartRepository.findByCustomerId(customerId).orElse(null);
    }

    @Override
    public void clearCart(Integer customerId) {
        cartRepository.findByCustomerId(customerId).ifPresent(cart -> {
            cartItemRepository.deleteAll(cart.getCartItems());
        });
    }
    
    @Override
    public void removeItemByCartItemId(Integer cartItemId) {
        cartItemRepository.findById(cartItemId)
                .ifPresent(cartItemRepository::delete);
    }


    @Override
    public BigDecimal getTotalAmount(Integer customerId) {
        return cartRepository.findByCustomerId(customerId)
                .map(cart -> cart.getCartItems().stream()
                        .map(CartItem::getTotalPrice)
                        .reduce(BigDecimal.ZERO, BigDecimal::add))
                .orElse(BigDecimal.ZERO);
    }
<<<<<<< HEAD
    @Override
    public void updateSelection(Integer cartItemId, boolean selected) {
        cartItemRepository.findById(cartItemId).ifPresent(item -> {
            item.setSelected(selected);
            cartItemRepository.save(item);
        });
    }


    
=======
>>>>>>> origin/PhuongNguyen
}
