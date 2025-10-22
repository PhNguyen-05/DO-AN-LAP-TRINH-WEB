package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "inventory_logs")
@Data
public class TonKho {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Hoa hoa;

    @Column(name = "quantity", nullable = false)
    private Integer soLuong;

    @Column(name = "note")
    private String ghiChu;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    private Date ngayCapNhat = new Date();
}
