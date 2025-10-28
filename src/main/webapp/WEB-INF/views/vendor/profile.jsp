<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-lg rounded-4 border-0" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">
                        🌸 Hồ Sơ Cửa Hàng
                    </h2>
                    <button class="btn btn-pink" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                        <i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Thông tin hồ sơ -->
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card shadow-lg border-0 rounded-4 p-4" style="background-color: #fff; border-left: 5px solid #ff69b4;">
                <ul class="list-group list-group-flush fs-6">
                    <li class="list-group-item border-0 py-3">
                        <i class="bi bi-shop text-pink me-2"></i><strong>Tên Cửa Hàng:</strong> ${vendor.shopName}
                    </li>
                    <li class="list-group-item border-0 py-3">
                        <i class="bi bi-geo-alt text-pink me-2"></i><strong>Địa Chỉ:</strong> ${vendor.address}
                    </li>
                    <li class="list-group-item border-0 py-3">
                        <i class="bi bi-telephone text-pink me-2"></i><strong>Số Điện Thoại:</strong> ${vendor.phone}
                    </li>
                    <li class="list-group-item border-0 py-3">
                        <i class="bi bi-envelope text-pink me-2"></i><strong>Email:</strong> ${vendor.email}
                    </li>
                    <li class="list-group-item border-0 py-3">
                        <i class="bi bi-text-paragraph text-pink me-2"></i><strong>Mô Tả:</strong> ${vendor.description}
                    </li>
                    <li class="list-group-item border-0 py-3">
                        <i class="bi bi-calendar-event text-pink me-2"></i><strong>Ngày Đăng Ký:</strong> ${vendor.createdAt}
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Modal chỉnh sửa -->
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                <h5 class="modal-title fw-bold text-dark">
                    <i class="bi bi-pencil-square me-2 text-pink"></i>Chỉnh Sửa Hồ Sơ
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-4">
                <form id="editProfileForm" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên Cửa Hàng <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-3" name="shopName" value="${vendor.shopName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Địa Chỉ</label>
                        <input type="text" class="form-control rounded-3" name="address" value="${vendor.address}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số Điện Thoại</label>
                        <input type="text" class="form-control rounded-3" name="phone" value="${vendor.phone}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email" class="form-control rounded-3" name="email" value="${vendor.email}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô Tả</label>
                        <textarea class="form-control rounded-3" name="description" rows="3">${vendor.description}</textarea>
                    </div>
                    <button type="submit" id="saveProfileBtn" class="btn btn-pink w-100 py-2 fw-semibold">
                        💾 Lưu Thay Đổi
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- CSS -->
<style>
    .btn-pink {
        background-color: #ff69b4;
        color: white;
        border: none;
        transition: all 0.3s ease;
    }
    .btn-pink:hover {
        background-color: #ff4081;
        color: white;
        transform: scale(1.05);
    }
    .text-pink { color: #ff69b4 !important; }
    .form-control:focus {
        border-color: #ff69b4;
        box-shadow: 0 0 0 0.2rem rgba(255,105,180,0.25);
    }
</style>

<!-- Script -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(function() {
    // Gắn sự kiện submit an toàn
    $('#editProfileForm').off('submit').on('submit', function(e) {
        e.preventDefault();

        $('#saveProfileBtn').prop('disabled', true).text('Đang lưu...');

        $.ajax({
            url: '${pageContext.request.contextPath}/vendor/profile/edit',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                $('#saveProfileBtn').prop('disabled', false).text('💾 Lưu Thay Đổi');

                if (response === "Success") {
                    // Reload lại trang ngay lập tức, không popup
                    location.reload();
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Cảnh báo!',
                        text: response,
                        confirmButtonColor: '#ff69b4'
                    });
                }
            },
            error: function() {
                $('#saveProfileBtn').prop('disabled', false).text('💾 Lưu Thay Đổi');
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi!',
                    text: 'Không thể cập nhật hồ sơ. Vui lòng thử lại.',
                    confirmButtonColor: '#ff69b4'
                });
            }
        });
    });
});
</script>
