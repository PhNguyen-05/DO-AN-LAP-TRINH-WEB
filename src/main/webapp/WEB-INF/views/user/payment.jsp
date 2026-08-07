<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<sitemesh:page title="Thanh toán - StarShop">
<sitemesh:head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Dancing+Script:wght@600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #fffafc, #e8faff); font-family: 'Poppins', sans-serif; }

        .payment-container { 
            max-width: 800px; margin: 50px auto; background: #fff;
            border-radius: 20px; padding: 40px 50px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .payment-header {
            text-align: center; margin-bottom: 30px;
        }

        .payment-header h3 {
            font-family: 'Dancing Script', cursive;
            font-size: 2.2rem;
            color: #ff69b4;
            font-weight: 700;
        }

        .payment-header p {
            color: #6c757d;
        }

        label { font-weight: 600; color: #555; }
        select, input[type="text"], textarea {
            width: 100%; padding: 12px 15px; border-radius: 12px;
            border: 1px solid #ddd; transition: 0.3s;
        }

        select:focus, input:focus, textarea:focus {
            border-color: #ff69b4; outline: none;
            box-shadow: 0 0 5px rgba(255,105,180,0.3);
        }

        .form-group { margin-bottom: 25px; }

        .btn-confirm {
            background: linear-gradient(135deg, #ff80b5, #ff69b4);
            border: none; border-radius: 12px;
            color: white; font-weight: 600;
            padding: 12px 25px; width: 100%;
            transition: 0.3s;
        }

        .btn-confirm:hover {
            background: linear-gradient(135deg, #ff69b4, #ff3385);
        }

        .qr-container {
            display: none;
            text-align: center;
            margin-top: 25px;
            animation: fadeIn 0.5s ease-in-out;
        }

        .qr-container img {
            width: 220px; height: 220px;
            border-radius: 10px;
            border: 3px solid #ffb6c1;
            padding: 10px;
            background-color: #fff0f6;
        }

        .qr-container p {
            margin-top: 10px;
            color: #555;
            font-weight: 500;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</sitemesh:head>

<div class="payment-container">
    <div class="payment-header">
        <h3>💖 Thanh toán đơn hàng</h3>
        <p>Vui lòng chọn phương thức thanh toán của bạn</p>
    </div>

    <form action="${pageContext.request.contextPath}/user/payment/confirm" method="post">
        <input type="hidden" name="orderId" value="${order.id}" />

        <div class="form-group">
            <label for="method">Phương thức thanh toán</label>
            <select id="method" name="method" class="form-select" required onchange="toggleQR()">
                <option value="">-- Chọn phương thức --</option>
                <option value="COD">💵 Thanh toán khi nhận hàng (COD)</option>
                <option value="BANK">🏦 Chuyển khoản ngân hàng</option>
                <option value="MOMO">📱 Ví điện tử MoMo</option>
            </select>
        </div>

        <!-- QR hiển thị động -->
        <div id="qrSection" class="qr-container">
            <img id="qrImage" src="" alt="QR Code thanh toán">
            <p id="qrText"></p>
        </div>

        <button type="submit" class="btn-confirm">
            <i class="bi bi-wallet2"></i> Xác nhận thanh toán
        </button>
    </form>
</div>

<script>

function toggleQR() {
    const method = document.getElementById('method').value;
    const qrSection = document.getElementById('qrSection');
    const qrImage = document.getElementById('qrImage');
    const qrText = document.getElementById('qrText');

    // Lấy context path của project
    const contextPath = '<c:url value="/" />';

    if (method === 'BANK') {
        qrSection.style.display = 'block';
        qrImage.src = contextPath + 'images/qr_bank1.png';  // sửa lại đúng file png
        qrText.textContent = 'Vui lòng quét mã QR để chuyển khoản ngân hàng.';
    } else if (method === 'MOMO') {
        qrSection.style.display = 'block';
        qrImage.src = contextPath + 'images/qr_momo.webp'; // sửa lại đúng file webp
        qrText.textContent = 'Quét mã QR MoMo để thanh toán.';
    } else {
        qrSection.style.display = 'none';
    }
}

</script>




</script>

</sitemesh:page>
