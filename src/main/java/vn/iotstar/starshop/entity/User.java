//package vn.iotstar.starshop.entity;
//
//import jakarta.persistence.*;
//import lombok.*;
//import java.time.LocalDateTime;
//
//@Entity
//@Table(name = "users")
//@Data // Tự động sinh Getter, Setter, ToString, Equals, HashCode
//@NoArgsConstructor
//@AllArgsConstructor
//@Builder // Cho phép tạo đối tượng kiểu builder (User.builder().email(...).build())
//public class User {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Integer id;
//
//    @Column(nullable = false, unique = true, length = 255)
//    private String email;
//
//    @Column(name = "password_hash", nullable = false, length = 512)
//    private String passwordHash;
//
//    @Column(nullable = false, unique = true, length = 20)
//    private String phone;
//
//    @Column(nullable = false, length = 20)
//    private String role; // Customer, Employee, Admin
//
//    @Column(nullable = false, length = 20)
//    private String status = "Active";
//
//    @Column(name = "created_at", nullable = false)
//    private LocalDateTime createdAt = LocalDateTime.now();
//
//   
//}






package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // ================== Tài khoản đăng nhập ==================
    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "password_hash", nullable = false, length = 512)
    private String passwordHash;

    @Column(nullable = false, unique = true, length = 20)
    private String phone;

    // ================== Phân quyền & trạng thái ==================
    @Column(nullable = false, length = 20)
    private String role = "Customer"; // Customer, Employee, Admin

    @Column(nullable = false, length = 20)
    private String status = "Inactive"; // Inactive khi mới đăng ký, Active sau khi xác thực OTP

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // ================== Thông tin OTP kích hoạt ==================
    @Column(name = "otp_code", length = 10)
    private String otpCode; // Mã OTP xác thực

    @Column(name = "otp_generated_at")
    private LocalDateTime otpGeneratedAt; // Thời điểm sinh OTP

    // ================== Tiện ích ==================
    public boolean isOtpValid(String otp) {
        if (otpCode == null || otpGeneratedAt == null) return false;
        return otpCode.equals(otp)
                && otpGeneratedAt.plusMinutes(5).isAfter(LocalDateTime.now());
    }
    
 // ✅ Thêm vào cuối class User
    public void setActive(boolean active) {
        this.status = active ? "Active" : "Inactive";
    }

    public boolean isActive() {
        return "Active".equalsIgnoreCase(this.status);
    }
}

