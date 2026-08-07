package vn.iotstar.starshop.service.impl;

import java.util.List;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.Address;
import vn.iotstar.starshop.repository.AddressRepository;
import vn.iotstar.starshop.service.AddressService;

@Service
public class AddressServiceImpl implements AddressService {

    private final AddressRepository addressRepository;

    public AddressServiceImpl(AddressRepository addressRepository) {
        this.addressRepository = addressRepository;
    }

    @Override
    public List<Address> findByCustomerId(Integer customerId) {
        return addressRepository.findByCustomer_Id(customerId);
    }

    @Override
    public Address findById(Integer id) {
        return addressRepository.findById(id).orElse(null);
    }

    @Override
    public Address save(Address address) {
        if (address.isDefaultAddress()) {
            // Nếu đặt mặc định, reset các địa chỉ khác của cùng khách hàng
            List<Address> others = findByCustomerId(address.getCustomer().getId());
            for (Address a : others) {
                if (!a.getId().equals(address.getId())) {
                	a.setDefaultAddress(false);
                    addressRepository.save(a);
                }
            }
        }
        return addressRepository.save(address);
    }

    @Override
    public void delete(Integer id) {
        addressRepository.deleteById(id);
    }
}
