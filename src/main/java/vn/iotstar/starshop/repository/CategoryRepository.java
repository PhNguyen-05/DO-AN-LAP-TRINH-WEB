package vn.iotstar.starshop.repository;

import vn.iotstar.starshop.entity.Category;
import vn.iotstar.starshop.entity.Vendor;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
Optional<Category> findById(Integer id);
	
	// ✅ Lấy danh mục theo vendor
    @Query("SELECT c FROM Category c WHERE c.vendor = :vendor")
    List<Category> findByVendor(@Param("vendor") Vendor vendor);

    // ✅ Lấy danh mục theo danh sách id và vendor
    @Query("SELECT c FROM Category c WHERE c.id IN :ids AND c.vendor = :vendor")
    List<Category> findByIdsAndVendor(@Param("ids") List<Integer> ids, @Param("vendor") Vendor vendor);
}
