<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
                <h3 class="fw-bold">${totalUsers}</h3>
                <small class="text-muted">Cập nhật mới nhất</small>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="200">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #ffeaf2; transition: transform 0.3s;">
                <i class="bi bi-shop fs-1" style="color: #ff1493;"></i>
                <h5 class="fw-bold mt-2" style="color: #ff1493;">Tổng Khách Hàng</h5>
                <h3 class="fw-bold">${totalCustomers}</h3>
                <small class="text-muted">Cập nhật mới nhất</small>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="300">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #d7f3ff; transition: transform 0.3s;">
                <i class="bi bi-basket fs-1" style="color: #007bff;"></i>
                <h5 class="fw-bold mt-2" style="color: #007bff;">Tổng Sản Phẩm</h5>
                <h3 class="fw-bold">${totalProducts}</h3>
                <small class="text-muted">Cập nhật mới nhất</small>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="400">
            <div class="card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #ffd6e8; transition: transform 0.3s;">
                <i class="bi bi-bag fs-1" style="color: #ff69b4;"></i>
                <h5 class="fw-bold mt-2" style="color: #ff69b4;">Tổng Đơn Hàng</h5>
                <h3 class="fw-bold">${totalOrders}</h3>
                <small class="text-muted">Cập nhật mới nhất</small>
            </div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="row mb-5">
        <div class="col-md-6" data-aos="fade-right">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Doanh Thu Theo Tháng</h5>
                <canvas id="revenueChart" height="200"></canvas>
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
                        <c:forEach var="order" items="${recentOrders}">
                            <tr>
                                <td>#${order[0]}</td>
                                <td>${order[1]}</td>
                                <td><fmt:formatNumber value="${order[2]}" type="currency" currencySymbol="₫" groupingUsed="true" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order[3] == 'Completed'}">
                                            <span class="badge bg-success">Hoàn Thành</span>
                                        </c:when>
                                        <c:when test="${order[3] == 'Shipped'}">
                                            <span class="badge bg-warning">Đang Giao</span>
                                        </c:when>
                                        <c:when test="${order[3] == 'Pending'}">
                                            <span class="badge bg-secondary">Đang Chờ</span>
                                        </c:when>
                                        <c:when test="${order[3] == 'Cancelled'}">
                                            <span class="badge bg-danger">Đã Hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-info">${order[3]}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr>
                                <td colspan="4" class="text-center text-muted">Chưa có đơn hàng nào.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-6" data-aos="fade-up" data-aos-delay="200">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">User Mới Đăng Ký</h5>
                <ul class="list-group list-group-flush">
                    <c:forEach var="user" items="${newUsers}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            ${user[1]}
                            <span class="badge bg-primary rounded-pill">${user[2]}</span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty newUsers}">
                        <li class="list-group-item text-center text-muted">Chưa có người dùng mới.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Chart.js and AOS Scripts -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init();

    // Revenue Chart (Line)
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: [<c:forEach var="data" items="${revenueData}">'${data[0]}',</c:forEach>],
            datasets: [{
                label: 'Doanh Thu (triệu ₫)',
                data: [<c:forEach var="data" items="${revenueData}">${data[1] / 1000000},</c:forEach>],
                borderColor: '#ff69b4',
                backgroundColor: 'rgba(255, 105, 180, 0.2)',
                tension: 0.4
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Doanh Thu (triệu ₫)'
                    }
                }
            }
        }
    });

    // Top Products Chart (Bar)
    const topProductsCtx = document.getElementById('topProductsChart').getContext('2d');
    new Chart(topProductsCtx, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="product" items="${topProducts}">'${product[0]}',</c:forEach>],
            datasets: [{
                label: 'Số Lượng Bán',
                data: [<c:forEach var="product" items="${topProducts}">${product[1]},</c:forEach>],
                backgroundColor: ['#ff69b4', '#007bff', '#28a745', '#ff1493', '#6f42c1']
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Số Lượng'
                    }
                }
            }
        }
    });
</script>