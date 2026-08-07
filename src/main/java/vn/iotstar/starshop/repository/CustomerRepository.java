package vn.iotstar.starshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.iotstar.starshop.entity.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {
    
	Customer findByUserId(Integer userId); // tìm khách hàng theo user_id
	
	List<Customer> findAll();
}