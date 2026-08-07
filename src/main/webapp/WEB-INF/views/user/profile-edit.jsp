<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chỉnh sửa hồ sơ | StarShop</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
body {
	background-color: #fff;
}

.text-pink {
	color: #ff1493;
}

.btn-pink {
	background-color: #ffd6e8;
	color: #ff1493;
}

.btn-pink:hover {
	background-color: #ffb6d9;
	color: #fff;
}
</style>
</head>
<body>

	<!-- Header dùng chung -->
	<%@ include file="/common/header.jsp"%>

	<!-- Nội dung chính -->
	<div class="container py-5" style="max-width: 800px;">
		<div class="card shadow-sm rounded-4"
			style="background-color: #fff0f6;">
			<div class="card-body p-5">

				<h3 class="text-center fw-bold text-pink mb-4">Chỉnh sửa thông
					tin cá nhân</h3>

				<!-- Form cập nhật hồ sơ -->
				<form
					action="${pageContext.request.contextPath}/user/profile/update"
					method="post">

					<!-- Họ và tên -->
					<div class="mb-3">
						<label for="fullName" class="form-label fw-semibold">Họ và
							tên</label> <input type="text" class="form-control" id="fullName"
							name="fullName" value="<c:out value='${customer.fullName}'/>"
							required>
					</div>

					<!-- Số điện thoại -->
					<div class="mb-3">
						<label for="phone" class="form-label fw-semibold">Số điện
							thoại</label> <input type="text" class="form-control" id="phone"
							name="phone" value="<c:out value='${customer.phone}'/>">
					</div>

					<!-- Địa chỉ -->
					<div class="mb-3">
						<label for="defaultAddress" class="form-label fw-semibold">Địa
							chỉ mặc định</label>
						<textarea class="form-control" id="defaultAddress" name="defaultAddress" rows="3"><c:out value='${customer.defaultAddress}'/></textarea>
					</div>

					<!-- Nút hành động -->
					<div class="text-center mt-4">
						<button type="submit"
							class="btn btn-pink rounded-pill px-4 py-2 shadow-sm">
							<i class="bi bi-check-circle me-2"></i> Lưu thay đổi
						</button>
						<a href="${pageContext.request.contextPath}/user/profile"
							class="btn btn-secondary rounded-pill px-4 py-2 ms-2"> <i
							class="bi bi-x-circle me-2"></i> Hủy
						</a>
					</div>

				</form>

			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
