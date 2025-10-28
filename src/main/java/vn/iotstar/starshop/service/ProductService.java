//package vn.iotstar.starshop.service;
//
//import java.util.List;
//import java.util.Optional;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//
//import vn.iotstar.starshop.entity.Product;
//import vn.iotstar.starshop.entity.Review;
//
//public interface ProductService {
//	Page<Product> searchByKeyword(String keyword, Pageable pageable);
//    List<Product> findTopNewProducts(int limit);
//    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);
//    Page<Product> findAllProducts(Pageable pageable);
//    
//    
//    
//    long countProducts();
//
//	Page<Product> findAllWithCategory(Pageable pageable);
//
//	Optional<Product> findById(Integer id);
//
//	Product save(Product product);
//
//	void deleteById(Integer id);
//	
//	Page<Product> findByNameContainingAndCategoryId(String name, Integer categoryId, Pageable pageable);
//	
//	List<Product> findByCategoryId(Integer categoryId);
//	
//	List<Review> getReviewsByProductId(Integer productId);
//}




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

    // 🔍 Tìm kiếm theo từ khóa
    Page<Product> searchByKeyword(String keyword, Pageable pageable);

    // 🌸 Lấy sản phẩm mới nhất
    List<Product> findTopNewProducts(int limit);

    // 🌷 Lấy sản phẩm theo danh mục
    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);

    // 🌼 Lấy tất cả sản phẩm
    Page<Product> findAllProducts(Pageable pageable);

    
    
   
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


    // 🔢 Đếm tổng sản phẩm
    long countProducts();

    // 🌺 Lấy tất cả sản phẩm cùng category
    Page<Product> findAllWithCategory(Pageable pageable);

    // 🔎 Tìm theo ID
    Optional<Product> findById(Integer id);

    // 💾 Lưu sản phẩm
    Product save(Product product);

    // ❌ Xóa theo ID
    void deleteById(Integer id);

    // 🔍 Tìm theo tên + danh mục
    Page<Product> findByNameContainingAndCategoryId(String name, Integer categoryId, Pageable pageable);

    // 🌻 Lấy danh sách sản phẩm theo danh mục (không phân trang)
    List<Product> findByCategoryId(Integer categoryId);

    // ⭐ Lấy danh sách review theo product
    List<Review> getReviewsByProductId(Integer productId);

    // ------------------------------------------------------
    // 🌈 Các phương thức mở rộng cho trang chủ (Guest/User)
    // ------------------------------------------------------
    List<Product> getTopSellingForGuest();      // 10 sp bán chạy nhất
    List<Product> getNewestProducts();          // 20 sp mới nhất
    List<Product> getBestSellingProducts();     // 20 sp bán chạy
    List<Product> getTopRatedProducts();        // 20 sp đánh giá cao
    List<Product> getMostFavoritedProducts();   // 20 sp yêu thích nhiều

    List<Product> findAll();
    
    List<Product> findProductsWithActivePromotions();
}
