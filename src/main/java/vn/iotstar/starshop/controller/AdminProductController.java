package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.service.CategoryService;
import vn.iotstar.starshop.service.ProductService;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/products")
public class AdminProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String listProducts(Model model,
                               @RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "10") int size,
                               @RequestParam(required = false, defaultValue = "") String name,
                               @RequestParam(required = false) Integer categoryId) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage;
        if (!name.isEmpty() || categoryId != null) {
            // Giả sử ProductService có method filter
            productPage = productService.findByNameContainingAndCategoryId(name, categoryId, pageable);
        } else {
            productPage = productService.findAllProducts(pageable);
        }
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalItems", productPage.getTotalElements());
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.findAll());
        // Giữ params cho pagination
        model.addAttribute("name", name);
        model.addAttribute("categoryId", categoryId);
        return "admin/product/products";
    }

    // View product detail
    @GetMapping("/detail/{id}")
    public String viewProductDetail(@PathVariable("id") Integer id, Model model) {
        Product product = productService.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        model.addAttribute("product", product);

        // Chuyển LocalDateTime -> Date để format dễ hơn trong JSP
        if (product.getCreatedAt() != null) {
            java.util.Date createdAtDate = java.util.Date.from(
                    product.getCreatedAt().atZone(java.time.ZoneId.systemDefault()).toInstant()
            );
            model.addAttribute("createdAtDate", createdAtDate);
        }

        return "admin/product/product-detail";
    }

    // Add
    @PostMapping("/add")
    public String addProduct(@ModelAttribute("product") Product product,
                             @RequestParam("imageFile") MultipartFile imageFile) throws IOException {
        if (!imageFile.isEmpty()) {
            String fileName = saveImage(imageFile);
            product.setImageUrl(fileName);  // Chỉ lưu tên file, không prefix
        }
        productService.save(product);
        return "redirect:/admin/products";
    }

    // Edit
    @PostMapping("/edit/{id}")
    public String editProduct(@PathVariable("id") Integer id, @ModelAttribute("product") Product updatedProduct,
                              @RequestParam("imageFile") MultipartFile imageFile) throws IOException {
        Optional<Product> existing = productService.findById(id);
        if (existing.isPresent()) {
            Product product = existing.get();
            product.setName(updatedProduct.getName());
            product.setDescription(updatedProduct.getDescription());
            product.setPrice(updatedProduct.getPrice());
            product.setStock(updatedProduct.getStock());
            product.setCategory(updatedProduct.getCategory());

            if (!imageFile.isEmpty()) {
                // Xóa ảnh cũ nếu có
                if (product.getImageUrl() != null) {
                    deleteImage(product.getImageUrl());
                }
                String fileName = saveImage(imageFile);
                product.setImageUrl(fileName);  // Chỉ lưu tên file, không prefix
            }
            productService.save(product);
        }
        return "redirect:/admin/products";
    }

    // Delete
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") Integer id) {
        Optional<Product> productOpt = productService.findById(id);
        if (productOpt.isPresent()) {
            // Xóa ảnh nếu có
            String imageUrl = productOpt.get().getImageUrl();
            if (imageUrl != null) {
                deleteImage(imageUrl);
            }
        }
        productService.deleteById(id);
        return "redirect:/admin/products";
    }

    // Helper method to save image
    private String saveImage(MultipartFile file) throws IOException {
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        Path uploadPath = Paths.get("src/main/resources/static/images");
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        try (InputStream inputStream = file.getInputStream()) {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        return fileName;
    }

    // Helper method to delete image
    private void deleteImage(String imageUrl) {
        try {
            // Loại bỏ prefix nếu có (để tương thích với dữ liệu cũ)
            String cleanUrl = imageUrl.replace("/images/", "");
            Path filePath = Paths.get("src/main/resources/static/images/" + cleanUrl);
            Files.deleteIfExists(filePath);
        } catch (IOException e) {
            // Log error if needed
        }
    }
    
    
    
    @GetMapping("/byCategory/{categoryId}")
    @ResponseBody
    public ResponseEntity<List<Product>> getProductsByCategory(@PathVariable("categoryId") Integer categoryId) {
        List<Product> products = productService.findByCategoryId(categoryId);
        return ResponseEntity.ok(products);
    }
}