package vn.iotstar.starshop.service;

import java.util.List;


import org.springframework.security.core.userdetails.UserDetailsService;

import vn.iotstar.starshop.entity.User;
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
}

