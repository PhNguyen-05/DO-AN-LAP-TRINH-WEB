package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.User;

public interface UserService {
    User authenticate(String emailOrPhone, String rawPassword);
    User findByEmail(String email);
    User register(User user);
    
    User save(User user);
    User update(User user);
}