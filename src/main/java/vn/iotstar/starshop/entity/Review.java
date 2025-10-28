package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "reviews", 
       uniqueConstraints = @UniqueConstraint(columnNames = {"customer_id", "product_id"}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // --- Quan hệ với Customer ---
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", nullable = false,
                foreignKey = @ForeignKey(name = "FK_reviews_customer"))
    private Customer customer;

    // --- Quan hệ với Product ---
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false,
                foreignKey = @ForeignKey(name = "FK_reviews_product"))
    private Product product;

    // --- Số sao đánh giá (1–5) ---
    @Column(nullable = false)
    private int rating;

    // --- Nội dung đánh giá ---
    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String comment;

    // --- Ngày người dùng viết đánh giá ---
    @Column(name = "review_date")
    private LocalDateTime reviewDate;

    @Column(name = "created_at")
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

}
