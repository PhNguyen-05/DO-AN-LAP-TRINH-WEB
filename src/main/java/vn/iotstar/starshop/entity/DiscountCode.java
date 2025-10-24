package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "discount_codes")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiscountCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "code", length = 100, nullable = false, unique = true)
    private String code;

    @Column(name = "discount_type", length = 20, nullable = false)
    private String discount_type;

    @Column(name = "discount_value", precision = 18, scale = 2, nullable = false)
    private BigDecimal discount_value;

    @Column(name = "start_date")
    private LocalDateTime start_date;

    @Column(name = "end_date")
    private LocalDateTime end_date;

    @Column(name = "condition_text", length = 500)
    private String condition_text;

    @Column(name = "quantity")
    private Integer quantity = 0;

    @Column(name = "created_at")
    private LocalDateTime created_at = LocalDateTime.now();
}
