package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.service.CustomerService;
import vn.iotstar.starshop.service.OrderService;
import vn.iotstar.starshop.service.UserService;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/customers")
public class AdminCustomerController {

    @Autowired
    private CustomerService customersService;

    @Autowired
    private OrderService orderService;
    
    @Autowired
    private UserService userService;

    // Hiển thị danh sách khách hàng
    @GetMapping
    public String listCustomers(Model model) {
        model.addAttribute("customers", customersService.findAll());
//        model.addAttribute("customer", new Customer());
//        model.addAttribute("users", userService.findAll()); // để chọn user khi thêm customer
        return "admin/customer/customers";
    }

//    // Thêm khách hàng
//    @PostMapping("/add")
//    public String addCustomer(@ModelAttribute("customer") Customer customer) {
//        customersService.save(customer);
//        return "redirect:/admin/customers";
//    }

    // Sửa thông tin khách hàng
    @PostMapping("/edit/{id}")
    public String editCustomer(@PathVariable("id") Integer id, @ModelAttribute("customer") Customer updatedCustomer) {
        Optional<Customer> existing = customersService.findById(id);
        if (existing.isPresent()) {
            Customer customer = existing.get();
            customer.setUserId(updatedCustomer.getUserId());
            customer.setFullName(updatedCustomer.getFullName());
            customer.setPhone(updatedCustomer.getPhone());
            customer.setDefaultAddress(updatedCustomer.getDefaultAddress());
            customersService.save(customer);
        } else {
            return "redirect:/admin/customers?error=CustomerNotFound";
        }
        return "redirect:/admin/customers";
    }

    // Xóa khách hàng
    @GetMapping("/delete/{id}")
    public String deleteCustomer(@PathVariable("id") Integer id) {
        customersService.deleteById(id);
        return "redirect:/admin/customers";
    }
    
 // === PHƯƠNG THỨC MỚI CHO NÚT "XEM LỊCH SỬ MUA HÀNG" ===
    @GetMapping("/history/{id}")
    public String getCustomerHistory(@PathVariable("id") Integer customerId, Model model) {
        // 1. Lấy khách hàng
        Optional<Customer> customerOpt = customersService.findById(customerId);
        if (customerOpt.isEmpty()) {
            return "redirect:/admin/customers?error=CustomerNotFound";
        }
        Customer customer = customerOpt.get();
        model.addAttribute("customer", customer);

        // 2. Lấy danh sách đơn hàng của khách hàng này
        // (Chúng ta sẽ tạo hàm findByCustomer trong OrderService)
        List<Order> orders = orderService.findByCustomer(customer); 
        
        // 3. Thêm danh sách đơn hàng vào model để JSP sử dụng
        model.addAttribute("orders", orders); 

        // 4. Trả về trang JSP
        return "admin/customer/customer-history";
    }
}
