package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "payments")
@Data
public class ThanhToan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private DonHang donHang;

    @Column(name = "amount", precision = 18, scale = 2, nullable = false)
    private BigDecimal soTien;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "payment_date")
    private Date ngayThanhToan = new Date();

    @Column(name = "payment_method")
    private String phuongThuc;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date ngayTao = new Date();
}
