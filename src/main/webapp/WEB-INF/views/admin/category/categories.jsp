<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.ZoneId" %>

<style>
    body { 
        background: linear-gradient(to bottom, #fff0f5, #ffffff); 
        font-family: 'Segoe UI', sans-serif; 
        color: #333; 
    }
    .page-title { color: #ff69b4; font-weight: 600; }
    .btn-pink { 
        background-color: #ff69b4; 
        border: none; 
        color: white; 
        transition: background-color 0.3s; 
    }
    .btn-pink:hover { background-color: #ff1493; }
    .card { 
        border: none; 
        box-shadow: 0 2px 10px rgba(255, 105, 180, 0.2); 
        border-radius: 10px; 
    }
    .table th { 
        background-color: #ffb6c1; 
        color: #fff; 
        font-weight: 600; 
    }
    .table td, .table th { vertical-align: middle; }
    tr:hover { background-color: #fff0f5; }
    .no-results { font-style: italic; color: #6c757d; }
    .text-pink { color: #ff69b4; }
</style>

<div class="container py-4">
    <!-- Tiêu đề + nút thêm -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">🌸 Quản Lý Danh Mục 🌸</h2>
        <button class="btn btn-pink btn-sm" data-bs-toggle="modal" data-bs-target="#categoryModal" onclick="resetForm()">
            <i class="bi bi-plus-lg me-1"></i> Thêm Danh Mục
        </button>
    </div>

    <!-- Bảng danh mục -->
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th class="text-center">ID</th>
                            <th>Tên Danh Mục</th>
                            <th>Mô Tả</th>
                            <th class="text-center">Ngày Tạo</th>
                            <th class="text-center">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <%
                                LocalDateTime createdAt = ((vn.iotstar.starshop.entity.Category) pageContext.getAttribute("category")).getCreatedAt();
                                Date createdAtDate = createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
                                pageContext.setAttribute("createdAtDate", createdAtDate);
                            %>
                            <fmt:formatDate var="formattedCreatedAt" value="${createdAtDate}" pattern="dd/MM/yyyy" />
                            <tr>
                                <td class="text-center">${category.id}</td>
                                <td>${category.name}</td>
                                <td class="text-muted" style="max-width:200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${category.description}</td>
                                <td class="text-center">${formattedCreatedAt}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/categories/detail/${category.id}"
                                       class="btn btn-outline-info btn-sm me-1">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <button class="btn btn-outline-primary btn-sm me-1" data-bs-toggle="modal" data-bs-target="#categoryModal"
                                            onclick="editCategory(${category.id}, '${category.name}', '${category.description}')">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/categories/delete/${category.id}"
                                       class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="5" class="text-center py-4 no-results">
                                    <i class="bi bi-search fs-4 d-block mb-2"></i>
                                    Chưa có danh mục nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal Form (Sửa/Thêm) -->
<div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0 rounded-3">
            <div class="modal-header bg-light border-bottom">
                <h5 class="modal-title fw-bold text-pink">Danh Mục</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%@ include file="category-form.jsp" %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetForm() {
        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/categories/add';
        document.getElementById('id').value = '';
        document.getElementById('name').value = '';
        document.getElementById('description').value = '';
    }

    function editCategory(id, name, description) {
        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/categories/edit/' + id;
        document.getElementById('id').value = id;
        document.getElementById('name').value = name;
        document.getElementById('description').value = description;
    }
</script>