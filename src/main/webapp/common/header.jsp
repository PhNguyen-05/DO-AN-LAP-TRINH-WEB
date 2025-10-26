<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-lg shadow-lg position-sticky top-0 z-3"
      style="background: linear-gradient(90deg, #ffeaf2, #d7f3ff, #d8f3dc); border-bottom: 3px solid #ffd6e8;">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand fw-bold"
           href="${pageContext.request.contextPath}/"
           style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2rem;">
            🌸 <span style="color: #007bff;">Star</span><span style="color: #ff1493;">Shop</span>
        </a>

        <!-- Toggle button cho responsive -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <!-- Menu chính -->
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link fw-semibold"
                                        href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link fw-semibold dropdown-toggle" href="#" role="button"
                       data-bs-toggle="dropdown">Cửa hàng</a>
                    <ul class="dropdown-menu rounded-3 shadow-lg">
                        <li><a class="dropdown-item"
                               href="${pageContext.request.contextPath}/shop">Tất cả sản phẩm</a></li>
                        <li><a class="dropdown-item"
                               href="${pageContext.request.contextPath}/shop/category">Danh mục</a></li>
                        <li><a class="dropdown-item"
                               href="${pageContext.request.contextPath}/shop/promotions">Khuyến mãi</a></li>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link fw-semibold"
                                        href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                <li class="nav-item"><a class="nav-link fw-semibold"
                                        href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
            </ul>

            <!-- Menu phải: user + giỏ hàng -->
            <ul class="navbar-nav ms-auto align-items-center">

                <!-- Nếu đã login -->
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fw-semibold" href="#"
                           data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle me-1"></i>
                            <sec:authentication property="principal.username"/>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end rounded-3 shadow-lg">
                            <li><a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/user/profile">
                                    <i class="bi bi-person me-2"></i> Hồ sơ
                                </a></li>
                            <li><a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/orders">
                                    <i class="bi bi-bag me-2"></i> Đơn hàng
                                </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger"
                                   href="${pageContext.request.contextPath}/auth/logout">
                                    <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                                </a></li>
                        </ul>
                    </li>
                </sec:authorize>

                <!-- Nếu chưa login -->
                <sec:authorize access="!isAuthenticated()">
                    <li class="nav-item"><a class="nav-link fw-semibold"
                                            href="${pageContext.request.contextPath}/auth/login">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                        </a></li>
                    <li class="nav-item"><a class="nav-link fw-semibold"
                                            href="${pageContext.request.contextPath}/auth/register">
                            <i class="bi bi-person-plus me-1"></i> Đăng ký
                        </a></li>
                </sec:authorize>

                <!-- Giỏ hàng -->
                <li class="nav-item ms-3">
                    <a class="btn rounded-pill position-relative shadow-sm"
                       href="${pageContext.request.contextPath}/cart"
                       style="background-color: #ffd6e8; color: #ff1493;">
                        <i class="bi bi-cart3"></i>
                        <c:if test="${not empty sessionScope.cartSize}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${sessionScope.cartSize}
                            </span>
                        </c:if>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
