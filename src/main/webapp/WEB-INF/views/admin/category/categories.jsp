<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Danh Mục Hoa</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container py-4">
    <h2 class="fw-bold mb-4" style="color: #ff69b4;">Quản Lý Danh Mục Hoa</h2>

    <!-- Table List -->
    <div class="card shadow-lg rounded-4 mb-4">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Danh Mục</th>
                        <th>Mô Tả</th>
                        <th>Ngày Tạo</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${categories}">
                        <tr>
                            <td>${category.id}</td>
                            <td>${category.tenDanhMuc}</td>
                            <td>${category.moTa}</td>
                            <td>${category.ngayTao}</td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#categoryModal" onclick="editCategory(${category.id}, '${category.tenDanhMuc}', '${category.moTa}')">Sửa</button>
                                <a href="${pageContext.request.contextPath}/admin/categories/delete/${category.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Button Add -->
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#categoryModal" onclick="resetForm()">Thêm Danh Mục Mới</button>
</div>

<!-- Modal Form -->
<div class="modal fade" id="categoryModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Form Danh Mục</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <%@ include file="/category-form.jsp" %> <!-- Adjust path if category-form.jsp is in same folder or adjust accordingly -->
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function resetForm() {
        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/categories/add';
        document.getElementById('id').value = '';
        document.getElementById('tenDanhMuc').value = '';
        document.getElementById('moTa').value = '';
    }

    function editCategory(id, tenDanhMuc, moTa) {
        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/categories/edit/' + id;
        document.getElementById('id').value = id;
        document.getElementById('tenDanhMuc').value = tenDanhMuc;
        document.getElementById('moTa').value = moTa;
    }
</script>

</body>
</html>