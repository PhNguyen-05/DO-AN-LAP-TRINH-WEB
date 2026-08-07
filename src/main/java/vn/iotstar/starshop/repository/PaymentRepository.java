package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.starshop.entity.Payment;
import vn.iotstar.starshop.entity.Order;

import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {
    List<Payment> findByOrder(Order order);
}
