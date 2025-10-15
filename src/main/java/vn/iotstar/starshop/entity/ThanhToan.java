package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "ThanhToan")
@Data
public class ThanhToan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_don_hang", nullable = false)
    private DonHang donHang;

    @Column(name = "so_tien", nullable = false)
    private Double soTien;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_thanh_toan")
    private Date ngayThanhToan = new Date();

    @Column(name = "phuong_thuc")
    private String phuongThuc;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}