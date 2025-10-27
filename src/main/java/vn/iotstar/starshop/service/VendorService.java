package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Vendor;

public interface VendorService {
    Vendor findByEmail(String email);
    
    Vendor save(Vendor vendor);
}