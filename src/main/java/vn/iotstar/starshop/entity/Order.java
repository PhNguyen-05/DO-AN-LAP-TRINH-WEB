package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private Customer customer_id;

    @Column(name = "order_date")
    private LocalDateTime order_date = LocalDateTime.now();

    @Column(name = "delivery_date")
    private LocalDateTime delivery_date;

    @Column(name = "status", length = 50)
    private String status = "Pending";

    @Column(name = "total_amount", precision = 18, scale = 2)
    private BigDecimal total_amount = BigDecimal.ZERO;

    @Column(name = "shipping_address", length = 500)
    private String shipping_address;

    @Column(name = "phone_number", length = 20)
    private String phone_number;

    @Column(name = "discount_code_id")
    private Integer discount_code_id;

    @Column(name = "created_at")
    private LocalDateTime created_at = LocalDateTime.now();
}
