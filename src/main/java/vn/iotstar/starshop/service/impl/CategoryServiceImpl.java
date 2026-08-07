package vn.iotstar.starshop.service.impl;

import vn.iotstar.starshop.entity.Category;
<<<<<<< HEAD
=======
import vn.iotstar.starshop.entity.Vendor;
>>>>>>> origin/PhuongNguyen
import vn.iotstar.starshop.repository.CategoryRepository;
import vn.iotstar.starshop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Optional<Category> findById(Integer id) {
        return categoryRepository.findById(id);
    }

    @Override
    public Category save(Category category) {
        return categoryRepository.save(category);
    }

    @Override
    public void deleteById(Integer id) {
        categoryRepository.deleteById(id);
    }
<<<<<<< HEAD
=======
    
    
    @Override
    public List<Category> findByVendor(Vendor vendor) {
        return categoryRepository.findByVendor(vendor);
    }

    @Override
    public List<Category> findByIdsAndVendor(List<Integer> ids, Vendor vendor) {
        return categoryRepository.findByIdsAndVendor(ids, vendor);
    }
    
    @Override
    public List<Category> findAllWithProducts() {
        return categoryRepository.findAllWithProducts();
    }
>>>>>>> origin/PhuongNguyen
}
