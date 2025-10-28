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


 // --- THAY THẾ CODE CŨ BẰNG CODE NÀY ---

//  Xem chi tiết khuyến mãi (Dùng innerHTML + setTimeout check)
$(document).on('click', '.view-btn', function () {
    console.log("[DEBUG] --- Nút Xem được bấm ---"); // LOG 1

    // 1. Lấy dữ liệu CÓ SẴN
    const id = $(this).data('id');
    const name = $(this).data('name');
    const discount = $(this).data('discount');
    const start = $(this).data('start');
    const end = $(this).data('end');
    const active = $(this).data('active');

    // 2. Lấy đối tượng Modal
    const viewModalElement = document.getElementById('viewPromotionModal');
    if (!viewModalElement) {
        console.error("[DEBUG] KHÔNG TÌM THẤY MODAL '#viewPromotionModal'");
        return;
    }
    const modal = bootstrap.Modal.getInstance(viewModalElement) || new bootstrap.Modal(viewModalElement);

    // 3. Gán dữ liệu CÓ SẴN (Kiểm tra lại xem các ID này có đúng không)
    $('#viewId').text(id || 'N/A');
    $('#viewName').text(name || 'N/A');
    $('#viewDiscount').text((discount !== undefined ? (discount < 1 ? discount + '%' : discount + ' VND') : 'N/A'));
    // Gán ngày tháng và status (Đảm bảo code này đúng)
    try {
        $('#viewStart').text(start ? start.split('T')[0] : 'N/A');
        $('#viewEnd').text(end ? end.split('T')[0] : 'N/A');

        const now = new Date();
        const startDate = start ? new Date(start) : null;
        const endDate = end ? new Date(end) : null;
        let statusHTML = '<span class="badge bg-secondary">Không xác định</span>'; // Default

        if (startDate && now < startDate) {
            statusHTML = '<span class="badge bg-secondary">⏳ Chưa bắt đầu</span>';
        } else if (endDate && (now > endDate || !active)) {
            statusHTML = '<span class="badge bg-danger">❌ Đã kết thúc</span>';
        } else if (startDate && endDate) { // Chỉ hiển thị active nếu có ngày hợp lệ
            statusHTML = '<span class="badge bg-success">✅ Đang hoạt động</span>';
        }
         $('#viewStatus').html(statusHTML);
         console.log("[DEBUG] Đã gán dữ liệu cơ bản vào modal."); // LOG X
    } catch(e) {
        console.error("[DEBUG] Lỗi khi gán ngày tháng/status:", e); // LOG Y (LỖI)
    }


    // 4. Reset danh sách và hiển thị "Đang tải..."
    const productListElement = document.getElementById('viewProducts');
    if (!productListElement) {
        console.error("[DEBUG] KHÔNG TÌM THẤY THẺ UL '#viewProducts'"); // LOG ERROR
        return;
    }
    console.log("[DEBUG] Đã tìm thấy UL #viewProducts."); // LOG 2
    productListElement.innerHTML = '<li class="list-group-item text-muted fst-italic">Đang tải danh sách sản phẩm...</li>';

    // 5. LẮNG NGHE sự kiện KHI MODAL ĐÃ HIỆN XONG
    $(viewModalElement).off('shown.bs.modal').on('shown.bs.modal', function () {
        console.log("[DEBUG] --- Modal ĐÃ HIỆN XONG, bắt đầu Fetch ---"); // LOG A

        fetch(`${pageContext.request.contextPath}/vendor/promotions/details/` + id)
        .then(response => {
          if (!response.ok) throw new Error('Fetch error: ' + response.status);
          return response.json();
        })
        .then(data => {
          console.log('[DEBUG] JSON data:', data);
          const products = data && data.productNames ? data.productNames : [];

          const uls = Array.from(document.querySelectorAll('#viewProducts'));
          if (uls.length === 0) {
            console.error('[DEBUG] Không tìm thấy element #viewProducts để đổ dữ liệu');
            return;
          }

          console.log('[DEBUG] #viewProducts count =', uls.length, uls);

          uls.forEach(($ul, idx) => {
            while ($ul.firstChild) $ul.removeChild($ul.firstChild);

            if (!products || products.length === 0) {
              const li = document.createElement('li');
              li.className = 'list-group-item text-muted fst-italic';
              li.textContent = 'Không có sản phẩm áp dụng.';
              $ul.appendChild(li);
              return;
            }

            products.forEach((p) => {
              const li = document.createElement('li');
              li.className = 'list-group-item';
              li.textContent = p;
              $ul.appendChild(li);
              console.log('[DEBUG] Appended LI with text:', p);
            });

            console.log('[DEBUG] UL #'+idx+' innerText:', $ul.innerText);
            console.log('[DEBUG] UL #'+idx+' innerHTML:', $ul.innerHTML);
          });
        })
        .catch(err => {
          console.error('[DEBUG] fetch error', err);
          const $ul = document.querySelector('#viewProducts');
          if ($ul) {
            $ul.innerHTML = `<li class="list-group-item text-danger">Lỗi tải sản phẩm: ${err.message}</li>`;
          }
        });
    });
 

    // 6. HIỂN THỊ MODAL
    console.log("[DEBUG] Chuẩn bị show modal..."); // LOG 11
    modal.show();

    // 7. KIỂM TRA DOM SAU MỘT KHOẢNG THỜI GIAN NGẮN
    // Chờ 1 giây sau khi modal được yêu cầu hiển thị, sau đó kiểm tra lại innerHTML
    setTimeout(() => {
        console.log("[DEBUG] --- KIỂM TRA LẠI SAU 1 GIÂY ---"); // LOG Z1
        const currentUlHtml = document.getElementById('viewProducts')?.innerHTML;
        console.log("[DEBUG] innerHTML của UL sau 1 giây:", currentUlHtml); // LOG Z2
    }, 1000); // Chờ 1000ms = 1 giây

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
