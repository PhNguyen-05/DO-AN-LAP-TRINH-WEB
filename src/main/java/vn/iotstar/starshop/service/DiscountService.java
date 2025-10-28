package vn.iotstar.starshop.service;

import java.math.BigDecimal;

public interface DiscountService {
    BigDecimal applyVoucher(String code, BigDecimal subtotal);
}
