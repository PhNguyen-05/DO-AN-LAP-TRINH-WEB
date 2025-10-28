package vn.iotstar.starshop.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.repository.CustomerRepository;
import vn.iotstar.starshop.service.CustomerService;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerRepository customersRepository;

    @Override
    public Customer findByUserId(Integer userId) {
        return customersRepository.findByUserId(userId);
    }

    @Override
    public Customer save(Customer customers) {
        // Nếu tạo mới, set createdAt
        if (customers.getId() == null) {
        	customers.setCreatedAt(LocalDateTime.now());
        }
        return customersRepository.save(customers);
    }
    
    
    @Override
    public List<Customer> findAll() {
        return customersRepository.findAll();
    }

    @Override
    public Optional<Customer> findById(Integer id) {
        return customersRepository.findById(id);
    }


    @Override
    public void deleteById(Integer id) {
        customersRepository.deleteById(id);
    }

    @Override
    public long countCustomers() {
        return customersRepository.count();
    }
}