<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container py-5" data-aos="fade-up">
    <div class="text-center mb-5">
        <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 3rem;">🌷 Liên hệ với StarShop</h2>
        <p class="text-muted fs-5">
            Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn 💌  
            Hãy để lại lời nhắn, đội ngũ StarShop sẽ phản hồi sớm nhất!
        </p>
    </div>

    <div class="row g-5">
        <!-- Form liên hệ -->
        <div class="col-lg-6" data-aos="fade-right">
            <form action="${pageContext.request.contextPath}/sendContact" method="post" class="p-4 rounded-4 shadow-sm"
                  style="background: linear-gradient(180deg, #fff, #fef6fb); border: 1px solid #ffd6e8;">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ và tên</label>
                    <input type="text" class="form-control rounded-pill" name="name" placeholder="Nhập họ tên của bạn" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <input type="email" class="form-control rounded-pill" name="email" placeholder="example@gmail.com" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại</label>
                    <input type="text" class="form-control rounded-pill" name="phone" placeholder="0909 xxx xxx">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Nội dung</label>
                    <textarea class="form-control" name="message" rows="5" placeholder="Viết tin nhắn của bạn..." required></textarea>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn rounded-pill px-5 py-2 shadow-lg" 
                            style="background: linear-gradient(45deg, #d7f3ff, #ffd6e8); color: #007bff; border: none;">
                        <i class="bi bi-send"></i> Gửi liên hệ
                    </button>
                </div>
            </form>
        </div>

        <!-- Thông tin & bản đồ -->
        <div class="col-lg-6" data-aos="fade-left">
            <div class="p-4 rounded-4 shadow-sm mb-4"
                 style="background: linear-gradient(180deg, #fff, #fef6fb); border: 1px solid #d8f3dc;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Thông tin liên hệ</h5>
                <ul class="list-unstyled text-muted fs-6">
                    <li class="mb-2"><i class="bi bi-geo-alt-fill text-danger me-2"></i> 123 Đường Hoa Xuân, TP. Hồ Chí Minh</li>
                    <li class="mb-2"><i class="bi bi-envelope-fill text-primary me-2"></i> support@starshop.vn</li>
                    <li class="mb-2"><i class="bi bi-telephone-fill text-success me-2"></i> 0909 123 456</li>
                </ul>

                <div class="mt-3 d-flex gap-3">
                    <a href="https://facebook.com" target="_blank" class="text-primary fs-4"><i class="bi bi-facebook"></i></a>
                    <a href="https://instagram.com" target="_blank" class="text-danger fs-4"><i class="bi bi-instagram"></i></a>
                    <a href="https://tiktok.com" target="_blank" class="text-dark fs-4"><i class="bi bi-tiktok"></i></a>
                </div>
            </div>

            <div class="rounded-4 overflow-hidden shadow-sm" style="border: 2px solid #ffd6e8;">
                <iframe 
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.469731397812!2d106.70042377583988!3d10.77688925924237!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f44b46e5a89%3A0xb0f2d0a8e463bf69!2zMTIzIMSQLiBIb2EgWHXDom4sIFBoxrDhu51uZyA0LCBRdeG6rW4gMSwgVMOibiBI4buTIE3hu5lpLCBWaWV0bmFt!5e0!3m2!1svi!2s!4v1697016871000!5m2!1svi!2s"
                    width="100%" height="300" style="border:0;" allowfullscreen="" loading="lazy">
                </iframe>
            </div>
        </div>
    </div>
</div>

