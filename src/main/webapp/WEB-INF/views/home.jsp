<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 🌸 Hero Section -->
<div class="hero-section position-relative overflow-hidden"
     style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc); height: 70vh; display: flex; align-items: center;">
    <div class="parallax-bg"
         style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
                background: url('https://images.unsplash.com/photo-1490750967868-88aa4486c946') no-repeat center/cover;
                opacity: 0.25; transform: translateY(0); transition: transform 0.5s;"></div>

    <div class="container text-center position-relative z-1" data-aos="fade-up" data-aos-duration="1200">
        <h1 class="display-3 fw-bold"
            style="font-family: 'Dancing Script', cursive; color: #ff69b4; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">
            🌸 Chào mừng đến với StarShop
        </h1>
        <p class="lead fs-4" style="color: #6c757d;">
            Nơi lan tỏa yêu thương qua những bó hoa tươi tắn và đầy cảm xúc 💐
        </p>
        <a href="${pageContext.request.contextPath}/shop"
           class="btn btn-lg px-5 rounded-pill shadow-lg"
           style="background: linear-gradient(45deg, #ffd6e8, #d7f3ff); color: #ff1493; border: none; transition: transform 0.3s;">
           Khám phá ngay
        </a>
    </div>
</div>

<!-- 💐 Sản phẩm nổi bật -->
<div class="container my-5" data-aos="fade-up">
    <h2 class="text-center mb-5"
        style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">
        💐 Sản phẩm nổi bật
    </h2>

    <div class="owl-carousel owl-theme">
        <c:forEach var="product" items="${topProducts}">
            <div class="item">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden position-relative"
                     style="background-color: #fff; transition: all 0.3s;">

                    <!-- Gắn nhãn giảm giá -->
                    <c:if test="${product.discountPercent > 0}">
                        <span class="position-absolute top-0 start-0 bg-danger text-white px-2 py-1 rounded-end fw-bold">
                            -${product.discountPercent}%
                        </span>
                    </c:if>

                    <!-- Gắn nhãn Best Seller -->
                    <c:if test="${product.soldQuantity > 100}">
                        <span class="position-absolute top-0 end-0 bg-warning text-dark px-2 py-1 rounded-start fw-bold">
                            🔥 Best Seller
                        </span>
                    </c:if>

                    <!-- Ảnh sản phẩm -->
                    <img src="${pageContext.request.contextPath}/images/${product.imageUrl}"
                         class="card-img-top" alt="${product.name}"
                         style="border-radius: 20px 20px 0 0; object-fit: cover; height: 250px; transition: transform 0.3s;">

                    <div class="card-body text-center p-4">
                        <h6 class="fw-bold" style="color: #ff1493; font-family: 'Poppins', sans-serif;">
                            ${product.name}
                        </h6>

                        <!-- Hiển thị giá -->
                        <c:choose>
                            <c:when test="${product.discountPercent > 0}">
                                <p class="mb-1">
                                    <span class="fw-bold text-success">
                                        <fmt:formatNumber value="${product.price * (1 - product.discountPercent/100.0)}" type="number"/> ₫
                                    </span>
                                    <small class="text-muted text-decoration-line-through ms-2">
                                        <fmt:formatNumber value="${product.price}" type="number"/> ₫
                                    </small>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="fw-bold text-success">
                                    <fmt:formatNumber value="${product.price}" type="number"/> ₫
                                </p>
                            </c:otherwise>
                        </c:choose>

                        <a href="${pageContext.request.contextPath}/product/${product.id}"
                           class="btn btn-outline rounded-pill mt-2"
                           style="border-color: #ffd6e8; color: #ff69b4; transition: background 0.3s;">
                           Xem chi tiết
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 🌈 Hiệu ứng -->
<script>
    // Hiệu ứng parallax
    window.addEventListener('scroll', function() {
        const parallax = document.querySelector('.parallax-bg');
        if (parallax) {
            const scrollPosition = window.pageYOffset;
            parallax.style.transform = 'translateY(' + scrollPosition * 0.5 + 'px)';
        }
    });

    // Owl Carousel
    $(document).ready(function() {
        $('.owl-carousel').owlCarousel({
            loop: true,
            margin: 20,
            nav: true,
            responsive: {
                0: { items: 1 },
                600: { items: 2 },
                1000: { items: 4 }
            }
        });
    });
</script>
