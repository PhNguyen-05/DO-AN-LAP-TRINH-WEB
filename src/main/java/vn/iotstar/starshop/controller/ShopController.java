//package vn.iotstar.starshop.controller;
//
//import java.util.List;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import lombok.RequiredArgsConstructor;
//import vn.iotstar.starshop.entity.Hoa;
//import vn.iotstar.starshop.service.HoaService;
//
//@Controller
//@RequiredArgsConstructor
//public class ShopController {
//
//    private final HoaService hoaService;
//
//    /**
//     * Trang cửa hàng /shop
//     * - Nếu có keyword: tìm kiếm theo tên hoặc mô tả
//     * - Nếu không có keyword: hiển thị sản phẩm mới nhất
//     */
//    @GetMapping("/shop")
//    public String shop(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
//        try {
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                List<Hoa> results = hoaService.searchByKeyword(keyword.trim());
//                model.addAttribute("products", results);
//                model.addAttribute("keyword", keyword);
//            } else {
//                List<Hoa> top = hoaService.findTopNewProducts(8); // lấy 8 sản phẩm mới nhất
//                model.addAttribute("topProducts", top);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("error", "Đã xảy ra lỗi khi tải sản phẩm.");
//        }
//
//        // Trả về trang JSP: /WEB-INF/views/user/shop.jsp
//        return "user/shop";
//    }
//}





//package vn.iotstar.starshop.controller;
//
//import java.util.List;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import lombok.RequiredArgsConstructor;
//import vn.iotstar.starshop.entity.Product;
//import vn.iotstar.starshop.service.ProductService;
//
//@Controller
//@RequiredArgsConstructor
//public class ShopController {
//
//    private final ProductService productService;
//
//    @GetMapping("/shop")
//    public String shop(
//            @RequestParam(value = "keyword", required = false) String keyword,
//            @RequestParam(value = "page", defaultValue = "0") int page,
//            Model model) {
//        try {
//            int pageSize = 8; // số sản phẩm / trang
//            Pageable pageable = PageRequest.of(page, pageSize);
//
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                // Tìm kiếm sản phẩm theo keyword
//                Page<Product> productPage = productService.searchByKeyword(keyword.trim(), pageable);
//                model.addAttribute("products", productPage.hasContent() ? productPage.getContent() : null);
//                model.addAttribute("productPage", productPage);
//                model.addAttribute("keyword", keyword);
//
//            } else {
//                // Không có keyword -> hiển thị 2 mục
//                // 1. Sản phẩm mới nhất (slider) -> lấy 6 sản phẩm mới nhất
//                List<Product> latestProducts = productService.findTopNewProducts(6);
//                model.addAttribute("latestProducts", latestProducts);
//
//                // 2. Tất cả sản phẩm (grid + phân trang)
//                Page<Product> allProductsPage = productService.findAllProducts(pageable);
//                model.addAttribute("allProducts", allProductsPage.getContent());
//                model.addAttribute("productPage", allProductsPage);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("error", "Đã xảy ra lỗi khi tải sản phẩm.");
//        }
//        return "user/shop";
//    }
//}



//package vn.iotstar.starshop.controller;
//
//import java.util.List;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import lombok.RequiredArgsConstructor;
//import vn.iotstar.starshop.entity.Category;
//import vn.iotstar.starshop.entity.Product;
//import vn.iotstar.starshop.service.CategoryService;
//import vn.iotstar.starshop.service.ProductService;
//
//@Controller
//@RequiredArgsConstructor
//public class ShopController {
//
//    private final ProductService productService;
//    private final CategoryService categoryService;
//
//    // Trang shop chính
//    @GetMapping("/shop")
//    public String shop(
//            @RequestParam(value = "keyword", required = false) String keyword,
//            @RequestParam(value = "page", defaultValue = "0") int page,
//            Model model) {
//
//        // Load danh mục cho sidebar / navbar
//        List<Category> categories = categoryService.findAll();
//        model.addAttribute("categories", categories);
//
//        int pageSize = 8; // số sản phẩm / trang
//        Pageable pageable = PageRequest.of(page, pageSize);
//
//        try {
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                // Tìm kiếm sản phẩm theo keyword
//                Page<Product> productPage = productService.searchByKeyword(keyword.trim(), pageable);
//                model.addAttribute("products", productPage.hasContent() ? productPage.getContent() : null);
//                model.addAttribute("productPage", productPage);
//                model.addAttribute("keyword", keyword);
//            } else {
//                // Không có keyword -> hiển thị 2 mục
//                // 1. Sản phẩm mới nhất (slider) -> lấy 6 sản phẩm mới nhất
//                List<Product> latestProducts = productService.findTopNewProducts(6);
//                model.addAttribute("latestProducts", latestProducts);
//
//                // 2. Tất cả sản phẩm (grid + phân trang)
//                Page<Product> allProductsPage = productService.findAllProducts(pageable);
//                model.addAttribute("allProducts", allProductsPage.getContent());
//                model.addAttribute("productPage", allProductsPage);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("error", "Đã xảy ra lỗi khi tải sản phẩm.");
//        }
//        return "user/shop"; // => /WEB-INF/views/user/shop.jsp
//    }
//
//    /**
//     * 📂 Trang hiển thị toàn bộ danh mục (/shop/category)
//     */
//    @GetMapping("/shop/category")
//    public String allCategories(Model model) {
//        List<Category> categories = categoryService.findAll();
//        model.addAttribute("categories", categories);
//        return "user/category"; // /WEB-INF/views/user/categories.jsp
//    }
//
//    /**
//     * 🌸 Lọc sản phẩm theo danh mục (/shop/category/{id})
//     */
//    @GetMapping("/shop/category/{id}")
//    public String shopByCategory(
//            @PathVariable("id") Integer categoryId,
//            @RequestParam(value = "page", defaultValue = "0") int page,
//            Model model) {
//
//        List<Category> categories = categoryService.findAll();
//        model.addAttribute("categories", categories);
//
//        Pageable pageable = PageRequest.of(page, 8);
//        Page<Product> productPage = productService.findByCategoryId(categoryId, pageable);
//
//        model.addAttribute("products", productPage.getContent());
//        model.addAttribute("productPage", productPage);
//        model.addAttribute("selectedCategoryId", categoryId);
//
//        return "user/category"; // /WEB-INF/views/user/category.jsp
//    }
//}








package vn.iotstar.starshop.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import vn.iotstar.starshop.entity.Category;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.service.CategoryService;
import vn.iotstar.starshop.service.ProductService;
import vn.iotstar.starshop.service.PromotionService;

@Controller
@RequiredArgsConstructor
public class ShopController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final PromotionService promotionService;

    /**
     * 🏬 Trang cửa hàng chính (/shop)
     * - Hiển thị sản phẩm mới nhất (carousel)
     * - Hiển thị toàn bộ sản phẩm (phân trang)
     * - Tìm kiếm sản phẩm theo keyword
     * - Hiển thị danh mục và khuyến mãi đang hoạt động
     */
    @GetMapping("/shop")
    public String shopPage(Model model,
                           @RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "keyword", required = false) String keyword) {

        int pageSize = 8;
        Pageable pageable = PageRequest.of(page, pageSize);

        // Danh mục hoa
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                // 🔍 Tìm kiếm sản phẩm theo từ khóa
                Page<Product> productPage = productService.searchByKeyword(keyword.trim(), pageable);
                model.addAttribute("products", productPage.getContent());
                model.addAttribute("productPage", productPage);
                model.addAttribute("keyword", keyword);
            } else {
                // 🌸 Không có keyword → hiển thị shop mặc định
                Page<Product> allProductsPage = productService.findAllProducts(pageable);
                List<Product> latestProducts = productService.findTopNewProducts(6);
                List<Product> discountedProducts = productService.findProductsWithActivePromotions();
                List<Promotion> activePromotions = promotionService.getActivePromotions();

                model.addAttribute("allProducts", allProductsPage.getContent());
                model.addAttribute("productPage", allProductsPage);
                model.addAttribute("latestProducts", latestProducts);
                model.addAttribute("discountedProducts", discountedProducts);
                model.addAttribute("activePromotions", activePromotions);
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Đã xảy ra lỗi khi tải sản phẩm.");
        }

        return "user/shop"; // => /WEB-INF/views/user/shop.jsp
    }

    /**
     * 📂 Trang hiển thị toàn bộ danh mục (/shop/category)
     */
    @GetMapping("/shop/category")
    public String allCategories(Model model) {
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        return "user/category"; // /WEB-INF/views/user/category.jsp
    }

    /**
     * 🌷 Lọc sản phẩm theo danh mục (/shop/category/{id})
     */
    @GetMapping("/shop/category/{id}")
    public String shopByCategory(@PathVariable("id") Integer categoryId,
                                 @RequestParam(value = "page", defaultValue = "0") int page,
                                 Model model) {

        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);

        Pageable pageable = PageRequest.of(page, 8);
        Page<Product> productPage = productService.findByCategoryId(categoryId, pageable);

        model.addAttribute("products", productPage.getContent());
        model.addAttribute("productPage", productPage);
        model.addAttribute("selectedCategoryId", categoryId);

        return "user/category"; // /WEB-INF/views/user/category.jsp
    }
}


