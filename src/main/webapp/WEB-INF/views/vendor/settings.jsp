<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Shop Settings</title>
    <style>
        .hover-scale:hover { transform: scale(1.05); box-shadow: 0 8px 20px rgba(0,0,0,0.15); }
        .modal-content { border-radius: 15px; }
        .modal-header { background: linear-gradient(135deg, #ffeaf2, #d7f3ff); }
        .btn-pink { background-color: #ff69b4; color: white; }
        .btn-pink:hover { background-color: #ff1493; }
    </style>
</head>

<body>
    <div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow-lg rounded-4 border-0" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                        <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌸 Shop Settings</h2>
                        <button class="btn btn-pink" data-bs-toggle="modal" data-bs-target="#editSettingsModal">Edit Settings</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-10 offset-md-1">
                <div class="card shadow-lg rounded-4 border-0 p-4" style="border-left: 5px solid #ff69b4;">
                    <h5 class="fw-bold mb-3" style="color: #ff69b4;">Shop Information</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><i class="bi bi-shop me-2"></i><strong>Shop Name:</strong> ${vendor.shopName}</li>
                        <li class="list-group-item"><i class="bi bi-geo-alt me-2"></i><strong>Address:</strong> ${vendor.address}</li>
                        <li class="list-group-item"><i class="bi bi-telephone me-2"></i><strong>Phone:</strong> ${vendor.phone}</li>
                        <li class="list-group-item"><i class="bi bi-envelope me-2"></i><strong>Email:</strong> ${vendor.email}</li>
                        <li class="list-group-item"><i class="bi bi-text-paragraph me-2"></i><strong>Description:</strong> ${vendor.description}</li>
                        <li class="list-group-item"><i class="bi bi-calendar-event me-2"></i><strong>Registration Date:</strong> ${vendor.createdAt}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Settings Modal -->
    <div class="modal fade" id="editSettingsModal" tabindex="-1" aria-labelledby="editSettingsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editSettingsModalLabel">Edit Settings</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editSettingsForm">
                        <div class="mb-3">
                            <label for="shopName" class="form-label">Shop Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="shopName" name="shopName" value="${vendor.shopName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address" value="${vendor.address}">
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${vendor.phone}">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${vendor.email}" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4">${vendor.description}</textarea>
                        </div>
                        <button type="submit" class="btn btn-pink w-100">Save Changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Dependencies -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $('#editSettingsForm').submit(function(e) {
            e.preventDefault();
            $.ajax({
                url: '${pageContext.request.contextPath}/vendor/settings',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    alert('Settings updated successfully!');
                    location.reload();
                },
                error: function() {
                    alert('Error updating settings.');
                }
            });
        });
    </script>
</body>