<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - StarShop</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .register-title {
            font-family: 'Dancing Script', cursive;
            font-size: 2.5rem;
            color: #ff69b4;
        }
        .btn-register {
            background: linear-gradient(45deg, #ffb6c1, #87cefa);
            border: none;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-register:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #ff69b4, #00bfff);
        }
        .form-floating label i {
            color: #ff69b4;
        }
        .link-login {
            color: #ff69b4;
            font-weight: 600;
            text-decoration: none;
        }
        .link-login:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center">

    <div class="card p-4" style="max-width: 480px; width: 100%;">
        <div class="text-center mb-4">
            <h2 class="register-title">🌸 StarShop</h2>
            <p class="text-muted">Tạo tài khoản mới của bạn</p>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty message}">
            <div class="alert alert-danger py-2 text-center">${message}</div>
        </c:if>

        <!-- Form đăng ký -->
        <form action="${pageContext.request.contextPath}/auth/register" method="post">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="fullname" name="fullName" placeholder="Họ tên" required>
                <label for="fullname"><i class="bi bi-person-fill me-2"></i>Họ tên</label>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                <label for="email"><i class="bi bi-envelope-fill me-2"></i>Email</label>
            </div>

            <div class="form-floating mb-3">
                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" pattern="[0-9]{9,11}" required>
                <label for="phone"><i class="bi bi-telephone-fill me-2"></i>Số điện thoại</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="password" name="passwordHash" placeholder="Mật khẩu" required minlength="6">
                <label for="password"><i class="bi bi-lock-fill me-2"></i>Mật khẩu</label>
            </div>

            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="confirmPassword" placeholder="Xác nhận mật khẩu" required minlength="6">
                <label for="confirmPassword"><i class="bi bi-lock-fill me-2"></i>Xác nhận mật khẩu</label>
            </div>

            <button type="submit" class="btn btn-register w-100 py-2 fw-semibold">
                <i class="bi bi-person-plus me-2"></i>Đăng ký ngay
            </button>
        </form>

        <div class="text-center mt-4">
            <p class="text-muted small mb-1">Đã có tài khoản?</p>
            <a href="${pageContext.request.contextPath}/auth/login" class="link-login">
                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập ngay
            </a>
        </div>
    </div>

    <!-- Kiểm tra mật khẩu -->
    <script>
        document.querySelector("form").addEventListener("submit", function(e) {
            const pw = document.getElementById("password").value;
            const pw2 = document.getElementById("confirmPassword").value;
            if (pw !== pw2) {
                e.preventDefault();
                alert("⚠️ Mật khẩu xác nhận không khớp!");
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
