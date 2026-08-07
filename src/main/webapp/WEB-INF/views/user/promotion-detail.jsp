<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="${promotion.promotionName} - StarShop">
<sitemesh:head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

	<style>
body {
	background: linear-gradient(135deg, #fffafc, #e8faff);
	font-family: 'Poppins', sans-serif;
}

/* ---------- KHUNG CHUNG ---------- */
.promo-container {
	max-width: 1200px;
	margin: 60px auto;
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
	padding: 40px;
}

/* ---------- TIÊU ĐỀ ---------- */
.section-title {
	font-family: 'Dancing Script', cursive;
	color: #ff69b4;
	font-size: 2rem;
	margin: 60px 0 25px;
	text-align: center;
}

/* ---------- HEADER ---------- */
.promo-header {
	text-align: center;
	background: linear-gradient(135deg, #ffb6c1, #ffd6e0);
	border-radius: 18px;
	padding: 50px 20px;
	color: white;
	margin-bottom: 40px;
}

.promo-header h2 {
	font-family: 'Dancing Script', cursive;
	font-size: 2.8rem;
	font-weight: bold;
	margin-bottom: 10px;
}

/* ---------- GRID SẢN PHẨM ---------- */
.product-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 25px;
}

/* ---------- CARD SẢN PHẨM ---------- */
.product-card {
	background: #fff;
	border: none;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 4px 15px rgba(0,0,0,0.08);
	transition: all 0.3s ease;
	text-align: center;
	display: flex;
	flex-direction: column;
}

.product-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 6px 20px rgba(0,0,0,0.12);
}

.product-card img {
	width: 100%;
	height: 240px;
	object-fit: cover;
}

.product-card .card-body {
	padding: 20px;
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.product-card h5 {
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.product-card .price {
	color: #ff69b4;
	font-weight: 600;
	font-size: 1rem;
}

.btn-outline-pink {
	color: #ff69b4;
	border: 1px solid #ff69b4;
	border-radius: 25px;
	transition: all 0.3s ease;
	margin-top: 10px;
}

.btn-outline-pink:hover {
	background-color: #ff69b4;
	color: white;
}
	</style>
</sitemesh:head>

<div class="container my-5">
	<div class="promo-container">
		<!-- 🌸 THÔNG TIN KHUYẾN MÃI -->
		<div class="promo-header">
			<h2>${promotion.promotionName}</h2>
			<span class="badge
				<c:choose>
					<c:when test="${promotion.statusCode == 1}">bg-success</c:when>
					<c:when test="${promotion.statusCode == 2}">bg-warning text-dark</c:when>
					<c:otherwise>bg-secondary</c:otherwise>
				</c:choose>">
				${promotion.statusLabel}
			</span>
			<p class="fw-semibold mt-3">${promotion.description}</p>
			<h4 class="text-white mt-3 fw-bold">
				<c:choose>
					<c:when test="${promotion.discountType == 'PERCENTAGE'}">
						Giảm ${promotion.discountValue}%
					</c:when>
					<c:otherwise>
						Giảm <fmt:formatNumber value="${promotion.discountValue}" type="number"/>₫
					</c:otherwise>
				</c:choose>
			</h4>
			<p class="mt-3">
				Hiệu lực từ <strong>${promotion.startDateFormatted}</strong> đến <strong>${promotion.endDateFormatted}</strong>
			</p>
		</div>

		<!-- 🌷 DANH SÁCH SẢN PHẨM -->
		<h3 class="section-title">🌷 Sản phẩm áp dụng 🌷</h3>

		<c:if test="${empty promotion.products}">
			<p class="text-center text-muted">Hiện chưa có sản phẩm nào áp dụng khuyến mãi này.</p>
		</c:if>

		<div class="product-grid mt-4">
			<c:forEach var="p" items="${promotion.products}">
				<div class="product-card">
					<img src="${pageContext.request.contextPath}/images/${p.imageUrl}" alt="${p.name}">
					<div class="card-body">
						<h5>${p.name}</h5>
						<p class="price">
							<del class="text-muted"><fmt:formatNumber value="${p.price}" type="number" />₫</del><br>
							<c:choose>
								<c:when test="${promotion.discountType == 'PERCENTAGE'}">
									<fmt:formatNumber value="${p.price - (p.price * promotion.discountValue / 100)}" type="number" />₫
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${p.price - promotion.discountValue}" type="number" />₫
								</c:otherwise>
							</c:choose>
						</p>
						<a href="${pageContext.request.contextPath}/product/${p.id}" class="btn btn-outline-pink btn-sm">Xem chi tiết</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
</sitemesh:page>
