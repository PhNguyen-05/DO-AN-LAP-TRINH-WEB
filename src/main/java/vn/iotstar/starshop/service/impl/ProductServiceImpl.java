package vn.iotstar.starshop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.repository.ProductRepository;
import vn.iotstar.starshop.service.ProductService;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;  

    @Override
    public Page<Product> searchByKeyword(String keyword, Pageable pageable) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Page.empty();
        }
        return productRepository.searchByKeyword(keyword.trim(), pageable);
    }

    @Override
    public List<Product> findTopNewProducts(int limit) {
        return productRepository.findTopNewFlowers(PageRequest.of(0, limit));
    }
    
    @Override
    public Page<Product> findByCategoryId(Integer categoryId, Pageable pageable) {
        return productRepository.findByCategoryId(categoryId, pageable);
    }

    @Override
    public Page<Product> findAllProducts(Pageable pageable) {
        return productRepository.findAllProducts(pageable);
    }
    
    
    
    @Override
    public Page<Product> findAllWithCategory(Pageable pageable) {
        return productRepository.findAllWithCategory(pageable);
    }

    @Override
    public Optional<Product> findById(Integer id) {
        return productRepository.findById(id);
    }

    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }

    @Override
    public void deleteById(Integer id) {
        productRepository.deleteById(id);
    }

    @Override
    public long countProducts() {
        return productRepository.count();
    }
    
    @Override
    public Page<Product> findByNameContainingAndCategoryId(String name, Integer categoryId, Pageable pageable) {
        Specification<Product> spec = Specification.where(null);

        if (name != null && !name.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
        }

        if (categoryId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.join("category").get("id"), categoryId));
        }

        return productRepository.findAll(spec, pageable);
    }
    
    @Override
    public List<Product> findByCategoryId(Integer categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }
}