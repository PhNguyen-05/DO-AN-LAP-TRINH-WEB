<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="Cửa hàng - StarShop">
    <sitemesh:head>
        <!-- Bootstrap CSS -->
        
        <style>
            body {
                background: linear-gradient(135deg, #fffafc, #e8faff);
                font-family: 'Poppins', sans-serif;
            }
            .shop-header {
                text-align: center;
                margin: 30px 0;
            }
            .shop-header h2 {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 2.3rem;
                font-weight: 700;
            }
            .shop-header p {
                color: #6c757d;
            }

            /* Thanh tìm kiếm */
            .search-bar {
                max-width: 600px;
                margin: 20px auto 40px auto;
            }
            .input-group input {
                border-radius: 30px 0 0 30px;
                padding-left: 15px;
            }
            .btn-search {
                border-radius: 0 30px 30px 0;
                background-color: #ff69b4;
                color: white;
                border: none;
            }
            .btn-search:hover {
                background-color: #ff1493;
            }

            /* Sản phẩm */
            .product-card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                overflow: hidden;
                background: white;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            }
            .product-img {
                height: 200px;
                width: auto;
                max-width: 100%;
                object-fit: contain;
                padding: 10px;
                background: #fff;
            }
            .card-body {
                padding: 15px;
            }
            .card-title {
                font-weight: 600;
                color: #333;
                min-height: 2.5rem;
            }
            .price {
                color: #ff69b4;
                font-weight: 700;
                font-size: 1.1rem;
            }
            .btn-outline-pink {
                color: #ff69b4;
                border-color: #ff69b4;
                border-radius: 20px;
                font-size: 0.9rem;
            }
            .btn-outline-pink:hover {
                background-color: #ff69b4;
                color: white;
            }

            /* Section tiêu đề */
            .section-title {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 2rem;
                margin: 40px 0 25px;
                text-align: center;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .product-img {
                    height: 180px;
                }
            }
        </style>
    </sitemesh:head>

    <div class="container">
        <!-- Tiêu đề -->
        <div class="shop-header">
            <h2>🌸 Cửa hàng hoa tươi StarShop 🌸</h2>
            <p>Khám phá bộ sưu tập hoa tươi rực rỡ mỗi ngày!</p>
        </div>

        <!-- Thanh tìm kiếm -->
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/shop" method="get" class="input-group">
                <input type="text" name="keyword" class="form-control" 
                       placeholder="🔍 Nhập tên hoa hoặc từ khóa sản phẩm..."
                       value="${param.keyword}">
                <button class="btn btn-search" type="submit">
                    <i class="bi bi-search"></i> Tìm kiếm
                </button>
            </form>
        </div>

        <!-- Nếu có keyword -->
        <c:if test="${not empty keyword}">
            <h3 class="section-title">Kết quả cho: "<c:out value='${keyword}'/>"</h3>
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="row g-4">
                        <c:forEach var="hoa" items="${products}">
                            <div class="col-lg-3 col-md-4 col-sm-6">
                                <div class="card product-card">
                                    <img src="${pageContext.request.contextPath}/images/${hoa.imageUrl}" 
                                         class="card-img-top product-img" alt="${hoa.name}">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${hoa.name}</h5>
                                        <p class="price"><fmt:formatNumber value="${hoa.price}" type="number"/> ₫</p>
                                        <a href="${pageContext.request.contextPath}/product/${hoa.id}" 
                                           class="btn btn-outline-pink btn-sm">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-emoji-frown" style="font-size:2rem;"></i>
                        <p class="mt-2">Không có sản phẩm phù hợp với từ khóa của bạn.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <!-- Nếu không có keyword -->
        <c:if test="${empty keyword}">
            <!-- Phần 1: Sản phẩm mới nhất (carousel) -->
            <!-- Phần 1: Sản phẩm mới nhất (carousel) -->
<h3 class="section-title">🌼 Sản phẩm mới nhất 🌼</h3>
<div id="latestProductsCarousel" class="carousel slide mb-5" data-bs-ride="carousel" data-bs-wrap="true">
    <div class="carousel-inner">
        <c:forEach var="hoa" items="${latestProducts}" varStatus="status">
            <div class="carousel-item ${status.first ? 'active' : ''}">
                <div class="d-flex justify-content-center">
                    <!-- Card sản phẩm với kích thước bằng phần 2 -->
                    <div class="card product-card" style="width: 100%; max-width: 250px;">
                        <img src="${pageContext.request.contextPath}/images/${hoa.imageUrl}"  
                             class="card-img-top product-img" alt="${hoa.name}">
                        <div class="card-body text-center">
                            <h5 class="card-title">${hoa.name}</h5>
                            <p class="price"><fmt:formatNumber value="${hoa.price}" type="number"/> ₫</p>
                            <a href="${pageContext.request.contextPath}/product/${hoa.id}" 
                               class="btn btn-outline-pink btn-sm">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Nút prev/next -->
    <button class="carousel-control-prev" type="button" data-bs-target="#latestProductsCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#latestProductsCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>


            <!-- Phần 2: Tất cả sản phẩm (grid + phân trang) -->
            <h3 class="section-title">🌸 Tất cả sản phẩm 🌸</h3>
            <div class="row g-4">
                <c:forEach var="hoa" items="${allProducts}">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card product-card">
                            <img src="${pageContext.request.contextPath}/images/${hoa.imageUrl}"  
                                 class="card-img-top product-img" alt="${hoa.name}">
                            <div class="card-body text-center">
                                <h5 class="card-title">${hoa.name}</h5>
                                <p class="price"><fmt:formatNumber value="${hoa.price}" type="number"/> ₫</p>
                                <a href="${pageContext.request.contextPath}/product/${hoa.id}" 
                                   class="btn btn-outline-pink btn-sm">
                                    Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Phân trang -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center mt-4">
                    <c:if test="${productPage.hasPrevious()}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${productPage.number - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach begin="0" end="${productPage.totalPages - 1}" var="i">
                        <li class="page-item ${i == productPage.number ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i + 1}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${productPage.hasNext()}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${productPage.number + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>

   
</sitemesh:page>
