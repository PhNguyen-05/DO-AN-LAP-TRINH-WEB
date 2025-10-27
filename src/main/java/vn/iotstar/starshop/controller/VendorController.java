package vn.iotstar.starshop.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import vn.iotstar.starshop.entity.*;

import vn.iotstar.starshop.security.CustomUserDetails;

import vn.iotstar.starshop.service.*;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/vendor")
public class VendorController {

    @Autowired
    private VendorService vendorService;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private PromotionService promotionService;

    @Autowired
    private RevenueService revenueService;

    @Autowired
    private CategoryService categoryService;

    // 🌸 Shop home
    @GetMapping("/home")
    public String vendorHome(Model model, HttpSession session) {

    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User currentUser = userDetails.getUser();


        String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) {
            model.addAttribute("message", "You have not registered a shop yet. Please register before accessing the management page.");
            return "vendor/register";
        }

        model.addAttribute("vendor", vendor);

        // Products on sale
        long productCount = productService.countByVendor(vendor);
        model.addAttribute("productCount", productCount);

        // Orders this month
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfMonth = now.withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
        long orderCount = orderService.countByVendorAndCreatedAtBetween(vendor, startOfMonth, now);
        model.addAttribute("orderCount", orderCount);

        // Revenue this month
        double monthlyRevenue = revenueService.getMonthlyRevenue(vendor, now.getMonthValue(), now.getYear());
        model.addAttribute("monthlyRevenue", monthlyRevenue);

        // Current promotions
        long promotionCount = promotionService.countActiveByVendor(vendor);
        model.addAttribute("promotionCount", promotionCount);

        // Revenue chart for last 6 months
        List<String> months = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        for (int i = 5; i >= 0; i--) {
            LocalDate month = LocalDate.now().minusMonths(i);
            months.add(month.format(formatter));
        }
        model.addAttribute("months", months);

        List<Double> revenues = revenueService.getLast6MonthsRevenue(vendor);
        model.addAttribute("revenues", revenues);

        // Recent orders (top 5)
        List<Order> recentOrders = orderService.getRecentOrdersByVendor(vendor, 5);
        model.addAttribute("recentOrders", recentOrders);

        // Top selling products (top 5)
        List<Object[]> topProducts = productService.getTopSellingByVendor(vendor, 5);
        model.addAttribute("topProducts", topProducts);

        // Recent promotions (top 5)
        List<Promotion> recentPromotions = promotionService.getRecentByVendor(vendor, 5);
        model.addAttribute("recentPromotions", recentPromotions);

        model.addAttribute("title", "Shop Home");
        return "vendor/home";
    }

    // 📦 Manage products
    @GetMapping("/products")
    public String manageProducts(@RequestParam(required = false) String name,
                                 @RequestParam(required = false) Integer categoryId,
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "10") int size,
                                 Model model, HttpSession session) {
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	User currentUser = userDetails.getUser();
    	String email = currentUser.getEmail();
        
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) return "redirect:/vendor/register";

        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage;
        Category category = null;
        if (categoryId != null) {
            category = categoryService.findById(categoryId).orElse(null);
        }

        if (name != null && !name.isEmpty() && category != null) {
            productPage = productService.findByVendorAndNameContainingAndCategory(vendor, name, category, pageable);
        } else if (name != null && !name.isEmpty()) {
            productPage = productService.findByVendorAndNameContaining(vendor, name, pageable);
        } else if (category != null) {
            productPage = productService.findByVendorAndCategory(vendor, category, pageable);
        } else {
            productPage = productService.findByVendor(vendor, pageable);
        }

        List<Category> categories = categoryService.findAll();
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("currentPage", page);
        model.addAttribute("categories", categories);
        model.addAttribute("title", "Product Management");

        return "vendor/products";
    }

 // 📦 Add product
    @PostMapping("/products/add")
    public ResponseEntity<String> addProduct(
            // SỬA LỖI 2: Nhận các tham số rõ ràng, không dùng @ModelAttribute
            @RequestParam("name") String name,
            @RequestParam("price") java.math.BigDecimal price,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam("stock") Integer stock,
            @RequestParam("category.id") Integer categoryId, // Nhận ID của Category
            @RequestParam("imageFile") MultipartFile imageFile
            // Không cần HttpSession
    ) {
        
        CustomUserDetails userDetails;
        try {
            userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        } catch (Exception e) {
            return new ResponseEntity<>("Unauthorized: User not logged in", HttpStatus.UNAUTHORIZED);
        }
        
        User currentUser = userDetails.getUser();
        String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        
        if (vendor == null)
            return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            // SỬA LỖI 2 (Tiếp): Tạo đối tượng Product thủ công
            Product product = new Product();
            product.setName(name);
            product.setPrice(price);
            product.setDescription(description);
            product.setStock(stock);
            product.setVendor(vendor);

            // Tìm đối tượng Category từ categoryId
            Category category = categoryService.findById(categoryId)
                    .orElseThrow(() -> new RuntimeException("Category not found with id: " + categoryId));
            product.setCategory(category); // Gán đối tượng Category

            // 🟢 Kiểm tra ảnh (Code này của bạn đã đúng)
            if (!imageFile.isEmpty()) {
                String fileName = imageFile.getOriginalFilename();

                String root = System.getProperty("user.dir");
                Path uploadPath = Paths.get(root + "/target/classes/static/images/");

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path filePath = uploadPath.resolve(fileName);
                imageFile.transferTo(filePath.toFile());

                product.setImageUrl(fileName);
            }

            productService.save(product);

            return new ResponseEntity<>("Success", HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    // 📦 Edit product
    @PostMapping("/products/edit/{id}")
    public ResponseEntity<String> editProduct(@PathVariable Integer id,
                                              @ModelAttribute Product product,
                                              @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                                              HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            Optional<Product> optionalProduct = productService.findById(id);
            if (optionalProduct.isEmpty() || !optionalProduct.get().getVendor().getId().equals(vendor.getId())) {
                return new ResponseEntity<>("Product not found", HttpStatus.NOT_FOUND);
            }

            Product existingProduct = optionalProduct.get();

            if (product.getName() != null && !product.getName().isEmpty()) {
                existingProduct.setName(product.getName());
            }
            if (product.getDescription() != null) {
                existingProduct.setDescription(product.getDescription());
            }
            if (product.getPrice() != null && product.getPrice().compareTo(java.math.BigDecimal.ZERO) > 0) {
                existingProduct.setPrice(product.getPrice());
            }
            if (product.getStock() != null && product.getStock() >= 0) {
                existingProduct.setStock(product.getStock());
            }
            if (imageFile != null && !imageFile.isEmpty()) {
                String fileName = imageFile.getOriginalFilename();

                String root = System.getProperty("user.dir");
                Path uploadPath = Paths.get(root + "/target/classes/static/images/");

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path filePath = uploadPath.resolve(fileName);
                imageFile.transferTo(filePath.toFile());

                existingProduct.setImageUrl(fileName);
            }
            if (product.getCategory() != null) {
                existingProduct.setCategory(product.getCategory());
            }

            productService.save(existingProduct);
        } catch (Exception e) {
            return new ResponseEntity<>("Error updating product: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

    // 📦 Delete product
    @PostMapping("/products/delete/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable Integer id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor vendor = vendorService.findByEmail(currentUser.getEmail());
        if (vendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            Optional<Product> optionalProduct = productService.findById(id);
            if (optionalProduct.isEmpty() || !optionalProduct.get().getVendor().getId().equals(vendor.getId())) {
                return new ResponseEntity<>("Product not found", HttpStatus.NOT_FOUND);
            }
            productService.delete(id);
        } catch (Exception e) {
            return new ResponseEntity<>("Error deleting product: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

    // 🛒 Manage orders
    @GetMapping("/orders")
    public String manageOrders(Model model, HttpSession session) {
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	User currentUser = userDetails.getUser();
    	String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) return "redirect:/vendor/register";

        List<Order> orders = orderService.findByVendor(vendor);
        model.addAttribute("orders", orders);
        model.addAttribute("title", "Order Management");

        return "vendor/orders";
    }

    // 💰 Revenue statistics
    @GetMapping("/revenue")
    public String revenueReport(Model model, HttpSession session) {
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	User currentUser = userDetails.getUser();
    	String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) return "redirect:/vendor/register";

        Map<String, Object> revenueData = revenueService.getRevenueData(vendor);
        model.addAttribute("revenueData", revenueData);
        model.addAttribute("title", "Shop Revenue");

        return "vendor/revenue";
    }

    // 🧾 Shop profile
    @GetMapping("/profile")
    public String vendorProfile(Model model, HttpSession session) {
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	User currentUser = userDetails.getUser();
    	String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) return "redirect:/vendor/register";

        model.addAttribute("vendor", vendor);
        model.addAttribute("title", "Shop Profile");

        return "vendor/profile";
    }

    // 🧾 Update shop profile
    @PostMapping("/profile/edit")
    public ResponseEntity<String> updateProfile(@ModelAttribute Vendor vendor, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor existingVendor = vendorService.findByEmail(currentUser.getEmail());
        if (existingVendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            if (vendor.getShopName() == null || vendor.getShopName().isEmpty()) {
                return new ResponseEntity<>("Shop name is required", HttpStatus.BAD_REQUEST);
            }
            existingVendor.setShopName(vendor.getShopName());
            existingVendor.setAddress(vendor.getAddress());
            existingVendor.setPhone(vendor.getPhone());
            existingVendor.setDescription(vendor.getDescription());
            vendorService.save(existingVendor);
        } catch (Exception e) {
            return new ResponseEntity<>("Error updating profile: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

    // ⚙️ Shop settings
    @GetMapping("/settings")
    public String vendorSettings(Model model, HttpSession session) {
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	User currentUser = userDetails.getUser();
    	String email = currentUser.getEmail();
        Vendor vendor = vendorService.findByEmail(email);
        if (vendor == null) return "redirect:/vendor/register";

        model.addAttribute("vendor", vendor);
        model.addAttribute("title", "Shop Settings");

        return "vendor/settings";
    }

    // ⚙️ Update shop settings
    @PostMapping("/settings")
    public ResponseEntity<String> updateSettings(@ModelAttribute Vendor vendor, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);

        Vendor existingVendor = vendorService.findByEmail(currentUser.getEmail());
        if (existingVendor == null) return new ResponseEntity<>("Vendor not found", HttpStatus.BAD_REQUEST);

        try {
            if (vendor.getShopName() == null || vendor.getShopName().isEmpty()) {
                return new ResponseEntity<>("Shop name is required", HttpStatus.BAD_REQUEST);
            }
            existingVendor.setShopName(vendor.getShopName());
            existingVendor.setAddress(vendor.getAddress());
            existingVendor.setPhone(vendor.getPhone());
            existingVendor.setDescription(vendor.getDescription());
            vendorService.save(existingVendor);
        } catch (Exception e) {
            return new ResponseEntity<>("Error updating settings: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("Success", HttpStatus.OK);
    }
}