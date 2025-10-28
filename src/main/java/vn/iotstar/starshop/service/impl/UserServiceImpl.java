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
<<<<<<< HEAD
=======

>>>>>>> origin/PhuongNguyen
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
<<<<<<< HEAD
   
    @Override
    public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
        // Tìm user theo email trước
        Optional<User> optionalUser = userRepository.findByEmail(identifier);
        User user = optionalUser.orElseGet(() ->
            // Nếu không tìm thấy theo email thì thử theo phone
            userRepository.findByPhone(identifier)
                    .orElseThrow(() -> new UsernameNotFoundException("User not found with email or phone: " + identifier))
        );

        // Trả về đối tượng UserDetails cho Spring Security
        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail()) // hoặc user.getPhone() tùy bạn hiển thị
                .password(user.getPasswordHash())
                .roles(user.getRole())
=======
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy người dùng: " + username));

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPasswordHash())
                .roles(user.getRole())
                .disabled(!"Active".equalsIgnoreCase(user.getStatus()))
>>>>>>> origin/PhuongNguyen
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
<<<<<<< HEAD
=======
    
    @Override
    public Optional<User> findById(Integer userId) {
        return userRepository.findById(userId);
    }


>>>>>>> origin/PhuongNguyen
}


