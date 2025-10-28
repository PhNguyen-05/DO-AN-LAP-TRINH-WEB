<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form id="customerForm" method="post" action="${pageContext.request.contextPath}/admin/customers/add">
    <input type="hidden" id="id" name="id" />

    <div class="mb-3">
        <label for="fullName" class="form-label fw-bold">Họ Tên <span class="text-danger">*</span></label>
        <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Nhập họ tên" required>
    </div>

    <div class="mb-3">
        <label for="phone" class="form-label fw-bold">Số Điện Thoại</label>
        <input type="text" id="phone" name="phone" class="form-control" placeholder="Nhập số điện thoại">
    </div>

    <div class="mb-3">
        <label for="defaultAddress" class="form-label fw-bold">Địa Chỉ</label>
        <textarea id="defaultAddress" name="defaultAddress" class="form-control" rows="3" placeholder="Nhập địa chỉ"></textarea>
    </div>

    <div class="mb-3">
        <label for="userId" class="form-label fw-bold">Tài Khoản <span class="text-danger">*</span></label>
        <select id="userId" name="user.id" class="form-select" required>
            <option value="">Chọn tài khoản</option>
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.email}</option>
            </c:forEach>
        </select>
    </div>

    <div class="text-end">
        <button type="submit" class="btn btn-success px-4">Lưu</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    </div>
</form>
