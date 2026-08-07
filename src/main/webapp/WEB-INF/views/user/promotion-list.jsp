<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<sitemesh:page title="Khuyến mãi - StarShop">
<sitemesh:head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
	background: linear-gradient(135deg, #fffafc, #e8faff);
	font-family: 'Poppins', sans-serif;
}

/* 🌸 TIÊU ĐỀ */
.section-title {
	font-family: 'Dancing Script', cursive;
	color: #ff69b4;
	font-size: 2.4rem;
	margin: 60px 0 40px;
	text-align: center;
	position: relative;
}
.section-title::after {
	content: "";
	width: 80px;
	height: 3px;
	background: #ff69b4;
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: -10px;
	border-radius: 2px;
}

/* 🌷 CARD KHUYẾN MÃI */
.promo-card {
	border: none;
	border-radius: 20px;
	overflow: hidden;
	background: #fff;
	box-shadow: 0 5px 15px rgba(0,0,0,0.08);
	transition: all 0.35s ease;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.promo-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 8px 22px rgba(0,0,0,0.12);
}

/* Ảnh nền phần đầu */
.promo-banner {
	position: relative;
	height: 180px;
	background: linear-gradient(135deg, #ffb6c1, #ffd6e0);
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	text-align: center;
}

.promo-banner h5 {
	font-family: 'Dancing Script', cursive;
	font-size: 1.9rem;
	font-weight: 600;
	margin: 0;
}

.badge-status {
	position: absolute;
	top: 15px;
	right: 15px;
	border-radius: 12px;
	padding: 5px 10px;
	font-size: 0.85rem;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* PHẦN THÔNG TIN */
.promo-body {
	padding: 20px;
	text-align: center;
	flex-grow: 1;
}

.promo-body p {
	color: #555;
	margin-bottom: 8px;
}

.discount-text {
	color: #e6399b;
	font-weight: 600;
	font-size: 1rem;
}

.date-text {
	font-size: 0.85rem;
	color: #888;
}

.btn-outline-pink {
	color: #ff69b4;
	border: 1px solid #ff69b4;
	border-radius: 25px;
	transition: all 0.3s ease;
}
.btn-outline-pink:hover {
	background-color: #ff69b4;
	color: white;
	transform: scale(1.05);
}

/* 🌼 PHÂN TRANG */
.pagination .page-item.active .page-link {
	background-color: #ff69b4;
	border-color: #ff69b4;
}
.pagination .page-link {
	color: #ff69b4;
	border-radius: 50%;
	margin: 0 5px;
	transition: all 0.3s ease;
}
.pagination .page-link:hover {
	background-color: #ffe6f0;
}
</style>
</sitemesh:head>

<div class="container my-5">
	<h2 class="section-title">🎀 Ưu đãi & Khuyến mãi nổi bật 🎀</h2>

	<!-- DANH SÁCH KHUYẾN MÃI -->
	<div class="row g-4">
		<c:if test="${empty promotions.content}">
			<p class="text-center text-muted">Hiện chưa có chương trình khuyến mãi nào.</p>
		</c:if>

		<c:forEach var="promo" items="${promotions.content}">
			<div class="col-lg-3 col-md-4 col-sm-6">
				<div class="promo-card">
					<div class="promo-banner">
						<h5>${promo.promotionName}</h5>
						<span class="badge-status 
							<c:choose>
								<c:when test="${promo.statusCode == 1}">bg-success</c:when>
								<c:when test="${promo.statusCode == 2}">bg-warning text-dark</c:when>
								<c:otherwise>bg-secondary</c:otherwise>
							</c:choose>">
							${promo.statusLabel}
						</span>
					</div>
					<div class="promo-body">
						<p>${promo.description}</p>
						<p class="discount-text">
							<c:choose>
								<c:when test="${promo.discountType == 'PERCENTAGE'}">
									Giảm ${promo.discountValue}%
								</c:when>
								<c:otherwise>
									Giảm <fmt:formatNumber value="${promo.discountValue}" type="number"/>₫
								</c:otherwise>
							</c:choose>
						</p>
						<p class="date-text">⏰ ${promo.startDateFormatted} - ${promo.endDateFormatted}</p>
						<a href="${pageContext.request.contextPath}/shop/promotions/${promo.id}" 
						   class="btn btn-outline-pink btn-sm px-4 mt-2">
						   <i class="bi bi-eye"></i> Xem chi tiết
						</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- PHÂN TRANG -->
	<c:if test="${promotions.totalPages > 1}">
		<nav class="mt-5">
			<ul class="pagination justify-content-center">
				<c:forEach var="i" begin="0" end="${promotions.totalPages - 1}">
					<li class="page-item ${i == promotions.number ? 'active' : ''}">
						<a class="page-link" href="?page=${i}">${i + 1}</a>
					</li>
				</c:forEach>
			</ul>
		</nav>
	</c:if>
</div>
</sitemesh:page>
