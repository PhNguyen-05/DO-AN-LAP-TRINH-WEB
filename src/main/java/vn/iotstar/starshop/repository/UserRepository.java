package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.User;

import java.util.List;


import vn.iotstar.starshop.entity.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);
    // nếu muốn hỗ trợ login bằng số điện thoại, thêm findBy... tương ứng
    Optional<User> findByPhone(String phone);

    
    @Query(value = """
	        SELECT TOP 5 id, email, role, status, created_at
	        FROM users
	        ORDER BY created_at DESC
	        """, nativeQuery = true)
	    List<Object[]> findLatestUsers();

}
