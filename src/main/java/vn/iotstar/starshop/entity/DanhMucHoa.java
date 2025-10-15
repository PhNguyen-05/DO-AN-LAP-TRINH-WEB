package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "DanhMucHoa")
@Data
public class DanhMucHoa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ten_danh_muc", nullable = false)
    private String tenDanhMuc;

    @Column(name = "mo_ta")
    private String moTa;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}