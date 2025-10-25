package vn.iotstar.starshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;
import vn.iotstar.starshop.service.ProductService;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Review;
import vn.iotstar.starshop.entity.Category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {

    private final ProductService productService;

//    @GetMapping("/{id}")
//    public String viewProductDetail(@PathVariable("id") Integer id, Model model) {
//        Product product = productService.findById(id)
//                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm ID: " + id));
//
//        model.addAttribute("product", product);
//
//        // Lấy sản phẩm liên quan cùng danh mục (loại trừ chính sản phẩm hiện tại)
//        Category category = product.getCategory();
//        if (category != null) {
//            List<Product> relatedProducts = productService.findByCategoryId(category.getId())
//                    .stream()
//                    .filter(p -> !p.getId().equals(id))
//                    .limit(4)
//                    .toList();
//
//            model.addAttribute("relatedProducts", relatedProducts);
//        }
//
//        return "user/product-detail";
//    }
    
    @GetMapping("/{id}")
    public String viewProductDetail(@PathVariable("id") Integer id, Model model) {
        Product product = productService.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm ID: " + id));

        model.addAttribute("product", product);

        // Lấy danh sách đánh giá sản phẩm
        List<Review> reviews = productService.getReviewsByProductId(id);
        model.addAttribute("reviews", reviews);

        // Tính điểm trung bình
        double averageRating = 0;
        int reviewCount = reviews.size();
        if (reviewCount > 0) {
            averageRating = reviews.stream()
                    .mapToInt(Review::getRating)
                    .average()
                    .orElse(0);
        }
        model.addAttribute("averageRating", averageRating);
        model.addAttribute("reviewCount", reviewCount);

        // Tính phần trăm từng mức sao
        Map<Integer, Double> ratingPercentages = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            final int ratingValue = i; // ✅ phải khai báo final ở đây
            long count = reviews.stream()
                    .filter(r -> r.getRating() == ratingValue)
                    .count();

            double percent = reviewCount > 0 ? (count * 100.0 / reviewCount) : 0;
            ratingPercentages.put(i, percent);
        }
        model.addAttribute("ratingPercentages", ratingPercentages);

        // Lấy sản phẩm liên quan cùng danh mục
        Category category = product.getCategory();
        if (category != null) {
            List<Product> relatedProducts = productService.findByCategoryId(category.getId())
                    .stream()
                    .filter(p -> !p.getId().equals(id))
                    .limit(4)
                    .toList();

            model.addAttribute("relatedProducts", relatedProducts);
        }

        return "user/product-detail";
    }

}
