package vn.iotstar.starshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.iotstar.starshop.dto.ProductDTO;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model) {

        // 🔹 Danh sách sản phẩm nổi bật
        List<ProductDTO> topProducts = new ArrayList<>();

        topProducts.add(new ProductDTO(
                1,
                "Hoa Hồng Đỏ",
                50000,
                "hongdo.jpg",   // ảnh nằm trong /images/
                null,
                20,                  // giảm 20%
                150                  // đã bán 150 -> hiện “Best Seller”
        ));

        topProducts.add(new ProductDTO(
                2,
                "Hoa Hướng Dương",
                120000,
                "huongduong.jpg",
                null,
                10,
                95
        ));

        topProducts.add(new ProductDTO(
                3,
                "Hoa Hồng Xanh",
                30000,
                "hongxanh.jpg",
                null,
                0,
                210
        ));

        topProducts.add(new ProductDTO(
                4,
                "Bó Hoa Mix Nhiều Loại",
                80000,
                "mix.jpg",
                null,
                15,
                180
        ));

        // 🔹 Gửi dữ liệu sang view
        model.addAttribute("topProducts", topProducts);

        return "home";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
}
