<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="Danh mục - StarShop">
    <sitemesh:head>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Dancing+Script:wght@600&display=swap" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(135deg, #fffafc, #e8faff);
                font-family: 'Poppins', sans-serif;
            }

            /* Header */
            .shop-header {
                text-align: center;
                margin: 30px 0;
            }
            .shop-header h2 {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 2.4rem;
                font-weight: 700;
            }
            .shop-header p {
                color: #6c757d;
            }

            /* Sidebar */
            .category-sidebar {
                background: white;
                border-radius: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                padding: 25px;
                position: sticky;
                top: 90px;
            }
            .category-sidebar h5 {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 1.7rem;
                margin-bottom: 18px;
                text-align: center;
            }
            .category-sidebar ul {
                list-style: none;
                padding-left: 0;
                margin: 0;
            }
            .category-sidebar a {
                display: block;
                color: #555;
                padding: 10px 14px;
                border-radius: 12px;
                margin-bottom: 6px;
                text-decoration: none;
                transition: 0.25s;
                font-weight: 500;
            }
            .category-sidebar a:hover {
                background: #fff0f6;
                color: #ff69b4;
                transform: translateX(5px);
            }
            .category-sidebar a.active {
                background: linear-gradient(135deg, #ffb6e6, #ff69b4);
                color: white;
                font-weight: 600;
            }

            /* Product card */
            .product-card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                background: white;
                transition: all 0.3s ease;
                overflow: hidden;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 22px rgba(0,0,0,0.15);
            }
            .product-img {
                height: 210px;
                object-fit: contain;
                width: 100%;
                background: #fff;
                padding: 15px;
            }
            .card-body {
                padding: 15px;
                text-align: center;
            }
            .card-title {
                font-weight: 600;
                color: #333;
                font-size: 1rem;
                min-height: 2.2rem;
            }
            .price {
                color: #ff69b4;
                font-weight: 700;
                font-size: 1.1rem;
            }
            .btn-outline-pink {
                color: #ff69b4;
                border-color: #ff69b4;
                border-radius: 25px;
                font-size: 0.9rem;
                padding: 5px 14px;
            }
            .btn-outline-pink:hover {
                background-color: #ff69b4;
                color: white;
            }

            /* Pagination */
            .pagination .page-link {
                color: #ff69b4;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                text-align: center;
                line-height: 38px;
                margin: 0 4px;
                border-color: #ffd6eb;
            }
            .pagination .page-link:hover {
                background-color: #ffeff8;
            }
            .pagination .active .page-link {
                background-color: #ff69b4;
                color: white;
                border-color: #ff69b4;
            }

            /* Empty message */
            .empty-box {
                text-align: center;
                color: #777;
                padding: 60px 0;
            }
            .empty-box i {
                font-size: 3rem;
                color: #ffb6c1;
            }

            @media (max-width: 992px) {
                .category-sidebar {
                    margin-bottom: 25px;
                }
                .product-img {
                    height: 180px;
                }
            }
        </style>
    </sitemesh:head>

    <div class="container">
        <div class="shop-header">
            <h2>
                <c:forEach var="cat" items="${categories}">
                    <c:if test="${cat.id == selectedCategoryId}">${cat.name}</c:if>
                </c:forEach>
            </h2>
            <p>Khám phá những bó hoa tuyệt đẹp trong danh mục này 🌷</p>
        </div>

        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-md-4">
                <div class="category-sidebar">
                    <h5>Danh mục hoa</h5>
                    <ul>
                        <c:forEach var="cat" items="${categories}">
                            <li>
                                <a href="${pageContext.request.contextPath}/shop/category/${cat.id}"
                                   class="${cat.id == selectedCategoryId ? 'active' : ''}">
                                    🌸 ${cat.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <!-- Product List -->
            <div class="col-lg-9 col-md-8">
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="row g-4">
                            <c:forEach var="p" items="${products}">
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="card product-card">
                                        <img src="${pageContext.request.contextPath}/images/${p.imageUrl}"
                                             class="product-img" alt="${p.name}">
                                        <div class="card-body">
                                            <h6 class="card-title text-truncate" title="${p.name}">${p.name}</h6>
                                            <p class="price"><fmt:formatNumber value="${p.price}" type="number"/> ₫</p>
                                            <a href="${pageContext.request.contextPath}/product/${p.id}" 
                                               class="btn btn-outline-pink btn-sm">Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <c:if test="${productPage.hasPrevious()}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/shop/category/${selectedCategoryId}?page=${productPage.number - 1}">&laquo;</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="0" end="${productPage.totalPages - 1}" var="i">
                                    <li class="page-item ${i == productPage.number ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/shop/category/${selectedCategoryId}?page=${i}">${i + 1}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${productPage.hasNext()}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/shop/category/${selectedCategoryId}?page=${productPage.number + 1}">&raquo;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            <i class="bi bi-flower2"></i>
                            <p class="mt-3 fs-5">Không có sản phẩm trong danh mục này.</p>
                            <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-pink mt-3">Quay lại cửa hàng</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</sitemesh:page>
