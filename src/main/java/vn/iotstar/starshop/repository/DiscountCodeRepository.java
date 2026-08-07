package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.starshop.entity.DiscountCode;
import java.util.Optional;

public interface DiscountCodeRepository extends JpaRepository<DiscountCode, Integer> {
    Optional<DiscountCode> findByCode(String code);
    
}
