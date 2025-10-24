package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.starshop.entity.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Integer> {
}
