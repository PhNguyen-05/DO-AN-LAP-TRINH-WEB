<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<form:form id="${param.formId}" modelAttribute="promotion" method="post" 
           action="${param.formId == 'promotionFormAdd' ? pageContext.request.contextPath.concat('/admin/promotions/add') : pageContext.request.contextPath.concat('/admin/promotions/edit/').concat(promotion.id)}">
    
    <form:hidden path="id" id="id" />

    <div class="mb-3">
        <label for="promotionName" class="form-label fw-bold">Tên Khuyến Mãi <span class="text-danger">*</span></label>
        <form:input path="promotionName" id="promotionName" class="form-control" placeholder="Nhập tên khuyến mãi" required="true" />
        <form:errors path="promotionName" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label for="description" class="form-label fw-bold">Mô Tả</label>
        <form:textarea path="description" id="description" class="form-control" rows="3" placeholder="Nhập mô tả khuyến mãi" />
        <form:errors path="description" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label for="discountValue" class="form-label fw-bold">Giá Trị Giảm <span class="text-danger">*</span></label>
        <form:input path="discountValue" id="discountValue" class="form-control" type="number" min="0" step="0.01" placeholder="Nhập giá trị giảm" required="true" />
        <form:errors path="discountValue" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label for="discountType" class="form-label fw-bold">Loại Giảm <span class="text-danger">*</span></label>
        <form:select path="discountType" id="discountType" class="form-select" required="true">
            <form:option value="PERCENTAGE">Phần Trăm</form:option>
            <form:option value="FIXED">Cố Định</form:option>
        </form:select>
        <form:errors path="discountType" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label for="startDate" class="form-label fw-bold">Ngày Bắt Đầu <span class="text-danger">*</span></label>
        <form:input path="startDate" id="startDate" class="form-control" type="date" required="true" />
        <form:errors path="startDate" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label for="endDate" class="form-label fw-bold">Ngày Kết Thúc <span class="text-danger">*</span></label>
        <form:input path="endDate" id="endDate" class="form-control" type="date" required="true" />
        <form:errors path="endDate" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label for="vendorId" class="form-label fw-bold">Nhà Cung Cấp <span class="text-danger">*</span></label>
        <form:select path="vendor.id" id="vendorId" class="form-select" required="true">
            <form:option value="">Chọn nhà cung cấp</form:option>
            <c:forEach var="vendor" items="${vendors}">
                <form:option value="${vendor.id}">${vendor.shopName}</form:option>
            </c:forEach>
        </form:select>
        <form:errors path="vendor.id" cssClass="text-danger" />
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Danh Mục / Sản Phẩm Áp Dụng</label>
        <div class="accordion" id="categoryAccordion">
            <c:forEach var="category" items="${categories}">
                <div class="accordion-item mb-2 border rounded">
                    <h2 class="accordion-header" id="heading-${category.id}">
                        <button class="accordion-button collapsed d-flex align-items-center" type="button"
                                data-bs-toggle="collapse" data-bs-target="#collapse-${category.id}"
                                aria-expanded="false" aria-controls="collapse-${category.id}">
                            <input type="checkbox" name="categoryIds" value="${category.id}"
                                   class="form-check-input me-2 category-checkbox"
                                   id="cat-${category.id}" data-category-id="${category.id}" />
                            <label for="cat-${category.id}" class="form-check-label fw-bold mb-0">${category.name}</label>
                        </button>
                    </h2>
                    <div id="collapse-${category.id}" class="accordion-collapse collapse"
                         aria-labelledby="heading-${category.id}" data-bs-parent="#categoryAccordion">
                        <div class="accordion-body">
                            <c:forEach var="product" items="${category.products}">
                                <div class="form-check ms-3">
                                    <input type="checkbox" name="productIds" value="${product.id}"
                                           class="form-check-input product-checkbox"
                                           id="prod-${product.id}" data-category-id="${category.id}" />
                                    <label class="form-check-label" for="prod-${product.id}">${product.name}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="text-end">
        <button type="submit" class="btn btn-success px-4">Lưu</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    </div>
</form:form>