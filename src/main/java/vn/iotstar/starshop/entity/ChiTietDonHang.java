package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "ChiTietDonHang")
@Data
public class ChiTietDonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_don_hang", nullable = false)
    private DonHang donHang;

    @ManyToOne
    @JoinColumn(name = "id_hoa", nullable = false)
    private Hoa hoa;

    @Column(name = "so_luong", nullable = false)
    private Integer soLuong;

    @Column(name = "don_gia", nullable = false)
    private Double donGia;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}