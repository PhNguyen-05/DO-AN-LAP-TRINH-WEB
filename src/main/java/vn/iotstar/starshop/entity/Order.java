package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Column(name = "order_date")
    private LocalDateTime orderDate = LocalDateTime.now();

    @Column(name = "delivery_date")
    private LocalDateTime deliveryDate;

    @Column(name = "status", length = 50)
    private String status = "Pending";

    @Column(name = "total_amount", precision = 18, scale = 2)
    private BigDecimal totalAmount = BigDecimal.ZERO;

    @Column(name = "shipping_address", length = 500)
    private String shippingAddress;

    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "discount_code_id")
    private DiscountCode discountCode;

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "payment_method", length = 50)
    private String paymentMethod; // "COD" hoặc "BANK_TRANSFER"

    @Column(name = "payment_status", length = 50)
    private String paymentStatus = "Unpaid"; // "Unpaid", "Paid", "Failed"

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();


    // --- Các method hỗ trợ logic Payment ---
    public void setPaymentMethod(String method) {
        this.paymentMethod = method;
    }

    public void setPaymentStatus(String status) {
        this.paymentStatus = status;
    }

    public boolean isPaid() {
        return "Paid".equalsIgnoreCase(this.paymentStatus);
    }

    public boolean isCOD() {
        return "COD".equalsIgnoreCase(this.paymentMethod);
    }

    public boolean isBankTransfer() {
        return "BANK_TRANSFER".equalsIgnoreCase(this.paymentMethod);
    }
    
    @ManyToOne
    @JoinColumn(name = "vendor_id")
    private Vendor vendor;

}
