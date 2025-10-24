package vn.iotstar.starshop.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.repository.UserRepository;
import vn.iotstar.starshop.service.UserService;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    // ✅ Đăng nhập (so sánh mật khẩu thường)
    @Override
    public User authenticate(String emailOrPhone, String rawPassword) {
    	Optional<User> opt;

        // 🔍 Nếu chuỗi nhập có ký tự '@' → là email
        if (emailOrPhone.contains("@")) {
            opt = userRepository.findByEmail(emailOrPhone);
        } 
        else {
            // 🔍 Ngược lại, giả định là số điện thoại
            opt = userRepository.findByPhone(emailOrPhone);
        }

        // Không tìm thấy tài khoản
        if (opt.isEmpty()) return null;

        User u = opt.get();

        // ⚠ Nếu tài khoản bị khóa
        if (!"Active".equalsIgnoreCase(u.getStatus())) return null;
        // ⚠ So sánh mật khẩu thường (không mã hoá)
        if (!rawPassword.equals(u.getPasswordHash())) return null;

        return u;
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    // ✅ Đăng ký (lưu mật khẩu thường, không mã hoá)
    @Override
    public User register(User user) {
        // Kiểm tra email trùng
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new IllegalArgumentException("❌ Email đã tồn tại trong hệ thống!");
        }

        // Kiểm tra số điện thoại hợp lệ (nếu có)
        if (user.getPhone() != null && !user.getPhone().isBlank()) {
            if (!user.getPhone().matches("^0\\d{9,10}$")) {
                throw new IllegalArgumentException("❌ Số điện thoại không hợp lệ! (phải gồm 10–11 chữ số, bắt đầu bằng 0)");
            }
        }

        // ⚠ Không mã hoá mật khẩu — giữ nguyên chuỗi nhập
        user.setPasswordHash(user.getPasswordHash());

        // Thiết lập mặc định
        user.setStatus("Active");
        if (user.getRole() == null || user.getRole().isBlank()) {
            user.setRole("Customer");
        }
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }

        // Lưu DB
        return userRepository.save(user);
    }
    
    // ✅ Lưu hoặc cập nhật (dùng trong reset mật khẩu)
    @Override
    public User save(User user) {
        if (user == null) throw new IllegalArgumentException("User is null");

        // ⚠ Giữ nguyên mật khẩu người nhập, không encode
        if (user.getPasswordHash() == null || user.getPasswordHash().isBlank()) {
            throw new IllegalArgumentException("Mật khẩu không được để trống!");
        }

        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }

        return userRepository.save(user);
    }

    // ✅ Alias cho save() (để dễ mở rộng)
    @Override
    public User update(User user) {
        return save(user);
    }
}
