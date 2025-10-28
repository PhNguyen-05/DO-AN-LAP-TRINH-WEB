<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

/* Giảm khoảng trống tổng thể */
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

/* Thanh tìm kiếm hiện đại hơn */
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

.low-stock {
	color: #dc3545;
	font-weight: bold;
}

tr:hover {
	background-color: #fff0f5;
}

.no-results {
	font-style: italic;
	color: #6c757d;
}
<<<<<<< HEAD
=======
td.low-stock {
    color: #dc3545 !important;
    font-weight: bold;
}

>>>>>>> origin/PhuongNguyen
</style>

<div class="container py-3">
	<!-- Tiêu đề + nút thêm -->
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="page-title">🌸 Quản Lý Sản Phẩm 🌸</h2>
		<button class="btn btn-pink btn-sm" data-bs-toggle="modal"
			data-bs-target="#productModal" onclick="resetForm()">
			<i class="bi bi-plus-lg me-1"></i> Thêm Sản Phẩm
		</button>
	</div>

	<!-- Thanh tìm kiếm -->
	<form action="${pageContext.request.contextPath}/admin/products"
		method="get" class="search-bar mb-3">
		<div class="input-group" style="max-width: 400px;">
			<span class="input-group-text"><i class="bi bi-search"></i></span> <input
				type="text" name="name" class="form-control"
				placeholder="Tìm theo tên sản phẩm..." value="${param.name}">
		</div>

		<select name="categoryId" class="form-select"
			style="max-width: 220px;">
			<option value="">Tất cả danh mục</option>
			<c:forEach var="category" items="${categories}">
				<option value="${category.id}"
					${param.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
			</c:forEach>
		</select>

		<button type="submit" class="btn btn-pink px-3">
			<i class="bi bi-funnel me-1"></i> Tìm
		</button>
	</form>

	<!-- Bảng sản phẩm -->
	<div class="card">
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover mb-0">
					<thead>
						<tr>
							<th class="text-center">ID</th>
							<th class="text-center">Ảnh</th>
<<<<<<< HEAD
							<th>Tên Sản Phẩm</th>
							<th>Mô Tả</th>
							<th>Danh Mục</th>
=======
							<th class="text-center">Tên Sản Phẩm</th>
							<th>Mô Tả</th>
							<th class="text-center">Giá Bán</th>
							<th class="text-center">Shop</th>
>>>>>>> origin/PhuongNguyen
							<th class="text-center">Tồn Kho</th>
							<th class="text-center">Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="product" items="${products}">
							<tr>
								<td class="text-center">${product.id}</td>
								<td class="text-center"><c:choose>
										<c:when test="${not empty product.imageUrl}">
											<img
												src="${pageContext.request.contextPath}/images/${product.imageUrl}"
												alt="Ảnh sản phẩm" class="rounded"
												style="width: 50px; height: 50px; object-fit: cover;"
												onerror="this.src='https://via.placeholder.com/50?text=No+Image';">
										</c:when>
										<c:otherwise>
											<img src="https://via.placeholder.com/50?text=No+Image"
												class="rounded" alt="No Image">
										</c:otherwise>
									</c:choose></td>
								<td>${product.name}</td>
								<td class="text-muted"
									style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${product.description}</td>
<<<<<<< HEAD
								<td>${product.category.name}</td>
								<td class="text-center ${product.stock < 10 ? 'low-stock' : ''}">${product.stock}</td>
=======
								<td class="text-center"><fmt:formatNumber
										value="${product.price}" type="currency" currencySymbol="₫" />
								</td>

								<td class="text-center">${product.vendor.shopName}</td>
								<c:choose>
									<c:when test="${product.stock <= 5}">
										<td class="text-center low-stock">${product.stock}</td>
									</c:when>
									<c:otherwise>
										<td class="text-center">${product.stock}</td>
									</c:otherwise>
								</c:choose>


>>>>>>> origin/PhuongNguyen
								<td class="text-center"><a
									href="${pageContext.request.contextPath}/admin/products/detail/${product.id}"
									class="btn btn-outline-secondary btn-sm me-1"
									title="Xem chi tiết"> <i class="bi bi-eye"></i>
								</a>
									<button class="btn btn-outline-primary btn-sm me-1"
										data-bs-toggle="modal" data-bs-target="#productModal"
										onclick="editProduct(${product.id}, '${product.name}', '${product.description}', ${product.price}, ${product.stock}, ${product.category.id})"
										title="Sửa">
										<i class="bi bi-pencil"></i>
									</button> <a
									href="${pageContext.request.contextPath}/admin/products/delete/${product.id}"
									class="btn btn-outline-danger btn-sm"
									onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')"
									title="Xóa"> <i class="bi bi-trash"></i>
								</a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty products}">
							<tr>
								<td colspan="7" class="text-center py-4 no-results"><i
									class="bi bi-search fs-4 d-block mb-2"></i> <c:choose>
										<c:when
											test="${not empty param.name or not empty param.categoryId}">
                                            Không tìm thấy sản phẩm phù hợp với tiêu chí tìm kiếm.
                                        </c:when>
										<c:otherwise>
                                            Chưa có sản phẩm nào trong hệ thống.
                                        </c:otherwise>
									</c:choose></td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Phân trang -->
	<c:if test="${totalPages > 0}">
		<nav aria-label="Page navigation" class="mt-4">
			<ul class="pagination justify-content-center">
				<li class="page-item ${currentPage == 0 ? 'disabled' : ''}"><a
					class="page-link"
					href="?name=${param.name}&categoryId=${param.categoryId}&page=${currentPage - 1}&size=10"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
				<c:forEach begin="0" end="${totalPages - 1}" var="i">
					<li class="page-item ${currentPage == i ? 'active' : ''}"><a
						class="page-link"
						href="?name=${param.name}&categoryId=${param.categoryId}&page=${i}&size=10">${i + 1}</a>
					</li>
				</c:forEach>
				<li
					class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
					<a class="page-link"
					href="?name=${param.name}&categoryId=${param.categoryId}&page=${currentPage + 1}&size=10"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>
				</li>
			</ul>
		</nav>
	</c:if>
</div>

<!-- Modal thêm/sửa sản phẩm -->
<div class="modal fade" id="productModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content shadow-lg border-0 rounded-3">
			<div class="modal-header bg-light border-bottom">
				<h5 class="modal-title fw-bold">Thông Tin Sản Phẩm</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<%@ include file="product-form.jsp"%>
			</div>
		</div>
	</div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetForm() {
        document.getElementById('productForm').action = '${pageContext.request.contextPath}/admin/products/add';
        document.getElementById('id').value = '';
        document.getElementById('name').value = '';
        document.getElementById('description').value = '';
        document.getElementById('price').value = '';
        document.getElementById('stock').value = '';
        document.getElementById('categoryId').value = '';
        document.getElementById('imageFile').value = '';
    }

    function editProduct(id, name, description, price, stock, categoryId) {
        document.getElementById('productForm').action = '${pageContext.request.contextPath}/admin/products/edit/' + id;
        document.getElementById('id').value = id;
        document.getElementById('name').value = name;
        document.getElementById('description').value = description;
        document.getElementById('price').value = price;
        document.getElementById('stock').value = stock;
        document.getElementById('categoryId').value = categoryId;
        document.getElementById('imageFile').value = '';
    }
</script>