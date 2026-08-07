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
import vn.iotstar.starshop.service.DiscountService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
public class CheckoutController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CartService cartService;

    @Autowired
    private DiscountService discountService;

    @Autowired
    private DiscountCodeRepository discountCodeRepository;

    /* -----------------------------
       1️⃣ HIỂN THỊ TRANG CHECKOUT
    ------------------------------ */
    @GetMapping("/checkout")
    public String checkoutPage(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(value = "selectedItems", required = false) String selectedItemIds,
            Model model
    ) {
        if (userDetails == null) {
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Customer customer = customerRepository.findByUserId(user.getId());
        Cart cart = cartService.getCartByCustomerId(customer.getId());

        if (cart == null || cart.getCartItems().isEmpty()) {
            return "redirect:/user/cart";
        }

        // ✅ Lấy danh sách sản phẩm được chọn
        List<Integer> selectedIds = (selectedItemIds == null || selectedItemIds.isEmpty())
                ? cart.getCartItems().stream().map(CartItem::getId).toList()
                : List.of(selectedItemIds.split(",")).stream().map(Integer::parseInt).toList();

        List<CartItem> selectedItems = cart.getCartItems()
                .stream()
                .filter(i -> selectedIds.contains(i.getId()))
                .collect(Collectors.toList());

        // ✅ Tính tổng tiền
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : selectedItems) {
            BigDecimal itemTotal = item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            subtotal = subtotal.add(itemTotal);
        }

        // ✅ Gán model
        model.addAttribute("customer", customer);
        model.addAttribute("selectedItems", selectedItems);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("cart", cart);

        return "user/checkout";
    }


    /* -------------------------------------
       2️⃣ ÁP DỤNG MÃ GIẢM GIÁ (Voucher Code)
    -------------------------------------- */
    @PostMapping("/checkout/applyVoucher")
    public String applyVoucher(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("voucherCode") String voucherCode,
            @RequestParam(value = "selectedItems", required = false) String selectedItemIds,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        if (userDetails == null) {
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Customer customer = customerRepository.findByUserId(user.getId());
        Cart cart = cartService.getCartByCustomerId(customer.getId());

        if (cart == null || cart.getCartItems().isEmpty()) {
            redirectAttributes.addFlashAttribute("discountError", "Giỏ hàng của bạn đang trống.");
            return "redirect:/user/cart";
        }

        List<Integer> selectedIds = (selectedItemIds == null || selectedItemIds.isEmpty())
                ? cart.getCartItems().stream().map(CartItem::getId).toList()
                : List.of(selectedItemIds.split(",")).stream().map(Integer::parseInt).toList();

        List<CartItem> selectedItems = cart.getCartItems()
                .stream()
                .filter(i -> selectedIds.contains(i.getId()))
                .collect(Collectors.toList());

        // ✅ Tính subtotal
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : selectedItems) {
            BigDecimal itemTotal = item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            subtotal = subtotal.add(itemTotal);
        }

        // ✅ Tìm voucher
        Optional<DiscountCode> discountOpt = discountCodeRepository.findByCode(voucherCode);

        if (discountOpt.isEmpty()) {
            model.addAttribute("discountSuccess", false);
            model.addAttribute("discountMessage", "❌ Mã giảm giá không hợp lệ!");
        } else {
            DiscountCode discount = discountOpt.get();

            if (discount.getIsActive() == false) {
                model.addAttribute("discountSuccess", false);
                model.addAttribute("discountMessage", "⚠️ Mã giảm giá đã hết hạn hoặc không còn hiệu lực!");
            } else {
                model.addAttribute("discountSuccess", true);
                model.addAttribute("discountMessage", "✅ Áp dụng thành công mã giảm " + discount.getDiscount_type() + "%!");
                model.addAttribute("appliedVoucher", discount);
            }
        }
        

        // ✅ Gán lại các dữ liệu hiển thị trên JSP
        model.addAttribute("customer", customer);
        model.addAttribute("selectedItems", selectedItems);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("cart", cart);

        return "user/checkout";
    }
    
}
