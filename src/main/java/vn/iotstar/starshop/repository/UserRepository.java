package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.starshop.entity.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);
    // nếu muốn hỗ trợ login bằng số điện thoại, thêm findBy... tương ứng
    Optional<User> findByPhone(String phone);
}
