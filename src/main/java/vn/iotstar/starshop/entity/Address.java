package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "addresses")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // Liên kết đến Customer
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;
    @ToString.Exclude // Loại trừ customer khỏi toString()

    @Column(nullable = false, length = 100)
    private String label; // Ví dụ: "Nhà riêng", "Công ty"

    @Column(nullable = false, length = 255)
    private String detail; // Ví dụ: "123 Đường ABC, Quận X, TP Y"

    @Column(name = "is_default", nullable = false)
    private boolean defaultAddress = false; // không dùng 'default'

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public Long getCustomerId() {
        return customer != null ? customer.getId().longValue() : null;
    }
}
