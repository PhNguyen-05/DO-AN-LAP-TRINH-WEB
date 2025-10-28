package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = {"category", "vendor", "orderDetails", "promotions"})
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 100, unique = true)
    private String sku;

    @Column(length = 200, nullable = false)
    private String name;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(nullable = false, precision = 18, scale = 2)
    private BigDecimal price;

    @Column(nullable = false)
    private Integer stock = 0;

    @Column(name = "image_url", length = 1000)
    private String imageUrl;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();
    
    @Column(name = "sold_quantity", nullable = false)
    private Integer soldQuantity = 0;

    @Column(name = "average_rating", precision = 2, scale = 1)
    private BigDecimal averageRating = BigDecimal.ZERO;

    @ManyToOne
    @JsonIgnoreProperties("products") // tránh gọi products trong category
    private Category category;
    
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "vendor_id")
    private Vendor vendor;
    
    @OneToMany(mappedBy = "product")
    private List<OrderDetail> orderDetails;

    
 // ⭐ Trường transient để đánh dấu sản phẩm có được yêu thích hay không
    @Transient
    private boolean isFavorite;

    @ManyToMany(mappedBy = "products")
    private List<Promotion> promotions;
    
    @Transient
    public Boolean getIsFavorite() {
        // Tạm trả false — tránh lỗi. Sau này thay bằng logic thực tế.
        return Boolean.FALSE;
    }
    
    @Transient
    public BigDecimal getDiscountPercent() {
        if (this.promotions == null || this.promotions.isEmpty()) {
            return BigDecimal.ZERO;
        }
        Promotion active = this.promotions.stream()
            .filter(Promotion::getActive)
            .filter(p -> !p.getStartDate().isAfter(LocalDate.now()) && !p.getEndDate().isBefore(LocalDate.now()))
            .findFirst()
            .orElse(null);
        if (active == null) return BigDecimal.ZERO;
        if (active.getDiscountType() == Promotion.DiscountType.PERCENTAGE)
            return active.getDiscountValue();
        return BigDecimal.ZERO;
    }
}
