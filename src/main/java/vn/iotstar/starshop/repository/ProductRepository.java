package vn.iotstar.starshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    // Lấy top hoa mới trong danh mục 'Hoa', hỗ trợ Pageable
    @Query("SELECT p FROM Product p WHERE p.category.name = 'Hoa' ORDER BY p.createdAt DESC")
    List<Product> findTopNewFlowers(Pageable pageable);
}