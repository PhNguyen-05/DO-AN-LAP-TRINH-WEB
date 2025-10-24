<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style>
    body {
        background: linear-gradient(to bottom, #fff0f5, #ffffff);
        font-family: 'Segoe UI', sans-serif;
        color: #333;
    }
    .page-title { color: #ff69b4; font-weight: 600; }
    .card { border: none; box-shadow: 0 2px 10px rgba(255, 105, 180, 0.2); border-radius: 10px; }
    .table th { background-color: #ffb6c1; color: #fff; font-weight: 600; }
    .table td, .table th { vertical-align: middle; }
    tr:hover { background-color: #fff0f5; }
    .low-stock { color: #dc3545; font-weight: bold; }
    .text-pink { color: #ff69b4; }
</style>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">🌸 Chi Tiết Danh Mục 🌸</h2>
        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <c:if test="${not empty category}">
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="fw-bold text-pink mb-3">${category.name}</h5>
                <p><strong>ID:</strong> ${category.id}</p>
                <p><strong>Mô tả:</strong>
                    <c:choose>
                        <c:when test="${not empty category.description}">
                            ${category.description}
                        </c:when>
                        <c:otherwise>(Không có mô tả)</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Ngày tạo:</strong> ${category.formattedCreatedAt}</p>
            </div>
        </div>

        <div class="card">
            <div class="card-body p-0">
                <h6 class="fw-bold text-pink px-3 pt-3">Danh Sách Sản Phẩm</h6>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th class="text-center">ID</th>
                                <th class="text-center">Ảnh</th>
                                <th>Tên Sản Phẩm</th>
                                <th class="text-center">Giá</th>
                                <th class="text-center">Tồn Kho</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty products}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-4">
                                        <i class="bi bi-emoji-frown fs-4 d-block mb-2"></i>
                                        Chưa có sản phẩm nào trong danh mục này.
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td class="text-center">${product.id}</td>
                                    <td class="text-center">
                                        <img src="${pageContext.request.contextPath}/images/${product.imageUrl}"
                                             alt="Ảnh sản phẩm"
                                             class="rounded"
                                             width="50" height="50"
                                             onerror="this.src='https://via.placeholder.com/50?text=No+Image';">
                                    </td>
                                    <td>${product.name}</td>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" />
                                    </td>
                                    <td class="text-center">
                                        <span class="${product.stock < 10 ? 'low-stock' : ''}">
                                            ${product.stock}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty category}">
        <div class="alert alert-warning text-center">
            Không tìm thấy danh mục.
        </div>
    </c:if>
</div>
