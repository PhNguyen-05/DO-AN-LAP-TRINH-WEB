package vn.iotstar.starshop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.service.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user/wishlist")
public class WishlistController {

    private final WishlistService wishlistService;
    private final ProductService productService;
    private final UserService userService; // cần thêm để lấy User từ username

    @GetMapping
    public String viewWishlist(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/auth/login";
        }

        User currentUser = userService.findByEmail(userDetails.getUsername());
        List<Product> wishlist = wishlistService.getWishlistByUser(currentUser);
        model.addAttribute("wishlist", wishlist);
        return "user/wishlist"; // /WEB-INF/views/user/wishlist.jsp
    }

 // ✅ Toggle wishlist + flash message
    @PostMapping("/toggle")
    public String toggleWishlist(@RequestParam("productId") Integer productId,
                                 @AuthenticationPrincipal UserDetails userDetails,
                                 RedirectAttributes redirectAttributes,
                                 HttpServletRequest request) {

        if (userDetails == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để sử dụng danh sách yêu thích!");
            return "redirect:/auth/login";
        }

        User currentUser = userService.findByEmail(userDetails.getUsername());
        Product product = productService.findById(productId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        boolean added = wishlistService.toggleWishlist(currentUser, product);

        if (added) {
            redirectAttributes.addFlashAttribute("success", "Đã thêm vào danh sách yêu thích 💖");
        } else {
            redirectAttributes.addFlashAttribute("info", "Đã bỏ khỏi danh sách yêu thích 💔");
        }

        // Quay lại trang trước
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/");
    }
}
