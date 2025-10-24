package vn.iotstar.starshop.service.impl;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.iotstar.starshop.entity.Customers;
import vn.iotstar.starshop.repository.CustomersRepository;
import vn.iotstar.starshop.service.CustomersService;

@Service
public class CustomersServiceImpl implements CustomersService {

    @Autowired
    private CustomersRepository customersRepository;

    @Override
    public Customers findByUserId(Integer userId) {
        return customersRepository.findByUserId(userId);
    }

    @Override
    public Customers save(Customers customers) {
        // Nếu tạo mới, set createdAt
        if (customers.getId() == null) {
        	customers.setCreatedAt(LocalDateTime.now());
        }
        return customersRepository.save(customers);
    }
}