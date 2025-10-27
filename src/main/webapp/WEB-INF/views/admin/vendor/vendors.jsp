<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
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

.search-bar .input-group-text {
	background-color: #ffb6c1;
	color: #fff;
	border: none;
	border-radius: 8px 0 0 8px;
}

.search-bar .form-control {
	border: 1px solid #ffe4ec;
	border-radius: 8px;
	box-shadow: none;
}

.search-bar .form-control:focus {
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

.status-active {
	color: #28a745;
	font-weight: 500;
}

.status-inactive {
	color: #dc3545;
	font-weight: 500;
}

tr:hover {
	background-color: #fff0f5;
}

.no-results {
	font-style: italic;
	color: #6c757d;
}
</style>

<div class="container py-3">
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="page-title">🌸 Quản Lý Chủ Shop Bán Hoa 🌸</h2>
		<button class="btn btn-pink btn-sm" onclick="openAddVendor()">
			<i class="bi bi-plus-lg me-1"></i> Thêm Chủ Shop
		</button>
	</div>

	<form action="${pageContext.request.contextPath}/admin/vendors"
		method="get" class="search-bar mb-3">
		<div class="input-group" style="max-width: 400px;">
			<span class="input-group-text"><i class="bi bi-search"></i></span> <input
				type="text" name="keyword" class="form-control"
				placeholder="Tìm theo tên shop hoặc người đại diện..."
				value="${param.keyword}">
		</div>
		<button type="submit" class="btn btn-pink px-3">
			<i class="bi bi-funnel me-1"></i> Tìm
		</button>
	</form>

	<c:if test="${not empty error}">
		<div class="alert alert-danger">${error}</div>
	</c:if>

	<div class="card">
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover mb-0">
					<thead>
						<tr>
							<th class="text-center">ID</th>
							<th class="text-center">Tên Shop</th>

							<th class="text-center">Email</th>
							<th class="text-center">Số Điện Thoại</th>
							<th class="text-center">Trạng Thái</th>
							<th class="text-center">Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vendor" items="${vendors}">
							<tr>
								<td class="text-center">${vendor.id}</td>
								<td>${vendor.shopName}</td>

								<td class="text-center">${vendor.email}</td>
								<td class="text-center">${vendor.phone}</td>
								<td class="text-center"><c:choose>
										<%-- Sửa thành kiểm tra trạng thái của User --%>
										<c:when test="${vendor.user.isActive()}">
											<span class="status-active">Đang hoạt động</span>
										</c:when>
										<c:otherwise>
											<span class="status-inactive">Ngưng hoạt động</span>
										</c:otherwise>
									</c:choose></td>
								<td class="text-center">
									<button class="btn btn-outline-primary btn-sm me-1"
										onclick="openEditVendor(${vendor.id})" title="Sửa">
										<i class="bi bi-pencil"></i>
									</button> <a
									href="${pageContext.request.contextPath}/admin/vendors/delete/${vendor.id}"
									class="btn btn-outline-danger btn-sm"
									onclick="return confirm('Bạn có chắc muốn xóa chủ shop này?')"
									title="Xóa"> <i class="bi bi-trash"></i>
								</a>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty vendors}">
							<tr>
								<td colspan="7" class="text-center py-4 no-results"><i
									class="bi bi-search fs-4 d-block mb-2"></i> Chưa có chủ shop
									nào trong hệ thống.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- Modal Thêm -->
<div class="modal fade" id="addVendorModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content shadow-lg border-0 rounded-3">
			<div class="modal-header bg-light border-bottom">
				<h5 class="modal-title fw-bold">Thêm Chủ Shop</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<jsp:include page="vendor-form.jsp">
					<jsp:param name="formId" value="vendorFormAdd" />
				</jsp:include>
			</div>
		</div>
	</div>
</div>

<!-- Modal Sửa -->
<div class="modal fade" id="editVendorModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content shadow-lg border-0 rounded-3">
			<div class="modal-header bg-light border-bottom">
				<h5 class="modal-title fw-bold">Chỉnh Sửa Chủ Shop</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<jsp:include page="vendor-form.jsp">
					<jsp:param name="formId" value="vendorFormEdit" />
				</jsp:include>
			</div>
		</div>
	</div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function openAddVendor() {
    const form = document.getElementById('vendorFormAdd');
    form.reset();
    form.action = '${pageContext.request.contextPath}/admin/vendor/save';
    const modal = new bootstrap.Modal(document.getElementById('addVendorModal'));
    modal.show();
}

function openEditVendor(id) {
    fetch('${pageContext.request.contextPath}/admin/vendor/' + id)
        .then(response => response.json())
        .then(data => {
            const form = document.getElementById('vendorFormEdit');
            form.action = '${pageContext.request.contextPath}/admin/vendor/save';

            form.querySelector('#id').value = data.id || '';
            form.querySelector('#shopName').value = data.shopName || '';
            form.querySelector('#address').value = data.address || '';
            form.querySelector('#phone').value = data.phone || '';
            form.querySelector('#email').value = data.email || '';
            form.querySelector('#description').value = data.description || '';

            const modal = new bootstrap.Modal(document.getElementById('editVendorModal'));
            modal.show();
        })
        .catch(err => alert('Không thể tải dữ liệu: ' + err.message));
}
</script>
