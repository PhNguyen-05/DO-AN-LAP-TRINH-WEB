package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order_id;

    @Column(name = "amount", precision = 18, scale = 2, nullable = false)
    private BigDecimal amount;

    @Column(name = "payment_method", length = 50)
    private String payment_method;

    @Column(name = "payment_date")
    private LocalDateTime payment_date = LocalDateTime.now();

    @Column(name = "status", length = 50)
    private String status = "Pending";

    @Column(name = "gateway_reference", length = 200)
    private String gateway_reference;

    @Column(name = "created_at")
    private LocalDateTime created_at = LocalDateTime.now();
}
