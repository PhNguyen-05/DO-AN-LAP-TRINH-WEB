<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form id="categoryForm" method="post" action="${pageContext.request.contextPath}/admin/categories/add">
    <input type="hidden" id="id" name="id" />

    <div class="mb-3">
        <label for="name" class="form-label fw-bold">Tên Danh Mục <span class="text-danger">*</span></label>
        <input type="text" id="name" name="name" class="form-control" placeholder="Nhập tên danh mục" required>
    </div>

    <div class="mb-3">
        <label for="description" class="form-label fw-bold">Mô Tả</label>
        <textarea id="description" name="description" class="form-control" rows="3" placeholder="Nhập mô tả danh mục"></textarea>
    </div>

    <div class="text-end">
        <button type="submit" class="btn btn-success px-4">Lưu</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    </div>
</form>