<<<<<<< HEAD
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<div class="container my-5">
    <h2 class="text-center mb-4" style="font-family: 'Dancing Script', cursive; color: #ff69b4;">
        ❤️ Sản phẩm yêu thích của bạn
    </h2>

    <c:if test="${empty wishlist}">
        <p class="text-center text-muted">Bạn chưa yêu thích sản phẩm nào 🌸</p>
    </c:if>

    <div class="row g-4">
        <c:forEach var="p" items="${wishlist}">
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card shadow-sm border-0 rounded-4">
                    <img src="${pageContext.request.contextPath}/images/${p.imageUrl}"
                         class="card-img-top rounded-top-4" alt="${p.name}">
                    <div class="card-body text-center">
                        <h6 class="fw-bold text-pink">${p.name}</h6>
                        <p class="fw-semibold text-success"><fmt:formatNumber value="${p.price}" type="number"/> ₫</p>

                        <a href="${pageContext.request.contextPath}/product/${p.id}"
                           class="btn btn-outline-pink btn-sm">
                            <i class="bi bi-eye"></i> Xem chi tiết
                        </a>

                        <button class="btn btn-outline-danger btn-sm mt-2 toggle-wishlist"
                                data-id="${p.id}">
                            💔 Bỏ yêu thích
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
document.querySelectorAll('.toggle-wishlist').forEach(btn => {
    btn.addEventListener('click', async () => {
        const id = btn.dataset.id;
        const res = await fetch(`${pageContext.request.contextPath}/wishlist/toggle?productId=${id}`, { method: 'POST' });
        if (res.ok) location.reload();
    });
});
</script>
=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="Danh sách yêu thích - StarShop">
    <sitemesh:head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Dancing+Script:wght@600&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fdfdfd;
            }

            .wishlist-section {
                max-width: 1200px;
                margin: 60px auto;
                background: #fff;
                border-radius: 12px;
                padding: 40px;
                box-shadow: 0 6px 24px rgba(0,0,0,0.05);
            }

            .wishlist-title {
                text-align: center;
                font-family: 'Dancing Script', cursive;
                font-size: 2.5rem;
                color: #ff4081;
                margin-bottom: 40px;
            }

            .wishlist-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 24px;
            }

            .product-card {
                border: 1px solid #f0f0f0;
                border-radius: 12px;
                background-color: #fff;
                transition: all 0.3s ease;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .product-card:hover {
                box-shadow: 0 8px 24px rgba(0,0,0,0.08);
                transform: translateY(-5px);
            }

            .product-card img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-bottom: 1px solid #eee;
            }

            .product-info {
                padding: 15px;
                text-align: center;
            }

            .product-info h6 {
                font-size: 1rem;
                font-weight: 500;
                color: #333;
                margin-bottom: 6px;
            }

            .product-price {
                color: #ff4081;
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 10px;
            }

            /* Phần hai nút */
            .product-actions {
                display: flex;
                justify-content: center;
                gap: 10px;
                padding: 0 10px 16px;
            }

            .product-actions form {
                display: flex;
                justify-content: center;
                gap: 10px;
                width: 100%;
            }

            .btn-action {
                flex: 1;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
                padding: 8px 0;
                font-size: 0.9rem;
                text-align: center;
            }

            .btn-view {
                border: 1px solid #ff4081;
                color: #ff4081;
                background: #fff;
            }

            .btn-view:hover {
                background-color: #ff4081;
                color: #fff;
            }

            .btn-wishlist {
                border: 1px solid #dc3545;
                color: #dc3545;
                background: #fff;
            }

            .btn-wishlist:hover {
                background-color: #dc3545;
                color: #fff;
            }

            .empty-message {
                text-align: center;
                font-size: 1.1rem;
                color: #777;
                margin-top: 50px;
            }
        </style>
    </sitemesh:head>

    <div class="wishlist-section">
        <h2 class="wishlist-title">💖 Sản phẩm yêu thích của bạn 💖</h2>

        <c:if test="${empty wishlist}">
            <p class="empty-message">Bạn chưa yêu thích sản phẩm nào 🌸</p>
        </c:if>

        <div class="wishlist-grid">
            <c:forEach var="p" items="${wishlist}">
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/images/${p.imageUrl}" alt="${p.name}">
                    <div class="product-info">
                        <h6>${p.name}</h6>
                        <p class="product-price"><fmt:formatNumber value="${p.price}" type="number"/> ₫</p>
                    </div>

                    <!-- Form chứa cả 2 nút -->
                    <div class="product-actions">
                        <form action="${pageContext.request.contextPath}/user/wishlist/toggle" method="post">
                            <input type="hidden" name="productId" value="${p.id}">

                            <a href="${pageContext.request.contextPath}/product/${p.id}" class="btn btn-action btn-view">
                                <i class="bi bi-eye"></i> Xem chi tiết
                            </a>

                            <button type="submit" class="btn btn-action btn-wishlist">
                                <i class="bi bi-heart-fill"></i> Bỏ yêu thích
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        document.querySelectorAll('form[action$="/wishlist/toggle"]').forEach(form => {
            form.addEventListener('submit', async e => {
                e.preventDefault();
                const res = await fetch(form.action, { method: 'POST', body: new FormData(form) });
                if (res.ok) location.reload();
            });
        });
    </script>
</sitemesh:page>
>>>>>>> origin/PhuongNguyen
