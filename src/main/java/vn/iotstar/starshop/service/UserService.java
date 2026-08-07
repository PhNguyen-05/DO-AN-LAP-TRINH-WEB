package vn.iotstar.starshop.service;

<<<<<<< HEAD
import org.springframework.security.core.userdetails.UserDetailsService;
import vn.iotstar.starshop.entity.User;
=======
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.userdetails.UserDetailsService;

import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.entity.Vendor;

>>>>>>> origin/PhuongNguyen
import java.util.List;

public interface UserService extends UserDetailsService {
    User authenticate(String emailOrPhone, String rawPassword);
    User findByEmail(String email);
    User register(User user);
    User save(User user);
    User update(User user);
    boolean existsByEmail(String email);
    boolean verifyOtp(String email, String otp);
    long countUsers();
    List<Object[]> findLatestUsers();
    List<User> findAll();
<<<<<<< HEAD
}
=======
    Optional<User> findById(Integer id);

}

>>>>>>> origin/PhuongNguyen
