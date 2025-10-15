package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "Hoa")
@Data
public class Hoa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ten_hoa", nullable = false)
    private String tenHoa;

    @Column(name = "mo_ta")
    private String moTa;

    @Column(name = "gia", nullable = false)
    private Double gia;

    @Column(name = "so_luong_ton")
    private Integer soLuongTon;

    @ManyToOne
    @JoinColumn(name = "id_danh_muc")
    private DanhMucHoa danhMuc;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}