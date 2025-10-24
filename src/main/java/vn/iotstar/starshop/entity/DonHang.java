//package vn.iotstar.starshop.entity;
//
//import jakarta.persistence.*;
//import lombok.Data;
//import java.math.BigDecimal;
//import java.util.Date;
//
//@Entity
//@Table(name = "orders")
//@Data
//public class DonHang {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Integer id;
//
//    @ManyToOne
//    @JoinColumn(name = "customer_id")
//    private KhachHang khachHang;
//
//    @Temporal(TemporalType.TIMESTAMP)
//    @Column(name = "order_date")
//    private Date ngayDat = new Date();
//
//    @Temporal(TemporalType.TIMESTAMP)
//    @Column(name = "delivery_date")
//    private Date ngayGiao;
//
//    @Column(name = "status")
//    private String trangThai = "Pending";
//
//    @Column(name = "total_amount", precision = 18, scale = 2)
//    private BigDecimal tongTien = BigDecimal.ZERO;
//
//    @Temporal(TemporalType.TIMESTAMP)
//    @Column(name = "created_at")
//    private Date ngayTao = new Date();
//}
