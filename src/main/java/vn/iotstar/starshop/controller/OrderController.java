package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.repository.*;
import vn.iotstar.starshop.service.CartService;
import vn.iotstar.starshop.service.OrderService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/user")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CartService cartService;

    @Autowired
    private DiscountCodeRepository discountCodeRepository;

    /* =======================
       HIỂN THỊ FORM CHECKOUT
    ======================== */
    @GetMapping("/order/checkout")
    public String checkoutForm(@AuthenticationPrincipal UserDetails userDetails,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đặt hàng!");
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Customer customer = customerRepository.findByUserId(user.getId());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy khách hàng.");
            return "redirect:/user/cart";
        }

        Cart cart = cartService.getCartByCustomerId(customer.getId());
        if (cart == null || cart.getCartItems().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng trống!");
            return "redirect:/user/cart";
        }

        List<DiscountCode> vouchers = discountCodeRepository.findAll();
        model.addAttribute("customer", customer);
        model.addAttribute("cart", cart);
        model.addAttribute("vouchers", vouchers);

        return "user/checkout";
    }

    /* =======================
       ÁP DỤNG VOUCHER
    ======================== */
    @PostMapping("/order/applyVoucher")
    public String applyVoucher(@AuthenticationPrincipal UserDetails userDetails,
                               @RequestParam("voucherCode") String voucherCode,
                               Model model,
                               RedirectAttributes redirectAttributes) {

        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để sử dụng voucher!");
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Customer customer = customerRepository.findByUserId(user.getId());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy khách hàng.");
            return "redirect:/user/cart";
        }

        Cart cart = cartService.getCartByCustomerId(customer.getId());
        if (cart == null || cart.getCartItems().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng trống!");
            return "redirect:/user/cart";
        }

        Optional<DiscountCode> optionalVoucher = discountCodeRepository.findByCode(voucherCode);

        if (optionalVoucher.isPresent()) {
            DiscountCode voucher = optionalVoucher.get();
            model.addAttribute("appliedVoucher", voucher);
            model.addAttribute("discountSuccess", true);
            model.addAttribute("discountMessage", "Áp dụng mã giảm giá thành công!");
        } else {
            model.addAttribute("discountSuccess", false);
            model.addAttribute("discountMessage", "Mã giảm giá không hợp lệ hoặc đã hết hạn.");
        }

        model.addAttribute("cart", cart);
        model.addAttribute("customer", customer);

        return "user/checkout";
    }

    /* =======================
       ĐẶT HÀNG → CHUYỂN SANG THANH TOÁN
    ======================== */
    @PostMapping("/order/checkout")
    public String placeOrder(@AuthenticationPrincipal UserDetails userDetails,
                             @RequestParam("shippingAddress") String shippingAddress,
                             @RequestParam("phone") String phone,
                             @RequestParam(value = "note", required = false) String note,
                             @RequestParam(value = "voucherId", required = false) Integer voucherId,
                             RedirectAttributes redirectAttributes) {

        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đặt hàng!");
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Customer customer = customerRepository.findByUserId(user.getId());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy khách hàng.");
            return "redirect:/user/cart";
        }

        try {
            // ✅ Gọi orderService với shippingAddress (thay vì address)
            Order order = orderService.placeOrder(customer, shippingAddress, phone, note, voucherId);

//            redirectAttributes.addFlashAttribute("orderId", order.getId());
//            redirectAttributes.addFlashAttribute("totalAmount", order.getTotalAmount());
//            return "redirect:/user/payment";
            return "redirect:/user/payment?orderId=" + order.getId();

        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/cart";
        }
    }

}
