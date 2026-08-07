package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Payment;
import vn.iotstar.starshop.repository.PaymentRepository;
import vn.iotstar.starshop.service.PaymentService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Override
    @Transactional
    public Payment createPayment(Order order, BigDecimal amount, String method, String gatewayReference) {
        Payment payment = Payment.builder()
                .order(order)
                .amount(amount)
                .paymentMethod(method)
                .paymentDate(LocalDateTime.now())
                .status("Success")
                .gatewayReference(gatewayReference)
                .build();
        return paymentRepository.save(payment);
    }

    @Override
    public List<Payment> getPaymentsByOrder(Order order) {
        return paymentRepository.findByOrder(order);
    }
}
