<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
body {
	background: linear-gradient(to bottom, #fff0f5, #ffffff);
	font-family: 'Segoe UI', sans-serif;
	color: #333;
}
.page-title { color: #ff69b4; font-weight: 600; }
.btn-pink { background-color: #ff69b4; border: none; color: white; transition: background-color 0.3s; }
.btn-pink:hover { background-color: #ff1493; }
.card { border: none; box-shadow: 0 2px 10px rgba(255,105,180,0.2); border-radius: 10px; }
.table th { background-color: #ffb6c1; color: #fff; font-weight: 600; }
.low-stock { color: #dc3545; font-weight: bold; }
tr:hover { background-color: #fff0f5; }
#viewImageContainer img {
	max-width: 100%;
	max-height: 250px;
	border-radius: 10px;
	object-fit: cover;
	box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}
</style>

<div class="container py-3">
	<!-- Tiêu đề + nút thêm -->
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="page-title">🌸 Quản Lý Sản Phẩm 🌸</h2>
		<button class="btn btn-pink btn-sm" data-bs-toggle="modal" data-bs-target="#addProductModal">
			<i class="bi bi-plus-lg me-1"></i> Thêm Sản Phẩm
		</button>
	</div>

	<!-- Thanh tìm kiếm -->
	<form action="${pageContext.request.contextPath}/vendor/products" method="get" class="search-bar mb-3 d-flex gap-2">
		<input type="text" name="name" class="form-control" placeholder="Tìm theo tên sản phẩm..." value="${param.name}">
		<select name="categoryId" class="form-select" style="max-width: 220px;">
			<option value="">Tất cả danh mục</option>
			<c:forEach var="category" items="${categories}">
				<option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
			</c:forEach>
		</select>
		<button type="submit" class="btn btn-pink"><i class="bi bi-search me-1"></i>Tìm</button>
	</form>

	<!-- Bảng sản phẩm -->
	<div class="card">
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead>
						<tr class="text-center">
							<th>ID</th>
							<th>Ảnh</th>
							<th>Tên</th>
							<th>Mô tả</th>
							<th>Giá</th>
							<th>Tồn kho</th>
							<th>Danh mục</th>
							<th>Hành động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="product" items="${products}">
							<tr>
								<td class="text-center">${product.id}</td>
								<td class="text-center">
									<c:choose>
										<c:when test="${not empty product.imageUrl}">
											<c:if test="${fn:startsWith(product.imageUrl, 'http')}">
												<img src="${product.imageUrl}" class="rounded" style="width:50px; height:50px; object-fit:cover;" onerror="this.src='https://via.placeholder.com/50?text=No+Image'">
											</c:if>
											<c:if test="${not fn:startsWith(product.imageUrl, 'http')}">
												<img src="${pageContext.request.contextPath}/images/${product.imageUrl}" class="rounded" style="width:50px; height:50px; object-fit:cover;" onerror="this.src='https://via.placeholder.com/50?text=No+Image'">
											</c:if>
										</c:when>
										<c:otherwise>
											<img src="https://via.placeholder.com/50?text=No+Image" class="rounded">
										</c:otherwise>
									</c:choose>
								</td>
								<td>${product.name}</td>
								<td class="text-muted" style="max-width: 180px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${product.description}</td>
								<td class="text-center"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" /></td>
								<td class="text-center ${product.stock < 10 ? 'low-stock' : ''}">${product.stock}</td>
								<td class="text-center">${product.category != null ? product.category.name : 'Không có'}</td>
								<td class="text-center">
									<!-- Xem -->
									<button class="btn btn-outline-primary btn-sm me-1"
										data-bs-toggle="modal" data-bs-target="#viewProductModal"
										data-id="${product.id}" data-name="${fn:escapeXml(product.name)}"
										data-description="${fn:escapeXml(product.description)}"
										data-price="${product.price}" data-stock="${product.stock}"
										data-image="${fn:escapeXml(product.imageUrl)}"
										data-category="${product.category != null ? fn:escapeXml(product.category.name) : 'Không có'}"
										onclick="openViewModal(this)">
										<i class="bi bi-eye"></i>
									</button>
									<!-- Sửa -->
									<button class="btn btn-outline-warning btn-sm me-1"
										data-bs-toggle="modal" data-bs-target="#editProductModal"
										onclick="openEditModal(${product.id}, '${fn:escapeXml(product.name)}', '${fn:escapeXml(product.description)}', ${product.price}, ${product.stock}, '${fn:escapeXml(product.imageUrl)}', ${product.category != null ? product.category.id : 0})">
										<i class="bi bi-pencil"></i>
									</button>
									<!-- Xóa -->
									<button class="btn btn-outline-danger btn-sm"
										onclick="deleteProduct(${product.id})">
										<i class="bi bi-trash"></i>
									</button>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty products}">
							<tr><td colspan="8" class="text-center py-4 text-muted">Không có sản phẩm nào.</td></tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- Modal Xem chi tiết -->
<div class="modal fade" id="viewProductModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content rounded-3 shadow-lg">
			<div class="modal-header bg-info text-white">
				<h5 class="modal-title"><i class="bi bi-eye me-2"></i>Chi Tiết Sản Phẩm</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4">
				<div class="row g-4 align-items-start">
					<div class="col-md-4 text-center">
						<div id="viewImageContainer"></div>
					</div>
					<div class="col-md-8">
						<ul class="list-group list-group-flush">
							<li class="list-group-item"><strong>ID:</strong> <span id="viewProductId"></span></li>
							<li class="list-group-item"><strong>Tên:</strong> <span id="viewName"></span></li>
							<li class="list-group-item"><strong>Giá:</strong> <span id="viewPrice"></span></li>
							<li class="list-group-item"><strong>Tồn Kho:</strong> <span id="viewStock"></span></li>
							<li class="list-group-item"><strong>Danh Mục:</strong> <span id="viewCategory"></span></li>
							<li class="list-group-item"><strong>Mô Tả:</strong> <span id="viewDescription"></span></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal Thêm -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header bg-success text-white">
				<h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Thêm Sản Phẩm</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
			</div>
			<form id="addProductForm" enctype="multipart/form-data">
				<div class="modal-body">
					<div class="row g-3">
						<div class="col-md-6"><label class="form-label">Tên sản phẩm</label><input type="text" name="name" class="form-control" required></div>
						<div class="col-md-6"><label class="form-label">Giá</label><input type="number" name="price" class="form-control" required></div>
						<div class="col-md-12"><label class="form-label">Mô tả</label><textarea name="description" class="form-control" rows="2"></textarea></div>
						<div class="col-md-6"><label class="form-label">Tồn kho</label><input type="number" name="stock" class="form-control" required></div>
						<div class="col-md-6">
							<label class="form-label">Danh mục</label>
							<select name="category.id" class="form-select" required>
								<c:forEach var="cat" items="${categories}">
									<option value="${cat.id}">${cat.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-12"><label class="form-label">Ảnh</label><input type="file" name="imageFile" class="form-control"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-success">Lưu</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Modal Sửa -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header bg-warning text-white">
				<h5 class="modal-title"><i class="bi bi-pencil-square me-2"></i>Sửa Sản Phẩm</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
			</div>
			<form id="editProductForm" enctype="multipart/form-data">
				<input type="hidden" name="id" id="editId">
				<div class="modal-body">
					<div class="row g-3">
						<div class="col-md-6"><label class="form-label">Tên sản phẩm</label><input type="text" name="name" id="editName" class="form-control" required></div>
						<div class="col-md-6"><label class="form-label">Giá</label><input type="number" name="price" id="editPrice" class="form-control" required></div>
						<div class="col-md-12"><label class="form-label">Mô tả</label><textarea name="description" id="editDescription" class="form-control" rows="2"></textarea></div>
						<div class="col-md-6"><label class="form-label">Tồn kho</label><input type="number" name="stock" id="editStock" class="form-control" required></div>
						<div class="col-md-6">
							<label class="form-label">Danh mục</label>
							<select name="category.id" id="editCategory" class="form-select" required>
								<c:forEach var="cat" items="${categories}">
									<option value="${cat.id}">${cat.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-12"><label class="form-label">Ảnh (nếu muốn đổi)</label><input type="file" name="imageFile" class="form-control"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-warning">Cập nhật</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
// ✅ Modal xem chi tiết
function openViewModal(button) {
	const context = '${pageContext.request.contextPath}';
	const id = button.dataset.id;
	const name = button.dataset.name;
	const description = button.dataset.description;
	const price = button.dataset.price;
	const stock = button.dataset.stock;
	const image = button.dataset.image;
	const category = button.dataset.category;

	document.getElementById("viewProductId").textContent = id;
	document.getElementById("viewName").textContent = name;
	document.getElementById("viewPrice").textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
	document.getElementById("viewStock").textContent = stock;
	document.getElementById("viewCategory").textContent = category;
	document.getElementById("viewDescription").textContent = description;


	let imageSrc = image && image.trim() !== "" 
	    ? (image.startsWith("http") ? image : context + "/images/" + image)
	    : context + "/images/noimage.jpg";

	document.getElementById("viewImageContainer").innerHTML = `<img src="${imageSrc}" alt="Ảnh sản phẩm" onerror="this.src='https://via.placeholder.com/250?text=No+Image'">`;
}

// ✅ Modal sửa
function openEditModal(id, name, desc, price, stock, imageUrl, categoryId) {
	$("#editId").val(id);
	$("#editName").val(name);
	$("#editDescription").val(desc);
	$("#editPrice").val(price);
	$("#editStock").val(stock);
	$("#editCategory").val(categoryId);
	// Since it's file input, we can't prefill the current image, but user can upload new one if needed
}

// ✅ Xóa sản phẩm
function deleteProduct(id) {
	if (confirm('Xóa sản phẩm này?')) {
		fetch("${pageContext.request.contextPath}/vendor/products/delete/" + id, {
			method: "POST"
		}).then(res => res.ok ? location.reload() : alert("Xóa thất bại!"));
	}
}

// ✅ Gửi form thêm
$("#addProductForm").on("submit", function (e) {
	e.preventDefault();
	let formData = new FormData(this);
	fetch("${pageContext.request.contextPath}/vendor/products/add", {
		method: "POST",
		body: formData
	}).then(res => res.ok ? location.reload() : alert("Lỗi khi thêm sản phẩm!"));
});

// ✅ Gửi form sửa
$("#editProductForm").on("submit", function (e) {
	e.preventDefault();
	let id = $("#editId").val();
	let formData = new FormData(this);
	fetch("${pageContext.request.contextPath}/vendor/products/edit/" + id, {
		method: "POST",
		body: formData
	}).then(res => res.ok ? location.reload() : alert("Cập nhật thất bại!"));
});
</script>