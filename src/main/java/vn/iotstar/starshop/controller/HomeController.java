package vn.iotstar.starshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.iotstar.starshop.dto.ProductDTO;
import vn.iotstar.starshop.dto.ShopDTO;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model) {

        // 🔹 Tạo danh sách shop mẫu
        List<ShopDTO> topShops = new ArrayList<>();
        topShops.add(new ShopDTO(
                1,
                "Shop Hoa Hồng",
                "https://cdn-icons-png.flaticon.com/512/616/616408.png",
                "Chuyên hoa hồng nhập khẩu sang trọng"
        ));
        topShops.add(new ShopDTO(
                2,
                "Shop Hoa Lan",
                "https://cdn-icons-png.flaticon.com/512/616/616408.png",
                "Hoa lan cao cấp dành cho dịp đặc biệt"
        ));
        topShops.add(new ShopDTO(
                3,
                "Shop Hoa Cúc",
                "https://cdn-icons-png.flaticon.com/512/616/616408.png",
                "Cung cấp hoa cúc tươi mới mỗi ngày"
        ));

        // 🔹 Tạo danh sách sản phẩm nổi bật (liên kết với shop)
        List<ProductDTO> topProducts = new ArrayList<>();
        topProducts.add(new ProductDTO(
                1,
                "Hoa Hồng Đỏ",
                50000,
                "https://cdn.tgdd.vn/2021/07/content/hoa-hong-dep-hoa-hong-do-thumb-800x450.jpg",
                topShops.get(0)
        ));
        topProducts.add(new ProductDTO(
                2,
                "Hoa Lan Trắng",
                120000,
                "https://cdn.tgdd.vn/2021/07/content/hoa-lan-dep-thumb-800x450.jpg",
                topShops.get(1)
        ));
        topProducts.add(new ProductDTO(
                3,
                "Hoa Cúc Vàng",
                30000,
                "https://cdn.tgdd.vn/2021/07/content/hoa-cuc-dep-thumb-800x450.jpg",
                topShops.get(2)
        ));

        // 🔹 Đưa dữ liệu sang view
        model.addAttribute("topProducts", topProducts);
        model.addAttribute("topShops", topShops);

        // Trả về trang home.jsp
        return "home";
        

    }
    
    
    @GetMapping("/about")
    public String about() {
        return "about";  // đúng nếu file nằm ở /WEB-INF/views/about.jsp
    }
    
    @GetMapping("/contact")
    public String contact() {
        return "contact";  // đúng nếu file nằm ở /WEB-INF/views/about.jsp
    }
}
