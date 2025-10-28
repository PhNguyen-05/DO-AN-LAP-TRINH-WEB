package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
<<<<<<< HEAD
import org.springframework.data.jpa.repository.Query;
=======


import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.User;

import java.util.List;


import org.springframework.data.jpa.repository.Query;

>>>>>>> origin/PhuongNguyen
import vn.iotstar.starshop.entity.User;
import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);
    Optional<User> findByPhone(String phone);

<<<<<<< HEAD
=======

>>>>>>> origin/PhuongNguyen
    @Query(value = """
        SELECT TOP 5 id, email, role, status, created_at
        FROM users ORDER BY created_at DESC
        """, nativeQuery = true)
    List<Object[]> findLatestUsers();
<<<<<<< HEAD
=======

    boolean existsByEmail(String email);

>>>>>>> origin/PhuongNguyen
}
