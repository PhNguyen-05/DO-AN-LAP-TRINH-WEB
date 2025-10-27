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

    // Tìm kiếm sản phẩm theo keyword với Pageable
    @Query("SELECT p FROM Product p " +
           "WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.category.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Product> searchByKeyword(String keyword, Pageable pageable);

    // Lấy tất cả sản phẩm với phân trang
    @Query("SELECT p FROM Product p")
    Page<Product> findAllProducts(Pageable pageable);
    
    @Query("SELECT p FROM Product p WHERE p.category.id = :categoryId ORDER BY p.createdAt DESC")
    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);

 // ✅ Lấy top sản phẩm mới nhất (không giới hạn danh mục)
    @Query("SELECT p FROM Product p ORDER BY p.createdAt DESC")
    List<Product> findTopNew(Pageable pageable);

    @Query("SELECT p FROM Product p JOIN FETCH p.category")
    Page<Product> findAllWithCategory(Pageable pageable);

    Page<Product> findAll(Specification<Product> spec, Pageable pageable);
    
    List<Product> findByCategoryId(Integer categoryId);

    
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
}