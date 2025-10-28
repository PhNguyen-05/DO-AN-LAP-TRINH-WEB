USE StarShop;
GO

CREATE TABLE addresses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    label NVARCHAR(100) NOT NULL,              -- Ví dụ: "Nhà riêng", "Công ty"
    detail NVARCHAR(255) NOT NULL,             -- Ví dụ: "123 Đường ABC, Quận X, TP Y"
    is_default BIT NOT NULL DEFAULT 0,         -- Cột boolean (false/true)
    created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME2 NULL,

    CONSTRAINT FK_addresses_customer
        FOREIGN KEY (customer_id) REFERENCES customers(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

ALTER TABLE products
ADD average_rating DECIMAL(2,1) NOT NULL DEFAULT 0;

ALTER TABLE products
ADD sold_quantity INT DEFAULT 0;

CREATE TABLE recently_viewed (
    id INT IDENTITY(1,1) PRIMARY KEY,           -- Khóa chính, tự tăng
    user_id INT NOT NULL,                       -- Khóa ngoại tham chiếu User
    product_id INT NOT NULL,                    -- Khóa ngoại tham chiếu Product
    viewed_at DATETIME DEFAULT GETDATE(),       -- Thời điểm xem (mặc định thời gian hiện tại)

    CONSTRAINT FK_recently_viewed_user FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT FK_recently_viewed_product FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE users
ADD 
    updated_at DATETIME NULL,
    otp_code NVARCHAR(10) NULL,
    otp_generated_at DATETIME NULL;

CREATE TABLE wishlist (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at DATETIME2,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);


ALTER TABLE users ALTER COLUMN password_hash NVARCHAR(1000);

USE StarShop;
GO

DELETE FROM users;
GO

INSERT INTO users (email, password_hash, role, phone, status, created_at)
VALUES 
('admin@starshop.com', '$2a$10$zuJf4GY.EmTd0IUwh2nCROWhQ5pNBdVmX55sCIY2vRMdtB24vHyr.', 'Admin', '0912345678', 'Active', SYSUTCDATETIME()),
('employee@starshop.com', '$2a$10$zuJf4GY.EmTd0IUwh2nCROWhQ5pNBdVmX55sCIY2vRMdtB24vHyr.', 'Employee', '0987654321', 'Active', SYSUTCDATETIME()),
('customer@starshop.com', '$2a$10$zuJf4GY.EmTd0IUwh2nCROWhQ5pNBdVmX55sCIY2vRMdtB24vHyr.', 'Customer', '0909090909', 'Active', SYSUTCDATETIME());

USE StarShop;
GO

-- Xóa dữ liệu cũ trong bảng Customer và Address (nếu cần)
DELETE FROM addresses;
DELETE FROM customers;
GO
INSERT INTO customers (user_id, full_name, phone, default_address, created_at)
VALUES
(20, 'Nguyen Van A', '0909090909', '123 Đường Lê Lợi, Quận 1, TP HCM', SYSUTCDATETIME());

DECLARE @customerId INT;
SELECT @customerId = id FROM customers WHERE user_id = 20;

INSERT INTO addresses (customer_id, label, detail, is_default, created_at)
VALUES
(@customerId, 'Nhà riêng', '123 Đường Lê Lợi, Quận 1, TP HCM', 1, SYSUTCDATETIME()),
(@customerId, 'Công ty', 'Tầng 5, Tòa nhà ABC, Quận 1, TP HCM', 0, SYSUTCDATETIME());

ALTER TABLE orders
ADD note NVARCHAR(500) NULL;

ALTER TABLE cart_items ADD selected BIT DEFAULT 0;


ALTER TABLE orders
ADD payment_method NVARCHAR(50),
    payment_status NVARCHAR(50) DEFAULT 'Unpaid';

