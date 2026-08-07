package vn.iotstar.starshop.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import vn.iotstar.starshop.entity.Promotion;
import vn.iotstar.starshop.service.PromotionService;

@Controller
@RequestMapping("/shop/promotions")
public class UserPromotionController {

    @Autowired
    private PromotionService promotionService;

    // 🏷️ Hiển thị danh sách khuyến mãi
    @GetMapping
    public String listPromotions(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "8") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by("startDate").descending());
        Page<Promotion> promotions = promotionService.findAll(pageable);

        model.addAttribute("promotions", promotions);
        return "user/promotion-list"; // JSP
    }

    // 🏷️ Chi tiết khuyến mãi
    @GetMapping("/{id}")
    public String promotionDetail(@PathVariable("id") Integer id, Model model) {
        Promotion promo = promotionService.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy khuyến mãi"));
        model.addAttribute("promotion", promo);
        return "user/promotion-detail";
    }
}
