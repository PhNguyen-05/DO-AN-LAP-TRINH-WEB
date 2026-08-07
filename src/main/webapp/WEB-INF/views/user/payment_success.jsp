<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<sitemesh:page title="Đặt hàng thành công - StarShop">
<sitemesh:head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Dancing+Script:wght@600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { 
            background: linear-gradient(135deg, #fffafc, #e8faff); 
            font-family: 'Poppins', sans-serif; 
        }

        .success-container { 
            max-width: 700px; 
            margin: 80px auto; 
            background: #fff;
            border-radius: 20px; 
            padding: 50px 40px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        .success-header h3 {
            font-family: 'Dancing Script', cursive;
            font-size: 2.5rem;
            color: #ff69b4;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .success-header p {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .order-info {
            font-size: 1.1rem;
            margin-bottom: 40px;
            color: #555;
        }

        .btn-home {
            background: linear-gradient(135deg, #ff80b5, #ff69b4);
            border: none; 
            border-radius: 12px;
            color: white; 
            font-weight: 600;
            padding: 12px 30px;
            font-size: 1.1rem;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn-home:hover {
            background: linear-gradient(135deg, #ff69b4, #ff3385);
        }
    </style>
</sitemesh:head>

<div class="success-container">
    <div class="success-header">
        <h3>🎉 Thanh toán thành công!</h3>
        <p>${message}</p>
    </div>

    <div class="order-info">
        <p>Mã đơn hàng: <strong>#${orderId}</strong></p>
        <p>Chúng tôi đã ghi nhận đơn hàng của bạn. Vui lòng chờ xử lý hoặc nhận hàng nếu thanh toán COD.</p>
    </div>

    <a href="${pageContext.request.contextPath}/" class="btn-home">
        <i class="bi bi-house-door-fill"></i> Về trang chủ
    </a>
</div>
</sitemesh:page>
