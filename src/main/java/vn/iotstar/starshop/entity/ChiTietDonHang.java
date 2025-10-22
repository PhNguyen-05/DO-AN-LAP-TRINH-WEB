package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "order_details")
@Data
public class ChiTietDonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // Liên kết với bảng orders
    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private DonHang donHang;

    // Liên kết với bảng products
    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Hoa hoa;

    @Column(name = "quantity", nullable = false)
    private Integer soLuong;

    @Column(name = "unit_price", precision = 18, scale = 2, nullable = false)
    private BigDecimal donGia;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date ngayTao = new Date();
}
