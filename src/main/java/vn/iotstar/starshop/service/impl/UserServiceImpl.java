//package vn.iotstar.starshop.service.impl;
//
//import org.springframework.stereotype.Service;
//import org.springframework.beans.factory.annotation.Autowired;
//import vn.iotstar.starshop.entity.User;
//import vn.iotstar.starshop.repository.UserRepository;
//import vn.iotstar.starshop.service.UserService;
//
//import java.time.LocalDateTime;
//import java.util.List;
//
//import java.util.Optional;
//
//@Service
//public class UserServiceImpl implements UserService {
//
//    @Autowired
//    private UserRepository userRepository;
//
//    // ✅ Đăng nhập (so sánh mật khẩu thường)
//    @Override
//    public User authenticate(String emailOrPhone, String rawPassword) {
//    	Optional<User> opt;
//
//        // 🔍 Nếu chuỗi nhập có ký tự '@' → là email
//        if (emailOrPhone.contains("@")) {
//            opt = userRepository.findByEmail(emailOrPhone);
//        } 
//        else {
//            // 🔍 Ngược lại, giả định là số điện thoại
//            opt = userRepository.findByPhone(emailOrPhone);
//        }
//
//        // Không tìm thấy tài khoản
//        if (opt.isEmpty()) return null;
//
//        User u = opt.get();
//
//        // ⚠ Nếu tài khoản bị khóa
//        if (!"Active".equalsIgnoreCase(u.getStatus())) return null;
//        // ⚠ So sánh mật khẩu thường (không mã hoá)
//        if (!rawPassword.equals(u.getPasswordHash())) return null;
//
//        return u;
//    }
//
//    @Override
//    public User findByEmail(String email) {
//        return userRepository.findByEmail(email).orElse(null);
//    }
//
//    // ✅ Đăng ký (lưu mật khẩu thường, không mã hoá)
//    @Override
//    public User register(User user) {
//        // Kiểm tra email trùng
//        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
//            throw new IllegalArgumentException("❌ Email đã tồn tại trong hệ thống!");
//        }
//
//        // Kiểm tra số điện thoại hợp lệ (nếu có)
//        if (user.getPhone() != null && !user.getPhone().isBlank()) {
//            if (!user.getPhone().matches("^0\\d{9,10}$")) {
//                throw new IllegalArgumentException("❌ Số điện thoại không hợp lệ! (phải gồm 10–11 chữ số, bắt đầu bằng 0)");
//            }
//        }
//
//        // ⚠ Không mã hoá mật khẩu — giữ nguyên chuỗi nhập
//        user.setPasswordHash(user.getPasswordHash());
//
//        // Thiết lập mặc định
//        user.setStatus("Active");
//        if (user.getRole() == null || user.getRole().isBlank()) {
//            user.setRole("Customer");
//        }
//        if (user.getCreatedAt() == null) {
//            user.setCreatedAt(LocalDateTime.now());
//        }
//
//        // Lưu DB
//        return userRepository.save(user);
//    }
//    
//    // ✅ Lưu hoặc cập nhật (dùng trong reset mật khẩu)
//    @Override
//    public User save(User user) {
//        if (user == null) throw new IllegalArgumentException("User is null");
//
//        // ⚠ Giữ nguyên mật khẩu người nhập, không encode
//        if (user.getPasswordHash() == null || user.getPasswordHash().isBlank()) {
//            throw new IllegalArgumentException("Mật khẩu không được để trống!");
//        }
//
//        if (user.getCreatedAt() == null) {
//            user.setCreatedAt(LocalDateTime.now());
//        }
//
//        return userRepository.save(user);
//    }
//
//    // ✅ Alias cho save() (để dễ mở rộng)
//    @Override
//    public User update(User user) {
//        return save(user);
//    }
//    
//    
//    @Override
//    public long countUsers() {
//        return userRepository.count();
//    }
//
//    @Override
//    public List<Object[]> findLatestUsers() {
//        return userRepository.findLatestUsers();
//    }
//    @Override
//    public List<User> findAll() {
//        return userRepository.findAll();
//    }
//}









package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.repository.UserRepository;
import vn.iotstar.starshop.service.UserService;
import vn.iotstar.starshop.util.EmailUtil;

import java.time.LocalDateTime;
import java.util.List;

import java.util.Optional;
import java.util.Random;

@Service
public class UserServiceImpl implements UserService {

    @Autowired 
    private UserRepository userRepository;

    @Autowired 
    private PasswordEncoder passwordEncoder;

    @Autowired 
    private EmailUtil emailUtil;

    // ==============================
    // 🔐 Dùng cho Spring Security
    // ==============================
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy người dùng: " + username));

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPasswordHash())
                .roles(user.getRole())
                .disabled(!"Active".equalsIgnoreCase(user.getStatus()))
                .build();
    }

    // ==============================
    // 🔑 Đăng nhập thủ công (không dùng Security)
    // ==============================
    @Override
    public User authenticate(String emailOrPhone, String rawPassword) {
        Optional<User> opt = emailOrPhone.contains("@")
                ? userRepository.findByEmail(emailOrPhone)
                : userRepository.findByPhone(emailOrPhone);

        if (opt.isEmpty()) return null;
        User u = opt.get();

        // Nếu tài khoản bị khóa / chưa kích hoạt
        if (!"Active".equalsIgnoreCase(u.getStatus())) return null;
        
     // 👇 Thêm đoạn này để kiểm tra
        System.out.println(">>> Raw password nhập vào: " + rawPassword);
        System.out.println(">>> Password trong DB: " + u.getPasswordHash());
        System.out.println(">>> Có khớp không: " + passwordEncoder.matches(rawPassword, u.getPasswordHash()));

        // So sánh mật khẩu đã mã hóa
        if (!passwordEncoder.matches(rawPassword, u.getPasswordHash())) return null;

        return u;
    }

    // ==============================
    // 🔍 Tìm người dùng
    // ==============================
    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    // ==============================
    // 📝 Đăng ký tài khoản + Gửi OTP
    // ==============================
    @Override
    public User register(User user) {
        if (existsByEmail(user.getEmail())) {
            throw new IllegalArgumentException("❌ Email đã tồn tại trong hệ thống!");
        }

        if (user.getPhone() != null && !user.getPhone().matches("^0\\d{9,10}$")) {
            throw new IllegalArgumentException("❌ Số điện thoại không hợp lệ!");
        }

        // Mã hóa mật khẩu trước khi lưu
        user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash()));
        user.setStatus("Inactive");
        user.setRole("Customer");
        user.setCreatedAt(LocalDateTime.now());

        // Tạo OTP
        String otp = String.format("%06d", new Random().nextInt(999999));
        user.setOtpCode(otp);
        user.setOtpGeneratedAt(LocalDateTime.now());

        // Lưu và gửi OTP (fake nếu mailSender null)
        userRepository.save(user);
        emailUtil.sendOtpEmail(user.getEmail(), otp);

        return user;
    }

    // ==============================
    // ✅ Xác thực OTP kích hoạt tài khoản
    // ==============================
    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = findByEmail(email);
        if (user == null || user.getOtpCode() == null) return false;

        boolean valid = otp.equals(user.getOtpCode()) &&
                user.getOtpGeneratedAt().plusMinutes(5).isAfter(LocalDateTime.now());

        if (valid) {
            user.setStatus("Active");
            user.setOtpCode(null);
            userRepository.save(user);
        }
        return valid;
    }

    // ==============================
    // 🔁 Đổi mật khẩu (mã hóa)
    @Override
    public User update(User user) {
        if (user.getPasswordHash() != null && !user.getPasswordHash().startsWith("$2a$")) {
            user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash()));
        }
        user.setUpdatedAt(LocalDateTime.now());  // cập nhật thời gian
        return userRepository.save(user);
    }

    @Override
    public User save(User user) {
        if (user.getPasswordHash() != null && !user.getPasswordHash().startsWith("$2a$")) {
            user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash()));
        }
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }
        user.setUpdatedAt(LocalDateTime.now());  // cập nhật thời gian
        return userRepository.save(user);
    }

    // ==============================
    // 📊 Các hàm thống kê
    // ==============================
    @Override
    public long countUsers() {
        return userRepository.count();
    }

    @Override
    public List<Object[]> findLatestUsers() {
        return userRepository.findLatestUsers();
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }
    


}


