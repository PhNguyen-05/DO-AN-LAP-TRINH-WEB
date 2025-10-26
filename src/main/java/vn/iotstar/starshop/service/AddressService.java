package vn.iotstar.starshop.service;

import java.util.List;
import vn.iotstar.starshop.entity.Address;

public interface AddressService {

    // Lấy danh sách địa chỉ theo customer_id
    List<Address> findByCustomerId(Integer customerId);

    // Lấy địa chỉ theo id
    Address findById(Integer id);

    // Lưu hoặc cập nhật địa chỉ
    Address save(Address address);

    // Xóa địa chỉ theo id
    void delete(Integer id);
}
