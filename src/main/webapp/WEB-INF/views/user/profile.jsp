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
        body {
            background-color: #fff;
        }
        .text-pink { color: #ff1493; }
        .btn-pink { background-color: #ffd6e8; color: #ff1493; }
        .btn-pink:hover { background-color: #ffb6d9; color: #fff; }
    </style>
</head>
<body>

    <!-- Header dùng chung -->
    <%@ include file="/common/header.jsp" %>

    <!-- Nội dung chính -->
    <div class="container py-5" style="max-width: 800px;">
        <div class="card shadow-sm rounded-4" style="background-color: #fff0f6;">
            <div class="card-body p-5">

                <h3 class="text-center fw-bold text-pink mb-4">Thông tin cá nhân</h3>

                <!-- Tên và email -->
                <h4 class="fw-bold text-pink mb-2">
                    <c:out value="${not empty customer.hoTen ? customer.hoTen : 'Chưa cập nhật'}"/>
                </h4>
                <c:if test="${not empty sessionScope.currentUser.email}">
                    <p class="text-muted mb-4">${sessionScope.currentUser.email}</p>
                </c:if>

                <!-- Thông tin chi tiết -->
                <div class="row text-start">
                    <div class="col-md-6 mb-3">
                        <strong>Số điện thoại:</strong> 
                        <c:out value="${not empty customer.soDienThoai ? customer.soDienThoai : 'Chưa cập nhật'}"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Địa chỉ mặc định:</strong> 
                        <c:out value="${not empty customer.diaChi ? customer.diaChi : 'Chưa cập nhật'}"/>
                    </div>
                   <div class="col-md-6 mb-3">
                    <strong>Ngày tạo tài khoản:</strong>
                    <c:choose>
                        <c:when test="${not empty createdDate}">
                            <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </c:when>
                        <c:otherwise>Chưa cập nhật</c:otherwise>
                    </c:choose>
                    </div>
                </div>

                <!-- Chỉnh sửa thông tin -->
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/user/profile/edit" 
                    class="btn btn-pink rounded-pill px-4 py-2 shadow-sm">
                        <i class="bi bi-pencil-square me-2"></i> Chỉnh sửa thông tin
                    </a>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
