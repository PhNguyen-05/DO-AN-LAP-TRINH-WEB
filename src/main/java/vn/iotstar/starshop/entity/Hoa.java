package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "products")
@Data
public class Hoa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String tenHoa;

    @Column(name = "description")
    private String moTa;

    @Column(name = "price", precision = 18, scale = 2, nullable = false)
    private BigDecimal gia;

    @Column(name = "stock")
    private Integer soLuongTon;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private DanhMucHoa danhMuc;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date ngayTao = new Date();
}
