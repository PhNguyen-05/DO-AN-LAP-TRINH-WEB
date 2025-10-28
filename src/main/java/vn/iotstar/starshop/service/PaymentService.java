package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Payment;
import vn.iotstar.starshop.entity.Order;

import java.math.BigDecimal;
import java.util.List;

public interface PaymentService {
    Payment createPayment(Order order, BigDecimal amount, String method, String gatewayReference);
    List<Payment> getPaymentsByOrder(Order order);
}
