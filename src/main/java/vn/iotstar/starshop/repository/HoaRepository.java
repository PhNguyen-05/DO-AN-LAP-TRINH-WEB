package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import vn.iotstar.starshop.entity.Hoa;

import java.util.List;

public interface HoaRepository extends JpaRepository<Hoa, Integer> {

    @Query("SELECT h FROM Hoa h ORDER BY h.ngayTao DESC")
    List<Hoa> findTopHoa(int limit); // Custom query nếu cần top
}