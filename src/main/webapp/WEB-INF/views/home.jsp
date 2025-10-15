<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="hero-section position-relative overflow-hidden" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc); height: 70vh; display: flex; align-items: center;">
    <div class="parallax-bg" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: url('https://images.unsplash.com/photo-1490750967868-88aa4486c946') no-repeat center/cover; opacity: 0.2; transform: translateY(0); transition: transform 0.5s;"></div>
    <div class="container text-center position-relative z-1" data-aos="fade-up" data-aos-duration="1200">
        <h1 class="display-3 fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">🌸 Chào mừng đến với StarShop</h1>
        <p class="lead fs-4" style="color: #6c757d;">Nơi lan tỏa yêu thương qua những bó hoa tươi tắn và đầy cảm xúc 💐</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-lg px-5 rounded-pill shadow-lg" style="background: linear-gradient(45deg, #ffd6e8, #d7f3ff); color: #ff1493; border: none; transition: transform 0.3s;">Khám phá ngay</a>
    </div>
</div>

<div class="container my-5" data-aos="fade-up">
    <h2 class="text-center mb-5" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">💐 Sản phẩm nổi bật</h2>
    <div class="owl-carousel owl-theme">
        <c:forEach var="product" items="${topProducts}">
            <div class="item">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden" style="background-color: #fff; transition: all 0.3s;" data-aos="zoom-in">
                    <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}" style="border-radius: 20px 20px 0 0; object-fit: cover; height: 250px; transition: transform 0.3s;">
                    <div class="card-body text-center p-4">
                        <h6 class="fw-bold" style="color: #ff1493; font-family: 'Poppins', sans-serif;">${product.name}</h6>
                        <p class="small text-muted mb-1">${product.shop.name}</p>
                        <p class="fw-bold" style="color: #28a745;">${product.price} ₫</p>
                        <a href="${pageContext.request.contextPath}/product/${product.id}" class="btn btn-outline rounded-pill" style="border-color: #ffd6e8; color: #ff69b4; transition: background 0.3s;">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="container my-5" data-aos="fade-up">
    <h2 class="text-center mb-5" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌼 Các shop nổi bật</h2>
    <div class="row g-4">
        <c:forEach var="shop" items="${topShops}">
            <div class="col-md-4" data-aos="flip-left" data-aos-delay="100">
                <div class="card shadow-lg border-0 rounded-4 text-center p-4" style="background: linear-gradient(135deg, #d7f3ff, #ffeaf2, #d8f3dc); transition: all 0.3s;">
                    <img src="${shop.logo}" class="rounded-circle mx-auto mb-3 shadow-lg" width="120" height="120" style="border: 4px solid #ffd6e8; transition: transform 0.3s;">
                    <h6 class="fw-bold" style="color: #ff1493; font-family: 'Poppins', sans-serif;">${shop.name}</h6>
                    <p class="text-muted small">${shop.description}</p>
                    <a href="${pageContext.request.contextPath}/shop/${shop.id}" class="btn btn-outline rounded-pill" style="border-color: #ff69b4; color: #ff69b4;">Xem shop</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    // Parallax effect
    window.addEventListener('scroll', function() {
        const parallax = document.querySelector('.parallax-bg');
        let scrollPosition = window.pageYOffset;
        parallax.style.transform = 'translateY(' + scrollPosition * 0.5 + 'px)';
    });

    // Owl Carousel init
    $('.owl-carousel').owlCarousel({
        loop: true,
        margin: 20,
        nav: true,
        responsive: { 0: { items: 1 }, 600: { items: 3 }, 1000: { items: 4 } }
    });
</script>
