<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
/* Style cơ bản cho trang */
body {
    background: linear-gradient(to bottom, #fdf6f9, #ffffff);
    font-family: 'Segoe UI', sans-serif;
}
.page-title {
    color: #ff69b4; /* Màu hồng */
    font-weight: 600;
}
.btn-pink {
    background-color: #ff69b4;
    border: none;
    color: white;
}
.btn-pink:hover {
    background-color: #ff1493;
}
.table th {
    background-color: #ffb6c1; /* Màu hồng nhạt */
    color: #fff;
    font-weight: 600;
}
.table td, .table th {
    vertical-align: middle;
}
.card {
    border: none;
    box-shadow: 0 2px 10px rgba(255, 105, 180, 0.2);
    border-radius: 10px;
}
.status-delivered { color: #28a745; }
.status-pending { color: #fd7e14; }
.status-cancelled { color: #dc3545; }
</style>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="page-title">🌸 Lịch Sử Mua Hàng 🌸</h2>
        <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-pink btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title fw-bold">${customer.fullName}</h5>
            <p class="mb-1"><strong>Email:</strong> ${customer.user.email}</p>
            <p class="mb-0"><strong>Điện thoại:</strong> ${customer.phone}</p>
        </div>
    </div>

    <h4 class="mb-3">📄 Danh sách đơn hàng</h4>
    
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th class="text-center">Mã Đơn Hàng</th>
                            <th class="text-center">Ngày Đặt</th>
                            <th class="text-center">Tổng Tiền</th>
                            <th class="text-center">Trạng Thái</th>
                            <th class="text-center">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- 
                            LƯU Ý: Bạn cần truyền một danh sách tên là "orders" 
                            từ controller (như đã ghi chú ở file controller)
                        --%>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td class="text-center">${order.id}</td>
                                <td class="text-center">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td class="text-center">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND" />
                                </td>
                                <td class="text-center">
                                    <%-- Ví dụ xử lý trạng thái (bạn cần sửa lại cho khớp) --%>
                                    <c:choose>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <span class="status-delivered fw-bold">Đã giao</span>
                                        </c:when>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="status-pending fw-bold">Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                            <span class="status-cancelled fw-bold">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/orders/detail/${order.id}" 
                                       class="btn btn-outline-primary btn-sm" title="Xem chi tiết">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4 fst-italic">
                                    Khách hàng này chưa có đơn hàng nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>