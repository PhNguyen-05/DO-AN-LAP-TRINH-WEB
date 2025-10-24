//package vn.iotstar.starshop.entity;
//
//import jakarta.persistence.*;
//import lombok.Data;
//import java.util.Date;
//
//@Entity
//@Table(name = "shipments")
//@Data
//public class VanChuyen {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Integer id;
//
//    @ManyToOne
//    @JoinColumn(name = "order_id", nullable = false)
//    private DonHang donHang;
//
//    @Column(name = "tracking_number")
//    private String maVanDon;
//
//    @Column(name = "carrier")
//    private String donViGiao;
//
//    @Temporal(TemporalType.TIMESTAMP)
//    @Column(name = "shipped_at")
//    private Date ngayGui;
//
//    @Temporal(TemporalType.TIMESTAMP)
//    @Column(name = "delivered_at")
//    private Date ngayGiao;
//
//    @Column(name = "status")
//    private String trangThai = "Shipping";
//
//    @Temporal(TemporalType.TIMESTAMP)
//    @Column(name = "created_at")
//    private Date ngayTao = new Date();
//}
