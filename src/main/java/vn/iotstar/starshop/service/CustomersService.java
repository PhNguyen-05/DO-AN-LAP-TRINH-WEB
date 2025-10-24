package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Customers;

public interface CustomersService {

	Customers findByUserId(Integer userId);

	Customers save(Customers khachHang);
}