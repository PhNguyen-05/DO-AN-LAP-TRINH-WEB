package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.iotstar.starshop.repository.*;

import java.util.List;

@Controller
@RequestMapping("/admin/dashboard")
public class AdminDashboardController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @GetMapping
    public String dashboard(Model model) {

        // ===  Thống kê tổng quan ===
        long totalUsers = userRepository.count();
        long totalCustomers = customerRepository.count();
        long totalProducts = productRepository.count();
        long totalOrders = orderRepository.count();

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalCustomers", totalCustomers);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalOrders", totalOrders);

        // === Đơn hàng gần đây ===
        List<Object[]> recentOrders = orderRepository.findRecentOrders();
        model.addAttribute("recentOrders", recentOrders);

        // === Người dùng mới nhất ===
        List<Object[]> newUsers = userRepository.findLatestUsers();
        model.addAttribute("newUsers", newUsers);

        // ===  Dữ liệu cho biểu đồ (doanh thu 6 tháng gần nhất) ===
        List<Object[]> revenueData = orderRepository.getRevenueLast6Months();
        model.addAttribute("revenueData", revenueData);

        // ===  Top sản phẩm bán chạy ===
        List<Object[]> topProducts = orderRepository.getTopSellingProducts();
        model.addAttribute("topProducts", topProducts);

        return "admin/dashboard"; // /WEB-INF/views/admin/dashboard.jsp
    }
}
