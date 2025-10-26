package vn.iotstar.starshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import vn.iotstar.starshop.entity.Address;
import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.User;
import vn.iotstar.starshop.service.AddressService;
import vn.iotstar.starshop.service.CustomerService;

import org.springframework.security.core.annotation.AuthenticationPrincipal;

@Controller
@RequestMapping("/user/address")
public class AddressController {

    private final AddressService addressService;
    private final CustomerService customerService;

    public AddressController(AddressService addressService, CustomerService customerService) {
        this.addressService = addressService;
        this.customerService = customerService;
    }

    // ====== Trang thêm địa chỉ ======
    @GetMapping("/add")
    public String addAddressForm(@AuthenticationPrincipal User currentUser, Model model) {
        if (currentUser == null) return "redirect:/auth/login";

        Address address = new Address();
        model.addAttribute("address", address);
        return "user/address-form";
    }

    // ====== Trang sửa địa chỉ ======
    @GetMapping("/edit/{id}")
    public String editAddressForm(@AuthenticationPrincipal User currentUser, @PathVariable Integer id, Model model) {
        if (currentUser == null) return "redirect:/auth/login";

        Address address = addressService.findById(id);
        model.addAttribute("address", address);
        return "user/address-form";
    }

    @PostMapping("/save")
    public String saveAddress(@AuthenticationPrincipal User currentUser,
                              @ModelAttribute Address address) {
        if (currentUser == null) return "redirect:/auth/login";

        // Lấy Customer hiện tại
        Customer customer = customerService.findByUserId(currentUser.getId());

        // Gán đối tượng Customer cho Address
        address.setCustomer(customer);

        addressService.save(address);
        return "redirect:/user/profile";
    }

    // ====== Xóa địa chỉ ======
    @GetMapping("/delete/{id}")
    public String deleteAddress(@AuthenticationPrincipal User currentUser, @PathVariable Integer id) {
        if (currentUser == null) return "redirect:/auth/login";

        addressService.delete(id);
        return "redirect:/user/profile";
    }

}
