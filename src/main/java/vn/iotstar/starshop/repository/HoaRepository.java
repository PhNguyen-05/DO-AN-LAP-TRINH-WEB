//package vn.iotstar.starshop.repository;
//
//import java.util.List;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.Query;
//import vn.iotstar.starshop.entity.Hoa;
//
//public interface HoaRepository extends JpaRepository<Hoa, Integer> {
//
//    // Tìm kiếm sản phẩm theo keyword với Pageable
//    @Query("SELECT p FROM Hoa p " +
//           "WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
//           "OR LOWER(p.category.tenDanhMuc) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
//           "OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
//    Page<Hoa> searchByKeyword(String keyword, Pageable pageable);
//
//    // Lấy tất cả sản phẩm với phân trang
//    @Query("SELECT p FROM Hoa p")
//    Page<Hoa> findAllProducts(Pageable pageable);
//
//    // Lấy top hoa mới trong danh mục 'Hoa', hỗ trợ Pageable
//    @Query("SELECT p FROM Hoa p WHERE p.category.tenDanhMuc = 'Hoa' ORDER BY p.createdAt DESC")
//    List<Hoa> findTopNewFlowers(Pageable pageable);
//}
