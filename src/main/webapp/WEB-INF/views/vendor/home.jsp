<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
.hover-card {
    transition: transform 0.3s, box-shadow 0.3s;
}

.hover-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
}
</style>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-lg rounded-4 border-0" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                <div class="card-body p-4 text-center">
                    <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌟 Chào Mừng Trở Lại, ${vendor.shopName}!</h2>
                    <p class="text-muted lead">Hôm nay là ngày tuyệt vời để quản lý StarShop 💐. Khám phá tổng quan dưới đây.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Stats Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="100">
            <div class="card hover-card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #d8f3dc; transition: transform 0.3s;">
                <i class="bi bi-basket fs-1" style="color: #28a745;"></i>
                <h5 class="fw-bold mt-2" style="color: #28a745;">Sản Phẩm Đang Bán</h5>
                <h3 class="fw-bold">${productCount}</h3>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="200">
            <div class="card hover-card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #ffeaf2; transition: transform 0.3s;">
                <i class="bi bi-cart-check fs-1" style="color: #ff1493;"></i>
                <h5 class="fw-bold mt-2" style="color: #ff1493;">Đơn Hàng Tháng Này</h5>
                <h3 class="fw-bold">${orderCount}</h3>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="300">
            <div class="card hover-card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #d7f3ff; transition: transform 0.3s;">
                <i class="bi bi-currency-dollar fs-1" style="color: #007bff;"></i>
                <h5 class="fw-bold mt-2" style="color: #007bff;">Doanh Thu Tháng Này</h5>
                <h3 class="fw-bold"><fmt:formatNumber value="${monthlyRevenue}" type="number" groupingUsed="true" /> ₫</h3>
            </div>
        </div>
        <div class="col-md-3" data-aos="zoom-in" data-aos-delay="400">
            <div class="card hover-card shadow-lg rounded-4 border-0 text-center p-3" style="background-color: #ffd6e8; transition: transform 0.3s;">
                <i class="bi bi-gift fs-1" style="color: #ff69b4;"></i>
                <h5 class="fw-bold mt-2" style="color: #ff69b4;">Khuyến Mãi Hiện Tại</h5>
                <h3 class="fw-bold">${promotionCount}</h3>
            </div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="row mb-5">
        <div class="col-md-6" data-aos="fade-right">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Doanh Thu Theo Tháng (6 Tháng Gần Nhất)</h5>
                <canvas id="revenueChart" height="200"></canvas>
            </div>
        </div>
        <div class="col-md-6" data-aos="fade-left">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Sản Phẩm Bán Chạy Nhất</h5>
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
                            <th>Ngày Đặt</th>
                            <th>Tổng Tiền</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${recentOrders}">
                            <tr>
                                <td>#${order.id}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> ₫</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'Completed'}">
                                            <span class="badge bg-success">Hoàn Thành</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Shipped'}">
                                            <span class="badge bg-warning text-dark">Đang Giao</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Pending'}">
                                            <span class="badge bg-secondary">Chờ Xử Lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Cancelled'}">
                                            <span class="badge bg-danger">Đã Hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-info">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr>
                                <td colspan="4" class="text-center text-muted">Chưa có đơn hàng.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-6" data-aos="fade-up" data-aos-delay="200">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Khuyến Mãi Gần Đây</h5>
                <ul class="list-group list-group-flush">
                    <c:forEach var="promotion" items="${recentPromotions}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            ${promotion.promotionName}
                            <span class="badge bg-primary rounded-pill">
                                <fmt:formatDate value="${promotion.startDateAsDate}" pattern="yyyy-MM-dd" />

                            </span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty recentPromotions}">
                        <li class="list-group-item text-center text-muted">Chưa có khuyến mãi mới.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init();

    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: [<c:forEach var="month" items="${months}">'${month}',</c:forEach>],
            datasets: [{
                label: 'Doanh Thu (₫)',
                data: [<c:forEach var="revenue" items="${revenues}">${revenue},</c:forEach>],
                borderColor: '#ff69b4',
                backgroundColor: 'rgba(255, 105, 180, 0.2)',
                tension: 0.4,
                pointBackgroundColor: '#ff69b4',
                pointHoverBorderColor: '#ff69b4'
            }]
        },
        options: {
            scales: { y: { beginAtZero: true } },
            plugins: { legend: { display: true, position: 'top' } }
        }
    });

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
            scales: { y: { beginAtZero: true } },
            plugins: { legend: { display: true, position: 'top' } }
        }
    });
</script>