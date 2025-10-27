<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-lg rounded-4 border-0" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌸 Hồ Sơ Cửa Hàng</h2>
                    <button class="btn btn-pink" data-bs-toggle="modal" data-bs-target="#editProfileModal">Chỉnh Sửa Hồ Sơ</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="border-left: 5px solid #ff69b4;">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><i class="bi bi-shop me-2"></i><strong>Tên Cửa Hàng:</strong> ${vendor.shopName}</li>
                    <li class="list-group-item"><i class="bi bi-geo-alt me-2"></i><strong>Địa Chỉ:</strong> ${vendor.address}</li>
                    <li class="list-group-item"><i class="bi bi-telephone me-2"></i><strong>Số Điện Thoại:</strong> ${vendor.phone}</li>
                    <li class="list-group-item"><i class="bi bi-envelope me-2"></i><strong>Email:</strong> ${vendor.email}</li>
                    <li class="list-group-item"><i class="bi bi-text-paragraph me-2"></i><strong>Mô Tả:</strong> ${vendor.description}</li>
                    <li class="list-group-item"><i class="bi bi-calendar-event me-2"></i><strong>Ngày Đăng Ký:</strong> ${vendor.createdAt}</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProfileModalLabel">Chỉnh Sửa Hồ Sơ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editProfileForm">
                    <div class="mb-3">
                        <label for="shopName" class="form-label">Tên Cửa Hàng <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="shopName" name="shopName" value="${vendor.shopName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Địa Chỉ</label>
                        <input type="text" class="form-control" id="address" name="address" value="${vendor.address}">
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Số Điện Thoại</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="${vendor.phone}">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${vendor.email}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô Tả</label>
                        <textarea class="form-control" id="description" name="description" rows="4">${vendor.description}</textarea>
                    </div>
                    <button type="submit" class="btn btn-pink w-100">Lưu Hồ Sơ</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $('#editProfileForm').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: '${pageContext.request.contextPath}/vendor/profile/edit',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                alert('Hồ sơ cập nhật thành công!');
                location.reload();
            },
            error: function() {
                alert('Lỗi cập nhật hồ sơ.');
            }
        });
    });
</script>