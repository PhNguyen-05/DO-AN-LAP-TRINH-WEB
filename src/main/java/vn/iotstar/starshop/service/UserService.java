package vn.iotstar.starshop.service;

import java.util.List;

import vn.iotstar.starshop.entity.User;

public interface UserService {
    User authenticate(String emailOrPhone, String rawPassword);
    User findByEmail(String email);
    User register(User user);
    
    User save(User user);
    User update(User user);

    long countUsers();

    List<Object[]> findLatestUsers();
  
    List<User> findAll();
}