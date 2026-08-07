package vn.iotstar.starshop.service;

import java.util.List;
import java.util.Optional;

import vn.iotstar.starshop.entity.Vendor;

public interface VendorService {
    Vendor findByEmail(String email);
    
    Vendor save(Vendor vendor);
    
    Optional<Vendor> findById(Integer id);
    List<Vendor> findAll();

	void deleteById(Integer id);
	
	
	
	Vendor createVendor(Vendor vendor);
}