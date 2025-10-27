<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!-- DataTables CSS -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<div class="container-fluid" data-aos="fade-up" data-aos-duration="800">
	<!-- Header -->
	<div class="row mb-4">
		<div class="col-12">
			<div class="card shadow-lg rounded-4 border-0"
				style="background: linear-gradient(135deg, #ffeaf2, #d7f3ff);">
				<div
					class="card-body p-4 d-flex justify-content-between align-items-center">
					<h2 class="fw-bold"
						style="font-family: 'Dancing Script', cursive; color: #ff69b4; font-size: 2.5rem;">
						🌸 Khuyến Mãi</h2>
					<div>
						<a href="${pageContext.request.contextPath}/vendor/add-promotion"
							class="btn btn-pink">+ Thêm Khuyến Mãi</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Table -->
	<div class="row">
		<div class="col-12">
			<div class="card shadow-lg rounded-4 border-0 p-4"
				style="border-top: 4px solid #ff69b4;">
				<table id="promotionsTable"
					class="table table-hover table-striped align-middle">
					<thead class="table-light">
						<tr>
							<th>Tên Khuyến Mãi</th>
							<th>Giảm Giá</th>
							<th>Ngày Bắt Đầu</th>
							<th>Ngày Kết Thúc</th>
							<th>Trạng Thái</th>
							<th>Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="promotion" items="${promotions}">
							<tr>
								<td>${promotion.promotionName}</td>
								<td><c:choose>
										<c:when test="${promotion.discountType == 'PERCENTAGE'}">${promotion.discountValue}%</c:when>
										<c:otherwise>${promotion.discountValue} VND</c:otherwise>
									</c:choose></td>
								<td><fmt:formatDate value="${promotion.startDateAsDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${promotion.endDateAsDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:set var="now"
										value="<%=java.time.LocalDate.now()%>" /> <c:choose>
										<c:when test="${promotion.startDate gt now}">
											<span class="badge bg-secondary px-3 py-2">⏳ Chưa bắt
												đầu</span>
										</c:when>
										<c:when
											test="${promotion.endDate lt now or not promotion.active}">
											<span class="badge bg-danger px-3 py-2">❌ Đã kết thúc</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-success px-3 py-2">✅ Đang hoạt
												động</span>
										</c:otherwise>
									</c:choose></td>

								<td class="text-center">
									<!-- Nút xem chi tiết -->
									<button
										class="btn btn-sm btn-info view-btn me-1 rounded-circle"
										data-id="${promotion.id}"
										data-name="${promotion.promotionName}"
										data-discount="${promotion.discountValue}"
										data-start="${promotion.startDate}"
										data-end="${promotion.endDate}"
										data-active="${promotion.active}" title="Xem chi tiết">
										<i class="fas fa-eye"></i>
									</button> <!-- Nút sửa --> <a
									href="${pageContext.request.contextPath}/vendor/edit-promotion?id=${promotion.id}"
									class="btn btn-sm btn-warning me-1 rounded-circle" title="Sửa">
										<i class="fas fa-edit"></i>
								</a> <!-- Nút xóa -->
									<button class="btn btn-sm btn-danger rounded-circle delete-btn"
										data-id="${promotion.id}" data-bs-toggle="modal"
										data-bs-target="#deletePromotionModal" title="Xóa">
										<i class="fas fa-trash-alt"></i>
									</button>
								</td>

							</tr>
						</c:forEach>

						<c:if test="${empty promotions}">
							<tr>
								<td colspan="6" class="text-center text-muted py-4">Chưa có
									khuyến mãi nào.</td>
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
			</div>
		</div>
	</div>
</div>

<!-- Modal Xóa -->
<div class="modal fade" id="deletePromotionModal" tabindex="-1"
	aria-labelledby="deletePromotionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content rounded-4 border-0">
			<div class="modal-header border-0">
				<h5 class="modal-title fw-bold text-danger"
					id="deletePromotionModalLabel">Xác Nhận Xóa Khuyến Mãi</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body text-center">Bạn chắc chắn muốn xóa
				khuyến mãi này?</div>
			<div class="modal-footer border-0">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Hủy</button>
				<a id="confirmDeleteLink" class="btn btn-danger">Xóa</a>
			</div>
		</div>
	</div>
</div>

<!-- Modal Xem Chi Tiết -->
<div class="modal fade" id="viewPromotionModal" tabindex="-1"
	aria-labelledby="viewPromotionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content rounded-4 border-0 shadow-lg">
			<div class="modal-header border-0 bg-light">
				<h5 class="modal-title fw-bold text-info"
					id="viewPromotionModalLabel">Chi Tiết Khuyến Mãi</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body">
				<div class="mb-2">
					<strong>ID khuyến mãi:</strong> <span id="viewId"></span>
				</div>
				<div class="mb-2">
					<strong>Tên khuyến mãi:</strong> <span id="viewName"></span>
				</div>
				<div class="mb-2">
					<strong>Giảm giá:</strong> <span id="viewDiscount"></span>
				</div>
				<div class="mb-2">
					<strong>Ngày bắt đầu:</strong> <span id="viewStart"></span>
				</div>
				<div class="mb-2">
					<strong>Ngày kết thúc:</strong> <span id="viewEnd"></span>
				</div>
				<div class="mb-3">
					<strong>Trạng thái:</strong> <span id="viewStatus"></span>
				</div>

				<hr>
				<h6 class="fw-bold text-secondary mb-2">Danh sách sản phẩm được
					giảm giá:</h6>
				<ul id="viewProducts" class="list-group list-group-flush"></ul>
			</div>
			<div class="modal-footer border-0">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>



<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap Bundle -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- DataTables JS with defer -->
<script defer
	src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script defer
	src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<!-- Custom Script -->
<script>
$(document).ready(function () {
    console.log('jQuery loaded:', typeof $ === 'function');
    console.log('Bootstrap loaded:', typeof bootstrap === 'object');

    // Khi toàn bộ trang (bao gồm JS & CSS) đã load xong
    window.addEventListener('load', function () {
        if ($.fn.DataTable) {
            console.log("DataTables loaded ✅");

            const table = $('#promotionsTable').DataTable({
                paging: false,
                searching: false,
                lengthChange: false,
                ordering: true,
                info: false,
                language: {
                    search: "Tìm kiếm:",
                    emptyTable: "Chưa có khuyến mãi."
                }
            });

            // 🔍 Liên kết ô tìm kiếm
            $('#searchInput').on('keyup', function () {
                table.search(this.value).draw();
            });
        } else {
            console.log("❌ DataTables not loaded. Check CDN or order.");
        }
    });

    // 🗑️ Xử lý hiển thị modal xóa
    $('#deletePromotionModal').on('show.bs.modal', function (event) {
        const button = $(event.relatedTarget);
        const id = button.data('id');
        const url = '${pageContext.request.contextPath}/vendor/promotions/delete/' + id;
        $('#confirmDeleteLink').attr('href', url);
    });

    // 🗑️ Gửi yêu cầu xóa bằng AJAX
    $('#confirmDeleteLink').click(function (e) {
        e.preventDefault();
        $.ajax({
            url: $(this).attr('href'),
            type: 'POST',
            success: function (response) {
                if (response === "Success") {
                    alert('Xóa thành công!');
                    window.location.href = '${pageContext.request.contextPath}/vendor/promotions';
                } else {
                    alert('Lỗi: ' + response);
                }
            },
            error: function (xhr) {
                alert('Lỗi xóa khuyến mãi: ' + xhr.responseText);
            }
        });
    });


//  Xem chi tiết khuyến mãi (đã thêm console.log để debug)
// --- THAY THẾ CODE CŨ BẰNG CODE NÀY ---

//  Xem chi tiết khuyến mãi (Thêm log kiểm tra innerHTML)
$(document).on('click', '.view-btn', function () {
    console.log("--- Nút Xem được bấm ---"); // LOG 1

    // 1. Lấy dữ liệu CÓ SẴN từ nút bấm
    const id = $(this).data('id');
    const name = $(this).data('name');
    // ... (lấy các data khác) ...
    const active = $(this).data('active');

    // 2. Lấy đối tượng Modal
    const viewModal = document.getElementById('viewPromotionModal');
    const modal = bootstrap.Modal.getInstance(viewModal) || new bootstrap.Modal(viewModal);

    // 3. Gán dữ liệu CÓ SẴN
    $('#viewId').text(id);
    $('#viewName').text(name);
    // ... (gán các span khác) ...
    $('#viewStatus').html(/* ... code xử lý status ... */);

    // 4. Reset danh sách và hiển thị "Đang tải..."
    const productListElement = document.getElementById('viewProducts'); // Lấy element gốc
    if (!productListElement) {
        console.error("KHÔNG TÌM THẤY THẺ UL VỚI ID 'viewProducts'!"); // LOG ERROR
        return; // Dừng lại nếu không tìm thấy UL
    }
    const productList = $(productListElement); // jQuery object
    console.log("Đã chọn được thẻ UL:", productList.length > 0); // LOG 2
    productList.empty();
    productList.append('<li class="list-group-item text-muted fst-italic">Đang tải danh sách sản phẩm...</li>');

    // 5. LẮNG NGHE sự kiện KHI MODAL ĐÃ HIỆN XONG
    $(viewModal).off('shown.bs.modal').on('shown.bs.modal', function () {
        console.log("--- Modal ĐÃ HIỆN XONG, bắt đầu Fetch ---"); // LOG A

        fetch('${pageContext.request.contextPath}/vendor/promotions/details/' + id)
            .then(response => {
                console.log("Fetch response status:", response.status); // LOG 3
                if (!response.ok) throw new Error('Network response error: ' + response.statusText);
                return response.json();
            })
            .then(data => {
                console.log("Dữ liệu JSON:", data); // LOG 4
                const products = data ? data.productNames : null;
                console.log("productNames:", products); // LOG 5

                productList.empty(); // Xóa "Đang tải..."
                console.log("HTML của UL sau khi empty:", productListElement.innerHTML); // LOG B: Kiểm tra UL trống

                if (products && Array.isArray(products) && products.length > 0) {
                    console.log("Bắt đầu append LI..."); // LOG 6
                    products.forEach((p, index) => {
                        const liHtml = `<li class="list-group-item">${p}</li>`;
                        productList.append(liHtml);
                        // KIỂM TRA NGAY LẬP TỨC
                        console.log(`  Đã append '${p}'. HTML của UL hiện tại:`, productListElement.innerHTML); // LOG C
                    });
                    console.log("--- HOÀN TẤT APPEND ---"); // LOG D
                    console.log("HTML cuối cùng của UL:", productListElement.innerHTML); // LOG E
                } else {
                    console.log("Không có sản phẩm hoặc lỗi dữ liệu."); // LOG 9
                    productList.append('<li class="list-group-item text-muted fst-italic">Không có sản phẩm áp dụng.</li>');
                }
            })
            .catch(error => {
                console.error('Lỗi fetch/JSON:', error); // LOG 10
                productList.empty();
                productList.append(`<li class="list-group-item text-danger">Lỗi: ${error.message}</li>`);
            });
    });

    // 7. HIỂN THỊ MODAL
    console.log("Chuẩn bị show modal..."); // LOG 11
    modal.show();
});
// --- KẾT THÚC CODE THAY THẾ ---
});
</script>

<style>
/* Ẩn ô tìm kiếm của DataTables */
.dataTables_filter {
	display: none;
}

#promotionsTable tbody tr:hover {
	background-color: #fff3f6;
	transition: 0.3s;
}

.btn-pink {
	background-color: #ff69b4;
	color: white;
	border: none;
}

.btn-pink:hover {
	background-color: #ff85c1;
	color: white;
}

#viewProducts .list-group-item {
  color: #212529 !important;       /* màu chữ mặc định đen */
  font-size: 1rem !important;
  background-color: transparent !important;
  display: list-item !important;
  visibility: visible !important;
  opacity: 1 !important;
}
</style>