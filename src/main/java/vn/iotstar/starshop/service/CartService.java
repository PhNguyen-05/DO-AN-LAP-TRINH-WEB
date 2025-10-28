package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Cart;
import java.math.BigDecimal;

public interface CartService {

    // ✅ Thêm sản phẩm vào giỏ
    void addToCart(Integer customerId, Integer productId, Integer quantity);

    // ✅ Lấy giỏ hàng theo customer
    Cart getCartByCustomerId(Integer customerId);

    // ✅ Xóa toàn bộ sản phẩm trong giỏ
    void clearCart(Integer customerId);

 // ✅ Xóa 1 sản phẩm theo cartItemId (dòng chi tiết trong giỏ hàng)
    void removeItemByCartItemId(Integer cartItemId);

    // ✅ Tính tổng tiền của giỏ hàng
    BigDecimal getTotalAmount(Integer customerId);

    
    void updateSelection(Integer cartItemId, boolean selected);


}
