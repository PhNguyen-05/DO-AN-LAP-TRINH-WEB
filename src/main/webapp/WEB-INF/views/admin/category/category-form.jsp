<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Danh Mục Hoa</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<form id="categoryForm" action="" method="post">
    <input type="hidden" id="id" name="id">
    <div class="mb-3">
        <label for="tenDanhMuc" class="form-label">Tên Danh Mục</label>
        <input type="text" class="form-control" id="tenDanhMuc" name="tenDanhMuc" required>
    </div>
    <div class="mb-3">
        <label for="moTa" class="form-label">Mô Tả</label>
        <textarea class="form-control" id="moTa" name="moTa" rows="3"></textarea>
    </div>
    <button type="submit" class="btn btn-success w-100">Lưu</button>
</form>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>