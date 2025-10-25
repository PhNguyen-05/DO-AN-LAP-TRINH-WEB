package vn.iotstar.starshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.Product;


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

}