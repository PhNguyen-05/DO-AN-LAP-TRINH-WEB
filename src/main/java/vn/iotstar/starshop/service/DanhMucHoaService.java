package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.DanhMucHoa;

import java.util.List;
import java.util.Optional;

public interface DanhMucHoaService {
    List<DanhMucHoa> findAll();
    Optional<DanhMucHoa> findById(Integer id);
    DanhMucHoa save(DanhMucHoa danhMucHoa);
    void deleteById(Integer id);
    long count();
}