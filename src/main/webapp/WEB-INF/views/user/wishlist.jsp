<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<div class="container my-5">
    <h2 class="text-center mb-4" style="font-family: 'Dancing Script', cursive; color: #ff69b4;">
        ❤️ Sản phẩm yêu thích của bạn
    </h2>

    <c:if test="${empty wishlist}">
        <p class="text-center text-muted">Bạn chưa yêu thích sản phẩm nào 🌸</p>
    </c:if>

    <div class="row g-4">
        <c:forEach var="p" items="${wishlist}">
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card shadow-sm border-0 rounded-4">
                    <img src="${pageContext.request.contextPath}/images/${p.imageUrl}"
                         class="card-img-top rounded-top-4" alt="${p.name}">
                    <div class="card-body text-center">
                        <h6 class="fw-bold text-pink">${p.name}</h6>
                        <p class="fw-semibold text-success"><fmt:formatNumber value="${p.price}" type="number"/> ₫</p>

                        <a href="${pageContext.request.contextPath}/product/${p.id}"
                           class="btn btn-outline-pink btn-sm">
                            <i class="bi bi-eye"></i> Xem chi tiết
                        </a>

                        <button class="btn btn-outline-danger btn-sm mt-2 toggle-wishlist"
                                data-id="${p.id}">
                            💔 Bỏ yêu thích
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
document.querySelectorAll('.toggle-wishlist').forEach(btn => {
    btn.addEventListener('click', async () => {
        const id = btn.dataset.id;
        const res = await fetch(`${pageContext.request.contextPath}/wishlist/toggle?productId=${id}`, { method: 'POST' });
        if (res.ok) location.reload();
    });
});
</script>
