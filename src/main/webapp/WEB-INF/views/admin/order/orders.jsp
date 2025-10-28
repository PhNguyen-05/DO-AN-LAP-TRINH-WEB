<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
/* ... (CSS chung giữ nguyên) ... */
body {
	background: linear-gradient(to bottom, #fff0f5, #ffffff);
	font-family: 'Segoe UI', sans-serif;
	color: #333;
}
.page-title {
	color: #ff69b4;
	font-weight: 600;
	margin-bottom: 0;
}
.container {
	padding-top: 0.8rem !important;
}
.btn-pink {
	background-color: #ff69b4;
	border: none;
	color: white;
	transition: background-color 0.3s;
}
.btn-pink:hover {
	background-color: #ff1493;
}
.search-bar {
	background-color: #fff;
	border-radius: 12px;
	padding: 10px 14px;
	box-shadow: 0 2px 6px rgba(255, 105, 180, 0.2);
	display: flex;
	align-items: center;
	gap: 10px;
}
.search-bar .form-control, .search-bar .form-select {
	border: 1px solid #ffe4ec;
	border-radius: 8px;
	box-shadow: none;
}
.search-bar .form-control:focus, .search-bar .form-select:focus {
	border-color: #ff69b4;
	box-shadow: 0 0 0 0.1rem rgba(255, 105, 180, 0.3);
}
.card {
	border: none;
	box-shadow: 0 2px 10px rgba(255, 105, 180, 0.2);
	border-radius: 10px;
}
.table th {
	background-color: #ffb6c1;
	color: #fff;
	font-weight: 600;
}
.table td, .table th {
	vertical-align: middle;
}
tr:hover {
	background-color: #fff0f5;
}
.no-results {
	font-style: italic;
	color: #6c757d;
}

/* === SỬA: CSS CHO 6 TRẠNG THÁI MỚI === */
.status-badge {
    padding: 0.35em 0.65em;
    font-size: .75em;
    font-weight: 700;
    border-radius: 0.375rem;
    color: #fff;
}
.status-pending { background-color: #ffc107; color: #000;} /* Vàng */
.status-confirmed { background-color: #0dcaf0; } /* Xanh lơ */
.status-delivering { background-color: #0d6efd; } /* Xanh dương */
.status-delivered { background-color: #198754; } /* Xanh lá */
.status-cancelled { background-color: #dc3545; } /* Đỏ */
.status-returned { background-color: #6c757d; } /* Xám */

</style>

<div class="container py-3">
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="page-title">🌸 Quản Lý Đơn Hàng 🌸</h2>
	</div>

	<form action="${pageContext.request.contextPath}/admin/orders"
		method="get" class="search-bar mb-3">

		<select name="status" class="form-select" style="max-width: 220px;">
			<option value="">Tất cả trạng thái</option>
			<option value="Chờ xác nhận" ${selectedStatus == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
			<option value="Đã xác nhận" ${selectedStatus == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
			<option value="Đang giao" ${selectedStatus == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
			<option value="Đã giao" ${selectedStatus == 'Đã giao' ? 'selected' : ''}>Đã giao</option>
			<option value="Hủy" ${selectedStatus == 'Hủy' ? 'selected' : ''}>Hủy</option>
			<option value="Trả hàng- hoàn tiền" ${selectedStatus == 'Trả hàng- hoàn tiền' ? 'selected' : ''}>Trả hàng- hoàn tiền</option>
		</select>

		<select name="vendorId" class="form-select" style="max-width: 220px;">
			<option value="">Tất cả các shop</option>
			<c:forEach var="vendor" items="${vendors}">
				<option value="${vendor.id}"
					${selectedVendorId == vendor.id ? 'selected' : ''}>${vendor.shopName}</option>
			</c:forEach>
		</select>
		
		<button type="submit" class="btn btn-pink px-3">
			<i class="bi bi-funnel me-1"></i> Lọc
		</button>
	</form>

	<c:if test="${not empty success}">
		<div class="alert alert-success">${success}</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger">${error}</div>
	</c:if>

	<div class="card">
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover mb-0">
					<thead>
						<tr>
							<th class="text-center">Mã ĐH</th>
							<th>Khách Hàng</th>
							<th>Shop</th>
							<th class="text-center">Ngày Đặt</th>
							<th class="text-center">Tổng Tiền</th>
							<th class="text-center">Trạng Thái</th>
							<th class="text-center">Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${orders}">
							<tr>
								<td class="text-center">#${order.id}</td>
								<td>${order.customer.fullName}</td>
								<td>${order.vendor.shopName}</td>
								<td class="text-center">
									<fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
								</td>
								<td class="text-center fw-bold">
									<fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND" />
								</td>
								
								<td class="text-center">
									<c:choose>
										<c:when test="${order.status == 'Đã giao'}">
											<span class="status-badge status-delivered">Đã giao</span>
										</c:when>
										<c:when test="${order.status == 'Đang giao'}">
											<span class="status-badge status-delivering">Đang giao</span>
										</c:when>
										<c:when test="${order.status == 'Đã xác nhận'}">
											<span class="status-badge status-confirmed">Đã xác nhận</span>
										</c:when>
										<c:when test="${order.status == 'Hủy'}">
											<span class="status-badge status-cancelled">Hủy</span>
										</c:when>
										<c:when test="${order.status == 'Trả hàng- hoàn tiền'}">
											<span class="status-badge status-returned">Trả hàng</span>
										</c:when>
										<c:otherwise> <span class="status-badge status-pending">Chờ xác nhận</span>
										</c:otherwise>
									</c:choose>
								</td>
								
								<td class="text-center">
									<a href="${pageContext.request.contextPath}/admin/orders/detail/${order.id}"
										class="btn btn-outline-secondary btn-sm me-1"
										title="Xem chi tiết"> 
										<i class="bi bi-eye"></i>
									</a> 
									<button class="btn btn-outline-primary btn-sm"
										title="Cập nhật trạng thái"
										onclick="openUpdateStatusModal(${order.id}, '${order.status}')">
										<i class="bi bi-pencil-square"></i>
									</button>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty orders}">
							<tr>
								<td colspan="7" class="text-center py-4 no-results">
									<i class="bi bi-search fs-4 d-block mb-2"></i>
                                    Không tìm thấy đơn hàng nào.
                                </td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="statusModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 400px;">
		<div class="modal-content shadow-lg border-0 rounded-3">
			<form id="statusForm" action="${pageContext.request.contextPath}/admin/orders/update-status" method="post">
				<div class="modal-header bg-light border-bottom">
					<h5 class="modal-title fw-bold">Cập Nhật Trạng Thái</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="orderId" id="modalOrderId">
					<div class="mb-3">
						<label for="modalStatus" class="form-label">Trạng thái mới:</label>
						<select name="status" id="modalStatus" class="form-select">
							<option value="Chờ xác nhận">Chờ xác nhận</option>
							<option value="Đã xác nhận">Đã xác nhận</option>
							<option value="Đang giao">Đang giao</option>
							<option value="Đã giao">Đã giao</option>
							<option value="Hủy">Hủy</option>
							<option value="Trả hàng- hoàn tiền">Trả hàng- hoàn tiền</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
					<button type="submit" class="btn btn-pink">Lưu thay đổi</button>
				</div>
			</form>
		</div>
	</div>
</div>


<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Biến modal (để tránh tạo lại nhiều lần)
var statusModalInstance = null;
document.addEventListener('DOMContentLoaded', function() {
    var modalEl = document.getElementById('statusModal');
    if (modalEl) {
        statusModalInstance = new bootstrap.Modal(modalEl);
    }
});

// Hàm mở Modal và gán dữ liệu
function openUpdateStatusModal(orderId, currentStatus) {
    if (statusModalInstance) {
        document.getElementById('modalOrderId').value = orderId;
        document.getElementById('modalStatus').value = currentStatus;
        statusModalInstance.show();
    }
}
</script>