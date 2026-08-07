<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
	<div class="row mb-4">
		<div class="col-12">
			<div class="card shadow-lg rounded-4 border-0"
				style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
				<div class="card-body p-4">
					<h2 class="fw-bold text-center"
						style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">🌸
						Quản Lý Đơn Hàng</h2>
					<p class="text-muted text-center lead">Theo dõi và quản lý đơn
						hàng của cửa hàng.</p>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<div class="card shadow-lg rounded-4 border-0 p-4">
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Ngày Đặt</th>
							<th>Tổng Tiền</th>
							<th>Trạng Thái</th>
							<th>Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${orders}">
							<tr>
								<td>#${order.id}</td>
								<td><fmt:formatDate value="${order.orderDate}"
										pattern="yyyy-MM-dd HH:mm" /></td>
								<td><fmt:formatNumber value="${order.totalAmount}"
										type="currency" currencySymbol="$" groupingUsed="true" /></td>
								<td><c:choose>
										<c:when test="${order.status == 'Completed'}">
											<span class="badge bg-success">Hoàn Thành</span>
										</c:when>
										<c:when test="${order.status == 'Shipped'}">
											<span class="badge bg-warning">Đang Giao</span>
										</c:when>
										<c:when test="${order.status == 'Pending'}">
											<span class="badge bg-secondary">Chờ Xử Lý</span>
										</c:when>
										<c:when test="${order.status == 'Cancelled'}">
											<span class="badge bg-danger">Đã Hủy</span>
										</c:when>
										<c:when test="${order.status == 'Returned'}">
											<span class="badge bg-info">Trả Hàng</span>
										</c:when>
										<c:when test="${order.status == 'Refunded'}">
											<span class="badge bg-primary">Hoàn Tiền</span>
										</c:when>
										<c:when test="${order.status == 'New'}">
											<span class="badge bg-light text-dark">Đơn Mới</span>
										</c:when>
										<c:when test="${order.status == 'Confirmed'}">
											<span class="badge bg-success-subtle text-success">Đã
												Xác Nhận</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-info">${order.status}</span>
										</c:otherwise>
									</c:choose></td>
								<td><a
									href="${pageContext.request.contextPath}/vendor/orders/view/${order.id}"
									class="btn btn-sm btn-primary">Xem</a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty orders}">
							<tr>
								<td colspan="5" class="text-center text-muted">Chưa có đơn
									hàng.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<!-- Pagination -->
				<c:if test="${totalPages > 0}">
					<nav aria-label="Pagination">
						<ul class="pagination justify-content-center">
							<c:if test="${currentPage > 0}">
								<li class="page-item"><a class="page-link"
									href="?page=${currentPage - 1}&size=${pageSize}&sort=${sort}">Trước</a>
								</li>
							</c:if>

							<c:forEach var="i" begin="0" end="${totalPages - 1}">
								<li class="page-item ${currentPage == i ? 'active' : ''}">
									<a class="page-link"
									href="?page=${i}&size=${pageSize}&sort=${sort}">${i + 1}</a>
								</li>
							</c:forEach>

							<c:if test="${currentPage < totalPages - 1}">
								<li class="page-item"><a class="page-link"
									href="?page=${currentPage + 1}&size=${pageSize}&sort=${sort}">Sau</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</c:if>

				<c:if test="${totalPages == 0}">
					<p class="text-center text-muted">Không có trang nào để hiển
						thị.</p>
				</c:if>
			</div>
		</div>
	</div>
</div>