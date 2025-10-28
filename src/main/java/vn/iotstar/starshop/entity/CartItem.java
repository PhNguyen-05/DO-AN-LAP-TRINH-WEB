package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "cart_items",
       uniqueConstraints = @UniqueConstraint(columnNames = {"cart_id", "product_id"}))
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // ✅ Liên kết đến giỏ hàng
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "cart_id",
        nullable = false,
        foreignKey = @ForeignKey(name = "FK_CARTITEM_CART")
    )
    @ToString.Exclude
    private Cart cart;

    // ✅ Liên kết đến sản phẩm
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "product_id",
        nullable = false,
        foreignKey = @ForeignKey(name = "FK_CARTITEM_PRODUCT")
    )
    @ToString.Exclude
    private Product product;

    @Column(nullable = false)
    private Integer quantity;

    @Column(name = "unit_price", precision = 18, scale = 2, nullable = false)
    private BigDecimal unitPrice;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "selected", nullable = false)
    private Boolean selected = false;

    // ✅ Tính tổng tiền của dòng này
    @Transient
    public BigDecimal getTotalPrice() {
        if (unitPrice == null || quantity == null) return BigDecimal.ZERO;
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }
}
