<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%-- THÊM MỚI: Cần import để so sánh ID --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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

					<div class="mb-3">
						<label for="editPromotionName" class="form-label">Tên
							Khuyến Mãi <span class="text-danger">*</span>
						</label> <input type="text" class="form-control" id="editPromotionName"
							name="promotionName" value="${promotion.promotionName}" required>
					</div>

					<div class="mb-3">
						<label for="editDiscountValue" class="form-label">Giá Trị
							Giảm <span class="text-danger">*</span>
						</label> <input type="number" step="0.01" min="0.01" class="form-control"
							id="editDiscountValue" name="discountValue"
							value="${promotion.discountValue}" required>
					</div>

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

					<div class="mb-3">
						<label for="editDescription" class="form-label">Mô Tả</label>
						<textarea class="form-control" id="editDescription"
							name="description">${promotion.description}</textarea>
					</div>

					<div class="mb-3">
						<label for="editStartDate" class="form-label">Ngày Bắt Đầu
							<span class="text-danger">*</span>
						</label> <input type="date" class="form-control" id="editStartDate"
							name="startDate" value="${promotion.startDate}" required>
					</div>

					<div class="mb-3">
						<label for="editEndDate" class="form-label">Ngày Kết Thúc
							<span class="text-danger">*</span>
						</label> <input type="date" class="form-control" id="editEndDate"
							name="endDate" value="${promotion.endDate}" required>
					</div>



					<div class="mb-3 form-check">
						<input type="checkbox" class="form-check-input" id="editActive"
							name="active" <c:if test="${promotion.active}">checked</c:if>>
						<label class="form-check-label" for="editActive">Hoạt Động</label>
					</div>

					<div class="mb-3">
						<label class="form-label fw-bold">🎯 Chọn Danh Mục & Sản
							Phẩm</label>
						<div class="overflow-auto border rounded p-3"
							style="max-height: 300px;">
							<c:forEach var="category" items="${vendorCategories}">
								<div class="mb-2 category-group"
									data-category-id="${category.id}">

									<c:set var="categoryIsChecked" value="false" />
									<c:forEach var="promoCat" items="${promotion.categories}">
										<c:if test="${promoCat.id == category.id}">
											<c:set var="categoryIsChecked" value="true" />
										</c:if>
									</c:forEach>
									<div class="form-check">
										<input class="form-check-input category-checkbox"
											type="checkbox" id="category_${category.id}"
											name="categoryIds" value="${category.id}"${categoryIsChecked ? 'checked' : ''} <%-- Thêm logic checked --%>
											>
										<label class="form-check-label fw-semibold text-primary"
											for="category_${category.id}"> 📦 ${category.name} </label>
									</div>

									<div class="ms-4 mt-1 products-list">
										<c:forEach var="product" items="${vendorProducts}">
											<c:if test="${product.category.id == category.id}">

												<c:set var="productIsChecked" value="false" />
												<c:forEach var="promoProd" items="${promotion.products}">
													<c:if test="${promoProd.id == product.id}">
														<c:set var="productIsChecked" value="true" />
													</c:if>
												</c:forEach>
												<div class="form-check">
													<input class="form-check-input product-checkbox"
														type="checkbox" id="product_${product.id}"
														name="productIds" value="${product.id}"
														data-category-id="${category.id}"${productIsChecked ? 'checked' : ''} <%-- Thêm logic checked --%>
														>
													<label class="form-check-label" for="product_${product.id}">
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

					<div id="editDiscountPreview" class="alert alert-info"
						style="display: none;"></div>

					<button type="submit" class="btn btn-pink w-100">Lưu Thay
						Đổi</button>
					<a href="${pageContext.request.contextPath}/vendor/promotions"
						class="btn btn-secondary mt-2 w-100">Quay Lại</a>
				</form>
			</div>
		</div>
	</div>
</div>

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

    // Kích hoạt preview khi tải trang (để giữ nguyên thông tin)
    $(document).ready(function() {
        updateDiscountPreview();
    });

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

        const formData = new FormData(this);
        
        if (!formData.has('active')) {
            formData.append('active', 'false');
        } else {
        	// Đảm bảo giá trị là "true" thay vì "on" (nếu cần)
        	formData.set('active', 'true');
        }

		fetch($(this).attr('action'), {
			method: 'POST',
			body: formData,
            headers: {
                // Thêm header CSRF nếu bạn dùng Spring Security
                // '${_csrf.headerName}': '${_csrf.token}' 
            }
		})
		.then(response => {
			if (response.ok) {
 				return response.text(); 
			} else {
				return response.text().then(text => { 
                    // Nếu lỗi 400, 500, ném ra text lỗi
                    throw new Error(text || 'Lỗi không xác định từ server.');
                });
			}
		})
		.then(text => {
            // Xóa lỗi cũ (nếu có)
            $('#errorAlert').remove();
            $('#successAlert').remove();

			if (text.trim() === "Success") {
			    $('#editPromotionForm').prepend(`
			        <div id="successAlert" class="alert alert-success text-center" role="alert">
			            ✅ Cập nhật thành công! Trang sẽ tải lại...
			        </div>
			    `);
			    // Vô hiệu hóa nút sau khi thành công
			    $(this).find('button[type="submit"]').prop('disabled', true);
			    setTimeout(() => {
			    	// Tải lại trang danh sách, không phải trang sửa
			    	window.location.href = "${pageContext.request.contextPath}/vendor/promotions";
			    }, 2000);
			
		    } else {
                // Nếu server trả về text lỗi (ví dụ "Lỗi: Tên trùng")
		        $('#editPromotionForm').prepend(`
		            <div id="errorAlert" class="alert alert-warning text-center" role="alert">
		                ⚠️ Lỗi: ${text}
		            </div>
		        `);
		        setTimeout(() => $('#errorAlert').fadeOut(1000, function() { $(this).remove(); }), 4000);
		    }
		})
        .catch(error => {
            // Bắt lỗi fetch (như 403, 500)
            $('#errorAlert').remove();
            $('#successAlert').remove();
            
            $('#editPromotionForm').prepend(`
                <div id="errorAlert" class="alert alert-danger text-center" role="alert">
                    ❌ Lỗi nghiêm trọng: ${error.message}
                </div>
            `);
            setTimeout(() => $('#errorAlert').fadeOut(1000, function() { $(this).remove(); }), 4000);
        });

	});

    // Script liên kết checkbox
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