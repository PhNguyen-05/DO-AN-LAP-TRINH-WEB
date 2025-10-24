package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "categories")
@Data
public class DanhMucHoa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String tenDanhMuc;

    @Column(name = "description")
    private String moTa;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date ngayTao = new Date();
}
