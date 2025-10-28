<%-- /vendor/products.jsp (PHIÊN BẢN ĐÃ SỬA LỖI VÀ TÁI CẤU TRÚC) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
/* (Toàn bộ style của bạn... không thay đổi) */
body {
	background: linear-gradient(to bottom, #fff0f5, #ffffff);
	font-family: 'Segoe UI', sans-serif;
	color: #333;
}
.page-title {
	color: #ff69b4;
	font-weight: 600;
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
.low-stock {
	color: #dc3545;
	font-weight: bold;
}
tr:hover {
	background-color: #fff0f5;
}
td.low-stock {
	color: #dc3545 !important;
	font-weight: bold;
}
</style>

<div class="container py-3">
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="page-title">🌸 Quản Lý Sản Phẩm 🌸</h2>
		<button class="btn btn-pink btn-sm" data-bs-toggle="modal"
			data-bs-target="#productModal" onclick="resetForm()">
			<i class="bi bi-plus-lg me-1"></i> Thêm Sản Phẩm
		</button>
	</div>

	<form action="${pageContext.request.contextPath}/vendor/products"
		method="get" class="search-bar mb-3 d-flex gap-2">
		<input type="text" name="name" class="form-control"
			placeholder="Tìm theo tên sản phẩm..." value="${paramName}">
		<select name="categoryId" class="form-select"
			style="max-width: 220px;">
			<option value="">Tất cả danh mục</option>
			<c:forEach var="category" items="${categories}">
				<option value="${category.id}"
					${paramCategoryId == category.id ? 'selected' : ''}>${category.name}</option>
			</c:forEach>
		</select> 
		<select name="stockStatus" class="form-select"
			style="max-width: 200px;">
			<option value="">Tất cả tồn kho</option>
			<option value="low" ${paramStockStatus == 'low' ? 'selected' : ''}>Sắp
				hết hàng</option>
			<option value="out" ${paramStockStatus == 'out' ? 'selected' : ''}>Hết
				hàng</option>
		</select>
		<button type="submit" class="btn btn-pink">
			<i class="bi bi-search me-1"></i>
		</button>
	</form>

	<div class="card">
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead>
						<tr class="text-center">
							<th>ID</th>
							<th>Ảnh</th>
							<th>Tên</th>
							<th>Giá</th>
							<th>Tồn kho</th>
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
												<img src="${product.imageUrl}" class="rounded"
													style="width: 50px; height: 50px; object-fit: cover;"
													onerror="this.src='https://via.placeholder.com/50?text=No+Image'">
											</c:if>
											<c:if test="${not fn:startsWith(product.imageUrl, 'http')}">
												<img
													src="${pageContext.request.contextPath}/images/${product.imageUrl}"
													class="rounded"
													style="width: 50px; height: 50px; object-fit: cover;"
													onerror="this.src='https://via.placeholder.com/50?text=No+Image'">
											</c:if>
										</c:when>
										<c:otherwise>
											<img src="https://via.placeholder.com/50?text=No+Image"
												class="rounded">
										</c:otherwise>
									</c:choose>
								</td>
								<td class="text-center">${product.name}</td>
								<td class="text-center"><fmt:formatNumber
										value="${product.price}" type="currency" currencySymbol="₫" /></td>
								<td class="text-center ${product.stock <=5 ? 'low-stock' : ''}">${product.stock}</td>
								
								<td class="text-center">
									<a href="${pageContext.request.contextPath}/vendor/products/detail/${product.id}" 
									   class="btn btn-outline-primary btn-sm me-1" title="Xem chi tiết">
										<i class="bi bi-eye"></i>
									</a>
									
									<button class="btn btn-outline-warning btn-sm me-1"
										data-bs-toggle="modal" data-bs-target="#productModal"
										onclick="openEditModal(
											${product.id}, 
											'${fn:escapeXml(product.name)}', 
											'${fn:escapeXml(product.sku)}', <%-- Thêm SKU --%>
											'${fn:escapeXml(product.description)}', 
											${product.price}, 
											${product.stock}, 
											${product.category != null ? product.category.id : 0}
										)">
										<i class="bi bi-pencil"></i>
									</button>
									
									<button class="btn btn-outline-danger btn-sm"
										onclick="deleteProduct(${product.id})">
										<i class="bi bi-trash"></i>
									</button>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty products}">
							<tr>
								<td colspan="8" class="text-center py-4 text-muted">Không
									có sản phẩm nào.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>


<c:if test="${totalPages > 0}">
	<nav aria-label="Page navigation" class="mt-4">
		<ul class="pagination justify-content-center">
			<li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
				<a class="page-link"
				   href="?name=${paramName}&categoryId=${paramCategoryId}&stockStatus=${paramStockStatus}&page=${currentPage - 1}"
				   aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
			<%-- (Logic tính toán trang) --%>
			<c:set var="maxPagesToShow" value="5" />
			<c:set var="halfWindow" value="2" />
			<c:set var="startPage" value="${currentPage - halfWindow}" />
			<c:set var="endPage" value="${currentPage + halfWindow}" />
			<c:if test="${startPage < 0}">
				<c:set var="endPage" value="${endPage - startPage}" />
				<c:set var="startPage" value="0" />
			</c:if>
			<c:if test="${endPage >= totalPages}">
				<c:set var="startPage" value="${startPage - (endPage - (totalPages - 1))}" />
				<c:set var="endPage" value="${totalPages - 1}" />
			</c:if>
			<c:if test="${startPage < 0}">
				<c:set var="startPage" value="0" />
			</c:if>
			<c:if test="${endPage >= totalPages}">
				<c:set var="endPage" value="${totalPages - 1}" />
			</c:if>
			<c:forEach begin="${startPage}" end="${endPage}" var="i">
				<li class="page-item ${currentPage == i ? 'active' : ''}">
					<a class="page-link"
					   href="?name=${paramName}&categoryId=${paramCategoryId}&stockStatus=${paramStockStatus}&page=${i}">
						${i + 1}
					</a>
				</li>
			</c:forEach>
			<li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
				<a class="page-link"
				   href="?name=${paramName}&categoryId=${paramCategoryId}&stockStatus=${paramStockStatus}&page=${currentPage + 1}"
				   aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</ul>
	</nav>
</c:if>
</div>

<div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="productModalTitle"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body">
				<%-- 
				     LƯU Ý: Bạn phải tạo file "product-form.jsp" 
				     và file đó PHẢI CÓ trường <input name="sku">
				--%>
				<%@ include file="product-form.jsp" %>
			</div>
			<div class="modal-footer">
				<button type="submit" form="productForm" class="btn" id="productSubmitButton">Lưu</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Hàm reset form (cho THÊM MỚI)
    function resetForm() {
        // 1. Đặt tiêu đề và action cho form
        $('#productModalTitle').text('Thêm Sản Phẩm');
        $('#productSubmitButton').text('Lưu').removeClass('btn-warning').addClass('btn-success');
        // Đảm bảo action trỏ về /add
        $('#productForm').attr('action', '${pageContext.request.contextPath}/vendor/products/add');

        // 2. Reset các trường
        $("#editId").val(''); // Input ẩn id
        $("#name").val('');
        $("#sku").val(''); // Input SKU
        $("#description").val('');
        $("#price").val('');
        $("#stock").val('');
        $("#category").val(''); // Reset dropdown
        $("#imageFile").val(''); // Xóa file đã chọn
    }

    // Hàm điền form (cho SỬA)
    // Cập nhật: Thêm 'sku'
    function openEditModal(id, name, sku, desc, price, stock, categoryId) {
        // 1. Đặt tiêu đề và action cho form
        $('#productModalTitle').text('Sửa Sản Phẩm');
        $('#productSubmitButton').text('Cập nhật').removeClass('btn-success').addClass('btn-warning');
        // Đảm bảo action trỏ về /edit/id
        $('#productForm').attr('action', '${pageContext.request.contextPath}/vendor/products/edit/' + id);

        // 2. Điền thông tin
        $("#editId").val(id);
        $("#name").val(name);
        $("#sku").val(sku); // Điền SKU
        $("#description").val(desc);
        $("#price").val(price);
        $("#stock").val(stock);
        $("#category").val(categoryId);
        $("#imageFile").val(''); 
    }

    // ✅ Xóa sản phẩm (Giữ nguyên logic fetch của bạn)
    function deleteProduct(id) {
        if (confirm('Xóa sản phẩm này?')) {
            fetch("${pageContext.request.contextPath}/vendor/products/delete/" + id, {
                method: "POST"
                // Thêm header CSRF nếu cần
            }).then(res => {
                 if (res.ok) {
                    location.reload();
                 } else {
                    res.text().then(text => alert("Xóa thất bại: " + text));
                 }
            });
        }
    }

    // ✅ Gửi form Thêm/Sửa (Dùng chung 1 hàm)
    $("#productForm").on("submit", function (e) {
        e.preventDefault();
        
        // Kiểm tra SKU (phía client)
        let sku = $("#sku").val();
        if (!sku || sku.trim() === '') {
            alert('Vui lòng nhập Mã SKU.');
            return;
        }
        
        let formData = new FormData(this);
        let actionUrl = $(this).attr('action');

        fetch(actionUrl, {
            method: "POST",
            body: formData
            // Thêm header CSRF nếu cần
        }).then(res => {
            if (res.ok) {
                location.reload();
            } else {
                res.text().then(text => alert("Thao tác thất bại: " + text));
            }
        }).catch(err => {
            alert("Lỗi kết nối: " + err.message);
        });
    });
</script>