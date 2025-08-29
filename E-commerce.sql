-- Bảng người dùng
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL,
    Address VARCHAR(255),
    Role ENUM('Customer', 'Staff', 'Manager') NOT NULL DEFAULT 'Customer'
);

-- Bảng danh mục
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Bảng sản phẩm
CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Price DECIMAL(12,2) NOT NULL,
    Stock INT NOT NULL,
    Description TEXT,
    Image VARCHAR(255),
    Brand VARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
        ON DELETE SET NULL
);

-- Bảng giỏ hàng
CREATE TABLE Cart (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    SubTotal DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
        ON DELETE CASCADE
);

-- Bảng chi tiết giỏ hàng
CREATE TABLE CartItem (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (CartID) REFERENCES Cart(CartID)
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON DELETE CASCADE
);

-- Bảng đơn hàng
CREATE TABLE `Order` (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    TotalAmount DECIMAL(12,2) NOT NULL,
    Status ENUM('Pending','Paid','Shipped','Completed','Cancelled') DEFAULT 'Pending',
    ShippingInfo VARCHAR(255),
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CompletedDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
        ON DELETE CASCADE
);

-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetail (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID)
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON DELETE CASCADE
);

-- Bảng thanh toán
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentMethod VARCHAR(50),
    Amount DECIMAL(12,2) NOT NULL,
    Status ENUM('Pending','Success','Failed') DEFAULT 'Pending',
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID)
        ON DELETE CASCADE
);

-- Bảng khuyến mãi
CREATE TABLE Promotion (
    PromotionID INT AUTO_INCREMENT PRIMARY KEY,
    Code VARCHAR(50) UNIQUE NOT NULL,
    DiscountPercent DECIMAL(5,2) NOT NULL,
    ConditionText VARCHAR(255),
    StartDate DATE,
    EndDate DATE
);

-- Bảng báo cáo/Phản hồi khách hàng
CREATE TABLE CustomerReport (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Content TEXT NOT NULL,
    Status ENUM('Pending','Processing','Done') DEFAULT 'Pending',
    StaffID INT,
    Note TEXT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
        ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES User(UserID)
        ON DELETE SET NULL
);

-- Bảng đánh giá sản phẩm
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON DELETE CASCADE
);

-- Bảng tin nhắn hỗ trợ (chatbox)
CREATE TABLE ChatMessage (
    MessageID INT AUTO_INCREMENT PRIMARY KEY,
    SenderID INT,
    ReceiverID INT,
    Content TEXT NOT NULL,
    SentTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Unread','Read') DEFAULT 'Unread',
    FOREIGN KEY (SenderID) REFERENCES User(UserID)
        ON DELETE CASCADE,
    FOREIGN KEY (ReceiverID) REFERENCES User(UserID)
        ON DELETE CASCADE
);