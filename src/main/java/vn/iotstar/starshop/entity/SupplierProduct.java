package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "supplier_products", uniqueConstraints = @UniqueConstraint(columnNames = {"supplier_id","product_id"}))
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SupplierProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "supplier_id", nullable = false)
    private Supplier supplier_id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product_id;

    @Column(name = "supply_price", precision = 18, scale = 2, nullable = false)
    private BigDecimal supply_price;

    @Column(name = "created_at")
    private LocalDateTime created_at = LocalDateTime.now();
}
