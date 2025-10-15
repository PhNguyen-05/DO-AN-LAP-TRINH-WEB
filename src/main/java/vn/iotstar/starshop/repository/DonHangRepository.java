package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import vn.iotstar.starshop.entity.DonHang;

import java.util.List;

public interface DonHangRepository extends JpaRepository<DonHang, Integer> {

    @Query("SELECT d FROM DonHang d ORDER BY d.ngayDat DESC")
    List<DonHang> findRecentDonHang(int limit);
}