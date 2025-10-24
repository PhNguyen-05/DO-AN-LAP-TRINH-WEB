//package vn.iotstar.starshop.entity;
//
//import jakarta.persistence.*;
//import lombok.Data;
//import java.math.BigDecimal;
//import java.time.LocalDateTime;
//import java.util.Date;
//
//
//@Entity
//@Table(name = "products")
//@Data
//public class Hoa {
//
//	    @Id
//	    @GeneratedValue(strategy = GenerationType.IDENTITY)
//	    private Integer id;
//
//	    private String sku;
//
//	    private String name;
//
//	    @Column(columnDefinition = "NVARCHAR(MAX)")
//	    private String description;
//
//	    @Column(nullable = false, precision = 10, scale = 2)
//	    private BigDecimal price;
//
//	    private Integer stock;
//
//	    @Column(name = "image_url")
//	    private String imageUrl;
//
//	    @Column(name = "created_at")
//	    private LocalDateTime createdAt;
//
//	    @ManyToOne
//	    @JoinColumn(name = "category_id")
//	    private DanhMucHoa category;
//}
