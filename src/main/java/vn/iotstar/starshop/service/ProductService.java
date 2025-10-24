package vn.iotstar.starshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Review;

public interface ProductService {
	Page<Product> searchByKeyword(String keyword, Pageable pageable);
    List<Product> findTopNewProducts(int limit);
    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);
    Page<Product> findAllProducts(Pageable pageable);
    
    
    
    long countProducts();

	Page<Product> findAllWithCategory(Pageable pageable);

	Optional<Product> findById(Integer id);

	Product save(Product product);

	void deleteById(Integer id);
	
	Page<Product> findByNameContainingAndCategoryId(String name, Integer categoryId, Pageable pageable);
	
	List<Product> findByCategoryId(Integer categoryId);
	
	List<Review> getReviewsByProductId(Integer productId);
}
