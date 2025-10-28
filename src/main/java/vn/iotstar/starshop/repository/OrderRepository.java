package vn.iotstar.starshop.repository;

<<<<<<< HEAD
import java.awt.print.Pageable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.Order;


public interface OrderRepository extends JpaRepository<Order, Integer> {

	@Query("SELECT d FROM Order d ORDER BY d.createdAt DESC")
	List<Order> findRecentOrders(Pageable pageable);
=======
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import vn.iotstar.starshop.entity.Customer;
import vn.iotstar.starshop.entity.Order;
import vn.iotstar.starshop.entity.Vendor;


public interface OrderRepository extends JpaRepository<Order, Integer>, JpaSpecificationExecutor<Order> {

	@Query("SELECT d FROM Order d ORDER BY d.createdAt DESC")
    List<Order> findRecentOrder(int limit);
>>>>>>> origin/PhuongNguyen
    
    @Query(value = """
	        SELECT TOP 5 o.id, c.full_name, o.total_amount, o.status, o.order_date
	        FROM orders o
	        LEFT JOIN customers c ON o.customer_id = c.id
	        ORDER BY o.order_date DESC
	        """, nativeQuery = true)
	    List<Object[]> findRecentOrders();

	    @Query(value = """
	        SELECT FORMAT(o.order_date, 'MM-yyyy') AS month, SUM(o.total_amount)
	        FROM orders o
	        WHERE o.order_date >= DATEADD(MONTH, -6, GETDATE())
	        GROUP BY FORMAT(o.order_date, 'MM-yyyy')
	        ORDER BY MIN(o.order_date)
	        """, nativeQuery = true)
	    List<Object[]> getRevenueLast6Months();

	    @Query(value = """
	        SELECT TOP 5 p.name, SUM(od.quantity) AS total_sold
	        FROM order_details od
	        JOIN products p ON od.product_id = p.id
	        GROUP BY p.name
	        ORDER BY total_sold DESC
	        """, nativeQuery = true)
	    List<Object[]> getTopSellingProducts();
<<<<<<< HEAD
=======
  
	    
	    
   
	    
	    @Query("SELECT COUNT(o) FROM Order o WHERE o.vendor = ?1 AND o.createdAt BETWEEN ?2 AND ?3")
	    long countByVendorAndCreatedAtBetween(Vendor vendor, LocalDateTime start, LocalDateTime end);


	    @Query("SELECT o FROM Order o WHERE o.vendor = ?1 ORDER BY o.createdAt DESC")
	    List<Order> getRecentOrdersByVendor(Vendor vendor, Pageable pageable);


	    List<Order> findByVendor(Vendor vendor);
	    
	    List<Order> findTop5ByVendorOrderByCreatedAtDesc(Vendor vendor);

	    List<Order> findByCustomerOrderByOrderDateDesc(Customer customer);
>>>>>>> origin/PhuongNguyen
}
