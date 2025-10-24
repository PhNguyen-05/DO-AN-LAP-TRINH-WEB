package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "employees")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id", nullable = false, unique = true)
    private Integer user_id;

    @Column(name = "full_name", nullable = false, length = 200)
    private String full_name;

    @Column(length = 100)
    private String position;

    @Column(precision = 18, scale = 2)
    private BigDecimal salary;

    @Column(name = "hired_date")
    private LocalDateTime hired_date;

    @Column(name = "created_at")
    private LocalDateTime created_at = LocalDateTime.now();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;
}
