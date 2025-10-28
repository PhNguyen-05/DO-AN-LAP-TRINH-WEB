<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<sitemesh:page title="Thanh toán - StarShop">
<sitemesh:head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Dancing+Script:wght@600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #fffafc, #e8faff); font-family: 'Poppins', sans-serif; }
        .checkout-container { max-width: 900px; margin: 40px auto; background: #fff; border-radius: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 30px 40px; }
        .checkout-header { text-align: center; margin-bottom: 30px; }
        .checkout-header h3 { font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.2rem; font-weight: 700; }
        .checkout-header p { color: #6c757d; }

        .form-group { margin-bottom: 20px; }
        label { font-weight: 600; color: #555; }
        input[type="text"], input[type="email"], input[type="tel"], textarea {
            width: 100%; padding: 10px 15px; border: 1px solid #ddd; border-radius: 12px; transition: 0.3s;
        }
        input:focus, textarea:focus { border-color: #ff69b4; outline: none; box-shadow: 0 0 5px rgba(255,105,180,0.3); }
        textarea { resize: none; height: 100px; }

        .summary-card { background: #fff0f6; border-radius: 15px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); margin-bottom: 25px; }
        .summary-card h5 { font-weight: 600; color: #ff69b4; margin-bottom: 15px; }
        .summary-item { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #ffe6f0; }
        .summary-total { font-weight: 700; color: #ff69b4; font-size: 1.1rem; }

        .btn-place-order { background: linear-gradient(135deg, #ff80b5, #ff69b4); color: white; border: none; border-radius: 12px; padding: 12px 25px; font-weight: 600; transition: 0.3s; width: 100%; }
        .btn-place-order:hover { background: linear-gradient(135deg, #ff69b4, #ff3385); }

        .voucher-input { display: flex; gap: 10px; align-items: center; }
        .voucher-input input { flex: 1; }
        .btn-apply { background-color: #ff69b4; color: white; border: none; border-radius: 10px; padding: 8px 15px; font-weight: 600; transition: 0.3s; }
        .btn-apply:hover { background-color: #ff3385; }

        .discount-info { color: green; font-weight: 500; margin-top: 10px; }
        .discount-error { color: red; font-weight: 500; margin-top: 10px; }
    </style>
</sitemesh:head>

<div class="checkout-container">
    <div class="checkout-header">
        <h3>💐 Thanh toán</h3>
        <p>Hoàn tất đơn hàng của bạn</p>
    </div>

    <form action="${pageContext.request.contextPath}/user/order/checkout" method="post">
        <!-- Thông tin khách hàng -->
        <div class="form-group">
            <label for="fullName">Họ và tên</label>
            <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${user.email}" required>
        </div>

        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="tel" id="phone" name="phone" value="${user.phone}" required>
        </div>

        <div class="form-group">
            <label for="address">Địa chỉ giao hàng</label>
            <textarea id="address" name="shippingAddress" required>${user.address}</textarea>
        </div>

        <div class="form-group">
            <label for="note">Ghi chú (nếu có)</label>
            <textarea id="note" name="note"></textarea>
        </div>

        <!-- Voucher -->
        <div class="form-group">
            <label for="voucherCode">Mã giảm giá</label>
            <div class="voucher-input">
                <input type="text" id="voucherCode" name="voucherCode" placeholder="Nhập mã voucher của bạn" value="${appliedVoucher.code}">
                <button type="submit" formaction="${pageContext.request.contextPath}/user/checkout/applyVoucher" class="btn-apply">Áp dụng</button>
            </div>
            <c:if test="${not empty discountMessage}">
                <p class="${discountSuccess ? 'discount-info' : 'discount-error'}">${discountMessage}</p>
            </c:if>
        </div>

        <!-- Order summary -->
        <div class="summary-card">
            <h5>Đơn hàng của bạn</h5>
            <c:forEach var="item" items="${selectedItems}">
                <div class="summary-item">
                    <span>${item.product.name} x ${item.quantity}</span>
                    <span><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" currencySymbol="₫"/></span>
                </div>
            </c:forEach>

            <div class="summary-item">
                <span>Tổng cộng:</span>
                <span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫"/></span>
            </div>

            <c:if test="${not empty appliedVoucher}">
                <div class="summary-item">
                    <span>Giảm giá (${appliedVoucher.discountPercent}%)</span>
                    <span>-<fmt:formatNumber value="${cart.totalAmount * appliedVoucher.discountPercent / 100}" type="currency" currencySymbol="₫"/></span>
                </div>
                <div class="summary-item summary-total">
                    <span>Thành tiền:</span>
                    <span>
                        <fmt:formatNumber 
                            value="${cart.totalAmount - (cart.totalAmount * appliedVoucher.discountPercent / 100)}"
                            type="currency" currencySymbol="₫"/>
                    </span>
                </div>
            </c:if>
        </div>

        <button type="submit" class="btn-place-order">Đặt hàng ngay</button>
    </form>
</div>
</sitemesh:page>
