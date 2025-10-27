package vn.iotstar.starshop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.*;
import vn.iotstar.starshop.service.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wishlist")
public class WishlistController {

    private final WishlistService wishlistService;
    private final ProductService productService;

    @GetMapping
    public String viewWishlist(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<Product> wishlist = wishlistService.getWishlistByUser(currentUser);
        model.addAttribute("wishlist", wishlist);
        return "user/wishlist";
    }

    @PostMapping("/toggle")
    @ResponseBody
    public String toggleWishlist(@RequestParam("productId") Integer productId, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return "unauthenticated";

        Product product = productService.findById(productId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        boolean added = wishlistService.toggleWishlist(currentUser, product);
        return added ? "added" : "removed";
    }
}
