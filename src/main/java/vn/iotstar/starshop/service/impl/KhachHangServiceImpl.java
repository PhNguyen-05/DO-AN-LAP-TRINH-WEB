package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.KhachHang;
import vn.iotstar.starshop.repository.KhachHangRepository;
import vn.iotstar.starshop.service.KhachHangService;

import java.time.LocalDateTime;

@Service
public class KhachHangServiceImpl implements KhachHangService {

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Override
    public KhachHang findByUserId(Integer userId) {
        return khachHangRepository.findByUserId(userId);
    }

    @Override
    public KhachHang save(KhachHang khachHang) {
        // Nếu tạo mới, set createdAt
        if (khachHang.getId() == null) {
            khachHang.setCreatedAt(LocalDateTime.now());
        }
        return khachHangRepository.save(khachHang);
    }
}
