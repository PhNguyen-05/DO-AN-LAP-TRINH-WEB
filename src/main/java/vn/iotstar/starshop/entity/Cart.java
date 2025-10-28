package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "carts")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "customer_id",
        foreignKey = @ForeignKey(name = "FK_CART_CUSTOMER")
    )
    @ToString.Exclude
    private Customer customer;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @Builder.Default
    private List<CartItem> cartItems = new ArrayList<>();

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    // ✅ Thêm hàm tính tổng tiền giỏ hàng (cho JSP dùng)
    @Transient
    public BigDecimal getTotalAmount() {
        if (cartItems == null || cartItems.isEmpty()) {
            return BigDecimal.ZERO;
        }
        return cartItems.stream()
                .map(CartItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // ✅ Cho JSP dùng thuộc tính ${cart.items} thay vì ${cart.cartItems}
    @Transient
    public List<CartItem> getItems() {
        return this.cartItems;
    }
}
