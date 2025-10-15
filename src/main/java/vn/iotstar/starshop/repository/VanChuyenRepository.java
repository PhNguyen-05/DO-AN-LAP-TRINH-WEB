package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.starshop.entity.VanChuyen;

public interface VanChuyenRepository extends JpaRepository<VanChuyen, Integer> {
}