<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🌸 <sitemesh:write property="title" default="StarShop Admin Dashboard" />StarShop</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Custom Pastel Admin Theme -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            overflow-x: hidden;
        }

        /* Sidebar */
        .sidebar {
            width: 250px; /* Tăng chiều rộng để chứa text đầy đủ mà không bị cắt */
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            background: linear-gradient(180deg, #d7f3ff, #ffeaf2, #d8f3dc);
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
            white-space: nowrap;
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
            white-space: nowrap; /* Ngăn text xuống dòng */
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
            margin-left: 250px; /* Vừa khít với sidebar */
            padding: 20px 30px; /* Padding hợp lý để nội dung không chạm cạnh */
            min-height: 100vh;
            background-color: #fff;
            transition: margin-left 0.3s ease;
        }

        /* Topbar */
        .topbar {
            background: linear-gradient(90deg, #ffeaf2, #d7f3ff, #d8f3dc);
            padding: 15px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Card và Table để vừa khít */
        .card {
            width: 100%;
            border-radius: 16px;
            background: #fff;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            padding: 25px;
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 0.95rem;
        }

        .table th {
            background-color: #f8fafc;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
        }

        .table td {
            vertical-align: middle;
            border-top: 1px solid #eee;
        }

        /* Hover effects */
        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 25px rgba(255,105,180,0.25) !important;
            transition: all 0.3s ease;
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

        /* Custom button */
        .btn-pink {
            background-color: #ff69b4;
            color: #fff;
            border: none;
        }
        .btn-pink:hover {
            background-color: #ff1493;
        }
    </style>

    <!-- Head bổ sung từ trang con -->
    <sitemesh:write property="head" />
</head>

<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h4>🌸 StarShop Admin</h4>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i> <span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/admin/vendors"><i class="bi bi-shop me-2"></i> <span>Quản Lý Shop</span></a>
        <a href="${pageContext.request.contextPath}/admin/customers"><i class="bi bi-person-circle me-2"></i> <span>Quản Lý Khách Hàng</span></a>
        <a href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-basket me-2"></i> <span>Quản Lý Sản Phẩm</span></a>
        <a href="${pageContext.request.contextPath}/admin/categories"><i class="bi bi-tags me-2"></i> <span>Quản Lý Danh Mục</span></a>
        <a href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-receipt me-2"></i> <span>Quản Lý Đơn Hàng</span></a>
        <a href="${pageContext.request.contextPath}/admin/inventory"><i class="bi bi-boxes me-2"></i> <span>Quản Lý Tồn Kho</span></a>
        <a href="${pageContext.request.contextPath}/admin/promotions"><i class="bi bi-percent me-2"></i> <span>Quản Lý Khuyến Mãi</span></a>
        <a href="${pageContext.request.contextPath}/admin/reviews"><i class="bi bi-chat-left-text me-2"></i> <span>Quản Lý Đánh Giá</span></a>
        <a href="${pageContext.request.contextPath}/admin/shippers"><i class="bi bi-truck me-2"></i> <span>Quản Lý Vận Chuyển</span></a>
        <a href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> <span>Đăng Xuất</span></a>

    </div>

    <!-- Main content -->
    <div class="content">
        <!-- Topbar -->
        <div class="topbar">
            <h5 class="fw-bold mb-0">
                <sitemesh:write property="title" default="Bảng Điều Khiển" />
            </h5>
            <div class="d-flex align-items-center">
                <button class="btn btn-pink toggle-sidebar d-none me-3" onclick="toggleSidebar()">
                    <i class="bi bi-list"></i>
                </button>
                <span>Xin chào, Admin 🌼</span>
            </div>
        </div>

        <!-- Nội dung chính -->
        <sitemesh:write property="body" />
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });

        // Toggle sidebar for mobile
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }

        // Highlight active menu item
        const currentPath = window.location.pathname;
        const menuItems = document.querySelectorAll('.sidebar a');
        menuItems.forEach(item => {
            if (item.getAttribute('href') === currentPath) {
                item.classList.add('active');
            }
        });

        // Responsive sidebar text hiding
        window.addEventListener('resize', () => {
            if (window.innerWidth <= 992) {
                document.querySelectorAll('.sidebar a span').forEach(span => span.style.display = 'none');
            } else {
                document.querySelectorAll('.sidebar a span').forEach(span => span.style.display = 'inline');
            }
        });
    </script>
</body>
</html>