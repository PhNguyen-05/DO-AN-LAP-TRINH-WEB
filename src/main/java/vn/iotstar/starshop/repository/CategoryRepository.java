package vn.iotstar.starshop.repository;

import vn.iotstar.starshop.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    // Không cần định nghĩa thêm gì, các method CRUD đã có sẵn từ JpaRepository
}
