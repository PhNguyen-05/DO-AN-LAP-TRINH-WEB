<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="categoryForm" method="post" action="${pageContext.request.contextPath}/admin/categories/add">
    <input type="hidden" id="id" name="id" />

    <div class="mb-3">
        <label for="tenDanhMuc" class="form-label fw-bold">Tên Danh Mục</label>
        <input type="text" id="tenDanhMuc" name="tenDanhMuc" class="form-control" placeholder="Nhập tên danh mục" required>
    </div>

    <div class="mb-3">
        <label for="moTa" class="form-label fw-bold">Mô Tả</label>
        <textarea id="moTa" name="moTa" class="form-control" rows="3" placeholder="Nhập mô tả danh mục"></textarea>
    </div>

    <div class="text-end">
        <button type="submit" class="btn btn-success px-4">Lưu</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    </div>
</form>
