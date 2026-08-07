// File: src/main/java/vn/iotstar/starshop/security/CustomUserDetailsService.java
package vn.iotstar.starshop.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
        // Tìm theo email hoặc số điện thoại
        User user = userRepository.findByEmail(identifier)
                .orElseGet(() -> userRepository.findByPhone(identifier)
                        .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy người dùng: " + identifier)));

        if (!user.isActive()) {
            throw new UsernameNotFoundException("Tài khoản chưa được kích hoạt!");
        }

        // Trả về CustomUserDetails, giữ entity User gốc
        return new CustomUserDetails(user);
    }
}
