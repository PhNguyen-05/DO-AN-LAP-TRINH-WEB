package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.service.OrderService;
import vn.iotstar.starshop.service.VendorService;

import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class AdminOrderController {

    @Autowired
    private OrderService orderService; // Bạn cần tạo service này

    @Autowired
    private VendorService vendorService; // Dùng để lọc theo shop

    /**
     * 📋 Hiển thị danh sách đơn hàng (có lọc)
     */
    @GetMapping
    public String listOrders(Model model,
                             @RequestParam(name = "status", required = false) String status,
                             @RequestParam(name = "vendorId", required = false) Integer vendorId) {

        // Lấy danh sách đơn hàng đã lọc (bạn cần implement logic này trong service)
        // Tạm thời, chúng ta sẽ gọi một hàm search (tìm kiếm)
        List<Order> orders = orderService.searchOrders(status, vendorId);

        // Lấy danh sách vendor để đổ vào <select> lọc
        List<Vendor> vendors = vendorService.findAll();

        model.addAttribute("orders", orders);
        model.addAttribute("vendors", vendors);
        model.addAttribute("selectedStatus", status); // Giữ lại giá trị lọc
        model.addAttribute("selectedVendorId", vendorId); // Giữ lại giá trị lọc
        model.addAttribute("title", "Quản Lý Đơn Hàng");

        return "admin/order/orders"; // Đường dẫn tới file orders.jsp
    }

    /**
     * 🔄 Cập nhật trạng thái đơn hàng (xử lý từ modal)
     */
    @PostMapping("/update-status")
    public String updateOrderStatus(@RequestParam("orderId") Integer orderId,
                                    @RequestParam("status") String status,
                                    RedirectAttributes redirectAttributes) {
        try {
            orderService.updateOrderStatus(orderId, status); // Bạn cần tạo hàm này
            redirectAttributes.addFlashAttribute("success", "Cập nhật trạng thái đơn hàng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/orders";
    }

    /**
     * 🧾 Xem chi tiết đơn hàng (Sẽ cần cho nút "Xem")
     */
    @GetMapping("/detail/{id}")
    public String viewOrderDetail(@PathVariable("id") Integer id, Model model) {
        Order order = orderService.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        
        // Bạn cần đảm bảo Order có chứa danh sách OrderDetails
        model.addAttribute("order", order);
        model.addAttribute("title", "Chi Tiết Đơn Hàng");
        
        // Tạo file order-detail.jsp để hiển thị
        return "admin/order/order-detail"; 
    }
}