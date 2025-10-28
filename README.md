# 🌸 StarShop – Cửa Hàng Bán Hoa Tươi

---

## 📖 Giới thiệu

**StarShop** là nền tảng thương mại điện tử chuyên kinh doanh **hoa tươi**, được xây dựng bằng **Spring Boot Framework** với kiến trúc 3 lớp (Controller – Service – Repository).
Hệ thống cung cấp giao diện hiện đại, thân thiện và an toàn, hỗ trợ nhiều vai trò người dùng, tích hợp thanh toán, xác thực OTP, thông báo thời gian thực và quản lý linh hoạt.

---

## ⚙️ Công nghệ sử dụng

| Thành phần             | Công nghệ                                                           |
| ---------------------- | -----------------------------------------------------------------   |
| **Backend**            | Spring Boot 3.x, Spring Security, JPA (Hibernate), JWT, WebSocket   |
| **Frontend**           | JSP / JSTL, Bootstrap 5, HTML5, CSS3, JavaScript, Decorator Sitemesh|
| **Cơ sở dữ liệu**      | SQL Server                                                          |
| **Công cụ build**      | Maven                                                               |
| **Quản lý mã nguồn**   | GitHub                                                              |
| **Công cụ phát triển** | IntelliJ IDEA / Eclipse / VSCode                                    |

---

## ⚡ Tính năng nổi bật

### 👤 Người dùng (Khách hàng)

| Chức năng              | Mô tả                                               |
| ---------------------- | --------------------------------------------------- |
| 🛍️ Mua sắm trực tuyến | Giao diện thân thiện, tối ưu trải nghiệm người dùng |
| 🔍 Tìm kiếm & Lọc      | Tìm sản phẩm theo danh mục, giá, tên                |
| 💳 Thanh toán          | Hỗ trợ **COD, VNPay, MoMo**                         |
| 📦 Theo dõi đơn hàng   | Cập nhật trạng thái đơn hàng theo thời gian thực    |
| ⭐ Đánh giá & Bình luận | Người dùng có thể đánh giá và nhận xét sản phẩm     |
| 💌 Thông báo           | Gửi thông báo tự động về đơn hàng và khuyến mãi     |
| 🔐 Xác thực OTP        | Đăng ký và quên mật khẩu qua OTP Email              |

### 🏪 Người bán (Vendor)

| Chức năng            | Mô tả                                    |
| -------------------- | ---------------------------------------- |
| 🏷️ Quản lý cửa hàng | Đăng ký, chỉnh sửa và quản lý shop riêng |
| 🌼 Quản lý sản phẩm  | CRUD sản phẩm, hình ảnh, danh mục        |
| 📦 Quản lý đơn hàng  | Cập nhật, xử lý, thống kê tình trạng đơn |
| 💰 Khuyến mãi        | Tạo và áp dụng chương trình giảm giá     |
| 📊 Doanh thu | Xem thống kê doanh số theo thời gian     |

### ⚙️ Quản trị viên (Admin)

⚙️ Quản trị viên (Admin)
|Chức năng	        |     Mô tả
|-----------------------|-------------------------------------------------------------|
|👥 Quản lý vendor	|Thêm, chỉnh sửa, xóa và quản lý thông tin cửa hàng           |
|🌸 Quản lý danh mục	|Tổ chức, thêm mới, chỉnh sửa loại hoa và phân loại sản phẩm  |
|🛍️ Quản lý sản phẩm	|Quản lý, duyệt và theo dõi sản phẩm từ các cửa hàng          |
|💰 Mã giảm giá	        |Tạo, áp dụng và quản lý chương trình khuyến mãi              |
|👤 Quản lý khách hàng	|Theo dõi, chỉnh sửa và khóa/mở tài khoản người dùng          |
|📈 Bảng điều khiển	|Xem thống kê doanh thu, đơn hàng, khách hàng, sản phẩm       |

---

## 🏗️ Kiến trúc hệ thống

```
src/main/java/vn/starshop/
├── config/          # Cấu hình Spring Boot
├── controller/      # Controller (MVC & REST)
├── dto/             # Đối tượng truyền dữ liệu
├── entity/          # Các thực thể JPA
├── repository/      # Lớp truy xuất dữ liệu
├── service/         # Xử lý nghiệp vụ
├── util/            # Tiện ích dùng chung
└── security/        # Cấu hình bảo mật, JWT, Authentication
```

### Mô hình tầng

```
Giao diện người dùng (JSP + Bootstrap)
        │
Controller (Spring MVC)
        │
Service (Xử lý nghiệp vụ)
        │
Repository (Spring Data JPA)
        │
Cơ sở dữ liệu (SQL Server / MySQL / PostgreSQL)
```

---

## 🔐 Điểm nổi bật kỹ thuật

✅ Hệ thống đa vai trò: Khách – Người dùng – Người bán – Quản trị – Shipper
✅ Xác thực OTP qua Email và đăng nhập bằng JWT Token
✅ Giao diện Responsive với Bootstrap 5
✅ Thông báo thời gian thực bằng WebSocket
✅ Tích hợp thanh toán VNPay, MoMo, COD
✅ Quản lý khuyến mãi và giảm giá linh hoạt
✅ Phân quyền chi tiết theo vai trò người dùng

---

## 🖥️ Hướng dẫn cài đặt

### Yêu cầu hệ thống

* ☕ **Java 21 trở lên**
* 🛠️ **Maven 3.6+**
* 🗄️ **SQL Server 2019+**
* 💻 **IDE**: IntelliJ IDEA / Eclipse / VSCode

### Cài đặt

1. **Clone dự án**

   ```bash
   git clone https://github.com/starshop-team/starshop.git
   cd starshop
   ```
2. **Tạo cơ sở dữ liệu**

   ```sql
   CREATE DATABASE StarShop;
   ```
3. **Cấu hình `application.properties`**

   ```properties
   spring.datasource.url=jdbc:sqlserver://localhost:1433;databaseName=StarShop
   spring.datasource.username=sa
   spring.datasource.password=your_password
   spring.jpa.hibernate.ddl-auto=update
   app.jwt.secret=your_secret_key
   spring.mail.username=your_email@gmail.com
   spring.mail.password=your_email_password
   ```
4. **Chạy ứng dụng**

   ```bash
   mvn clean install
   mvn spring-boot:run
   ```
5. **Truy cập hệ thống**

* 🌐 Trang người dùng: [http://localhost:8080/home](http://localhost:8080/home)
* 🏪 Trang người bán: [http://localhost:8080/vendor/home](http://localhost:8080/vendor/home)
* ⚙️ Trang quản trị: [http://localhost:8080/admin/dashboard](http://localhost:8080/admin/dashboard)


---


## 🧩 Yêu cầu phi chức năng

* **Bảo mật:** Mã hóa mật khẩu, JWT, phân quyền Spring Security
* **Hiệu năng:** Phân trang, tải dữ liệu theo nhu cầu
* **Khả năng mở rộng:** Thiết kế module độc lập, dễ phát triển thêm
* **Tương thích:** Responsive trên mọi thiết bị
* **Bảo trì:** Cấu trúc rõ ràng, tuân thủ mô hình MVC và SOLID

---

## 🔮 Hướng phát triển

* 📱 Xây dựng ứng dụng **di động (Android/iOS)**
* 🌍 Tích hợp **thanh toán quốc tế**
* 🚚 Liên kết **API giao vận (GHN, GHTK)**
* 🤖 Tích hợp **AI gợi ý sản phẩm**
* ☁️ Triển khai **lên AWS / Azure**
* 💬 Bổ sung **chat trực tuyến với người bán**

---

## 📚 Tài liệu tham khảo

* [Spring Boot](https://spring.io/projects/spring-boot)
* [Spring Security](https://spring.io/projects/spring-security)
* [Bootstrap 5](https://getbootstrap.com)
* [JWT.io](https://jwt.io/introduction/)
* [Baeldung – WebSocket in Spring](https://www.baeldung.com/websockets-spring)

---


| Họ và Tên             | MSSV     |
| --------------------- | -------- |
| Nguyễn Thị Hoàng Kim  | 23110248 |
| Trần Hồ Phương Nguyên | 23110271 |
| Trần Bảo Việt         | 22133065 |

### © 2025 Nhóm 04 – StarShop | Đại học Sư phạm Kỹ thuật TP.HCM

Được phát triển với ❤️ bằng **Spring Boot**, **JSP**, và **Bootstrap**.
