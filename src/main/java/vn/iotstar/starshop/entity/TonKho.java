package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "TonKho")
@Data
public class TonKho {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_hoa", nullable = false)
    private Hoa hoa;

    @Column(name = "so_luong", nullable = false)
    private Integer soLuong;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_cap_nhat")
    private Date ngayCapNhat = new Date();
}