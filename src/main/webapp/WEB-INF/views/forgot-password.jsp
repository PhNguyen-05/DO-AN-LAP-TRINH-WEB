<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - StarShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #ffeaf2, #d7f3ff, #d8f3dc);
            font-family: 'Poppins', sans-serif;
            height: 100vh;
        }
        .forgot-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 450px;
            width: 100%;
        }
        .forgot-header {
            font-family: 'Dancing Script', cursive;
            font-size: 2.3rem;
            color: #ff69b4;
        }
        .btn-send {
            background: linear-gradient(45deg, #ffb6c1, #87cefa);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-send:hover {
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
    </style>
</head>
<body class="d-flex align-items-center justify-content-center">
    <div class="forgot-card text-center">
        <h2 class="forgot-header mb-3">💌 Quên mật khẩu</h2>
        <p class="text-muted mb-4">Nhập email bạn đã đăng ký để nhận liên kết đặt lại mật khẩu.</p>

        <!-- Thông báo lỗi hoặc thành công -->
        <c:if test="${not empty message}">
            <div class="alert alert-danger py-2">${message}</div>
        </c:if>
       <!-- Thông báo thành công + đếm ngược -->
        <c:if test="${not empty success}">
            <div class="alert alert-success border-0 shadow-sm py-3 px-3 mt-2" 
         style="background: linear-gradient(90deg, #d4f8e8, #e0f7fa); 
                border-radius: 15px; 
                color: #2e7d32; 
                font-size: 0.95rem; 
                text-align: center; 
                font-family: 'Poppins', sans-serif;">
        ${success}<br>
        <span style="white-space: nowrap; color:#2e7d32; font-weight: 500;">
                <span>⏰ Liên kết sẽ hết hạn trong: <span id="countdown"></span></span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/forgot-password" method="post">
            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" required>
                <label for="email"><i class="bi bi-envelope-fill me-2"></i>Email đăng ký</label>
            </div>

            <button type="submit" class="btn btn-send w-100 py-2 fw-semibold">
                <i class="bi bi-send-fill me-2"></i>Gửi liên kết đặt lại
            </button>
        </form>

        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/auth/login" class="text-pink fw-semibold">
                <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
            </a>
        </div>
    </div>
    
    <c:if test="${not empty expireSeconds}">
        <script>
            var timeLeft = ${expireSeconds};
            var countdownEl = document.getElementById("countdown");

            function updateCountdown() {
                var minutes = Math.floor(timeLeft / 60);
                var seconds = timeLeft % 60;
                countdownEl.textContent = minutes + " phút " + seconds + " giây";
                if (timeLeft > 0) {
                    timeLeft--;
                } else {
                    countdownEl.textContent = "⏳ Liên kết đã hết hạn!";
                }
            }

            updateCountdown();
            setInterval(updateCountdown, 1000);
        </script>
    </c:if>
</body>
</html>
