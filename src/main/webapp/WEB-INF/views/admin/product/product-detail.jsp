<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.util.Date"%>

<!-- CSS tùy chỉnh cho trang chi tiết -->
<style>
    body {
        background: linear-gradient(to bottom, #fff0f5, #ffffff); /* Gradient pastel pink */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .page-title {
        color: #ff69b4; /* Pink theme */
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        animation: fadeIn 1s ease-in-out;
    }
    .card {
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 20px rgba(255, 105, 180, 0.2); /* Pink shadow */
        overflow: hidden;
        animation: fadeIn 1.5s ease-in-out;
    }
    .product-image {
        transition: transform 0.3s ease;
        border-radius: 15px;
    }
    .product-image:hover {
        transform: scale(1.1); /* Zoom effect */
    }
    .product-name {
        color: #ff1493; /* Deep pink */
        font-weight: bold;
        font-size: 1.8rem;
    }
    .product-desc {
        font-style: italic;
        color: #555;
    }
    .badge-category {
        background-color: #ffb6c1; /* Light pink */
        color: #fff;
        font-size: 1rem;
        padding: 0.5em 1em;
        border-radius: 20px;
    }
    .btn-back {
        background-color: #ff69b4;
        border: none;
        border-radius: 25px;
        color: white;
        transition: background-color 0.3s;
    }
    .btn-back:hover {
        background-color: #ff1493;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .info-item {
        margin-bottom: 1rem;
        animation: fadeIn 2s ease-in-out;
    }
</style>

<div class="container py-5">
    <h2 class="page-title text-center mb-4">🌸 Chi Tiết Sản Phẩm 🌸</h2>
    <div class="card">
        <div class="card-body p-4">
            <div class="row">
                <div class="col-md-5 text-center mb-4">
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <img src="${pageContext.request.contextPath}/images/${product.imageUrl}"
                                 alt="Ảnh sản phẩm" class="img-fluid product-image"
                                 onerror="this.src='https://via.placeholder.com/400x400?text=Hoa+Đẹp';">
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">🌼 Chưa có ảnh</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-7">
                    <h4 class="product-name">${product.name}</h4>
                    <p class="product-desc info-item">
                        <i class="bi bi-chat-dots-fill me-2 text-pink"></i><strong>Mô tả:</strong> ${product.description}
                    </p>
                    <p class="info-item">
                        <i class="bi bi-currency-exchange me-2 text-pink"></i><strong>Giá:</strong>
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" />
                    </p>
                    <p class="info-item">
                        <i class="bi bi-box-seam me-2 text-pink"></i><strong>Tồn kho:</strong> ${product.stock}
                    </p>
                    <p class="info-item">
                        <i class="bi bi-tags-fill me-2 text-pink"></i><strong>Danh mục:</strong> 
                        <span class="badge badge-category">${product.category.name}</span>
                    </p>
                    <p class="info-item">
                        <i class="bi bi-calendar-event me-2 text-pink"></i><strong>Ngày tạo:</strong>
                        <fmt:formatDate value="${createdAtDate}" pattern="dd/MM/yyyy" />
                    </p>
                </div>
            </div>
            <div class="mt-4 text-end">
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-back">
                    <i class="bi bi-arrow-left me-2"></i> Quay lại danh sách
                </a>
            </div>
        </div>
    </div>
</div>