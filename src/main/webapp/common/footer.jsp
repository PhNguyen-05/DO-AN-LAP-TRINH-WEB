<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="pt-5 pb-4 mt-5 position-relative overflow-hidden"
        style="background: linear-gradient(180deg, #fff0f6, #e3f8ff, #e8f5e9); border-top: 4px solid #ffb6c1; font-family: 'Poppins', sans-serif;">
    <div class="container" data-aos="fade-up">
        <div class="row gy-5">
            <!-- Cột 1: Logo & Mô tả -->
            <div class="col-md-4">
                <h4 class="fw-bold mb-3" style="font-family: 'Dancing Script', cursive; color: #ff4081;">
                    🌷 StarShop
                </h4>
                <p class="text-muted small lh-lg">
                    StarShop – nền tảng hoa tươi toàn quốc 💐  
                    Mang đến niềm vui, yêu thương và sự tinh tế qua từng bó hoa mỗi ngày.
                </p>

                
            </div>

            <!-- Cột 2: Liên kết nhanh -->
            <div class="col-md-4">
                <h6 class="fw-bold mb-3 text-uppercase" style="color: #ff4081;">Liên kết nhanh</h6>
                <ul class="list-unstyled">
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/about" class="text-muted text-decoration-none">
                            <i class="bi bi-chevron-right small me-1 text-primary"></i> Về chúng tôi
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/shop" class="text-muted text-decoration-none">
                            <i class="bi bi-chevron-right small me-1 text-primary"></i> Cửa hàng
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/contact" class="text-muted text-decoration-none">
                            <i class="bi bi-chevron-right small me-1 text-primary"></i> Liên hệ
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/policy" class="text-muted text-decoration-none">
                            <i class="bi bi-chevron-right small me-1 text-primary"></i> Chính sách & Bảo mật
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Cột 3: Liên hệ -->
            <div class="col-md-4">
                <h6 class="fw-bold mb-3 text-uppercase" style="color: #ff4081;">Liên hệ</h6>
                <ul class="list-unstyled text-muted small">
                    <li class="mb-2">
                        <i class="bi bi-geo-alt-fill me-2 text-danger"></i>
                        123 Đường Hoa Xuân, Quận 3, TP. Hồ Chí Minh
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-envelope-fill me-2 text-primary"></i>
                        support@starshop.vn
                    </li>
                    <li>
                        <i class="bi bi-telephone-fill me-2 text-success"></i>
                        0909 123 456
                    </li>
                </ul>
                <!-- Icon mạng xã hội -->
                <div class="mt-3 d-flex gap-3">
                    <a href="https://facebook.com" target="_blank" class="social-icon text-decoration-none">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="https://instagram.com" target="_blank" class="social-icon text-decoration-none">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="https://tiktok.com" target="_blank" class="social-icon text-decoration-none">
                        <i class="bi bi-tiktok"></i>
                    </a>
                    <a href="mailto:support@starshop.vn" class="social-icon text-decoration-none">
                        <i class="bi bi-envelope"></i>
                    </a>
                </div>
            </div>
            
        </div>

        <hr class="my-4" style="border-color: rgba(255, 182, 193, 0.4);">
        <div class="text-center small text-muted">
            © 2025 <span class="fw-semibold" style="color:#ff4081;">StarShop</span> — Hoa tươi mỗi ngày 🌸
        </div>
    </div>

    <!-- CSS thêm -->
    <style>
        .social-icon {
            font-size: 1.5rem;
            color: #888;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            color: #ff4081;
            transform: scale(1.2);
        }

        footer a:hover {
            color: #ff4081 !important;
            text-decoration: none;
        }

        footer i {
            vertical-align: middle;
        }
    </style>
</footer>
