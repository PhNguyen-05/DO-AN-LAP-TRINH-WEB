package vn.iotstar.starshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.starshop.entity.Category;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Review;
import vn.iotstar.starshop.entity.Vendor;

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
	
	
	long countByVendor(Vendor vendor);

    List<Product> findByVendor(Vendor vendor);

    List<Object[]> getTopSellingByVendor(Vendor vendor, int limit);
    
    void delete(Integer id);
    boolean existsBySkuAndVendor(String sku, Vendor vendor);
    
    Page<Product> findByVendor(Vendor vendor, Pageable pageable);
    
    Page<Product> findByVendorAndCategory(Vendor vendor, Category category, Pageable pageable);
    
    Page<Product> findByVendorAndNameContaining(Vendor vendor, String name, Pageable pageable);
    
    Page<Product> findByVendorAndNameContainingAndCategory(Vendor vendor, String name, Category category, Pageable pageable);
    
    List<Product> findByIdsAndVendor(List<Integer> ids, Vendor vendor);
}
