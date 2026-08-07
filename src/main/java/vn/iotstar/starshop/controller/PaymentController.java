package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.repository.OrderRepository;

@Controller
@RequestMapping("/user")
public class PaymentController {

    @Autowired
    private OrderRepository orderRepository;

    /* =======================
       HIỂN THỊ FORM PAYMENT
    ======================== */
    @GetMapping("/payment")
    public String showPaymentPage(@RequestParam("orderId") Integer orderId, Model model) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        
        model.addAttribute("order", order);   // Truyền object order
        return "user/payment";
    }


    /* =======================
       XÁC NHẬN THANH TOÁN
    ======================== */
    @PostMapping("/payment/confirm")
    public String confirmPayment(@RequestParam("orderId") Integer orderId,
                                 @RequestParam("method") String method,
                                 Model model) {

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));

        String message;

        switch (method) {
            case "COD":
                order.setPaymentMethod("COD");
                order.setPaymentStatus("Chưa thanh toán");
                message = "✅ Đặt hàng thành công! Bạn sẽ thanh toán khi nhận hàng.";
                break;

            case "BANK":
                order.setPaymentMethod("BANK");
                order.setPaymentStatus("Đã thanh toán");
                message = "✅ Thanh toán qua chuyển khoản ngân hàng thành công!";
                break;

            case "MOMO":
                order.setPaymentMethod("MOMO");
                order.setPaymentStatus("Đã thanh toán");
                message = "✅ Thanh toán qua ví MoMo thành công!";
                break;

            default:
                message = "❌ Phương thức thanh toán không hợp lệ.";
                break;
        }

        orderRepository.save(order);

        // Truyền thông báo và orderId sang success page
        model.addAttribute("message", message);
        model.addAttribute("orderId", orderId);

        return "user/payment_success";
    }

}
