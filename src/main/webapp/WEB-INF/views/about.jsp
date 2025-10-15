<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="about-section py-5" style="background: linear-gradient(180deg, #fff0f6, #f1f9ff);">
    <div class="container" data-aos="fade-up">

        <!-- Tiêu đề chính -->
        <div class="text-center mb-5">
            <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff4da6; font-size: 3rem;">
                🌸 Về StarShop 🌸
            </h2>
            <p class="text-muted fs-5 mt-3">
                Nơi hoa tươi kể câu chuyện của yêu thương và hạnh phúc 💖
            </p>
        </div>

        <!-- Nội dung chính -->
        <div class="row align-items-center gy-4">
            <div class="col-md-6 text-center" data-aos="fade-right">
                <img src="https://images.unsplash.com/photo-1523693916903-027d144a2b7d?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=735"
                     alt="About StarShop"
                     class="img-fluid rounded-4 shadow-lg"
                     style="border: 5px solid #ffe6f2; transform: rotate(-2deg); transition: all 0.3s ease-in-out;">
            </div>

            <div class="col-md-6" data-aos="fade-left">
                <h3 class="fw-semibold mb-3" style="color: #ff69b4;">
                    💐 Lan tỏa yêu thương qua từng cánh hoa
                </h3>
                <p class="text-muted lh-lg fs-5">
                    <strong>StarShop</strong> là nền tảng thương mại điện tử chuyên về <strong>hoa tươi và quà tặng</strong>,
                    giúp kết nối hàng nghìn cửa hàng hoa trên toàn quốc đến tay khách hàng nhanh chóng và tinh tế nhất.
                </p>
                <p class="text-muted lh-lg fs-5">
                    Với sứ mệnh <em>“Gửi cảm xúc – Trao yêu thương”</em>, chúng tôi mang đến không chỉ là hoa,
                    mà còn là trải nghiệm dịch vụ tận tâm, nhanh chóng, và mang đậm dấu ấn riêng.
                </p>

                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/contact"
                       class="btn btn-lg rounded-pill px-5 shadow"
                       style="background: linear-gradient(90deg, #ffb6c1, #ffd6e8); color: #fff; border: none; transition: all 0.3s;">
                       Liên hệ ngay
                    </a>
                </div>
            </div>
        </div>

        <!-- Phần tầm nhìn & giá trị -->
        <div class="row mt-5 gy-4">
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                <div class="card border-0 shadow-sm h-100 text-center p-4 rounded-4" style="background-color: #fff;">
                    <div class="mb-3" style="font-size: 2rem; color: #ff69b4;">🌷</div>
                    <h5 class="fw-bold mb-2">Chất lượng hàng đầu</h5>
                    <p class="text-muted small">Từng bông hoa đều được chọn lựa kỹ càng để mang đến sự tươi mới và hoàn hảo nhất.</p>
                </div>
            </div>

            <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                <div class="card border-0 shadow-sm h-100 text-center p-4 rounded-4" style="background-color: #fff;">
                    <div class="mb-3" style="font-size: 2rem; color: #ff69b4;">🚚</div>
                    <h5 class="fw-bold mb-2">Giao hàng nhanh chóng</h5>
                    <p class="text-muted small">Đặt hoa online – giao ngay tận nơi, đúng giờ, đúng cảm xúc.</p>
                </div>
            </div>

            <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                <div class="card border-0 shadow-sm h-100 text-center p-4 rounded-4" style="background-color: #fff;">
                    <div class="mb-3" style="font-size: 2rem; color: #ff69b4;">💖</div>
                    <h5 class="fw-bold mb-2">Dịch vụ tận tâm</h5>
                    <p class="text-muted small">Chúng tôi đồng hành cùng bạn trong mọi khoảnh khắc đặc biệt của cuộc sống.</p>
                </div>
            </div>
        </div>

    </div>
</section>

<!-- Hiệu ứng CSS -->
<style>
    .about-section img:hover {
        transform: rotate(0deg) scale(1.03);
    }

    .about-section .btn:hover {
        background: linear-gradient(90deg, #ff69b4, #ff8abf);
        transform: translateY(-3px);
    }
</style>
