<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>🌸 <sitemesh:write property="title" default="StarShop Admin Dashboard" /> StarShop</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- AOS animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <!-- Custom Pastel Admin Theme -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fdfdfd;
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
            background: linear-gradient(180deg, #d7f3ff, #ffeaf2, #d8f3dc);
            padding-top: 30px;
            box-shadow: 2px 0 15px rgba(0,0,0,0.05);
            z-index: 1000;
        }

        .sidebar h4 {
            font-family: 'Dancing Script', cursive;
            color: #ff69b4;
            text-align: center;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: #007bff;
            padding: 12px 20px;
            border-radius: 12px;
            margin: 8px 15px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #ffd6e8;
            transform: translateX(8px);
            color: #ff1493;
        }

        /* Main content */
        .content {
            margin-left: 260px;
            padding: 40px;
            background-color: #fff;
            min-height: 100vh;
        }

        /* Topbar */
        .topbar {
            background: linear-gradient(90deg, #ffeaf2, #d7f3ff, #d8f3dc);
            padding: 15px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .card:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 25px rgba(255,105,180,0.25) !important;
        }
    </style>

    <!-- Head bổ sung từ trang con -->
    <sitemesh:write property="head" />
</head>

<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h4>🌸 StarShop Admin</h4>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people me-2"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin/vendors"><i class="bi bi-shop me-2"></i> Quản lý Shop</a>
        <a href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-basket me-2"></i> Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/categories"><i class="bi bi-tags me-2"></i> Danh mục</a>
        <a href="${pageContext.request.contextPath}/admin/promotions"><i class="bi bi-percent me-2"></i> Khuyến mãi</a>
        <a href="${pageContext.request.contextPath}/admin/shippers"><i class="bi bi-truck me-2"></i> Vận chuyển</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
    </div>

    <!-- Main content -->
    <div class="content">
        <!-- Topbar -->
        <div class="topbar d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0">
                <sitemesh:write property="title" default="Bảng điều khiển" />
            </h5>
            <span>Xin chào, Admin 🌼</span>
        </div>

        <!-- Nội dung chính -->
        <sitemesh:write property="body" />
    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });
    </script>
</body>
</html>
