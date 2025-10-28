// VendorRepository
package vn.iotstar.starshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.iotstar.starshop.entity.Vendor;

@Repository
public interface VendorRepository extends JpaRepository<Vendor, Integer> {
    Vendor findByUserEmail(String email);  // Sử dụng email vì schema dùng email làm unique identifier
    
    @Query("SELECT v FROM Vendor v WHERE v.shopName LIKE %:kw% OR v.email LIKE %:kw%")
    List<Vendor> searchByKeyword(@Param("kw") String keyword);

}