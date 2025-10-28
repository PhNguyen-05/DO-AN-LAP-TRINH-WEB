package vn.iotstar.starshop.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.UserRepository;
import vn.iotstar.starshop.repository.VendorRepository;
import vn.iotstar.starshop.service.VendorService;

@Service
public class VendorServiceImpl implements VendorService {

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    
    @Autowired
    private UserRepository userRepository;

    @Override
    public Vendor findByEmail(String email) {
        return vendorRepository.findByUserEmail(email);
    }
    
    @Override
    public Vendor save(Vendor vendor) {
        return vendorRepository.save(vendor);
    }
    
    @Override
    public Optional<Vendor> findById(Integer id) {
        return vendorRepository.findById(id);
    }

    @Override
    public List<Vendor> findAll() {
        return vendorRepository.findAll();
    }
    
    @Override
    public void deleteById(Integer id) {
        vendorRepository.deleteById(id);
    }
    
  
//    @Override
//    @Transactional
//    public Vendor createVendor(Vendor vendor) {
//
//        // Kiểm tra email đã tồn tại
//        if(userRepository.findByEmail(vendor.getEmail()).isPresent()) {
//            throw new RuntimeException("Email đã tồn tại, vui lòng chọn email khác.");
//        }
//
//        // 1️⃣ Tạo User
//        User user = new User();
//        user.setEmail(vendor.getEmail());
//        user.setPhone(vendor.getPhone());
//        user.setPasswordHash(passwordEncoder.encode("123456")); // mật khẩu mặc định
//        user.setRole("Vendor");
//        user.setActive(true);
//
//        // Lưu User
//        userRepository.save(user);
//
//        // 2️⃣ Gán User cho Vendor
//        vendor.setUser(user);
//
//        // 3️⃣ Lưu Vendor
//        return vendorRepository.save(vendor);
//    }
    
    @Override
    @Transactional
    public Vendor createVendor(Vendor vendor) {

        // Kiểm tra email đã tồn tại
        if(userRepository.findByEmail(vendor.getEmail()).isPresent()) {
            throw new RuntimeException("Email đã tồn tại, vui lòng chọn email khác.");
        }

        // 1️⃣ Kiểm tra shopName
        if(vendor.getShopName() == null || vendor.getShopName().trim().isEmpty()) {
            throw new RuntimeException("Tên shop không được để trống.");
        }

        // 2️⃣ Tạo User
        User user = new User();
        user.setEmail(vendor.getEmail());
        user.setPhone(vendor.getPhone());
        user.setPasswordHash(passwordEncoder.encode("123456")); // mật khẩu mặc định
        user.setRole("Vendor");
        user.setActive(true);

        // Lưu User
        userRepository.save(user);

        // 3️⃣ Gán User cho Vendor
        vendor.setUser(user);

        // 4️⃣ Gán thời gian tạo nếu null
        if(vendor.getCreatedAt() == null) {
            vendor.setCreatedAt(LocalDateTime.now());
        }

        // 5️⃣ Lưu Vendor
        return vendorRepository.save(vendor);
    }

}