//package vn.iotstar.starshop.entity;
//
//import jakarta.persistence.*;
//import lombok.Data;
//
//import java.time.LocalDateTime;
//
//@Data
//@Entity
//@Table(name = "promotions")
//public class Promotion {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Integer id;
//
//    @Column(name = "promotion_name", nullable = false)
//    private String promotionName;
//
//    @Column(name = "description")
//    private String description;
//
//    @Column(name = "discount_value", precision = 18, scale = 2)
//    private java.math.BigDecimal discountValue;
//
//    @Column(name = "start_date")
//    private LocalDateTime startDate;
//
//    @Column(name = "end_date")
//    private LocalDateTime endDate;
//
//    @Column(name = "is_active")
//    private Boolean active = true;
//
//    @ManyToOne
//    @JoinColumn(name = "vendor_id", nullable = false)
//    private Vendor vendor;
//
//    @Column(name = "created_at")
//    private LocalDateTime createdAt = LocalDateTime.now();
//}

package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "promotions")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = {"products", "categories", "vendor"})
public class Promotion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "promotion_name", nullable = false, length = 200)
    private String promotionName;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "discount_value", nullable = false, precision = 18, scale = 2)
    private BigDecimal discountValue;

    @Enumerated(EnumType.STRING)
    @Column(name = "discount_type", nullable = false)
    private DiscountType discountType;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Column(name = "is_active")
    private Boolean active = true;

    @ManyToOne
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "promotion_product",
               joinColumns = @JoinColumn(name = "promotion_id"),
               inverseJoinColumns = @JoinColumn(name = "product_id"))
    private List<Product> products;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "promotion_category",
               joinColumns = @JoinColumn(name = "promotion_id"),
               inverseJoinColumns = @JoinColumn(name = "category_id"))
    private List<Category> categories;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    public enum DiscountType {
        PERCENTAGE, FIXED
    }

    // Phương thức tính giá giảm
    public BigDecimal calculateDiscount(BigDecimal originalPrice) {
        if (!active || startDate.isAfter(LocalDate.now()) || endDate.isBefore(LocalDate.now())) {
            return BigDecimal.ZERO;
        }
        if (discountType == DiscountType.PERCENTAGE) {
            return originalPrice.multiply(discountValue.divide(BigDecimal.valueOf(100)));
        } else if (discountType == DiscountType.FIXED) {
            return discountValue.min(originalPrice); // Đảm bảo không giảm quá giá gốc
        }
        return BigDecimal.ZERO;
    }
    
 // Thêm getter formatted cho JSP
    public String getStartDateFormatted() {
        if (startDate == null) return "Không xác định";
        return startDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getEndDateFormatted() {
        if (endDate == null) return "Không xác định";
        return endDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    
    @Transient
    public Long getStatusCode() {
        LocalDate today = LocalDate.now();
        if (endDate != null && endDate.isBefore(today)) {
            return 0L; // đã hết hạn
        }
        if (startDate != null && startDate.isAfter(today)) {
            return 2L; // sắp diễn ra
        }
        return 1L; // đang diễn ra
    }

    @Transient
    public String getStatusLabel() {
        Long code = getStatusCode();
        if (code == null) return "Không xác định";
        return switch (code.intValue()) {
            case 0 -> "Đã hết hạn";
            case 2 -> "Sắp diễn ra";
            default -> "Đang hoạt động";
        };
    }

    @Transient
    public String getCreatedAtFormatted() {
        if (this.createdAt == null) return "Không xác định";
        // Ví dụ định dạng: 27/10/2025 18:15
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return this.createdAt.format(fmt);
    }
    
    @Transient
    public Date getStartDateAsDate() {
        if (this.startDate == null) return null;
        return Date.from(this.startDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    @Transient
    public Date getEndDateAsDate() {
        if (this.endDate == null) return null;
        return Date.from(this.endDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }
}