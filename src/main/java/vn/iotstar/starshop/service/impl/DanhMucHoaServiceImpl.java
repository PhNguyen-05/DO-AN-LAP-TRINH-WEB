package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.DanhMucHoa;
import vn.iotstar.starshop.repository.DanhMucHoaRepository;
import vn.iotstar.starshop.service.DanhMucHoaService;

import java.util.List;
import java.util.Optional;

@Service
public class DanhMucHoaServiceImpl implements DanhMucHoaService {

    @Autowired
    private DanhMucHoaRepository danhMucHoaRepository;

    @Override
    public List<DanhMucHoa> findAll() {
        return danhMucHoaRepository.findAll();
    }

    @Override
    public Optional<DanhMucHoa> findById(Integer id) {
        return danhMucHoaRepository.findById(id);
    }

    @Override
    public DanhMucHoa save(DanhMucHoa danhMucHoa) {
        return danhMucHoaRepository.save(danhMucHoa);
    }

    @Override
    public void deleteById(Integer id) {
        danhMucHoaRepository.deleteById(id);
    }

    @Override
    public long count() {
        return danhMucHoaRepository.count();
    }
}