package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Category;

import vn.iotstar.starshop.entity.Vendor;


import java.util.List;
import java.util.Optional;

public interface CategoryService {
    List<Category> findAll();
    Optional<Category> findById(Integer id);
    Category save(Category category);
    void deleteById(Integer id);

    
    List<Category> findByVendor(Vendor vendor);
    List<Category> findByIdsAndVendor(List<Integer> ids, Vendor vendor);
    List<Category> findAllWithProducts();

}
