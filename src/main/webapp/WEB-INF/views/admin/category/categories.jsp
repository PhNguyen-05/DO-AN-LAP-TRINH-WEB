<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">🌸 Quản Lý Danh Mục Hoa 🌸</h2>
        <button class="btn btn-pink" data-bs-toggle="modal" data-bs-target="#categoryModal" onclick="resetForm()">
            <i class="bi bi-plus-lg me-2"></i> Thêm Danh Mục
        </button>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-hover align-middle">
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
                            <td><fmt:formatDate value="${category.ngayTao}" pattern="dd/MM/yyyy" /></td>
                            <td>
                                <button class="btn btn-outline-primary btn-sm"
                                        data-bs-toggle="modal"
                                        data-bs-target="#categoryModal"
                                        onclick="editCategory(${category.id}, '${category.tenDanhMuc}', '${category.moTa}')">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/categories/delete/${category.id}"
                                   class="btn btn-outline-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">
                                   <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty categories}">
                        <tr>
                            <td colspan="5" class="text-center text-muted py-3">Chưa có danh mục nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal Form -->
<div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-primary">Danh Mục Hoa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
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

