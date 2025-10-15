<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">

<!-- Title: nếu trang con có <title> thì sẽ thay vào đây, còn không dùng default -->
<title>🌸 <sitemesh:write property="title"
		default="StarShop - Hoa tươi mỗi ngày" /> StarShop
</title>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;500;600;700&display=swap" rel="stylesheet">
<!-- CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Phần head bổ sung từ trang con (css/js meta cụ thể) -->
<sitemesh:write property="head" />
</head>
<decorator:head />
</head>
<body>
	<%@ include file="/common/header.jsp"%>
	<main class="container-fluid my-4">
		<div class="row mt-4">
			<div class="col mb-5">
				<sitemesh:write property="body" />
			</div>
		</div>
	</main>
	<%@ include file="/common/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>