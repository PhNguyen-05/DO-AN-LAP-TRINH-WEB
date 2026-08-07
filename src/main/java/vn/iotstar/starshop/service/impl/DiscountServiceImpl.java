package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.DiscountCode;
import vn.iotstar.starshop.repository.DiscountCodeRepository;
import vn.iotstar.starshop.service.DiscountService;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class DiscountServiceImpl implements DiscountService {

    @Autowired
    private DiscountCodeRepository discountCodeRepository;

    @Override
    public BigDecimal applyVoucher(String code, BigDecimal subtotal) {
        DiscountCode voucher = discountCodeRepository.findByCode(code).orElse(null);
        if (voucher == null) return subtotal;

        if (voucher.getStart_date() != null && voucher.getStart_date().isAfter(LocalDateTime.now())) return subtotal;
        if (voucher.getEnd_date() != null && voucher.getEnd_date().isBefore(LocalDateTime.now())) return subtotal;

        BigDecimal discountValue = BigDecimal.ZERO;
        if ("PERCENT".equalsIgnoreCase(voucher.getDiscount_type())) {
            discountValue = subtotal.multiply(voucher.getDiscount_value().divide(BigDecimal.valueOf(100)));
        } else if ("FIXED".equalsIgnoreCase(voucher.getDiscount_type())) {
            discountValue = voucher.getDiscount_value();
        }

        BigDecimal finalTotal = subtotal.subtract(discountValue);
        return finalTotal.compareTo(BigDecimal.ZERO) < 0 ? BigDecimal.ZERO : finalTotal;
    }
}
