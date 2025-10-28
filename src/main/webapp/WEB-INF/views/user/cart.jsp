
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="Giỏ hàng - StarShop">
    <sitemesh:head>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Dancing+Script:wght@600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(135deg, #fffafc, #e8faff);
                font-family: 'Poppins', sans-serif;
            }

            .cart-container {
                max-width: 1000px;
                margin: 30px auto;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                padding: 25px 35px;
            }

            .cart-header {
                text-align: center;
                margin-bottom: 25px;
            }
            .cart-header h3 {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 2.2rem;
                font-weight: 700;
            }

            .cart-item {
                display: flex;
                align-items: center;
                border-bottom: 1px solid #f1f1f1;
                padding: 15px 0;
            }
            .cart-item img {
                width: 85px;
                height: 85px;
                object-fit: cover;
                border-radius: 12px;
                margin-right: 20px;
                border: 1px solid #eee;
            }
            .item-info {
                flex-grow: 1;
            }
            .item-name {
                font-weight: 600;
                color: #333;
                text-decoration: none;
            }
            .item-name:hover {
                color: #ff69b4;
            }
            .item-price {
                color: #ff69b4;
                font-weight: 700;
                font-size: 1rem;
            }

            .quantity-box {
                display: flex;
                align-items: center;
            }
            .quantity-btn {
                width: 32px;
                height: 32px;
                border: 1px solid #ddd;
                background: #fff;
                border-radius: 6px;
                font-weight: bold;
                color: #555;
            }
            .quantity-btn:hover {
                background: #ffeff8;
                color: #ff69b4;
            }
            .quantity-input {
                width: 55px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 6px;
                margin: 0 5px;
            }

            .btn-delete-selected {
                background: linear-gradient(135deg, #ff7eb9, #ff4b8a);
                color: white;
                border: none;
                border-radius: 12px;
                padding: 8px 18px;
                font-weight: 600;
                margin-left: 15px;
                transition: 0.3s;
            }
            .btn-delete-selected:hover {
                background: linear-gradient(135deg, #ff4b8a, #ff2b70);
            }

            .total-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 20px;
                padding-top: 15px;
                border-top: 2px solid #ffe6f0;
            }

            .btn-checkout {
                background: linear-gradient(135deg, #ff80b5, #ff69b4);
                color: white;
                border: none;
                border-radius: 12px;
                padding: 10px 25px;
                font-weight: 600;
                transition: 0.3s;
            }
            .btn-checkout:hover {
                background: linear-gradient(135deg, #ff69b4, #ff3385);
            }

            #selectAll {
                accent-color: #ff69b4;
            }

            .btn-outline-pink {
                border: 1px solid #ff69b4;
                color: #ff69b4;
                border-radius: 12px;
                padding: 8px 20px;
                transition: 0.3s;
            }
            .btn-outline-pink:hover {
                background: #ff69b4;
                color: #fff;
            }
        </style>
    </sitemesh:head>

    <div class="cart-container">
        <div class="cart-header">
            <h3>🛒 Giỏ hàng của bạn</h3>
            <p class="text-muted">Chọn sản phẩm và thao tác dễ dàng 🌸</p>
        </div>

        <!-- Nếu giỏ hàng trống -->
        <c:if test="${empty cart.cartItems}">
            <div class="text-center py-5">
                <i class="bi bi-bag-x fs-1 text-muted"></i>
                <p class="mt-3">Giỏ hàng của bạn đang trống.</p>
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-pink">Tiếp tục mua sắm</a>
            </div>
        </c:if>

        <!-- Nếu có sản phẩm -->
        <c:if test="${not empty cart.cartItems}">
            <form id="cartForm" method="get" action="${pageContext.request.contextPath}/user/cart/delete-selected">
                <div class="d-flex align-items-center mb-3">
                    <input type="checkbox" id="selectAll" class="me-2">
                    <label for="selectAll" class="fw-medium me-auto">Chọn tất cả</label>
                    <button type="button" id="btnDeleteSelected" class="btn-delete-selected">
                        <i class="bi bi-trash"></i> Xóa
                    </button>
                </div>

                <c:forEach var="item" items="${cart.cartItems}">
                    <div class="cart-item">
                        <input type="checkbox" name="selectedItems" value="${item.id}" class="item-checkbox me-3">
                        <img src="${pageContext.request.contextPath}/images/${item.product.imageUrl}" alt="${item.product.name}">
                        <div class="item-info">
                            <a href="${pageContext.request.contextPath}/product/${item.product.id}" class="item-name">${item.product.name}</a><br>
                            <span class="text-muted small">${item.product.sku}</span><br>
                            <span class="item-price" data-price="${item.unitPrice}">
                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>

                        <div class="quantity-box">
                            <button type="button" class="quantity-btn minus">-</button>
                            <input type="text" class="quantity-input" value="${item.quantity}" readonly>
                            <button type="button" class="quantity-btn plus">+</button>
                        </div>

                        <div class="ms-3">
                            <strong class="item-total text-danger">
                                <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" currencySymbol="₫"/>
                            </strong>
                        </div>
                    </div>
                </c:forEach>

                <div class="total-bar">
                    <div>
                        <strong>Tổng cộng:</strong>
                        <span id="cartTotal" class="text-danger fw-bold">
                            <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫"/>
                        </span>
                    </div>
                    <button type="button" class="btn-checkout">Thanh toán</button>
                </div>
            </form>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    // ✅ Chọn tất cả
    $('#selectAll').on('change', function() {
        $('.item-checkbox').prop('checked', $(this).prop('checked'));
        updateTotal(); // tính lại tổng khi chọn tất cả
    });

    // ✅ Chọn từng sản phẩm
    $('.item-checkbox').on('change', function() {
        // nếu tất cả checkbox được chọn, check selectAll
        $('#selectAll').prop('checked', $('.item-checkbox:checked').length === $('.item-checkbox').length);
        updateTotal(); // cập nhật tổng tiền
    });

    // ✅ Nút XÓA — xử lý tất cả sản phẩm được chọn
    $('#btnDeleteSelected').on('click', function() {
        let ids = [];
        $('.item-checkbox:checked').each(function() {
            ids.push($(this).val());
        });

        if (ids.length === 0) {
            alert('Vui lòng chọn ít nhất một sản phẩm để xóa!');
            return;
        }

        if (confirm('Bạn có chắc muốn xóa các sản phẩm đã chọn?')) {
            window.location.href = '${pageContext.request.contextPath}/user/cart/delete-selected?ids=' + ids.join(',');
        }
    });

    // ✅ Cộng / Trừ số lượng
    $(document).on('click', '.plus', function() {
        let input = $(this).siblings('.quantity-input');
        input.val(parseInt(input.val()) + 1);
        updateItemTotal($(this).closest('.cart-item'));
        updateTotal();
    });

    $(document).on('click', '.minus', function() {
        let input = $(this).siblings('.quantity-input');
        input.val(Math.max(1, parseInt(input.val()) - 1));
        updateItemTotal($(this).closest('.cart-item'));
        updateTotal();
    });

    // ✅ Cập nhật tổng tiền của 1 item
    function updateItemTotal(cartItem) {
        let qty = parseInt(cartItem.find('.quantity-input').val());
        let price = parseFloat(cartItem.find('.item-price').data('price'));
        cartItem.find('.item-total').text(new Intl.NumberFormat('vi-VN').format(qty * price) + '₫');
    }

    // ✅ Cập nhật tổng tiền dựa trên các sản phẩm được chọn
    function updateTotal() {
        let total = 0;
        $('.cart-item').each(function() {
            if ($(this).find('.item-checkbox').is(':checked')) {
                let qty = parseInt($(this).find('.quantity-input').val());
                let price = parseFloat($(this).find('.item-price').data('price'));
                total += qty * price;
            }
        });
        $('#cartTotal').text(new Intl.NumberFormat('vi-VN').format(total) + '₫');
    }

    // Khởi tạo tổng tiền lúc load page dựa trên checkbox đã chọn
    $(document).ready(function(){
        updateTotal();
    });
    </script>

</sitemesh:page>
