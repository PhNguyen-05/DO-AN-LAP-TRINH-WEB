<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<form id="${param.formId}" action="${pageContext.request.contextPath}/admin/vendor/save" method="post">
    <input type="hidden" name="id" id="id" value="${vendor.id}" />

    <div class="mb-3">
        <label class="form-label fw-bold">Chọn tài khoản người dùng</label>
        <select name="userId" class="form-select" required>
            <option value="">-- Chọn user --</option>
            <c:forEach var="u" items="${users}">
                <option value="${u.id}" ${vendor.user.id == u.id ? 'selected' : ''}>
                    ${u.fullName} (${u.email})
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Tên Shop</label>
        <input type="text" class="form-control" id="shopName" name="shopName" value="${vendor.shopName}" required>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Địa chỉ</label>
        <input type="text" class="form-control" id="address" name="address" value="${vendor.address}">
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Số điện thoại</label>
        <input type="text" class="form-control" id="phone" name="phone" value="${vendor.phone}">
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Email</label>
        <input type="email" class="form-control" id="email" name="email" value="${vendor.email}">
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Mô tả</label>
        <textarea class="form-control" id="description" name="description" rows="3">${vendor.description}</textarea>
    </div>

    <div class="text-center">
        <button type="submit" class="btn btn-pink px-4">Lưu</button>
    </div>
</form>
