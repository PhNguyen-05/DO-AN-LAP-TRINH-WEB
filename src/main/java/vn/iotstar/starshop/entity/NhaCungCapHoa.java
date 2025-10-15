package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "NhaCungCap_Hoa")
@Data
public class NhaCungCapHoa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_nha_cung_cap", nullable = false)
    private NhaCungCap nhaCungCap;

    @ManyToOne
    @JoinColumn(name = "id_hoa", nullable = false)
    private Hoa hoa;

    @Column(name = "gia_cung_cap", nullable = false)
    private Double giaCungCap;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_tao")
    private Date ngayTao = new Date();
}