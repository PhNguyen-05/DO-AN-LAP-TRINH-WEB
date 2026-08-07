package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "recently_viewed",
       uniqueConstraints = {@UniqueConstraint(columnNames = {"user_id", "product_id"})})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecentlyViewed {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(name = "viewed_at", nullable = false)
    private LocalDateTime viewedAt; // Thời gian xem gần nhất
}
