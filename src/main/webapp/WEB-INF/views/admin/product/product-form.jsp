<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<form id="productForm" method="post" enctype="multipart/form-data"
	action="${pageContext.request.contextPath}/admin/products/add">
	<input type="hidden" id="id" name="id" />

	<div class="mb-3">
		<label for="name" class="form-label fw-bold">Tên Sản Phẩm <span
			class="text-danger">*</span></label> <input type="text" id="name" name="name"
			class="form-control" placeholder="Nhập tên sản phẩm" required>
	</div>

	<div class="mb-3">
		<label for="description" class="form-label fw-bold">Mô Tả</label>
		<textarea id="description" name="description" class="form-control"
			rows="3" placeholder="Nhập mô tả sản phẩm"></textarea>
	</div>

	<div class="mb-3">
		<label for="imageFile" class="form-label fw-bold">Ảnh Sản Phẩm</label>
		<input type="file" id="imageFile" name="imageFile"
			class="form-control" accept="image/*" onchange="previewImage(event)">
		<small class="form-text text-muted"> Chọn ảnh mới nếu muốn
			thay. Nếu không chọn, giữ ảnh cũ. </small>

		<div class="mt-2 text-center">
			<!-- Hiển thị ảnh hiện tại (nếu có) -->
			<img id="preview"
				src="<c:out value='${not empty product.imageUrl ? pageContext.request.contextPath + "/images/" + product.imageUrl : ""}'/>"
				data-old-src="<c:out value='${not empty product.imageUrl ? pageContext.request.contextPath + "/images/" + product.imageUrl : ""}'/>"
				alt="Ảnh sản phẩm"
				style="width:100px; height:100px; object-fit:cover;
                    display:${not empty product.imageUrl ? "
				inline" : "none"};"
             class="rounded shadow-sm border">
		</div>
	</div>


	<div class="mb-3">
		<label for="price" class="form-label fw-bold">Giá <span
			class="text-danger">*</span></label> <input type="number" id="price"
			name="price" class="form-control" placeholder="Nhập giá sản phẩm"
			min="0" step="0.01" required>
	</div>

	<div class="mb-3">
		<label for="stock" class="form-label fw-bold">Tồn Kho <span
			class="text-danger">*</span></label> <input type="number" id="stock"
			name="stock" class="form-control" placeholder="Nhập số lượng tồn kho"
			min="0" required>
	</div>
	<div class="mb-3">
		<label for="sku" class="form-label fw-bold">Mã SKU <span
			class="text-danger">*</span></label> <input type="text" id="sku" name="sku"
			class="form-control" placeholder="Nhập mã SKU" required>
	</div>
	<div class="mb-3">
		<label for="categoryId" class="form-label fw-bold">Danh Mục <span
			class="text-danger">*</span></label> <select id="categoryId"
			name="category.id" class="form-select" required>
			<option value="">Chọn danh mục</option>
			<c:forEach var="category" items="${categories}">
				<option value="${category.id}">${category.name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="mb-3">
		<label for="vendorId" class="form-label fw-bold">Shop Bán <span
			class="text-danger">*</span></label> <select id="vendorId" name="vendor.id"
			class="form-select" required>
			<option value="">Chọn Shop</option>
			<%-- Vòng lặp này yêu cầu Controller phải gửi 'vendors' --%>
			<c:forEach var="vendor" items="${vendors}">
				<option value="${vendor.id}">${vendor.shopName}</option>
			</c:forEach>
		</select>
	</div>
	<div class="text-end">
		<button type="submit" class="btn btn-success px-4">Lưu</button>
		<button type="button" class="btn btn-secondary"
			data-bs-dismiss="modal">Hủy</button>
	</div>


	<script>
		function previewImage(event) {
			const file = event.target.files[0];
			const preview = document.getElementById('preview');

			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					preview.src = e.target.result;
					preview.style.display = 'inline';
				}
				reader.readAsDataURL(file);
			} else {
				// Nếu bỏ chọn ảnh mới, quay về ảnh cũ
				preview.src = preview.dataset.oldSrc || '';
			}
		}
	</script>