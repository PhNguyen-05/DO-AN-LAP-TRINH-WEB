//package vn.iotstar.starshop.repository;
//
//import java.util.List;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.domain.Specification;
//
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.Query;
//
//import vn.iotstar.starshop.entity.Product;
//
//
//public interface ProductRepository extends JpaRepository<Product, Integer> {
//
//    // Tìm kiếm sản phẩm theo keyword với Pageable
//    @Query("SELECT p FROM Product p " +
//           "WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
//           "OR LOWER(p.category.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
//           "OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
//    Page<Product> searchByKeyword(String keyword, Pageable pageable);
//
//    // Lấy tất cả sản phẩm với phân trang
//    @Query("SELECT p FROM Product p")
//    Page<Product> findAllProducts(Pageable pageable);
//    
//    @Query("SELECT p FROM Product p WHERE p.category.id = :categoryId ORDER BY p.createdAt DESC")
//    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);
//
// // ✅ Lấy top sản phẩm mới nhất (không giới hạn danh mục)
//    @Query("SELECT p FROM Product p ORDER BY p.createdAt DESC")
//    List<Product> findTopNew(Pageable pageable);
//
//    @Query("SELECT p FROM Product p JOIN FETCH p.category")
//    Page<Product> findAllWithCategory(Pageable pageable);
//
//    Page<Product> findAll(Specification<Product> spec, Pageable pageable);
//    
//    List<Product> findByCategoryId(Integer categoryId);
//
//}


package vn.iotstar.starshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Vendor;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    // 🔍 Tìm kiếm theo từ khóa (tên, danh mục, mô tả)
    @Query("""
        SELECT p FROM Product p
        WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(p.category.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))
        """)
    Page<Product> searchByKeyword(String keyword, Pageable pageable);

    // 🌸 Lấy tất cả sản phẩm có phân trang
    @Query("SELECT p FROM Product p")
    Page<Product> findAllProducts(Pageable pageable);

    // 🌷 Lấy sản phẩm theo danh mục (mới nhất)
    @Query("SELECT p FROM Product p WHERE p.category.id = :categoryId ORDER BY p.createdAt DESC")
    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);

 // ✅ Lấy top sản phẩm mới nhất (không giới hạn danh mục)
//    @Query("SELECT p FROM Product p ORDER BY p.createdAt DESC")
//    List<Product> findTopNew(Pageable pageable);
//
//    @Query("SELECT p FROM Product p JOIN FETCH p.category")
//    Page<Product> findAllWithCategory(Pageable pageable);
//
//    Page<Product> findAll(Specification<Product> spec, Pageable pageable);
//    
    // List<Product> findByCategoryId(Integer categoryId);

    
    long countByVendor(Vendor vendor);

    List<Product> findByVendor(Vendor vendor);

    @Query("SELECT p.name, SUM(od.quantity) FROM Product p JOIN p.orderDetails od WHERE p.vendor = ?1 GROUP BY p.id, p.name ORDER BY SUM(od.quantity) DESC")
    List<Object[]> getTopSellingByVendor(Vendor vendor, int limit);



    boolean existsBySkuAndVendor(String sku, Vendor vendor);

    Optional<Product> findById(Integer id);
    
    @Query("SELECT p.name, SUM(od.quantity) FROM Product p JOIN p.orderDetails od WHERE p.vendor = ?1 GROUP BY p.id ORDER BY SUM(od.quantity) DESC LIMIT ?2")
    List<Object[]> findTopSellingByVendor(Vendor vendor, int limit);
    
    
    @Query("SELECT p FROM Product p WHERE p.id IN :ids AND p.vendor = :vendor")
    List<Product> findByIdsAndVendor(List<Integer> ids, Vendor vendor);


    // 🌼 Lấy top sản phẩm mới nhất
    @Query("SELECT p FROM Product p ORDER BY p.createdAt DESC")
    List<Product> findTopNew(Pageable pageable);

    // 🌺 Lấy sản phẩm có category (dành cho admin hoặc user)
    @Query(value = "SELECT p FROM Product p JOIN FETCH p.category",
            countQuery = "SELECT COUNT(p) FROM Product p")
     Page<Product> findAllWithCategory(Pageable pageable);

    // 🔎 Cho phép filter bằng Specification
    Page<Product> findAll(Specification<Product> spec, Pageable pageable);

    // 🌻 Lấy danh sách sản phẩm theo danh mục (không phân trang)
    List<Product> findByCategoryId(Integer categoryId);

    // 💰 Lấy top sản phẩm bán chạy
    @Query("SELECT p FROM Product p ORDER BY p.soldQuantity DESC")
    List<Product> findTopSelling(Pageable pageable);

    // ⭐ Lấy top sản phẩm được đánh giá cao
    @Query("SELECT p FROM Product p ORDER BY p.averageRating DESC")
    List<Product> findTopRated(Pageable pageable);

    // 💖 Lấy top sản phẩm được yêu thích nhiều nhất
    @Query("""
            SELECT p 
            FROM Product p 
            LEFT JOIN Wishlist w ON w.product = p
            GROUP BY p
            ORDER BY COUNT(w) DESC
            """)
        List<Product> findMostFavorited(Pageable pageable);
}

