package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "supplier_products")
@Data
public class NhaCungCapHoa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "supplier_id", nullable = false)
    private NhaCungCap nhaCungCap;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Hoa hoa;

    @Column(name = "supply_price", precision = 18, scale = 2, nullable = false)
    private BigDecimal giaCungCap;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date ngayTao = new Date();
}
