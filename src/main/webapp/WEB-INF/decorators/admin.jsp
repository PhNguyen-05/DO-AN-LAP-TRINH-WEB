<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="StarShop Admin" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="StarShop - Nền tảng quản trị hệ thống bán hoa trực tuyến.">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">

    <!-- AOS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <!-- Owl Carousel -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

    <!-- Custom Pastel Admin Theme -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fdfdfd;
            color: #333;
            scroll-behavior: smooth;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            position: fixed;
            top: 0; left: 0;
            height: 100vh;
            background: linear-gradient(180deg, #d7f3ff, #ffeaf2, #d8f3dc);
            padding-top: 30px;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.05);
            z-index: 1000;
        }

        .sidebar h4 {
            font-family: 'Dancing Script', cursive;
            color: #ff69b4;
            font-size: 1.8rem;
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
            transform: translateX(8px) scale(1.05);
            color: #ff1493;
        }

        /* Content area */
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
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        /* Card & Button hover */
        .card:hover {
            transform: scale(1.05) rotate(1deg);
            box-shadow: 0 10px 25px rgba(255, 105, 180, 0.3) !important;
        }

        .btn:hover {
            transform: translateY(-3px) scale(1.05);
        }

        /* Owl Carousel button */
        .owl-nav button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: #ffd6e8 !important;
            color: #ff69b4 !important;
            border-radius: 50% !important;
        }
        .owl-prev { left: -20px; }
        .owl-next { right: -20px; }
    </style>

    <decorator:head />
</head>

<body>

    <!-- Sidebar Admin -->
    <div class="sidebar">
        <h4 class="text-center mb-4">🌸 StarShop Admin</h4>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people me-2"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin/vendors"><i class="bi bi-shop me-2"></i> Quản lý Shop</a>
        <a href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-basket me-2"></i> Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/categories"><i class="bi bi-tags me-2"></i> Danh mục</a>
        <a href="${pageContext.request.contextPath}/admin/promotions"><i class="bi bi-percent me-2"></i> Khuyến mãi</a>
        <a href="${pageContext.request.contextPath}/admin/shippers"><i class="bi bi-truck me-2"></i> Vận chuyển</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
    </div>

    <!-- Header -->
    <%@ include file="/common/header.jsp" %>

    <!-- Main Content -->
    <div class="content">
        <div class="topbar d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0">
                <decorator:title default="Bảng điều khiển" />
            </h5>
            <span>Xin chào, Admin 🌼</span>
        </div>

        <decorator:body />
    </div>

    <!-- Footer -->
    <%@ include file="/common/footer.jsp" %>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });
    </script>

</body>
</html>
