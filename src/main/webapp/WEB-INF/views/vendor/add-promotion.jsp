<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="border-top: 4px solid #ff69b4;">
                <h2 class="fw-bold text-center mb-4" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌸 Thêm Khuyến Mãi Mới</h2>

                <form id="addPromotionForm" action="${pageContext.request.contextPath}/vendor/promotions/add" method="post">
                    <!-- Tên khuyến mãi -->
                    <div class="mb-3">
                        <label for="promotionName" class="form-label">Tên Khuyến Mãi <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="promotionName" name="promotionName" required>
                    </div>

                    <!-- Giá trị giảm -->
                    <div class="mb-3">
                        <label for="discountValue" class="form-label">Giá Trị Giảm <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" min="0.01" class="form-control" id="discountValue" name="discountValue" required>
                    </div>

                    <!-- Loại giảm -->
                    <div class="mb-3">
                        <label for="discountType" class="form-label">Loại Giảm <span class="text-danger">*</span></label>
                        <select class="form-select" id="discountType" name="discountType" required>
                            <option value="PERCENTAGE">Phần Trăm (%)</option>
                            <option value="FIXED">Cố Định (VND)</option>
                        </select>
                    </div>

                    <!-- Mô tả -->
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô Tả</label>
                        <textarea class="form-control" id="description" name="description"></textarea>
                    </div>

                    <!-- Ngày bắt đầu / kết thúc -->
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Ngày Bắt Đầu <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="endDate" class="form-label">Ngày Kết Thúc <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                    </div>

                    <!-- Trạng thái -->
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="active" name="active" checked>
                        <label class="form-check-label" for="active">Hoạt Động</label>
                    </div>

                    <!-- Danh mục & sản phẩm -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">🎯 Chọn Danh Mục & Sản Phẩm</label>
                        <div class="overflow-auto border rounded p-3" style="max-height: 300px;">
                            <c:forEach var="category" items="${vendorCategories}">
                                <div class="mb-2 category-group" data-category-id="${category.id}">
                                    <!-- Checkbox danh mục -->
                                    <div class="form-check">
                                        <input class="form-check-input category-checkbox"
                                               type="checkbox"
                                               id="category_${category.id}"
                                               name="categoryIds"
                                               value="${category.id}">
                                        <label class="form-check-label fw-semibold text-primary"
                                               for="category_${category.id}">
                                            📦 ${category.name}
                                        </label>
                                    </div>

                                    <!-- Danh sách sản phẩm thuộc danh mục -->
                                    <div class="ms-4 mt-1 products-list">
                                        <c:forEach var="product" items="${vendorProducts}">
                                            <c:if test="${product.category.id == category.id}">
                                                <div class="form-check">
                                                    <input class="form-check-input product-checkbox"
                                                           type="checkbox"
                                                           id="product_${product.id}"
                                                           name="productIds"
                                                           value="${product.id}"
                                                           data-category-id="${category.id}">
                                                    <label class="form-check-label" for="product_${product.id}">
                                                        ${product.name}
                                                    </label>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                                <hr class="my-2">
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Preview giảm giá -->
                    <div id="discountPreview" class="alert alert-info" style="display: none;"></div>

                    <!-- Nút hành động -->
                    <button type="submit" class="btn btn-pink w-100">Thêm Khuyến Mãi</button>
                    <a href="${pageContext.request.contextPath}/vendor/promotions" class="btn btn-secondary mt-2 w-100">Quay Lại</a>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // ===============================
    // Hiển thị preview giảm giá
    // ===============================
    function updateDiscountPreview(typeSelector, valueSelector, previewSelector) {
        let type = $(typeSelector).val();
        let value = $(valueSelector).val();
        if (value > 0) {
            let preview = (type === 'PERCENTAGE') ? `Giảm ${value}%` : `Giảm cố định ${value} VND`;
            $(previewSelector).text(preview).show();
        } else {
            $(previewSelector).hide();
        }
    }

    $('#discountType, #discountValue').change(function() {
        updateDiscountPreview('#discountType', '#discountValue', '#discountPreview');
    });

    // ===============================
    // Liên kết chọn danh mục & sản phẩm
    // ===============================
    $('.category-checkbox').on('change', function() {
        const categoryId = $(this).val();
        const isChecked = $(this).is(':checked');
        const $categoryGroup = $(`.category-group[data-category-id='${categoryId}']`);
        $categoryGroup.find('.product-checkbox').prop('checked', isChecked);
        $categoryGroup.toggleClass('selected-category', isChecked);
    });

    $('.product-checkbox').on('change', function() {
        const categoryId = $(this).data('category-id');
        const $categoryGroup = $(`.category-group[data-category-id='${categoryId}']`);
        const $products = $categoryGroup.find('.product-checkbox');
        const $checkedProducts = $products.filter(':checked');
        const $categoryCheckbox = $categoryGroup.find('.category-checkbox');

        $categoryCheckbox.prop('checked', $products.length === $checkedProducts.length);
        $categoryGroup.toggleClass('selected-category', $checkedProducts.length > 0);
    });

    // ===============================
    // Submit form AJAX
    // ===============================
    $('#addPromotionForm').submit(function(e) {
        e.preventDefault();

        if ($('#startDate').val() >= $('#endDate').val()) {
            alert('Ngày bắt đầu phải trước ngày kết thúc.');
            return;
        }

        if (parseFloat($('#discountValue').val()) <= 0) {
            alert('Giá trị giảm phải lớn hơn 0.');
            return;
        }

        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if (response === "Success") {
                    alert('🎉 Thêm khuyến mãi thành công!');
                    window.location.href = '${pageContext.request.contextPath}/vendor/promotions';
                } else {
                    alert('Lỗi: ' + response);
                }
            },
            error: function(xhr) {
                alert('❌ Lỗi thêm khuyến mãi: ' + xhr.responseText);
            }
        });
    });

    // Thêm hiệu ứng giao diện
    $('.category-group').each(function() {
        const $checkboxes = $(this).find('.product-checkbox');
        if ($checkboxes.length && $checkboxes.filter(':checked').length > 0) {
            $(this).addClass('selected-category');
        }
    });
</script>

<style>
    .selected-category {
        background-color: #fff3f6;
        border-left: 4px solid #ff69b4;
        padding-left: 8px;
        transition: all 0.3s ease;
    }
    .category-group .form-check-label {
        transition: color 0.3s ease;
    }
    .selected-category .form-check-label {
        color: #ff69b4 !important;
    }
</style>