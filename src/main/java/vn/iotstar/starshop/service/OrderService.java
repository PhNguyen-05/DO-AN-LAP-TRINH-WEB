package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Customer;

public interface OrderService {

    // Tạo đơn hàng từ giỏ hàng của customer
    Order placeOrder(Customer customer, String shippingAddress, String phoneNumber, String note, Integer discountCodeId);

}
