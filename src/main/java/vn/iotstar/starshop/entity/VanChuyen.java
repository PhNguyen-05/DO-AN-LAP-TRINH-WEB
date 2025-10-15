package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "VanChuyen")
@Data
public class VanChuyen {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_don_hang", nullable = false)
    private DonHang donHang;

    @Column(name = "ma_van_don")
    private String maVanDon;

    @Column(name = "don_vi_giao")
    private String donViGiao;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_gui")
    private Date ngayGui;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_giao")
    private Date ngayGiao;

    @Column(name = "trang_thai")
    private String trangThai = "Đang giao";

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}