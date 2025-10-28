<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container py-4">
    <h2 class="text-pink mb-4">🌸 Chi Tiết Chủ Shop 🌸</h2>

    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h5 class="card-title fw-bold">${vendor.shopName}</h5>
            <p><strong>Email:</strong> ${vendor.email}</p>
            <p><strong>Điện thoại:</strong> ${vendor.phone}</p>
            <p><strong>Địa chỉ:</strong> ${vendor.address}</p>
            <p><strong>Mô tả:</strong> ${vendor.description}</p>
            <p><strong>Trạng thái:</strong>
                <c:choose>
                    <c:when test="${vendor.user.active}">
                        <span class="text-success">Đang hoạt động</span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-danger">Ngưng hoạt động</span>
                    </c:otherwise>
                </c:choose>
            </p>
            <p><strong>Ngày tạo:</strong> ${vendor.createdAt}</p>
        </div>
    </div>

    <h4 class="mb-3">🌼 Sản phẩm của shop</h4>
    <c:if test="${not empty vendor.products}">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th class="text-center">ID</th>
                        <th class="text-center">Ảnh</th>
                        <th>Tên sản phẩm</th> <th class="text-center">Giá</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${vendor.products}">
                        <tr>
                            <td class="text-center">${product.id}</td>
                             <td class="text-center"> <c:if test="${not empty product.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/images/${product.imageUrl}"style="width: 50px; height: 50px; object-fit: cover;"/>
                                </c:if>
                                <c:if test="${empty product.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/images/no-image.png" class="product-img"/>
                                </c:if>
                            </td>
                            <td class="text-center">${product.name}</td> <td class="text-center">${product.price}</td> </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty vendor.products}">
        <p class="text-muted fst-italic">Chưa có sản phẩm nào.</p>
    </c:if>

    <a href="${pageContext.request.contextPath}/admin/vendors" class="btn btn-pink mt-3">
        <i class="bi bi-arrow-left"></i> Quay lại danh sách
    </a>
</div>

<style>
.text-pink { color: #ff69b4; }
.btn-pink { background-color: #ff69b4; color: white; }
.btn-pink:hover { background-color: #ff1493; }

/* === PHẦN THÊM MỚI === */

/* 1. CSS cho ảnh sản phẩm */
.product-img {
    width: 70px;  /* Kích thước ảnh thumbnail */
    height: 70px;
    object-fit: cover; /* Đảm bảo ảnh không bị méo */
    border-radius: 8px; /* Bo góc cho đẹp */
    border: 1px solid #eee; /* Thêm viền mờ */
}

/* 2. CSS căn giữa dọc cho toàn bộ bảng */
.table td,
.table th {
    vertical-align: middle; /* Đây là chìa khóa để căn giữa dọc */
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>