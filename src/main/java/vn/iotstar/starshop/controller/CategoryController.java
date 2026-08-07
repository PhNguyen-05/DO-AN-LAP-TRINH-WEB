package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.Category;
import vn.iotstar.starshop.service.CategoryService;

import java.util.Optional;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    // ✅ Hiển thị danh sách danh mục
    @GetMapping
    public String listCategories(Model model) {
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("category", new Category());
        return "admin/category/categories";
    }
    @GetMapping("/{id}")
    public String viewCategory(@PathVariable("id") Integer id, Model model) {
        Optional<Category> category = categoryService.findById(id);
        if (category.isPresent()) {
            model.addAttribute("category", category.get());
            return "user/category/category-detail";
        }
        return "redirect:/categories";
    }

//    @PostMapping("/add")
//    public String addCategory(@ModelAttribute("category") Category category) {
//        categoryService.save(category);
//        return "redirect:/admin/categories";
//    }
//   
//
//
//
// // ✅ Sửa danh mục
//    @PostMapping("/edit/{id}")
//    public String editCategory(@PathVariable("id") Integer id,
//                               @ModelAttribute("category") Category updatedCategory) {
//        Optional<Category> existing = categoryService.findById(id);
//        if (existing.isPresent()) {
//            Category category = existing.get();
//            category.setName(updatedCategory.getName());
//            category.setDescription(updatedCategory.getDescription());
//            categoryService.save(category);
//        }
//        return "redirect:/admin/categories";
//    }
//
//    // ✅ Xóa danh mục
//    @GetMapping("/delete/{id}")
//    public String deleteCategory(@PathVariable("id") Integer id) {
//        categoryService.deleteById(id);
//        return "redirect:/admin/categories";
//    }

}
