package vn.iotstar.starshop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.VendorRepository;
import vn.iotstar.starshop.service.VendorService;

@Service
public class VendorServiceImpl implements VendorService {

    @Autowired
    private VendorRepository vendorRepository;

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
}