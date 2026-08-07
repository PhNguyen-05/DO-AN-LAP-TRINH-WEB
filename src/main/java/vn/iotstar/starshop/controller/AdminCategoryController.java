package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.Category;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.service.CategoryService;
import vn.iotstar.starshop.service.ProductService;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/categories")
public class AdminCategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    
    // ✅ Hiển thị danh sách danh mục
    @GetMapping
    public String listCategories(Model model) {
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("category", new Category());
        return "admin/category/categories"; 
    }

    // ✅ Thêm danh mục mới
    @PostMapping("/add")
    public String addCategory(@ModelAttribute("category") Category category) {
        categoryService.save(category);
        return "redirect:/admin/categories";
    }

    // ✅ Sửa danh mục
    @PostMapping("/edit/{id}")
    public String editCategory(@PathVariable("id") Integer id,
                               @ModelAttribute("category") Category updatedCategory) {
        Optional<Category> existing = categoryService.findById(id);
        if (existing.isPresent()) {
            Category category = existing.get();
            category.setName(updatedCategory.getName());
            category.setDescription(updatedCategory.getDescription());
            categoryService.save(category);
        }
        return "redirect:/admin/categories";
    }

    // ✅ Xóa danh mục
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Integer id) {
        categoryService.deleteById(id);
        return "redirect:/admin/categories";
    }
    

    @GetMapping("/detail/{id}")
    public String categoryDetail(@PathVariable("id") Integer id, Model model) {
        Optional<Category> categoryOpt = categoryService.findById(id);
        if (categoryOpt.isPresent()) {
            Category category = categoryOpt.get();
            List<Product> products = productService.findByCategoryId(id);
            model.addAttribute("category", category);
            model.addAttribute("products", products);
            return "admin/category/category-detail";
        } else {
            return "redirect:/admin/categories"; 
        }
    }

}
