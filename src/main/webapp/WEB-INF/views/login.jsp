<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - StarShop</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc);
            font-family: 'Poppins', sans-serif;
            height: 100vh;
        }
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 450px;
            width: 100%;
        }
        .login-header {
            font-family: 'Dancing Script', cursive;
            font-size: 2.5rem;
            color: #ff69b4;
        }
        .btn-login {
            background: linear-gradient(45deg, #ffb6c1, #87cefa);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-login:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #ff69b4, #00bfff);
        }
        .form-check-input:checked {
            background-color: #ff69b4;
            border-color: #ff69b4;
        }
        a.text-pink {
            color: #ff69b4;
            text-decoration: none;
        }
        a.text-pink:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center">

    <div class="login-card text-center">
        <h2 class="login-header mb-3">🌸 StarShop</h2>
        <div class="welcome-text mb-4">
            <p class="fw-light mb-1" style="font-size: 1.05rem; color: #6c757d;">
                🌷 <span style="color:#ff69b4; font-weight:600;">Chào mừng bạn quay lại!</span>
            </p>
            <p class="text-muted" style="font-size: 0.95rem;">
                Hãy đăng nhập để tiếp tục mua sắm cùng <span style="color:#ff69b4;">StarShop</span> 💖
            </p>
        </div>

        <!-- Hiển thị thông báo -->
        <c:if test="${param.error != null}">
            <div class="alert alert-danger py-2 mb-3">❌ Sai thông tin đăng nhập!</div>
        </c:if>
        <c:if test="${param.logout != null}">
            <div class="alert alert-success py-2 mb-3">✅ Đăng xuất thành công!</div>
        </c:if>
        <c:if test="${param.registered != null}">
            <div class="alert alert-success py-2 mb-3">🎉 Đăng ký thành công! Hãy đăng nhập.</div>
        </c:if>

        <!-- Form đăng nhập -->
        <form action="${pageContext.request.contextPath}/auth/login" method="post">
            <!-- Nếu bật CSRF trong production thì thêm token -->
            <c:if test="${not empty _csrf}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </c:if>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="identifier" name="identifier"
                       placeholder="Email hoặc số điện thoại" required>
                <label for="identifier"><i class="bi bi-person-fill me-2"></i>Email hoặc số điện thoại</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="Mật khẩu" required>
                <label for="password"><i class="bi bi-lock-fill me-2"></i>Mật khẩu</label>
            </div>

            <!-- Ghi nhớ mật khẩu + Quên mật khẩu -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me">
                    <label class="form-check-label small text-muted" for="rememberMe">
                        Ghi nhớ đăng nhập
                    </label>
                </div>
                <a href="${pageContext.request.contextPath}/auth/forgot-password" class="small text-pink">
                    Quên mật khẩu?
                </a>
            </div>

            <button type="submit" class="btn btn-login w-100 py-2 fw-semibold">
                <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
            </button>
        </form>

        <!-- Liên kết đăng ký -->
        <div class="mt-4">
            <p class="text-muted small mb-1">Chưa có tài khoản?</p>
            <a href="${pageContext.request.contextPath}/auth/register" class="text-pink fw-semibold">
                <i class="bi bi-person-plus me-1"></i>Đăng ký ngay
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
