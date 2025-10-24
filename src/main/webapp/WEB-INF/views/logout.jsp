<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng xuất - StarShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc);
            font-family: 'Poppins', sans-serif;
            height: 100vh;
        }
        .logout-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 450px;
            width: 100%;
            text-align: center;
        }
        .btn-logout {
            background: linear-gradient(45deg, #ffb6c1, #87cefa);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-logout:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #ff69b4, #00bfff);
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center">
    <div class="logout-card">
        <h2 class="mb-3">🌸 StarShop</h2>

        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <p class="mb-4">Xin chào, <strong>${sessionScope.currentUser.email}</strong></p>
                
                <!-- Form logout -->
                <form action="${pageContext.request.contextPath}/auth/logout" method="get">
                    <button type="submit" class="btn btn-logout w-100 py-2 fw-semibold">
                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <p class="text-muted mb-3">Bạn chưa đăng nhập!</p>
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-login w-100 py-2 fw-semibold">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
