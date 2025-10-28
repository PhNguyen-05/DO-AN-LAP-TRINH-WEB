<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="Sản phẩm đã xem - StarShop">
    <sitemesh:head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(135deg, #fffafc, #e8faff);
                font-family: 'Poppins', sans-serif;
            }
            .recently-viewed-section {
                max-width: 1200px;
                margin: 40px auto;
                padding: 20px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            }
            .section-title {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 2rem;
                margin-bottom: 20px;
                text-align: center;
            }

            /* Scroll ngang giống Shopee */
            .recently-viewed-container {
                display: flex;
                overflow-x: auto;
                gap: 20px;
                padding: 10px 0;
                scroll-behavior: smooth;
            }
            .product-card {
                flex: 0 0 180px;
                text-align: center;
                border: 1px solid #eee;
                border-radius: 16px;
                background: #fff;
                transition: transform 0.3s, box-shadow 0.3s;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }
            .product-card:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            }
            .product-card img {
                width: 100%;
                height: 180px;
                object-fit: cover;
                border-top-left-radius: 16px;
                border-top-right-radius: 16px;
            }
            .product-card .card-body {
                padding: 10px;
            }
            .product-card .name {
                font-size: 14px;
                font-weight: 500;
                color: #333;
                margin: 5px 0;
                min-height: 38px; /* giữ chiều cao đồng đều */
            }
            .product-card .price {
                color: #ff69b4;
                font-weight: 700;
                font-size: 1.1rem;
                margin-bottom: 10px;
            }
            .product-card a.btn-detail {
                display: inline-block;
                font-size: 0.9rem;
                padding: 6px 12px;
                border-radius: 25px;
                border: 1px solid #ff69b4;
                color: #ff69b4;
                text-decoration: none;
                transition: all 0.3s;
            }
            .product-card a.btn-detail:hover {
                background-color: #ff69b4;
                color: #fff;
            }
        </style>
    </sitemesh:head>

    <div class="container recently-viewed-section">
        <h2 class="section-title">🌸 Sản phẩm bạn đã xem gần đây 🌸</h2>

        <c:if test="${not empty recentlyViewed}">
            <div class="recently-viewed-container">
                <c:forEach var="p" items="${recentlyViewed}">
                    <div class="product-card">
                        <a href="${pageContext.request.contextPath}/product/${p.id}">
                            <img src="${pageContext.request.contextPath}/images/${p.imageUrl}" alt="${p.name}">
                        </a>
                        <div class="card-body">
                            <a href="${pageContext.request.contextPath}/product/${p.id}" class="name">${p.name}</a>
                            <p class="price"><fmt:formatNumber value="${p.price}" type="number"/> ₫</p>
                            <a href="${pageContext.request.contextPath}/product/${p.id}" class="btn-detail">Xem chi tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty recentlyViewed}">
            <p class="text-center text-muted mt-3">Bạn chưa xem sản phẩm nào.</p>
        </c:if>
    </div>
</sitemesh:page>
