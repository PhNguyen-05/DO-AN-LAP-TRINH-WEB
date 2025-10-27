<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP đặt lại mật khẩu - StarShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc);
            font-family: 'Poppins', sans-serif;
            height: 100vh;
        }
        .otp-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 450px;
            width: 100%;
        }
        .otp-header {
            font-family: 'Dancing Script', cursive;
            font-size: 2.3rem;
            color: #ff69b4;
        }
        .btn-verify {
            background: linear-gradient(45deg, #ffb6c1, #87cefa);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-verify:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #ff69b4, #00bfff);
        }
        a.text-pink {
            color: #ff69b4;
            text-decoration: none;
        }
        a.text-pink:hover {
            text-decoration: underline;
        }
        .otp-input {
            letter-spacing: 8px;
            text-align: center;
            font-size: 1.4rem;
            font-weight: bold;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center">
    <div class="otp-card text-center">
        <h2 class="otp-header mb-3">🔑 Xác minh OTP đặt lại mật khẩu</h2>
        <p class="text-muted mb-4">Nhập mã OTP đã được gửi đến email của bạn để tiếp tục đặt lại mật khẩu.</p>

        <!-- Thông báo -->
        <c:if test="${not empty message}">
            <div class="alert alert-danger py-2">${message}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success py-2">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/verify-reset-otp" method="post">
            <div class="form-floating mb-3">
                <input type="text" maxlength="6" class="form-control otp-input" id="otp" name="otp" placeholder="Mã OTP" required>
                <label for="otp"><i class="bi bi-key-fill me-2"></i>Mã OTP (6 số)</label>
            </div>

            <button type="submit" class="btn btn-verify w-100 py-2 fw-semibold">
                <i class="bi bi-check-circle-fill me-2"></i>Xác minh OTP
            </button>
        </form>

        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/auth/forgot-password" class="text-pink fw-semibold">
                🔄 Gửi lại mã OTP
            </a><br>
            <a href="${pageContext.request.contextPath}/auth/login" class="text-pink fw-semibold mt-2 d-inline-block">
                <i class="bi bi-box-arrow-in-right me-1"></i>Quay lại đăng nhập
            </a>
        </div>
    </div>
</body>
</html>
