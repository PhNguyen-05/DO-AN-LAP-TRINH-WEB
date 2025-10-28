<%-- /vendor/product-form.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- 
  Đây là form dùng chung. 
  JavaScript sẽ đổi 'action' của form này
--%>
<form id="productForm" method="post" enctype="multipart/form-data">
    <%-- CSRF Token (nếu bạn dùng Spring Security) --%>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    
    <%-- ID sản phẩm, rỗng khi thêm, có giá trị khi sửa --%>
    <input type="hidden" id="editId" name="id">

    <div class="row g-3">
        <div class="col-md-6">
            <label for="sku" class="form-label">Mã SKU <span class="text-danger">*</span></label>
            <input type="text" id="sku" name="sku" class="form-control" required>
        </div>
        
        <div class="col-md-6">
            <label for="name" class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
            <input type="text" id="name" name="name" class="form-control" required>
        </div>

        <div class="col-md-6">
            <label for="price" class="form-label">Giá <span class="text-danger">*</span></label>
            <input type="number" id="price" name="price" class="form-control" required>
        </div>
        
        <div class="col-md-6">
            <label for="stock" class="form-label">Tồn kho <span class="text-danger">*</span></label>
            <input type="number" id="stock" name="stock" class="form-control" required>
        </div>
        
        <div class="col-md-12">
            <label for="category" class="form-label">Danh mục <span class="text-danger">*</span></label>
            <select id="category" name="category.id" class="form-select" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="col-md-12">
            <label for="description" class="form-label">Mô tả</label>
            <textarea id="description" name="description" class="form-control" rows="2"></textarea>
        </div>
        
        <div class="col-md-12">
            <label for="imageFile" class="form-label">Ảnh (nếu muốn đổi)</label>
            <input type="file" id="imageFile" name="imageFile" class="form-control">
        </div>
    </div>
</form>