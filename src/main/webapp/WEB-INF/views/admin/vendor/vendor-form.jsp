<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<form id="${param.formId}" action="${pageContext.request.contextPath}/admin/vendors/save" method="post">
    <%-- CSRF token nếu Spring Security bật --%>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

    <%-- Hidden ID để phân biệt thêm mới hay sửa --%>
    <input type="hidden" name="id" id="id" value="${vendor.id}" />

    <div class="mb-3">
        <label class="form-label fw-bold">Tên Shop <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="shopName" name="ShopName" value="${vendor.shopName}" required>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Email <span class="text-danger">*</span></label>
        <input type="email" class="form-control" id="email" name="email" value="${vendor.email}" required>
        <div class="form-text">Email này sẽ được dùng làm tài khoản đăng nhập cho vendor.</div>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Số điện thoại <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="phone" name="phone" value="${vendor.phone}" required>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Địa chỉ</label>
        <input type="text" class="form-control" id="address" name="address" value="${vendor.address}">
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Mô tả</label>
        <textarea class="form-control" id="description" name="description" rows="3">${vendor.description}</textarea>
    </div>

    <div class="mb-2 text-muted">
        <small>Mật khẩu mặc định của vendor sẽ là: <strong>123456</strong></small>
    </div>

    <div class="text-center">
        <button type="submit" class="btn btn-pink px-4">Lưu</button>
    </div>
</form>
