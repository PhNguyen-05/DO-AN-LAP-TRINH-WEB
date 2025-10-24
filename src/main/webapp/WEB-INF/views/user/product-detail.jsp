<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sitemesh:page title="${product.name} - StarShop">
    <sitemesh:head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(135deg, #fffafc, #e8faff);
                font-family: 'Poppins', sans-serif;
            }
            .product-container {
                max-width: 1200px;
                margin: 60px auto;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.05);
                padding: 40px;
            }
            .product-layout {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 40px;
                align-items: center;
            }
            .product-image {
                width: 100%;
                border-radius: 16px;
                object-fit: cover;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }
            .product-info h2 {
                font-family: 'Dancing Script', cursive;
                font-size: 2.3rem;
                color: #ff69b4;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .product-price {
                color: #ff69b4;
                font-size: 1.8rem;
                font-weight: 700;
                margin: 15px 0 25px;
            }
            .btn-buy {
                background-color: #ff69b4;
                color: #fff;
                border: none;
                border-radius: 25px;
                padding: 10px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-buy:hover { background-color: #ff1493; }
            .section-title {
                font-family: 'Dancing Script', cursive;
                color: #ff69b4;
                font-size: 2rem;
                margin: 60px 0 25px;
                text-align: center;
            }
            .btn-outline-pink {
                color: #ff69b4;
                border: 1px solid #ff69b4;
                border-radius: 25px;
            }
            .btn-outline-pink:hover {
                background-color: #ff69b4;
                color: #fff;
            }
            .text-pink { color: #ff69b4; }

            /* ⭐ Hiệu ứng sao trong modal */
            .rating-stars i {
                font-size: 2.3rem;
                color: #ddd;
                cursor: pointer;
                transition: transform 0.2s ease, color 0.2s ease;
                margin: 0 3px;
            }
            .rating-stars i.hovered {
                color: #FFD700;
                transform: scale(1.2);
            }
            .rating-stars i.active {
                color: #FFD700;
            }

            /* Preview ảnh/video */
            .preview-container img, .preview-container video {
                max-width: 90px;
                margin: 5px;
                border-radius: 10px;
                box-shadow: 0 0 5px rgba(0,0,0,0.15);
                transition: transform 0.2s ease;
            }
            .preview-container img:hover, .preview-container video:hover {
                transform: scale(1.05);
            }
        </style>
    </sitemesh:head>

    <div class="container my-5">
        <div class="product-container">
            <div class="product-layout">
                <div>
                    <img src="${pageContext.request.contextPath}/images/${product.imageUrl}" 
                         alt="${product.name}" class="product-image">
                </div>

                <div class="product-info">
                    <h2>${product.name}</h2>
                    <p class="product-price"><fmt:formatNumber value="${product.price}" type="number"/> ₫</p>

                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-flex align-items-center mb-3">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="number" name="quantity" value="1" min="1" 
                               class="form-control w-25 me-2 text-center rounded-pill">
                        <button type="submit" class="btn btn-buy">
                            <i class="bi bi-cart"></i> Thêm vào giỏ hàng
                        </button>
                    </form>

                    <p class="mt-2"><strong>Mô tả:</strong> ${product.description}</p>
                    <button class="btn btn-outline-pink mt-3" data-bs-toggle="modal" data-bs-target="#reviewModal">
                        <i class="bi bi-pencil-square"></i> Viết đánh giá
                    </button>
                </div>
            </div>

            <!-- ĐÁNH GIÁ SẢN PHẨM -->
            <h3 class="section-title text-start mb-4">Đánh giá sản phẩm</h3>
            <div class="row mb-5">
                <!-- Tổng điểm -->
                <div class="col-md-4">
                    <div class="border rounded p-4 text-center shadow-sm bg-light">
                        <h5 class="fw-bold mb-3">Đánh giá sản phẩm</h5>
                        <h2 class="text-warning fw-bold mb-0">
                            <fmt:formatNumber value="${averageRating}" pattern="#,##0.0"/> 
                            <small class="text-muted">/5</small>
                        </h2>
                        <div class="mt-2 mb-1">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="bi bi-star${i <= averageRating ? '-fill text-warning' : ''}" style="font-size:1.5rem;"></i>
                            </c:forEach>
                        </div>
                        <p class="text-muted mb-0">(${reviewCount} đánh giá)</p>
                    </div>
                </div>

                <!-- Tỉ lệ sao -->
                <div class="col-md-8">
                    <div class="bg-light border rounded p-4 shadow-sm">
                        <c:forEach var="i" begin="1" end="5">
                            <c:set var="star" value="${6 - i}" />
                            <div class="d-flex align-items-center mb-2">
                                <div class="me-2" style="width:50px;">${star} sao</div>
                                <div class="progress flex-grow-1" style="height:8px;">
                                    <div class="progress-bar bg-warning" 
                                         role="progressbar" 
                                         style="width: ${ratingPercentages[star]}%;"
                                         aria-valuenow="${ratingPercentages[star]}" 
                                         aria-valuemin="0" 
                                         aria-valuemax="100"></div>
                                </div>
                                <div class="ms-2 text-muted" style="width:40px;">
                                    <fmt:formatNumber value="${ratingPercentages[star]}" pattern="#0"/>%
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- DANH SÁCH REVIEW -->
            <h4 class="fw-bold mb-3">Đánh giá & Bình luận</h4>
            <div class="mt-3">
                <c:if test="${empty reviews}">
                    <p class="text-muted text-center">Chưa có đánh giá nào cho sản phẩm này.</p>
                </c:if>
                <c:forEach var="r" items="${reviews}">
                    <div class="border-bottom py-3">
                        <div class="text-warning mb-1">
                            <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                        </div>
                        <p class="mb-1">${r.content}</p>
                        <small class="text-muted"><fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                    </div>
                </c:forEach>
            </div>

            <!-- 🌸 MODAL VIẾT ĐÁNH GIÁ -->
            <div class="modal fade" id="reviewModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow-lg">
                        <div class="modal-header border-0 bg-light">
                            <h5 class="modal-title fw-semibold text-pink">
                                <i class="bi bi-chat-heart-fill me-2 text-pink"></i> Viết đánh giá sản phẩm
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body px-4 pb-4">
                            <p class="text-center fw-medium mb-3 text-secondary">
                                Hãy chia sẻ trải nghiệm của bạn với sản phẩm này nhé 💕
                            </p>
                            <div class="rating-stars mb-4 text-center">
                                <i class="bi bi-star" data-value="1"></i>
                                <i class="bi bi-star" data-value="2"></i>
                                <i class="bi bi-star" data-value="3"></i>
                                <i class="bi bi-star" data-value="4"></i>
                                <i class="bi bi-star" data-value="5"></i>
                            </div>
                            <textarea id="reviewContent" class="form-control mb-3 border-2" rows="3"
                                placeholder="Sản phẩm này có tốt không? Bạn thích hay không thích điểm nào?"
                                style="border-radius: 12px;"></textarea>
                            <label class="fw-semibold mb-2"><i class="bi bi-paperclip text-pink"></i> Đính kèm ảnh/video:</label>
                            <input type="file" id="fileUpload" class="form-control" multiple accept="image/*,video/*"
                                style="border-radius: 12px;">
                            <div class="preview-container d-flex flex-wrap mt-3"></div>
                        </div>
                        <div class="modal-footer border-0 justify-content-between px-4 pb-4">
                            <button class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Hủy</button>
                            <button class="btn btn-buy px-4" id="submitReview">
                                <i class="bi bi-send"></i> Gửi đánh giá
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 🌸 SẢN PHẨM LIÊN QUAN -->
            <c:if test="${not empty relatedProducts}">
                <h3 class="section-title">🌸 Sản phẩm liên quan 🌸</h3>
                <div class="row g-4 mt-3">
                    <c:forEach var="hoa" items="${relatedProducts}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card product-card">
                                <img src="${pageContext.request.contextPath}/images/${hoa.imageUrl}" class="card-img-top" alt="${hoa.name}">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${hoa.name}</h5>
                                    <p class="price"><fmt:formatNumber value="${hoa.price}" type="number"/> ₫</p>
                                    <a href="${pageContext.request.contextPath}/product/${hoa.id}" class="btn btn-outline-pink btn-sm">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        // ⭐ Hiệu ứng sao hover + chọn
        const stars = document.querySelectorAll('.rating-stars i');
        let selectedRating = 0;
        stars.forEach((star, index) => {
            star.addEventListener('mouseover', () => {
                stars.forEach((s, i) => s.classList.toggle('hovered', i <= index));
            });
            star.addEventListener('mouseout', () => stars.forEach(s => s.classList.remove('hovered')));
            star.addEventListener('click', () => {
                selectedRating = index + 1;
                stars.forEach((s, i) => s.classList.toggle('active', i < selectedRating));
            });
        });

        // Preview file
        const fileInput = document.getElementById('fileUpload');
        const preview = document.querySelector('.preview-container');
        fileInput.addEventListener('change', () => {
            preview.innerHTML = '';
            Array.from(fileInput.files).forEach(file => {
                const url = URL.createObjectURL(file);
                if (file.type.startsWith('image')) {
                    const img = document.createElement('img');
                    img.src = url;
                    preview.appendChild(img);
                } else if (file.type.startsWith('video')) {
                    const vid = document.createElement('video');
                    vid.src = url;
                    vid.controls = true;
                    preview.appendChild(vid);
                }
            });
        });

        // Gửi đánh giá
        document.getElementById('submitReview').addEventListener('click', async () => {
            const content = document.getElementById('reviewContent').value.trim();
            if (!selectedRating || !content) {
                alert('Vui lòng chọn số sao và nhập nội dung đánh giá.');
                return;
            }
            const formData = new FormData();
            formData.append('rating', selectedRating);
            formData.append('content', content);
            Array.from(fileInput.files).forEach(f => formData.append('files', f));

            const res = await fetch('${pageContext.request.contextPath}/product/${product.id}/review', {
                method: 'POST',
                body: formData
            });
            if (res.ok) {
                alert('Cảm ơn bạn đã gửi đánh giá!');
                location.reload();
            } else {
                alert('Gửi đánh giá thất bại.');
            }
        });
    </script>
</sitemesh:page>
