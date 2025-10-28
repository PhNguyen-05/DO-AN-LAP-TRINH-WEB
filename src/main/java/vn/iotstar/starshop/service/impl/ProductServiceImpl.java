//package vn.iotstar.starshop.service.impl;
//
//import java.util.List;
//import java.util.Optional;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.domain.Specification;
//import org.springframework.stereotype.Service;
//
//import lombok.RequiredArgsConstructor;
//import vn.iotstar.starshop.entity.Product;
//import vn.iotstar.starshop.entity.Review;
//import vn.iotstar.starshop.repository.ReviewRepository;
//import vn.iotstar.starshop.repository.ProductRepository;
//import vn.iotstar.starshop.service.ProductService;
//
//@Service
//@RequiredArgsConstructor
//public class ProductServiceImpl implements ProductService {
//
//    private final ProductRepository productRepository;  
//    private final ReviewRepository reviewRepository;
//
//    @Override
//    public Page<Product> searchByKeyword(String keyword, Pageable pageable) {
//        if (keyword == null || keyword.trim().isEmpty()) {
//            return Page.empty();
//        }
//        return productRepository.searchByKeyword(keyword.trim(), pageable);
//    }
//
// // ✅ Lấy sản phẩm mới nhất, không giới hạn danh mục
//    @Override
//    public List<Product> findTopNewProducts(int limit) {
//        return productRepository.findTopNew(PageRequest.of(0, limit));
//    }
//    
//    @Override
//    public Page<Product> findByCategoryId(Integer categoryId, Pageable pageable) {
//        return productRepository.findByCategoryId(categoryId, pageable);
//    }
//
//    @Override
//    public Page<Product> findAllProducts(Pageable pageable) {
//        return productRepository.findAllProducts(pageable);
//    }
//
//    
//    @Override
//    public Page<Product> findAllWithCategory(Pageable pageable) {
//        return productRepository.findAllWithCategory(pageable);
//    }
//
//    @Override
//    public Optional<Product> findById(Integer id) {
//        return productRepository.findById(id);
//    }
//
//    @Override
//    public Product save(Product product) {
//        return productRepository.save(product);
//    }
//
//    @Override
//    public void deleteById(Integer id) {
//        productRepository.deleteById(id);
//    }
//
//    @Override
//    public long countProducts() {
//        return productRepository.count();
//    }
//    
//    @Override
//    public Page<Product> findByNameContainingAndCategoryId(String name, Integer categoryId, Pageable pageable) {
//        Specification<Product> spec = Specification.where(null);
//
//        if (name != null && !name.isEmpty()) {
//            spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
//        }
//
//        if (categoryId != null) {
//            spec = spec.and((root, query, cb) -> cb.equal(root.join("category").get("id"), categoryId));
//        }
//
//        return productRepository.findAll(spec, pageable);
//    }
//    
//    @Override
//    public List<Product> findByCategoryId(Integer categoryId) {
//        return productRepository.findByCategoryId(categoryId);
//    }
//    
//    @Override
//    public List<Review> getReviewsByProductId(Integer productId) {
//        return reviewRepository.findByProductId(productId);
//    }
//}




package vn.iotstar.starshop.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.persistence.criteria.Predicate;
import lombok.RequiredArgsConstructor;
<<<<<<< HEAD
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Review;
import vn.iotstar.starshop.repository.ProductRepository;
import vn.iotstar.starshop.repository.ReviewRepository;
=======
import vn.iotstar.starshop.entity.Category;
import vn.iotstar.starshop.entity.Product;
import vn.iotstar.starshop.entity.Review;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.ReviewRepository;
import vn.iotstar.starshop.repository.ProductRepository;
>>>>>>> origin/PhuongNguyen
import vn.iotstar.starshop.service.ProductService;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

<<<<<<< HEAD
    private final ProductRepository productRepository;
=======

    private final ProductRepository productRepository;  

>>>>>>> origin/PhuongNguyen
    private final ReviewRepository reviewRepository;

    @Override
    public Page<Product> searchByKeyword(String keyword, Pageable pageable) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Page.empty();
        }
        return productRepository.searchByKeyword(keyword.trim(), pageable);
    }

<<<<<<< HEAD
=======
 // ✅ Lấy sản phẩm mới nhất, không giới hạn danh mục
>>>>>>> origin/PhuongNguyen
    @Override
    public List<Product> findTopNewProducts(int limit) {
        return productRepository.findTopNew(PageRequest.of(0, limit));
    }

    @Override
    public Page<Product> findByCategoryId(Integer categoryId, Pageable pageable) {
        return productRepository.findByCategoryId(categoryId, pageable);
    }

    @Override
    public Page<Product> findAllProducts(Pageable pageable) {
        return productRepository.findAllProducts(pageable);
    }

    @Override
    public Page<Product> findAllWithCategory(Pageable pageable) {
        return productRepository.findAllWithCategory(pageable);
    }

    @Override
    public Optional<Product> findById(Integer id) {
        return productRepository.findById(id);
    }

    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }

    @Override
    public void deleteById(Integer id) {
        productRepository.deleteById(id);
    }

    @Override
    public long countProducts() {
        return productRepository.count();
    }

    @Override
    public Page<Product> findByNameContainingAndCategoryId(String name, Integer categoryId, Pageable pageable) {
        Specification<Product> spec = Specification.where(null);

        if (name != null && !name.isEmpty()) {
<<<<<<< HEAD
            spec = spec.and((root, query, cb) ->
                    cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
        }

        if (categoryId != null) {
            spec = spec.and((root, query, cb) ->
                    cb.equal(root.join("category").get("id"), categoryId));
=======
            spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
        }

        if (categoryId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.join("category").get("id"), categoryId));
>>>>>>> origin/PhuongNguyen
        }

        return productRepository.findAll(spec, pageable);
    }

    @Override
    public List<Product> findByCategoryId(Integer categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }

    @Override
    public List<Review> getReviewsByProductId(Integer productId) {
        return reviewRepository.findByProductId(productId);
    }

<<<<<<< HEAD
=======
    
    
    
    @Override
    public long countByVendor(Vendor vendor) {
        return productRepository.countByVendor(vendor);
    }

    @Override
    public List<Product> findByVendor(Vendor vendor) {
        return productRepository.findByVendor(vendor);
    }

    @Override
    public List<Object[]> getTopSellingByVendor(Vendor vendor, int limit) {
        return productRepository.getTopSellingByVendor(vendor, limit);
    }
    

    @Override
    public void delete(Integer id) {
        productRepository.deleteById(id);
    }

    @Override
    public boolean existsBySkuAndVendor(String sku, Vendor vendor) {
        return productRepository.existsBySkuAndVendor(sku, vendor);
    }
    
    @Override
    public Page<Product> findByVendor(Vendor vendor, Pageable pageable) {
        Specification<Product> spec = (root, query, cb) -> cb.equal(root.get("vendor"), vendor);
        return productRepository.findAll(spec, pageable);
    }

    @Override
    public Page<Product> findByVendorAndCategory(Vendor vendor, Category category, Pageable pageable) {
        Specification<Product> spec = Specification.where(null);
        if (vendor != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("vendor"), vendor));
        }
        if (category != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("category"), category));
        }
        return productRepository.findAll(spec, pageable);
    }

    @Override
    public Page<Product> findByVendorAndNameContaining(Vendor vendor, String name, Pageable pageable) {
        Specification<Product> spec = Specification.where(null);
        if (vendor != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("vendor"), vendor));
        }
        if (name != null && !name.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
        }
        return productRepository.findAll(spec, pageable);
    }

    @Override
    public Page<Product> findByVendorAndNameContainingAndCategory(Vendor vendor, String name, Category category, Pageable pageable) {
        Specification<Product> spec = Specification.where(null);
        if (vendor != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("vendor"), vendor));
        }
        if (name != null && !name.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
        }
        if (category != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("category"), category));
        }
        return productRepository.findAll(spec, pageable);
    }
    
    @Override
    public List<Product> findByIdsAndVendor(List<Integer> ids, Vendor vendor) {
        return productRepository.findByIdsAndVendor(ids, vendor);
    }
    



>>>>>>> origin/PhuongNguyen
    // ----------------------------------------------------------
    // 🌈 Phần mở rộng: xử lý cho trang chủ Guest/User
    // ----------------------------------------------------------

    @Override
    public List<Product> getTopSellingForGuest() {
        // 10 sản phẩm bán chạy nhất
        return productRepository.findTopSelling(PageRequest.of(0, 10));
    }

    @Override
    public List<Product> getNewestProducts() {
        // 20 sản phẩm mới nhất
        return productRepository.findTopNew(PageRequest.of(0, 20));
    }

    @Override
    public List<Product> getBestSellingProducts() {
        // 20 sản phẩm bán chạy nhất
        return productRepository.findTopSelling(PageRequest.of(0, 20));
    }

    @Override
    public List<Product> getTopRatedProducts() {
        // 20 sản phẩm có điểm đánh giá cao nhất
        return productRepository.findTopRated(PageRequest.of(0, 20));
    }

    @Override
    public List<Product> getMostFavoritedProducts() {
        // 20 sản phẩm được yêu thích nhiều nhất
        return productRepository.findMostFavorited(PageRequest.of(0, 20));
    }
<<<<<<< HEAD
}
=======
    
    
    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }
    
    @Override
    public List<Product> findProductsWithActivePromotions() {
        return productRepository.findDiscountedProducts();
    }
    
    
    @Override
    public Page<Product> searchProductsVendor(Vendor vendor, String name, Integer categoryId, String stockStatus, Pageable pageable) {
        
        Specification<Product> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            predicates.add(cb.equal(root.get("vendor"), vendor));

            if (name != null && !name.isEmpty()) {
                predicates.add(cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
            }
            if (categoryId != null) {
                predicates.add(cb.equal(root.get("category").get("id"), categoryId));
            }

            // === NÂNG CẤP LOGIC LỌC TỒN KHO ===
            // Xóa code cũ 'if (lowStock != null && lowStock)'
            // Thêm code mới:
            if (stockStatus != null && !stockStatus.isEmpty()) {
                if ("low".equals(stockStatus)) {
                    // "Sắp hết hàng": Lớn hơn 0 VÀ nhỏ hơn hoặc bằng 10
                    predicates.add(cb.between(root.get("stock"), 1, 10));
                } else if ("out".equals(stockStatus)) {
                    // "Hết hàng": Bằng 0
                    predicates.add(cb.equal(root.get("stock"), 0));
                } else if ("sufficient".equals(stockStatus)) {
                    // "Còn nhiều": Lớn hơn 10
                    predicates.add(cb.greaterThan(root.get("stock"), 10));
                }
            }
            // === KẾT THÚC NÂNG CẤP ===

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        return productRepository.findAll(spec, pageable);
    }

    // Bạn cũng nên làm điều tương tự cho hàm 'searchProductsAdmin'
    @Override
    public Page<Product> searchProductsAdmin(String name, Integer categoryId, Integer vendorId, String stockStatus, Pageable pageable) {
        Specification<Product> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (name != null && !name.isEmpty()) { /* ... */ }
            if (categoryId != null) { /* ... */ }
            if (vendorId != null) { /* ... */ }

            // === NÂNG CẤP LOGIC LỌC TỒN KHO (cho Admin) ===
            if (stockStatus != null && !stockStatus.isEmpty()) {
                if ("low".equals(stockStatus)) {
                    predicates.add(cb.between(root.get("stock"), 1, 10));
                } else if ("out".equals(stockStatus)) {
                    predicates.add(cb.equal(root.get("stock"), 0));
                } else if ("sufficient".equals(stockStatus)) {
                    predicates.add(cb.greaterThan(root.get("stock"), 10));
                }
            }
            // === KẾT THÚC NÂNG CẤP ===
            
            return cb.and(predicates.toArray(new Predicate[0]));
        };
        return productRepository.findAll(spec, pageable);
    }

}

>>>>>>> origin/PhuongNguyen
