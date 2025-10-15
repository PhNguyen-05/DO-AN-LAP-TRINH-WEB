package vn.iotstar.starshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.starshop.entity.DanhMucHoa;
import vn.iotstar.starshop.service.DanhMucHoaService;

import java.util.Optional;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private DanhMucHoaService danhMucHoaService;

    // ✅ Hiển thị danh sách danh mục
    @GetMapping
    public String listCategories(Model model) {
        model.addAttribute("categories", danhMucHoaService.findAll());
        model.addAttribute("category", new DanhMucHoa());
        return "admin/category/categories"; // => /WEB-INF/views/admin/category/categories.jsp
    }

    // ✅ Thêm danh mục mới
    @PostMapping("/add")
    public String addCategory(@ModelAttribute("category") DanhMucHoa danhMucHoa) {
        danhMucHoaService.save(danhMucHoa);
        return "redirect:/admin/categories";
    }

    // ✅ Sửa danh mục
    @PostMapping("/edit/{id}")
    public String editCategory(@PathVariable("id") Integer id,
                               @ModelAttribute("category") DanhMucHoa updatedDanhMucHoa) {
        Optional<DanhMucHoa> existing = danhMucHoaService.findById(id);
        if (existing.isPresent()) {
            DanhMucHoa danhMucHoa = existing.get();
            danhMucHoa.setTenDanhMuc(updatedDanhMucHoa.getTenDanhMuc());
            danhMucHoa.setMoTa(updatedDanhMucHoa.getMoTa());
            danhMucHoaService.save(danhMucHoa);
        }
        return "redirect:/admin/categories";
    }

    // ✅ Xóa danh mục
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Integer id) {
        danhMucHoaService.deleteById(id);
        return "redirect:/admin/categories";
    }
}
