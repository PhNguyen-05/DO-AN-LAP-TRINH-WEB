<%-- /vendor/product-detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; }
    .detail-card { 
        max-width: 900px; 
        margin: 2rem auto; 
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        border-radius: 12px;
    }
    .detail-header {
        background-color: #ffb6c1;
        color: white;
        padding: 1rem 1.5rem;
        border-bottom: none;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }
    .product-image {
        width: 100%;
        max-height: 400px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #eee;
    }
    .list-group-item { border-left: none; border-right: none; }
</style>

<div class="container">
    <div class="card detail-card">
        <div class="card-header detail-header">
            <h4 class="mb-0">Chi Tiết Sản Phẩm</h4>
        </div>
        <div class="card-body p-4">
            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-outline-secondary btn-sm mb-3">
                &larr; Quay lại danh sách
            </a>
            
            <div class="row g-4">
                <div class="col-md-5 text-center">
                    <%-- Logic hiển thị ảnh (đã sửa lỗi) --%>
                    <c:set var="imageUrl" value="${product.imageUrl}" />
                    <c:set var="placeholderUrl" value="https://via.placeholder.com/400?text=No+Image" />
                    
                    <c:choose>
                        <c:when test="${empty imageUrl}">
                            <img src="${placeholderUrl}" class="product-image">
                        </c:when>
                        <c:when test="${fn:startsWith(imageUrl, 'http')}">
                            <img src="${imageUrl}" class="product-image" onerror="this.src='${placeholderUrl}'">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/${imageUrl}" class="product-image" onerror="this.src='${placeholderUrl}'">
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="col-md-7">
                    <h2 class="mb-3">${product.name}</h2>
                    
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item px-0">
                            <strong>SKU:</strong> ${product.sku}
                        </li>
                        <li class="list-group-item px-0">
                            <strong>Giá:</strong> 
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" />
                        </li>
                        <li class="list-group-item px-0">
                            <strong>Tồn Kho:</strong> ${product.stock}
                        </li>
                        <li class="list-group-item px-0">
                            <strong>Danh Mục:</strong> ${product.category.name}
                        </li>
                        <li class="list-group-item px-0">
                            <strong>Mô Tả:</strong>
                            <p class="text-muted mt-1 mb-0">${not empty product.description ? product.description : 'Không có mô tả'}</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>