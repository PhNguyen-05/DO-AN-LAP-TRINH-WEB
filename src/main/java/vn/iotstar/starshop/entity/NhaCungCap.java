package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "suppliers")
@Data
public class NhaCungCap {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String tenNhaCungCap;

    @Column(name = "contact_name")
    private String nguoiLienHe;

    @Column(name = "phone")
    private String soDienThoai;

    @Column(name = "email")
    private String email;

    @Column(name = "address")
    private String diaChi;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date ngayTao = new Date();
}
