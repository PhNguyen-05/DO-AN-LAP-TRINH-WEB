package vn.iotstar.starshop.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.starshop.entity.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {

    // Sửa để JPA hiểu: truy cập customer.id
    List<Address> findByCustomer_Id(Integer customerId);

}
