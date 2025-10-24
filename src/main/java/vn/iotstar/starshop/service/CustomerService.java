package vn.iotstar.starshop.service;

import java.util.List;
import java.util.Optional;

import vn.iotstar.starshop.entity.Customer;

public interface CustomerService {

	Customer findByUserId(Integer userId);

//	Customer save(Customer khachHang);
	

	
	List<Customer> findAll();

    Optional<Customer> findById(Integer id);

    Customer save(Customer customer);

    void deleteById(Integer id);

    long countCustomers();
}