package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "DonHang")
@Data
public class DonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang khachHang;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_dat")
    private Date ngayDat = new Date();

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_giao")
    private Date ngayGiao;

    @Column(name = "trang_thai")
    private String trangThai = "Chờ xử lý";

    @Column(name = "tong_tien")
    private Double tongTien = 0.0;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}