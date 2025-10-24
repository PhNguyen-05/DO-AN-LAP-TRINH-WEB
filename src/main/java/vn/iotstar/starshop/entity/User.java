package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data // Tự động sinh Getter, Setter, ToString, Equals, HashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder // Cho phép tạo đối tượng kiểu builder (User.builder().email(...).build())
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "password_hash", nullable = false, length = 512)
    private String passwordHash;

    @Column(nullable = false, unique = true, length = 20)
    private String phone;

    @Column(nullable = false, length = 20)
    private String role; // Customer, Employee, Admin

    @Column(nullable = false, length = 20)
    private String status = "Active";

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

   
}
