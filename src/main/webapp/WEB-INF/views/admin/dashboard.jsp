<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<decorator:title>Dashboard</decorator:title>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-lg rounded-4 border-0" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                <div class="card-body p-4 text-center">
                    <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌟 Chào mừng quay lại, Admin!</h2>
                    <p class="text-muted lead">Hôm nay là một ngày tuyệt vời để quản lý StarShop 💐. Hãy xem tổng quan dưới đây.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Stats Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="100">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #d8f3dc; transition: transform 0.3s;">
                <i class="bi bi-people fs-1" style="color: #28a745;"></i>
                <h5 class="fw-bold mt-2" style="color: #28a745;">Tổng User</h5>
                <h3 class="fw-bold">1,250</h3> <!-- Data giả định -->
                <small class="text-muted">+5% so với tuần trước</small>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="200">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #ffeaf2; transition: transform 0.3s;">
                <i class="bi bi-shop fs-1" style="color: #ff1493;"></i>
                <h5 class="fw-bold mt-2" style="color: #ff1493;">Tổng Shop</h5>
                <h3 class="fw-bold">150</h3>
                <small class="text-muted">+2 mới hôm nay</small>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="300">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #d7f3ff; transition: transform 0.3s;">
                <i class="bi bi-basket fs-1" style="color: #007bff;"></i>
                <h5 class="fw-bold mt-2" style="color: #007bff;">Tổng Sản Phẩm</h5>
                <h3 class="fw-bold">2,500</h3>
                <small class="text-muted">+10% doanh số</small>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="400">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #ffd6e8; transition: transform 0.3s;">
                <i class="bi bi-bag fs-1" style="color: #ff69b4;"></i>
                <h5 class="fw-bold mt-2" style="color: #ff69b4;">Tổng Đơn Hàng</h5>
                <h3 class="fw-bold">800</h3>
                <small class="text-muted">+15 hôm nay</small>
            </div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="row mb-5">
        <div class="col-md-6" data-aos="fade-right">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Doanh Thu Theo Tháng</h5>
                <canvas id="revenueChart" height="200"></canvas> <!-- Sử dụng Chart.js -->
            </div>
        </div>
        <div class="col-md-6" data-aos="fade-left">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Sản Phẩm Bán Chạy</h5>
                <canvas id="topProductsChart" height="200"></canvas>
            </div>
        </div>
    </div>

    <!-- Recent Activities -->
    <div class="row">
        <div class="col-md-6" data-aos="fade-up" data-aos-delay="100">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Đơn Hàng Gần Đây</h5>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Khách Hàng</th>
                            <th>Tổng Tiền</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Data giả định -->
                        <tr>
                            <td>#001</td>
                            <td>Nguyễn Văn A</td>
                            <td>500,000 ₫</td>
                            <td><span class="badge bg-success">Hoàn Thành</span></td>
                        </tr>
                        <tr>
                            <td>#002</td>
                            <td>Trần Thị B</td>
                            <td>300,000 ₫</td>
                            <td><span class="badge bg-warning">Đang Giao</span></td>
                        </tr>
                        <!-- Thêm rows khác -->
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-6" data-aos="fade-up" data-aos-delay="200">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">User Mới Đăng Ký</h5>
                <ul class="list-group list-group-flush">
                    <!-- Data giả định -->
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        user1@example.com
                        <span class="badge bg-primary rounded-pill">Mới</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        user2@example.com
                        <span class="badge bg-primary rounded-pill">Mới</span>
                    </li>
                    <!-- Thêm items khác -->
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Script cho Charts (sử dụng Chart.js, thêm CDN trong decorator nếu cần) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Revenue Chart (Line)
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6'],
            datasets: [{
                label: 'Doanh Thu (triệu ₫)',
                data: [12, 19, 3, 5, 2, 3], // Data giả định
                borderColor: '#ff69b4',
                backgroundColor: 'rgba(255, 105, 180, 0.2)',
                tension: 0.4
            }]
        },
        options: { scales: { y: { beginAtZero: true } } }
    });

    // Top Products Chart (Bar)
    const topProductsCtx = document.getElementById('topProductsChart').getContext('2d');
    new Chart(topProductsCtx, {
        type: 'bar',
        data: {
            labels: ['Hoa Hồng', 'Hoa Lan', 'Hoa Cúc', 'Hoa Lily'],
            datasets: [{
                label: 'Số Lượng Bán',
                data: [65, 59, 80, 81], // Data giả định
                backgroundColor: ['#ff69b4', '#007bff', '#28a745', '#ff1493']
            }]
        },
        options: { scales: { y: { beginAtZero: true } } }
    });
</script>