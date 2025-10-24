package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "shipments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Shipment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order_id;

    @Column(name = "tracking_number", length = 100, unique = true)
    private String tracking_number;

    @Column(name = "carrier", length = 100)
    private String carrier;

    @Column(name = "shipped_at")
    private LocalDateTime shipped_at;

    @Column(name = "delivered_at")
    private LocalDateTime delivered_at;

    @Column(name = "status", length = 50)
    private String status = "Shipping";

    @Column(name = "created_at")
    private LocalDateTime created_at = LocalDateTime.now();
}
