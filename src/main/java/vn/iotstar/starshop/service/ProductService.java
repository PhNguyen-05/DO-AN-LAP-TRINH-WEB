package vn.iotstar.starshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.starshop.entity.Product;

public interface ProductService {
	Page<Product> searchByKeyword(String keyword, Pageable pageable);
    List<Product> findTopNewProducts(int limit);
    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);
    Page<Product> findAllProducts(Pageable pageable);
}
