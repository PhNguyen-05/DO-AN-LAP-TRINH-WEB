<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-lg rounded-4 border-0" style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <h2 class="fw-bold" style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌸 Doanh Thu Cửa Hàng</h2>
                    <button class="btn btn-pink" onclick="exportRevenue()">Xuất Báo Cáo</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
            <div class="card shadow-lg rounded-4 border-0 text-center p-4 hover-scale" style="background-color: #d7f3ff; transition: transform 0.3s, box-shadow 0.3s;">
                <i class="bi bi-currency-dollar fs-1 mb-3" style="color: #007bff;"></i>
                <h5 class="fw-bold" style="color: #007bff;">Tổng Doanh Thu</h5>
                <h3 class="fw-bold"><fmt:formatNumber value="${revenueData.totalRevenue}" type="currency" currencySymbol="$" groupingUsed="true" /></h3>
            </div>
        </div>
        <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
            <div class="card shadow-lg rounded-4 border-0 text-center p-4 hover-scale" style="background-color: #ffeaf2; transition: transform 0.3s, box-shadow 0.3s;">
                <i class="bi bi-graph-up fs-1 mb-3" style="color: #ff1493;"></i>
                <h5 class="fw-bold" style="color: #ff1493;">Doanh Thu Tháng Này</h5>
                <h3 class="fw-bold"><fmt:formatNumber value="${revenueData.monthlyRevenue}" type="currency" currencySymbol="$" groupingUsed="true" /></h3>
            </div>
        </div>
        <div class="col-md-4" data-aos="zoom-in" data-aos-delay="300">
            <div class="card shadow-lg rounded-4 border-0 text-center p-4 hover-scale" style="background-color: #d8f3dc; transition: transform 0.3s, box-shadow 0.3s;">
                <i class="bi bi-check-circle fs-1 mb-3" style="color: #28a745;"></i>
                <h5 class="fw-bold" style="color: #28a745;">Đơn Hàng Thành Công</h5>
                <h3 class="fw-bold">${revenueData.successfulOrders}</h3>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12" data-aos="fade-right">
            <div class="card shadow-lg rounded-4 border-0 p-4" style="background-color: #fff; border-left: 5px solid #ff69b4;">
                <h5 class="fw-bold mb-3" style="color: #ff69b4;">Doanh Thu Theo Tháng</h5>
                <canvas id="revenueChart" height="300"></canvas>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: [<c:forEach var="month" items="${revenueData.months}">'${month}',</c:forEach>],
            datasets: [{
                label: 'Doanh Thu (triệu $)',
                data: [<c:forEach var="revenue" items="${revenueData.revenues}">${revenue / 1000000},</c:forEach>],
                borderColor: '#ff69b4',
                backgroundColor: 'rgba(255, 105, 180, 0.2)',
                tension: 0.4,
                pointBackgroundColor: '#ff69b4',
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: '#ff69b4'
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    title: { display: true, text: 'Doanh Thu (triệu $)' }
                }
            },
            plugins: { legend: { display: true, position: 'top' } }
        }
    });

    function exportRevenue() {
        alert('Tính năng xuất báo cáo đang phát triển.');
    }
</script>