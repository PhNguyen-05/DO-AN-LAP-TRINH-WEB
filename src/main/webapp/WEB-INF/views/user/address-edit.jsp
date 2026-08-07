<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Địa chỉ nhận hàng | StarShop</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
body { background-color: #fff; }
.text-pink { color: #ff1493; }
.btn-pink { background-color: #ffd6e8; color: #ff1493; }
.btn-pink:hover { background-color: #ffb6d9; color: #fff; }
</style>
</head>
<body>
<%@ include file="/common/header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <div class="card shadow-sm rounded-4 p-4">
        <h3 class="text-center text-pink mb-4">
            <c:choose>
                <c:when test="${not empty address.id}">Chỉnh sửa địa chỉ</c:when>
                <c:otherwise>Thêm địa chỉ mới</c:otherwise>
            </c:choose>
        </h3>

        <form action="${pageContext.request.contextPath}/user/profile/address/save" method="post">
            <c:if test="${not empty address.id}">
                <input type="hidden" name="id" value="${address.id}" />
            </c:if>

            <div class="mb-3">
                <label class="form-label">Nhãn địa chỉ</label>
                <input type="text" name="label" class="form-control" value="${address.label}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Chi tiết địa chỉ</label>
                <textarea name="detail" class="form-control" rows="3" required>${address.detail}</textarea>
            </div>

            <div class="form-check mb-3">
                <!-- Chỉnh tên checkbox trùng với entity: defaultAddress -->
                <input class="form-check-input" type="checkbox" name="defaultAddress" id="defaultAddress"
                       <c:if test="${address.defaultAddress}">checked</c:if>>
                <label class="form-check-label" for="defaultAddress">Đặt mặc định</label>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-pink px-4 py-2 rounded-pill">
                    <i class="bi bi-check-circle me-2"></i>Lưu
                </button>
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary px-4 py-2 rounded-pill ms-2">
                    <i class="bi bi-x-circle me-2"></i>Hủy
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
