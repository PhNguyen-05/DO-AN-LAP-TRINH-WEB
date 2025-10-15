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

    @GetMapping
    public String listCategories(Model model) {
        model.addAttribute("categories", danhMucHoaService.findAll());
        model.addAttribute("category", new DanhMucHoa()); // For add form
        return "admin/categories"; // /WEB-INF/views/admin/categories.jsp
    }

    @PostMapping("/add")
    public String addCategory(@ModelAttribute("category") DanhMucHoa danhMucHoa) {
        danhMucHoaService.save(danhMucHoa);
        return "redirect:/admin/categories";
    }

    @PostMapping("/edit/{id}")
    public String editCategory(@PathVariable Integer id, @ModelAttribute("category") DanhMucHoa updatedDanhMucHoa) {
        Optional<DanhMucHoa> existing = danhMucHoaService.findById(id);
        if (existing.isPresent()) {
            DanhMucHoa danhMucHoa = existing.get();
            danhMucHoa.setTenDanhMuc(updatedDanhMucHoa.getTenDanhMuc());
            danhMucHoa.setMoTa(updatedDanhMucHoa.getMoTa());
            danhMucHoaService.save(danhMucHoa);
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable Integer id) {
        danhMucHoaService.deleteById(id);
        return "redirect:/admin/categories";
    }
}