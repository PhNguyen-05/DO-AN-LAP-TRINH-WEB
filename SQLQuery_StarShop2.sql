create database StarShop2;
go
USE StarShop2;
GO

/* -----------------------
   USERS / PROFILES
   ----------------------- */
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(255) NOT NULL UNIQUE,
    password_hash NVARCHAR(512) NOT NULL,
    role NVARCHAR(20) NOT NULL CHECK (role IN ('Customer','Employee','Admin')),
    status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name NVARCHAR(200) NOT NULL,
    phone NVARCHAR(20),
    default_address NVARCHAR(500),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_customers_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

CREATE TABLE employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name NVARCHAR(200) NOT NULL,
    position NVARCHAR(100),
    salary DECIMAL(18,2) CHECK (salary >= 0),
    hired_date DATETIME2 NULL,
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_employees_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

/* -----------------------
   CATEGORIES & PRODUCTS
   ----------------------- */
CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    sku NVARCHAR(100) NULL UNIQUE,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(18,2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    category_id INT NULL,
    image_url NVARCHAR(1000),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_products_categories FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);
GO

/* -----------------------
   SUPPLIERS & SUPPLIER_PRODUCTS
   ----------------------- */
CREATE TABLE suppliers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL UNIQUE,
    contact_name NVARCHAR(200),
    phone NVARCHAR(20),
    email NVARCHAR(255),
    address NVARCHAR(500),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE supplier_products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    supply_price DECIMAL(18,2) NOT NULL CHECK (supply_price >= 0),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_supplier_products_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE,
    CONSTRAINT FK_supplier_products_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT UQ_supplier_product UNIQUE (supplier_id, product_id)
);
GO

/* -----------------------
   INVENTORY LOGS (history)
   ----------------------- */
CREATE TABLE inventory_logs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    note NVARCHAR(500),
    updated_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_inventory_logs_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
GO

/* -----------------------
   CART & CART ITEMS
   ----------------------- */
CREATE TABLE carts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NULL,
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_carts_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
);
GO

CREATE TABLE cart_items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(18,2) NOT NULL CHECK (unit_price >= 0),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_cart_items_cart FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    CONSTRAINT FK_cart_items_product FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT UQ_cart_product UNIQUE (cart_id, product_id)
);
GO

/* -----------------------
   DISCOUNT CODES
   ----------------------- */
CREATE TABLE discount_codes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    code NVARCHAR(100) NOT NULL UNIQUE,
    discount_type NVARCHAR(20) NOT NULL CHECK (discount_type IN ('Percent','Fixed')),
    discount_value DECIMAL(18,2) NOT NULL CHECK (discount_value >= 0),
    start_date DATETIME2 NULL,
    end_date DATETIME2 NULL,
    condition_text NVARCHAR(500),
    quantity INT DEFAULT 0 CHECK (quantity >= 0),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

/* -----------------------
   ORDERS & ORDER DETAILS
   ----------------------- */
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NULL,
    order_date DATETIME2 DEFAULT SYSUTCDATETIME(),
    delivery_date DATETIME2 NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    total_amount DECIMAL(18,2) NOT NULL CHECK (total_amount >= 0),
    shipping_address NVARCHAR(500),
    phone_number NVARCHAR(20),
    discount_code_id INT NULL,
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    CONSTRAINT FK_orders_discount FOREIGN KEY (discount_code_id) REFERENCES discount_codes(id) ON DELETE SET NULL
);
GO

CREATE TABLE order_details (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(18,2) NOT NULL CHECK (unit_price >= 0),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_order_details_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT FK_order_details_product FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT UQ_order_product UNIQUE (order_id, product_id)
);
GO

/* -----------------------
   PAYMENTS
   ----------------------- */
CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(18,2) NOT NULL CHECK (amount >= 0),
    payment_method NVARCHAR(50),
    payment_date DATETIME2 DEFAULT SYSUTCDATETIME(),
    status NVARCHAR(50) DEFAULT 'Pending',
    gateway_reference NVARCHAR(200),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
GO

/* -----------------------
   SHIPMENTS
   ----------------------- */
CREATE TABLE shipments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    tracking_number NVARCHAR(100) UNIQUE,
    carrier NVARCHAR(100),
    shipped_at DATETIME2 NULL,
    delivered_at DATETIME2 NULL,
    status NVARCHAR(50) DEFAULT 'Shipping',
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_shipments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
GO

/* -----------------------
   REVIEWS
   ----------------------- */
CREATE TABLE reviews (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(MAX),
    review_date DATETIME2 DEFAULT SYSUTCDATETIME(),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_reviews_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT FK_reviews_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT UQ_customer_product_review UNIQUE (customer_id, product_id)
);
GO

/* -----------------------
   NOTIFICATIONS
   ----------------------- */
CREATE TABLE notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    title NVARCHAR(200),
    content NVARCHAR(MAX),
    type NVARCHAR(50),
    is_read BIT DEFAULT 0,
    sent_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_notifications_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
GO

/* -----------------------
   SUPPORT CHATS (fixed cascade issue)
   ----------------------- */
CREATE TABLE support_chats (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_khach_hang INT NOT NULL,
    id_nhan_vien INT NULL,
    noi_dung NVARCHAR(MAX),
    thoi_gian DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_khach_hang) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (id_nhan_vien) REFERENCES employees(id) ON DELETE NO ACTION
);

GO

/* -----------------------
   EVENTS & EVENT ARRANGEMENTS
   ----------------------- */
CREATE TABLE events (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    event_date DATETIME2 NULL,
    location NVARCHAR(255),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE event_arrangements (
    id INT IDENTITY(1,1) PRIMARY KEY,
    event_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_event_arrangements_event FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    CONSTRAINT FK_event_arrangements_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT UQ_event_product UNIQUE (event_id, product_id)
);
GO

/* -----------------------
   REPORTS
   ----------------------- */
CREATE TABLE reports (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200),
    report_type NVARCHAR(100),
    start_date DATETIME2,
    end_date DATETIME2,
    data_summary NVARCHAR(MAX),
    created_by INT NULL,
    created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_reports_user FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);
GO

/* -----------------------
   SAMPLE INDEXES
   ----------------------- */
CREATE INDEX IX_products_name ON products(name);
CREATE INDEX IX_products_sku ON products(sku);
CREATE INDEX IX_orders_customer_id ON orders(customer_id);
CREATE INDEX IX_cart_items_cart_id ON cart_items(cart_id);
GO

ALTER TABLE users
ADD phone NVARCHAR(20) NOT NULL UNIQUE;
GO

INSERT INTO users (email, password_hash, role, status, phone, created_at)
VALUES 
('admin@starshop.com', '123456', 'Admin', 'Active', '0909999999', SYSDATETIME()),
('employee@starshop.com', '123456', 'Employee', 'Active', '0908888888', SYSDATETIME()),
('customer@starshop.com', '123456', 'Customer', 'Active', '0907777777', SYSDATETIME());

