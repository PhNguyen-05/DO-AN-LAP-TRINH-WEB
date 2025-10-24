package vn.iotstar.starshop.service.impl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
}