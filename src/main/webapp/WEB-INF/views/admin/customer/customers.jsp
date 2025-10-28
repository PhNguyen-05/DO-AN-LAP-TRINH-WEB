<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.ZoneId" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">🌸 Quản Lý Khách Hàng 🌸</h2>
        <button class="btn btn-pink" data-bs-toggle="modal" data-bs-target="#customerModal" onclick="resetForm()">
            <i class="bi bi-plus-lg me-2"></i> Thêm Khách Hàng
        </button>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ Tên</th>
                        <th>Email</th>
                        <th>Số Điện Thoại</th>
                        <th>Địa Chỉ</th>
                        <th>Ngày Tạo</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <%
                        LocalDateTime createdAt = ((vn.iotstar.starshop.entity.Customer) pageContext.getAttribute("customer")).getCreatedAt();
                                                    Date createdAtDate = createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
                                                    pageContext.setAttribute("created_AtDate", createdAtDate);
                        %>
                        <tr>
                            <td>${customer.id}</td>
                            <td>${customer.fullName}</td>
                            <td>${customer.user.email}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.defaultAddress}</td>
                            <td><fmt:formatDate value="${createdAtDate}" pattern="dd/MM/yyyy" /></td>
                            <td>
                                <button class="btn btn-outline-primary btn-sm"
                                        data-bs-toggle="modal"
                                        data-bs-target="#customerModal"
                                        onclick="editCustomer(${customer.id}, '${customer.fullName}', '${customer.user.email}', '${customer.phone}', '${customer.defaultAddress}', ${customer.user.id})">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/customers/delete/${customer.id}"
                                   class="btn btn-outline-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">
                                   <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty customers}">
                        <tr>
                            <td colspan="7" class="text-center text-muted py-3">Chưa có khách hàng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal Form -->
<div class="modal fade" id="customerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-primary">Khách Hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <%@ include file="customer-form.jsp" %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetForm() {
        document.getElementById('customerForm').action = '${pageContext.request.contextPath}/admin/customers/add';
        document.getElementById('id').value = '';
        document.getElementById('fullName').value = '';
        document.getElementById('phone').value = '';
        document.getElementById('defaultAddress').value = '';
        document.getElementById('userId').value = '';
    }

    function editCustomer(id, fullName, email, phone, defaultAddress, userId) {
        document.getElementById('customerForm').action = '${pageContext.request.contextPath}/admin/customers/edit/' + id;
        document.getElementById('id').value = id;
        document.getElementById('fullName').value = fullName;
        document.getElementById('phone').value = phone;
        document.getElementById('defaultAddress').value = defaultAddress;
        document.getElementById('userId').value = userId;
    }
</script>
