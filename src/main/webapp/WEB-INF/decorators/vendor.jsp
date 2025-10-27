<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🌸 <sitemesh:write property="title" default="StarShop Vendor Dashboard" /> StarShop</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Custom Pastel Vendor Theme -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            overflow-x: hidden;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            background: linear-gradient(180deg, #ffeaf2, #fffbe7, #d8f3dc);
            padding: 30px 20px;
            box-shadow: 2px 0 15px rgba(0,0,0,0.05);
            z-index: 1000;
            transition: width 0.3s ease;
        }

        .sidebar h4 {
            font-family: 'Dancing Script', cursive;
            color: #ff69b4;
            text-align: center;
            font-size: 1.8rem;
            margin-bottom: 2rem;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: #007bff;
            padding: 12px 15px;
            border-radius: 12px;
            margin: 8px 0;
            text-decoration: none;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .sidebar a:hover {
            background-color: #ffd6e8;
            transform: translateX(8px);
            color: #ff1493;
        }

        .sidebar a.active {
            background-color: #ffd6e8;
            color: #ff1493;
            font-weight: 600;
        }

        /* Main content */
        .content {
            margin-left: 250px;
            padding: 20px 30px;
            min-height: 100vh;
            background-color: #fff;
            transition: margin-left 0.3s ease;
        }

        /* Topbar */
        .topbar {
            background: linear-gradient(90deg, #ffeaf2, #fffbe7, #d8f3dc);
            padding: 15px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card {
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            padding: 25px;
        }

        .btn-pink {
            background-color: #ff69b4;
            color: #fff;
            border: none;
        }
        .btn-pink:hover {
            background-color: #ff1493;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 30px 10px;
            }
            .sidebar h4, .sidebar a span {
                display: none;
            }
            .sidebar a {
                justify-content: center;
            }
            .content {
                margin-left: 80px;
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .content {
                margin-left: 0;
            }
            .topbar {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>

    <!-- Head bổ sung từ trang con -->
    <sitemesh:write property="head" />
</head>

<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h4>🌼 StarShop Vendor</h4>
        <a href="${pageContext.request.contextPath}/vendor/home"><i class="bi bi-house-door me-2"></i> <span>Trang chủ Shop</span></a>
        <a href="${pageContext.request.contextPath}/vendor/products"><i class="bi bi-box me-2"></i> <span>Quản lý sản phẩm</span></a>
        <a href="${pageContext.request.contextPath}/vendor/orders"><i class="bi bi-cart-check me-2"></i> <span>Quản lý đơn hàng</span></a>
        <a href="${pageContext.request.contextPath}/vendor/returns"><i class="bi bi-arrow-return-left me-2"></i> <span>Trả hàng & Hoàn tiền</span></a>
        <a href="${pageContext.request.contextPath}/vendor/promotions"><i class="bi bi-gift me-2"></i> <span>Khuyến mãi</span></a>
        <a href="${pageContext.request.contextPath}/vendor/revenue"><i class="bi bi-bar-chart me-2"></i> <span>Doanh thu</span></a>
        <a href="${pageContext.request.contextPath}/vendor/profile"><i class="bi bi-person-vcard me-2"></i> <span>Hồ sơ Shop</span></a>
        <a href="${pageContext.request.contextPath}/vendor/settings"><i class="bi bi-gear me-2"></i> <span>Cài đặt</span></a>
        <a href="${pageContext.request.contextPath}/auth/logout" class="text-danger"><i class="bi bi-box-arrow-right me-2"></i> <span>Đăng xuất</span></a>
    </div>

    <!-- Main content -->
    <div class="content">
        <!-- Topbar -->
        <div class="topbar">
            <h5 class="fw-bold mb-0"><sitemesh:write property="title" default="Bảng điều khiển shop" /></h5>
            <div class="d-flex align-items-center">
                <button class="btn btn-pink toggle-sidebar d-none me-3" onclick="toggleSidebar()">
                    <i class="bi bi-list"></i>
                </button>
                <span>Xin chào, ${vendor.shopName} 🌸</span>
            </div>
        </div>

        <!-- Nội dung trang con -->
        <sitemesh:write property="body" />
    </div>

    <!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

    <script>
        AOS.init({ duration: 800, once: true });

        // Toggle sidebar (mobile)
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }

        // Highlight active menu
        const currentPath = window.location.pathname;
        document.querySelectorAll('.sidebar a').forEach(item => {
            if (item.getAttribute('href') === currentPath) {
                item.classList.add('active');
            }
        });

        // Responsive text hide
        window.addEventListener('resize', () => {
            const spans = document.querySelectorAll('.sidebar a span');
            if (window.innerWidth <= 992) {
                spans.forEach(span => span.style.display = 'none');
            } else {
                spans.forEach(span => span.style.display = 'inline');
            }
        });
    </script>
</body>
</html>
