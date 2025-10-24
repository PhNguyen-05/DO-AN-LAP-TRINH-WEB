package vn.iotstar.starshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.Order;


public interface OrderRepository extends JpaRepository<Order, Integer> {

    @Query("SELECT d FROM Order d ORDER BY d.created_at DESC")
    List<Order> findRecentOrder(int limit);
}
