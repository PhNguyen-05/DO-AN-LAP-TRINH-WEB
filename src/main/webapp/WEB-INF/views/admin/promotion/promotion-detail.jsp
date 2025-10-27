<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- CSS tùy chỉnh cho trang chi tiết -->
<style>
body {
	background: linear-gradient(to bottom, #fff0f5, #ffffff);
	/* Gradient pastel pink */
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.page-title {
	color: #ff69b4; /* Pink theme */
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
	animation: fadeIn 1s ease-in-out;
}

.card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 10px 20px rgba(255, 105, 180, 0.2); /* Pink shadow */
	overflow: hidden;
	animation: fadeIn 1.5s ease-in-out;
}

.promotion-name {
	color: #ff1493; /* Deep pink */
	font-weight: bold;
	font-size: 1.8rem;
}

.promotion-desc {
	font-style: italic;
	color: #555;
}

.badge-status {
	background-color: #ffb6c1; /* Light pink */
	color: #fff;
	font-size: 1rem;
	padding: 0.5em 1em;
	border-radius: 20px;
}

.btn-back {
	background-color: #ff69b4;
	border: none;
	border-radius: 25px;
	color: white;
	transition: background-color 0.3s;
}

.btn-back:hover {
	background-color: #ff1493;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.info-item {
	margin-bottom: 1rem;
	animation: fadeIn 2s ease-in-out;
}
</style>

<div class="container py-5">
	<h2 class="page-title text-center mb-4">🌸 Chi Tiết Khuyến Mãi 🌸</h2>
	<div class="card">
		<div class="card-body p-4">
			<div class="row">
				<div class="col-md-12">
					<h4 class="promotion-name">${promotion.promotionName}</h4>
					<p class="promotion-desc info-item">
						<i class="bi bi-chat-dots-fill me-2 text-pink"></i><strong>Mô
							tả:</strong> ${promotion.description}
					</p>
					<p class="info-item">
						<i class="bi bi-currency-exchange me-2 text-pink"></i><strong>Giá
							trị giảm:</strong>
						<c:choose>
							<c:when test="${promotion.discountType == 'PERCENTAGE'}">
                                ${promotion.discountValue}%
                            </c:when>
							<c:otherwise>
								<fmt:formatNumber value="${promotion.discountValue}"
									type="currency" currencySymbol="₫" />
							</c:otherwise>
						</c:choose>
					</p>
					<p class="info-item">
						<i class="bi bi-tags-fill me-2 text-pink"></i><strong>Loại
							giảm:</strong> <span class="badge badge-status">${promotion.discountType == 'PERCENTAGE' ? 'Phần Trăm' : 'Cố Định'}</span>
					</p>
					<p class="info-item">
						<i class="bi bi-calendar-event me-2 text-pink"></i> <strong>Ngày
							bắt đầu:</strong>
						<fmt:formatDate value="${promotion.startDateAsDate}"
							pattern="dd/MM/yyyy" />
					</p>
					<p class="info-item">
						<i class="bi bi-calendar-event me-2 text-pink"></i> <strong>Ngày
							kết thúc:</strong>
						<fmt:formatDate value="${promotion.endDateAsDate}"
							pattern="dd/MM/yyyy" />
					</p>


					<p class="info-item">
						<i class="bi bi-check-circle me-2 text-pink"></i><strong>Active:</strong>
						${promotion.active ? 'Có' : 'Không'}
					</p>
					<p class="info-item">
						<i class="bi bi-shop me-2 text-pink"></i><strong>Nhà cung
							cấp:</strong> ${promotion.vendor.shopName}
					</p>
					<p class="info-item">
						<i class="bi bi-box-seam me-2 text-pink"></i><strong>Sản
							phẩm áp dụng:</strong>
					<ul>
						<c:forEach var="product" items="${promotion.products}">
							<li>${product.name}</li>
						</c:forEach>
					</ul>
					</p>
					<p class="info-item">
						<i class="bi bi-tags me-2 text-pink"></i><strong>Danh mục
							áp dụng:</strong>
					<ul>
						<c:forEach var="category" items="${promotion.categories}">
							<li>${category.name}</li>
						</c:forEach>
					</ul>
					</p>
					<p class="info-item">
						<i class="bi bi-calendar-event me-2 text-pink"></i><strong>Ngày
							tạo:</strong> ${promotion.createdAtFormatted}
					</p>

				</div>
			</div>
			<div class="mt-4 text-end">
				<a href="${pageContext.request.contextPath}/admin/promotions"
					class="btn btn-back"> <i class="bi bi-arrow-left me-2"></i>
					Quay lại danh sách
				</a>
			</div>
		</div>
	</div>
</div>