package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.service.CustomerService;
import vn.iotstar.starshop.service.UserService;

import java.util.Optional;

@Controller
@RequestMapping("/admin/customers")
public class AdminCustomerController {

    @Autowired
    private CustomerService customersService;

    @Autowired
    private UserService userService;

    // Hiển thị danh sách khách hàng
    @GetMapping
    public String listCustomers(Model model) {
        model.addAttribute("customers", customersService.findAll());
        model.addAttribute("customer", new Customer());
        model.addAttribute("users", userService.findAll()); // để chọn user khi thêm customer
        return "admin/customer/customers";
    }

    // Thêm khách hàng
    @PostMapping("/add")
    public String addCustomer(@ModelAttribute("customer") Customer customer) {
        customersService.save(customer);
        return "redirect:/admin/customers";
    }

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
}
