package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.starshop.entity.Cart;
import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.repository.CustomerRepository;
import vn.iotstar.starshop.repository.UserRepository;
import vn.iotstar.starshop.service.CartService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    // ✅ Hiển thị giỏ hàng
    @GetMapping("/cart")
    public String viewCart(Model model,
                           @AuthenticationPrincipal UserDetails userDetails,
                           RedirectAttributes redirectAttributes) {

        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem giỏ hàng!");
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Customer customer = customerRepository.findByUserId(user.getId());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy thông tin khách hàng.");
            return "redirect:/";
        }

        Cart cart = cartService.getCartByCustomerId(customer.getId());
        model.addAttribute("cart", cart);

        // 👉 Trỏ đến file: /WEB-INF/views/user/cart.jsp
        return "user/cart";
    }

    // ✅ Thêm sản phẩm vào giỏ hàng
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("productId") Integer productId,
                            @RequestParam("quantity") Integer quantity,
                            @AuthenticationPrincipal UserDetails userDetails,
                            RedirectAttributes redirectAttributes,
                            HttpSession session) {

        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để thêm vào giỏ hàng!");
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Customer customer = customerRepository.findByUserId(user.getId());
        if (customer == null) {
            throw new RuntimeException("Customer not found");
        }

        cartService.addToCart(customer.getId(), productId, quantity);

        Cart cart = cartService.getCartByCustomerId(customer.getId());
        int newCartSize = (cart != null && cart.getCartItems() != null) ? cart.getCartItems().size() : 0;
        session.setAttribute("cartSize", newCartSize);

        redirectAttributes.addFlashAttribute("success", "Đã thêm sản phẩm vào giỏ hàng!");
        return "redirect:/user/cart";
    }
    
 // Xóa nhiều sản phẩm (bao gồm cả 1 sản phẩm nếu chỉ chọn 1)
    @GetMapping("/cart/delete-selected")
    public String deleteSelectedItems(@RequestParam("ids") String ids,
                                      RedirectAttributes redirectAttributes) {
        for (String idStr : ids.split(",")) {
            cartService.removeItemByCartItemId(Integer.parseInt(idStr.trim()));
        }
        redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm được chọn!");
        return "redirect:/user/cart";
    }

    // ✅ Xoá toàn bộ sản phẩm trong giỏ hàng
    @GetMapping("/cart/clear")
    public String clearCart(@AuthenticationPrincipal UserDetails userDetails,
                            RedirectAttributes redirectAttributes) {

        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xoá giỏ hàng!");
            return "redirect:/auth/login";
        }

        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Customer customer = customerRepository.findByUserId(user.getId());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy khách hàng!");
            return "redirect:/user/cart";
        }

        cartService.clearCart(customer.getId());

        redirectAttributes.addFlashAttribute("success", "Đã xoá toàn bộ sản phẩm trong giỏ hàng!");
        return "redirect:/user/cart";
    }
}
