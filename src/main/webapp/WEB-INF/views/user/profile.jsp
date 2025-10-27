<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân | StarShop</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body { background-color: #fff; }
        .text-pink { color: #ff1493; }
        .btn-pink { background-color: #ffd6e8; color: #ff1493; }
        .btn-pink:hover { background-color: #ffb6d9; color: #fff; }
        .btn-outline-pink { border-color: #ff1493; color: #ff1493; }
        .btn-outline-pink:hover { background-color: #ff1493; color: #fff; }
    </style>
</head>
<body>

<%@ include file="/common/header.jsp" %>

<div class="container py-5" style="max-width: 800px;">
    <div class="card shadow-sm rounded-4" style="background-color: #fff0f6;">
        <div class="card-body p-5">

            <h3 class="text-center fw-bold text-pink mb-4">Thông tin cá nhân</h3>

            <!-- Tên và email -->
            <h4 class="fw-bold text-pink mb-2">
                <c:out value="${not empty customer.fullName ? customer.fullName : 'Chưa cập nhật'}"/>
            </h4>
            <c:if test="${not empty sessionScope.currentUser.email}">
                <p class="text-muted mb-4">${sessionScope.currentUser.email}</p>
            </c:if>

            <!-- Thông tin chi tiết -->
            <div class="row text-start mb-3">
                <div class="col-md-6 mb-2">
                    <strong>Số điện thoại:</strong> 
                    <c:out value="${not empty customer.phone ? customer.phone : 'Chưa cập nhật'}"/>
                </div>
                <div class="col-md-6 mb-2">
                    <strong>Địa chỉ mặc định:</strong> 
                    <c:choose>
                        <c:when test="${not empty customer.addressList}">
                            <c:forEach var="addr" items="${customer.addressList}">
                                <c:if test="${addr.defaultAddress}">
                                    <c:out value="${addr.detail}"/>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>Chưa cập nhật</c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-6 mb-2">
                    <strong>Ngày tạo tài khoản:</strong>
                    <c:choose>
                        <c:when test="${not empty createdDate}">
                            <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </c:when>
                        <c:otherwise>Chưa cập nhật</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Nút chỉnh sửa thông tin -->
            <div class="text-center mb-4">
                <a href="${pageContext.request.contextPath}/user/profile/edit" 
                   class="btn btn-pink rounded-pill px-4 py-2 shadow-sm">
                   <i class="bi bi-pencil-square me-2"></i> Chỉnh sửa thông tin
                </a>
            </div>

            <!-- Danh sách địa chỉ -->
            <h5 class="text-pink fw-bold mb-3">Địa chỉ nhận hàng</h5>
            <c:if test="${not empty customer.addressList}">
                <c:forEach var="addr" items="${customer.addressList}">
                    <div class="border rounded p-3 mb-2">
                        <p class="mb-1"><strong>Nhãn:</strong> ${addr.label}</p>
                        <p class="mb-1"><strong>Địa chỉ:</strong> ${addr.detail}</p>
                        <c:if test="${addr.defaultAddress}">
                            <span class="badge bg-pink text-white">Mặc định</span>
                        </c:if>
                        <div class="mt-2">
                            <a href="${pageContext.request.contextPath}/user/profile/address/edit?id=${addr.id}" 
                               class="btn btn-sm btn-outline-pink me-2">Sửa</a>
                            <a href="${pageContext.request.contextPath}/user/profile/address/delete/${addr.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Bạn có chắc muốn xóa địa chỉ này không?');">Xóa</a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty customer.addressList}">
                <p>Chưa có địa chỉ nào.</p>
            </c:if>

            <!-- Nút thêm địa chỉ mới -->
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/user/profile/address/edit" 
                   class="btn btn-pink px-4 py-2 rounded-pill">
                   <i class="bi bi-plus-circle me-2"></i> Thêm địa chỉ mới
                </a>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
