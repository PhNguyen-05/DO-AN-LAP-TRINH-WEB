//package vn.iotstar.starshop.service.impl;
//
//import java.util.List;
//
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.stereotype.Service;
//
//import lombok.RequiredArgsConstructor;
//import vn.iotstar.starshop.entity.Hoa;
//import vn.iotstar.starshop.repository.HoaRepository;
//import vn.iotstar.starshop.service.HoaService;
//
//@Service
//@RequiredArgsConstructor
//public class HoaServiceImpl implements HoaService {
//
//    private final HoaRepository hoaRepository;
//
//    @Override
//    public Page<Hoa> searchByKeyword(String keyword, Pageable pageable) {
//        if (keyword == null || keyword.trim().isEmpty()) {
//            return Page.empty();
//        }
//        return hoaRepository.searchByKeyword(keyword.trim(), pageable);
//    }
//
//    @Override
//    public List<Hoa> findTopNewProducts(int limit) {
//        return hoaRepository.findTopNewFlowers(PageRequest.of(0, limit));
//    }
//
//    @Override
//    public Page<Hoa> findAllProducts(Pageable pageable) {
//        return hoaRepository.findAllProducts(pageable);
//    }
//}
