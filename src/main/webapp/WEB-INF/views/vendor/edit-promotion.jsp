<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
	<div class="row">
		<div class="col-12">
			<div class="card shadow-lg rounded-4 border-0 p-4"
				style="border-top: 4px solid #ff69b4;">
				<h2 class="fw-bold text-center mb-4"
					style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">
					🌸 Sửa Khuyến Mãi</h2>

				<form id="editPromotionForm"
					action="${pageContext.request.contextPath}/vendor/promotions/edit/${promotion.id}"
					method="post">

					<input type="hidden" name="id" value="${promotion.id}">

					<!-- Tên khuyến mãi -->
					<div class="mb-3">
						<label for="editPromotionName" class="form-label">Tên
							Khuyến Mãi <span class="text-danger">*</span>
						</label> <input type="text" class="form-control" id="editPromotionName"
							name="promotionName" value="${promotion.promotionName}" required>
					</div>

					<!-- Giá trị giảm -->
					<div class="mb-3">
						<label for="editDiscountValue" class="form-label">Giá Trị
							Giảm <span class="text-danger">*</span>
						</label> <input type="number" step="0.01" min="0.01" class="form-control"
							id="editDiscountValue" name="discountValue"
							value="${promotion.discountValue}" required>
					</div>

					<!-- Loại giảm -->
					<div class="mb-3">
						<label for="editDiscountType" class="form-label">Loại Giảm
							<span class="text-danger">*</span>
						</label> <select class="form-select" id="editDiscountType"
							name="discountType" required>
							<option value="PERCENTAGE"
								<c:if test="${promotion.discountType == 'PERCENTAGE'}">selected</c:if>>
								Phần Trăm (%)</option>
							<option value="FIXED"
								<c:if test="${promotion.discountType == 'FIXED'}">selected</c:if>>
								Cố Định (VND)</option>
						</select>
					</div>

					<!-- Mô tả -->
					<div class="mb-3">
						<label for="editDescription" class="form-label">Mô Tả</label>
						<textarea class="form-control" id="editDescription"
							name="description">${promotion.description}</textarea>
					</div>

					<!-- Ngày bắt đầu -->
					<div class="mb-3">
						<label for="editStartDate" class="form-label">Ngày Bắt Đầu
							<span class="text-danger">*</span>
						</label> <input type="date" class="form-control"
							id="editStartDate" name="startDate" value="${formattedStartDate}"
							required>
					</div>

					<!-- Ngày kết thúc -->
					<div class="mb-3">
						<label for="editEndDate" class="form-label">Ngày Kết Thúc
							<span class="text-danger">*</span>
						</label> <input type="date" class="form-control"
							id="editEndDate" name="endDate" value="${formattedEndDate}"
							required>
					</div>



					<!-- Hoạt động -->
					<div class="mb-3 form-check">
						<input type="checkbox" class="form-check-input" id="editActive"
							name="active" <c:if test="${promotion.active}">checked</c:if>>
						<label class="form-check-label" for="editActive">Hoạt Động</label>
					</div>

					<!-- Danh mục & sản phẩm -->
					<div class="mb-3">
						<label class="form-label fw-bold">🎯 Chọn Danh Mục & Sản
							Phẩm</label>
						<div class="overflow-auto border rounded p-3"
							style="max-height: 300px;">
							<c:forEach var="category" items="${vendorCategories}">
								<div class="mb-2 category-group"
									data-category-id="${category.id}">
									<!-- Checkbox danh mục -->
									<div class="form-check">
										<input class="form-check-input category-checkbox"
											type="checkbox" id="category_${category.id}"
											name="categoryIds" value="${category.id}"> <label
											class="form-check-label fw-semibold text-primary"
											for="category_${category.id}"> 📦 ${category.name} </label>
									</div>

									<!-- Danh sách sản phẩm thuộc danh mục -->
									<div class="ms-4 mt-1 products-list">
										<c:forEach var="product" items="${vendorProducts}">
											<c:if test="${product.category.id == category.id}">
												<div class="form-check">
													<input class="form-check-input product-checkbox"
														type="checkbox" id="product_${product.id}"
														name="productIds" value="${product.id}"
														data-category-id="${category.id}"> <label
														class="form-check-label" for="product_${product.id}">
														${product.name} </label>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
								<hr class="my-2">
							</c:forEach>
						</div>
					</div>

					<!-- Preview -->
					<div id="editDiscountPreview" class="alert alert-info"
						style="display: none;"></div>

					<!-- Buttons -->
					<button type="submit" class="btn btn-pink w-100">Lưu Thay
						Đổi</button>
					<a href="${pageContext.request.contextPath}/vendor/promotions"
						class="btn btn-secondary mt-2 w-100">Quay Lại</a>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function updateDiscountPreview() {
		let type = $('#editDiscountType').val();
		let value = $('#editDiscountValue').val();
		if (value > 0) {
			let preview = (type === 'PERCENTAGE') ? `Giảm ${value}%`
					: `Giảm cố định ${value} VND`;
			$('#editDiscountPreview').text(preview).show();
		} else {
			$('#editDiscountPreview').hide();
		}
	}

	$('#editDiscountType, #editDiscountValue').on('change',
			updateDiscountPreview);

    // ===============================================
	// --- BẮT ĐẦU SỬA LỖI SUBMIT ---
    // ===============================================
	$('#editPromotionForm').on('submit', function(e) {
		e.preventDefault(); // Ngăn submit form truyền thống

		// 1. Kiểm tra validation
		if ($('#editStartDate').val() >= $('#editEndDate').val()) {
			alert('❌ Ngày bắt đầu phải trước ngày kết thúc.');
			return;
		}
		if (parseFloat($('#editDiscountValue').val()) <= 0) {
			alert('❌ Giá trị giảm phải lớn hơn 0.');
			return;
		}

        // 2. Dùng FormData thay vì .serialize()
        // FormData sẽ xử lý đúng cả checkbox "active" và danh sách "productIds"
        const formData = new FormData(this);
        
        // 3. Xử lý checkbox 'active' thủ công (RẤT QUAN TRỌNG)
        // Nếu checkbox "active" không được tick, FormData sẽ không gửi gì
        // Server (Spring) sẽ nhận là NULL.
        // Chúng ta phải thêm logic để nếu nó không được tick, ta gửi "false"
        if (!formData.has('active')) {
            formData.append('active', 'false');
        }
        
        // (Trong file controller, @RequestParam Boolean active sẽ nhận 'false' là false
        // và 'on' (mặc định của form) là true, nhưng 'null' sẽ gây lỗi nếu ta
        // không xử lý 'active != null && active'.
        // Bằng cách này, ta luôn gửi 'on' hoặc 'false')

		// 4. Gửi bằng fetch (an toàn hơn $.ajax với FormData)
		fetch($(this).attr('action'), {
			method: 'POST',
			body: formData
		})
		.then(response => {
			if (response.ok) {
 				// Nếu server trả về "Success"
 				return response.text(); // Lấy text "Success"
			} else {
				// Nếu server trả về lỗi (400, 500)
				return response.text().then(text => { throw new Error(text) });
			}
		})
		.then(text => {
			if (text === "Success") {
				alert('✅ Cập nhật thành công!');
				window.location.href = '${pageContext.request.contextPath}/vendor/promotions';
			} else {
 				// Trường hợp server trả về 200 OK nhưng text không phải "Success"
				alert('⚠️ Lỗi: ' + text);
			}
		})
		.catch(error => {
			// Bắt lỗi từ throw new Error(text) hoặc lỗi mạng
			console.error('Lỗi khi submit form:', error);
			alert('⚠️ Lỗi cập nhật khuyến mãi: ' + error.message);
		});
	});
    // ===============================================
	// --- KẾT THÚC SỬA LỖI SUBMIT ---
    // ===============================================

    // Bổ sung: Script liên kết checkbox (nếu bạn chưa có)
    $(document).ready(function() {
        $('.category-checkbox').on('change', function() {
            const categoryId = $(this).val();
            const isChecked = $(this).is(':checked');
            $(`.product-checkbox[data-category-id='${categoryId}']`).prop('checked', isChecked);
        });

        $('.product-checkbox').on('change', function() {
            const categoryId = $(this).data('category-id');
            const $products = $(`.product-checkbox[data-category-id='${categoryId}']`);
            const allChecked = $products.length === $products.filter(':checked').length;
            $(`.category-checkbox[value='${categoryId}']`).prop('checked', allChecked);
        });
    });
</script>