package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.iotstar.starshop.entity.Customers;

@Repository
public interface CustomersRepository extends JpaRepository<Customers, Integer> {
    
	Customers findByUserId(Integer userId); // tìm khách hàng theo user_id
}