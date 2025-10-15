package vn.iotstar.starshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/dashboard")
public class AdminDashboardController {

    @GetMapping
    public String dashboard(Model model) {
        // Bỏ kiểm tra session để hiển thị dashboard mà không cần login

        // Data giả định cho dashboard (chưa có DB)
        long totalUsers = 1250;
        long totalShops = 150;
        long totalProducts = 2500;
        long totalOrders = 800;

        List<Object> recentOrders = new ArrayList<>();
        recentOrders.add(new Object() { public int id = 1; public String customer = "Nguyễn Văn A"; public double total = 500000; public String status = "Hoàn Thành"; });
        recentOrders.add(new Object() { public int id = 2; public String customer = "Trần Thị B"; public double total = 300000; public String status = "Đang Giao"; });

        List<Object> newUsers = new ArrayList<>();
        newUsers.add(new Object() { public String email = "user1@example.com"; });
        newUsers.add(new Object() { public String email = "user2@example.com"; });

        // Set attributes
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalShops", totalShops);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("recentOrders", recentOrders);
        model.addAttribute("newUsers", newUsers);

        // Data cho charts (giả định)
        model.addAttribute("revenueData", new double[]{12000000, 19000000, 3000000, 5000000, 2000000, 3000000});
        model.addAttribute("topProductsData", new int[]{65, 59, 80, 81});

        return "admin/dashboard"; // /WEB-INF/views/admin/dashboard.jsp
    }
}