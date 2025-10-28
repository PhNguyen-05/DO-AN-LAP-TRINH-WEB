<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
java.util.Date now = new java.util.Date();
%>

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

.status-upcoming {
	color: #6c757d;
	font-weight: 500;
}

.status-active {
	color: #28a745;
	font-weight: 500;
}

.status-ended {
	color: #dc3545;
	font-weight: 500;
}

.promotion-name-highlight {
	font-weight: 600;
	color: #c71585; /* Màu hồng đậm/tím để nổi bật */
}
</style>

<div class="container py-3">
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="page-title">🌸 Quản Lý Khuyến Mãi 🌸</h2>
		<button class="btn btn-pink btn-sm" onclick="openAddPromotion()">
			<i class="bi bi-plus-lg me-1"></i> Thêm Khuyến Mãi
		</button>
	</div>

	<form action="${pageContext.request.contextPath}/admin/promotions"
		method="get" class="search-bar mb-3">
		<div class="input-group" style="max-width: 400px;">
			<span class="input-group-text"><i class="bi bi-search"></i></span> <input
				type="text" name="promotionName" class="form-control"
				placeholder="Tìm theo tên khuyến mãi..."
				value="${param.promotionName}">
		</div>
		<select name="vendorId" class="form-select" style="max-width: 220px;">
			<option value="">Tất cả nhà cung cấp</option>
			<c:forEach var="vendor" items="${vendors}">
				<option value="${vendor.id}"
					${param.vendorId == vendor.id ? 'selected' : ''}>${vendor.shopName}</option>
			</c:forEach>
		</select>
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

							<th class="text-center">Tên Khuyến Mãi</th>
							<th class="text-center">Giá Trị Giảm</th>
							<th class="text-center">Ngày Bắt Đầu</th>
							<th class="text-center">Ngày Kết Thúc</th>
							<th class="text-center">Trạng Thái</th>
							<th class="text-center">Shop</th>
							<th class="text-center">Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="promotion" items="${promotions}">
							<tr>

								<td class=" promotion-name-highlight">${promotion.promotionName}</td>
								<td class="text-center"><c:choose>
										<c:when test="${promotion.discountType == 'PERCENTAGE'}">
											<fmt:formatNumber value="${promotion.discountValue}"
												type="number" maxFractionDigits="0" />%</c:when>
										<c:otherwise>
											<fmt:formatNumber value="${promotion.discountValue}"
												type="currency" currencySymbol="₫" />
										</c:otherwise>
									</c:choose></td>

								<!-- Sửa: Wrap vào <td>, thay pattern thành dd/MM/yyyy cho đồng bộ, fallback nếu null -->
								<td class="text-center"><c:choose>
										<c:when test="${promotion.startDateAsDate != null}">
											<fmt:formatDate value="${promotion.startDateAsDate}"
												pattern="dd/MM/yyyy" />
										</c:when>
										<c:otherwise>
                                            Không xác định
                                        </c:otherwise>
									</c:choose></td>
								<td class="text-center"><c:choose>
										<c:when test="${promotion.endDateAsDate != null}">
											<fmt:formatDate value="${promotion.endDateAsDate}"
												pattern="dd/MM/yyyy" />
										</c:when>
										<c:otherwise>
                                            Không xác định
                                        </c:otherwise>
									</c:choose></td>
								<td class="text-center"><c:choose>
										<c:when test="${promotion.statusCode == 2}">
											<span class="status-upcoming">${promotion.statusLabel}</span>
										</c:when>
										<c:when test="${promotion.statusCode == 0}">
											<span class="status-ended">${promotion.statusLabel}</span>
										</c:when>
										<c:otherwise>
											<span class="status-active">${promotion.statusLabel}</span>
										</c:otherwise>
									</c:choose></td>
								<td class="text-center">${promotion.vendor.shopName}</td>
								<td class="text-center"><a
									href="${pageContext.request.contextPath}/admin/promotions/detail/${promotion.id}"
									class="btn btn-outline-secondary btn-sm me-1"
									title="Xem chi tiết"> <i class="bi bi-eye"></i>
								</a>
									<button class="btn btn-outline-primary btn-sm me-1"
										onclick="openEditPromotion(${promotion.id})">
										<i class="bi bi-pencil"></i>
									</button> <a
									href="${pageContext.request.contextPath}/admin/promotions/delete/${promotion.id}"
									class="btn btn-outline-danger btn-sm"
									onclick="return confirm('Bạn có chắc muốn xóa khuyến mãi này?')"
									title="Xóa"> <i class="bi bi-trash"></i>
								</a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty promotions}">
							<tr>
								<td colspan="8" class="text-center py-4 no-results"><i
									class="bi bi-search fs-4 d-block mb-2"></i> <c:choose>
										<c:when
											test="${not empty param.promotionName or not empty param.vendorId}">
                                            Không tìm thấy khuyến mãi phù hợp với tiêu chí tìm kiếm.
                                        </c:when>
										<c:otherwise>
                                            Chưa có khuyến mãi nào trong hệ thống.
                                        </c:otherwise>
									</c:choose></td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<c:if test="${totalPages > 0}">
		<nav aria-label="Page navigation" class="mt-4">
			<ul class="pagination justify-content-center">

				<li class="page-item ${currentPage == 0 ? 'disabled' : ''}"><a
					class="page-link"
					href="?promotionName=${param.promotionName}&vendorId=${param.vendorId}&page=${currentPage - 1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>

				<c:set var="maxPagesToShow" value="5" />
				<c:set var="halfWindow" value="2" />
				<%-- (maxPagesToShow - 1) / 2 --%>

				<c:set var="startPage" value="${currentPage - halfWindow}" />
				<c:set var="endPage" value="${currentPage + halfWindow}" />

				<%-- Điều chỉnh khi ở gần đầu --%>
				<c:if test="${startPage < 0}">
					<c:set var="endPage" value="${endPage - startPage}" />
					<c:set var="startPage" value="0" />
				</c:if>

				<%-- Điều chỉnh khi ở gần cuối --%>
				<c:if test="${endPage >= totalPages}">
					<c:set var="startPage"
						value="${startPage - (endPage - (totalPages - 1))}" />
					<c:set var="endPage" value="${totalPages - 1}" />
				</c:if>

				<%-- Điều chỉnh cuối cùng nếu tổng số trang < maxPagesToShow --%>
				<c:if test="${startPage < 0}">
					<c:set var="startPage" value="0" />
				</c:if>
				<c:if test="${endPage >= totalPages}">
					<c:set var="endPage" value="${totalPages - 1}" />
				</c:if>

				<c:forEach begin="${startPage}" end="${endPage}" var="i">
					<li class="page-item ${currentPage == i ? 'active' : ''}"><a
						class="page-link"
						href="?promotionName=${param.promotionName}&vendorId=${param.vendorId}&page=${i}">${i + 1}</a>
					</li>
				</c:forEach>

				<li
					class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
					<a class="page-link"
					href="?promotionName=${param.promotionName}&vendorId=${param.vendorId}&page=${currentPage + 1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>
				</li>

			</ul>
		</nav>
	</c:if>

	<div class="modal fade" id="addPromotionModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content shadow-lg border-0 rounded-3">
				<div class="modal-header bg-light border-bottom">
					<h5 class="modal-title fw-bold">Thêm Khuyến Mãi Mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<jsp:include page="promotion-form.jsp">
						<jsp:param name="formId" value="promotionFormAdd" />
					</jsp:include>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editPromotionModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content shadow-lg border-0 rounded-3">
				<div class="modal-header bg-light border-bottom">
					<h5 class="modal-title fw-bold">Chỉnh Sửa Khuyến Mãi</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<jsp:include page="promotion-form.jsp">
						<jsp:param name="formId" value="promotionFormEdit" />
					</jsp:include>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
function formatDateForInput(dateStr) {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    if (isNaN(date.getTime())) return '';
    return date.toISOString().slice(0, 10);
}

function attachCheckboxListeners(modalSelector) {
    const modal = document.querySelector(modalSelector);
    if (!modal) return;

    modal.querySelectorAll('.category-checkbox').forEach(categoryCheckbox => {
        categoryCheckbox.removeEventListener('change', categoryCheckbox._listener);
        categoryCheckbox._listener = function() {
            const categoryId = this.dataset.categoryId;
            const isChecked = this.checked;
            modal.querySelectorAll('.product-checkbox[data-category-id="' + categoryId + '"]').forEach(p => p.checked = isChecked);
        };
        categoryCheckbox.addEventListener('change', categoryCheckbox._listener);
    });

    modal.querySelectorAll('.product-checkbox').forEach(productCheckbox => {
        productCheckbox.removeEventListener('change', productCheckbox._listener);
        productCheckbox._listener = function() {
            const categoryId = this.dataset.categoryId;
            const allProducts = modal.querySelectorAll('.product-checkbox[data-category-id="' + categoryId + '"]');
            const allChecked = Array.from(allProducts).every(cb => cb.checked);
            const categoryCheckbox = modal.querySelector('.category-checkbox[data-category-id="' + categoryId + '"]');
            if (categoryCheckbox) categoryCheckbox.checked = allChecked;
        };
        productCheckbox.addEventListener('change', productCheckbox._listener);
    });
}

function openAddPromotion() {
    const form = document.getElementById('promotionFormAdd');
    if (!form) return;

    form.reset();
    form.action = '${pageContext.request.contextPath}/admin/promotions/add';
    console.log('Add form action set to:', form.action);

    form.querySelectorAll('input[type=checkbox]').forEach(cb => cb.checked = false);
    const vendorSelect = form.querySelector('#vendorId');
    if (vendorSelect) vendorSelect.selectedIndex = 0;

    attachCheckboxListeners('#addPromotionModal');

    const modal = new bootstrap.Modal(document.getElementById('addPromotionModal'));
    modal.show();
}

function openEditPromotion(id) {
    if (!id) return;

    fetch('${pageContext.request.contextPath}/admin/promotions/' + id)
        .then(response => {
            if (!response.ok) throw new Error('Fetch failed: ' + response.status);
            return response.json();
        })
        .then(data => {
            const form = document.getElementById('promotionFormEdit');
            if (!form) throw new Error('Form not found');

            form.action = '${pageContext.request.contextPath}/admin/promotions/edit/' + id;
            console.log('Edit form action set to:', form.action);

            form.querySelector('#id').value = data.id || '';
            form.querySelector('#promotionName').value = data.promotionName || '';
            form.querySelector('#description').value = data.description || '';
            form.querySelector('#discountValue').value = data.discountValue || '';
            form.querySelector('#discountType').value = data.discountType || 'PERCENTAGE';
            form.querySelector('#startDate').value = formatDateForInput(data.startDate);
            form.querySelector('#endDate').value = formatDateForInput(data.endDate);
            form.querySelector('#vendorId').value = data.vendor?.id || '';

            form.querySelectorAll('.category-checkbox').forEach(cb => {
                cb.checked = data.categories ? data.categories.some(c => c.id == cb.value) : false;
            });

            form.querySelectorAll('.product-checkbox').forEach(cb => {
                cb.checked = data.products ? data.products.some(p => p.id == cb.value) : false;
            });

            attachCheckboxListeners('#editPromotionModal');

            const modal = new bootstrap.Modal(document.getElementById('editPromotionModal'));
            modal.show();
        })
        .catch(error => {
            console.error('Error fetching promotion:', error);
            alert('Lỗi tải dữ liệu: ' + error.message);
        });
}

document.addEventListener('DOMContentLoaded', function() {
    attachCheckboxListeners('#addPromotionModal');
    attachCheckboxListeners('#editPromotionModal');
});
</script>