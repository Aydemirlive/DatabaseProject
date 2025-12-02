---------------------------------------------------------
-- E-TICARET YÖNETÝM SÝSTEMÝ VERÝTABANI
-- Burhan Aydemir - Proje
-- Tablo Oluþturma Bölümü
---------------------------------------------------------

CREATE DATABASE ETicaretDB;
GO
USE ETicaretDB;
GO

---------------------------------------------------------
-- 1) CATEGORIES (KATEGORILER)
---------------------------------------------------------
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

---------------------------------------------------------
-- 2) PRODUCTS (ÜRÜNLER)
---------------------------------------------------------
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_products_categories FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

---------------------------------------------------------
-- 3) CUSTOMERS (MÜÞTERÝLER)
---------------------------------------------------------
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT GETDATE()
);

---------------------------------------------------------
-- 4) SHIPPING_ADDRESSES (TESLÝMAT ADRESLERÝ)
---------------------------------------------------------
CREATE TABLE shipping_addresses (
    address_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    address_line VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'Türkiye',

    CONSTRAINT FK_addresses_customers FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

---------------------------------------------------------
-- 5) ORDERS (SÝPARÝÞLER)
---------------------------------------------------------
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(50) DEFAULT 'Pending',

    CONSTRAINT FK_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

---------------------------------------------------------
-- 6) ORDER_ITEMS (SÝPARÝÞ DETAYLARI)
---------------------------------------------------------
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_items_orders FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT FK_items_products FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

---------------------------------------------------------
-- 7) REVIEWS (ÜRÜN YORUMLARI)
---------------------------------------------------------
CREATE TABLE reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    comment VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_reviews_customers FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT FK_reviews_products FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

---------------------------------------------------------
-- CATEGORIES - Örnek Veriler
---------------------------------------------------------
INSERT INTO categories (category_name) VALUES
('Elektronik'),
('Giyim'),
('Mobilya'),
('Kitap'),
('Spor'),
('Bilgisayar'),
('Telefon'),
('Kozmetik'),
('Ev Aletleri'),
('Aksesuar');

---------------------------------------------------------
-- PRODUCTS - Örnek Veriler
---------------------------------------------------------
INSERT INTO products (category_id, product_name, price, stock) VALUES
(1, 'Bluetooth Kulaklýk', 450.00, 50),
(1, 'Akýllý TV', 12500.00, 10),
(7, 'iPhone 14', 48500.00, 15),
(7, 'Samsung Galaxy S23', 38500.00, 20),
(6, 'Gaming Laptop', 32500.00, 8),
(2, 'Spor Ayakkabý', 950.00, 100),
(4, 'Roman Kitap', 75.00, 200),
(9, 'Elektrikli Süpürge', 2800.00, 25),
(3, 'Ofis Sandalyesi', 1750.00, 30),
(8, 'Parfüm', 650.00, 45);

---------------------------------------------------------
-- CUSTOMERS - Örnek Veriler
---------------------------------------------------------
INSERT INTO customers (first_name, last_name, email, phone) VALUES
('Ahmet', 'Yýlmaz', 'ahmet@gmail.com', '05312345678'),
('Mehmet', 'Demir', 'mehmet@gmail.com', '05322345678'),
('Ayþe', 'Kara', 'ayse@gmail.com', '05332345678'),
('Fatma', 'Yýldýz', 'fatma@gmail.com', '05342345678'),
('Ali', 'Öztürk', 'ali@gmail.com', '05352345678'),
('Buse', 'Taþ', 'buse@gmail.com', '05362345678'),
('Zeynep', 'Þimþek', 'zeynep@gmail.com', '05372345678'),
('Emre', 'Bal', 'emre@gmail.com', '05382345678'),
('Yusuf', 'Arslan', 'yusuf@gmail.com', '05392345678'),
('Murat', 'Ak', 'murat@gmail.com', '05301345678');

---------------------------------------------------------
-- SHIPPING_ADDRESSES - Örnek Veriler
---------------------------------------------------------
INSERT INTO shipping_addresses (customer_id, address_line, city) VALUES
(1, 'Ýstiklal Cad. No:10', 'Ýstanbul'),
(2, 'Yenimahalle Sok. No:25', 'Ankara'),
(3, 'Alsancak Mah. No:33', 'Ýzmir'),
(4, 'Kýzýlay Cad. No:12', 'Ankara'),
(5, 'Atatürk Bulvarý No:8', 'Bursa'),
(6, 'Barbaros Cad. No:14', 'Antalya'),
(7, 'Gazi Mah. No:55', 'Eskiþehir'),
(8, 'Yýldýz Sok. No:5', 'Trabzon'),
(9, 'Sahil Yolu No:19', 'Samsun'),
(10, 'Merkez Mah. No:3', 'Konya');

---------------------------------------------------------
-- ORDERS - Örnek Veriler
---------------------------------------------------------
INSERT INTO orders (customer_id, status) VALUES
(1, 'Completed'),
(1, 'Pending'),
(3, 'Completed'),
(5, 'Cancelled'),
(2, 'Completed'),
(4, 'Pending'),
(6, 'Completed'),
(7, 'Completed'),
(9, 'Pending'),
(10, 'Completed');

---------------------------------------------------------
-- ORDER_ITEMS - Örnek Veriler
---------------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 3, 1, 48500.00),  -- iPhone
(1, 1, 2, 450.00),    -- Kulaklýk
(2, 6, 1, 950.00),    -- Spor Ayakkabý
(3, 9, 1, 1750.00),
(4, 10, 1, 650.00),
(5, 2, 1, 12500.00),
(6, 7, 3, 75.00),
(7, 5, 1, 32500.00),
(8, 4, 2, 38500.00),
(9, 8, 1, 2800.00);

---------------------------------------------------------
-- REVIEWS - Örnek Veriler
---------------------------------------------------------
INSERT INTO reviews (customer_id, product_id, rating, comment) VALUES
(1, 3, 5, 'Harika bir telefon!'),
(2, 1, 4, 'Ses kalitesi iyi'),
(3, 6, 5, 'Çok rahat bir ayakkabý'),
(4, 9, 3, 'Ortalama bir sandalye'),
(5, 10, 4, 'Güzel koku'),
(6, 3, 5, 'Bayýldým!'),
(7, 7, 3, 'Fiyat yüksek'),
(8, 4, 4, 'Kitap sürükleyici'),
(9, 1, 5, 'Kulaklýk çok iyi'),
(10, 2, 5, 'TV performansý harika');

---------------------------------------------------------
-- FONKSÝYON 1: Sipariþ Toplam Tutarý Hesaplama
---------------------------------------------------------
CREATE FUNCTION calculate_order_total(@order_id INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = SUM(quantity * unit_price)
    FROM order_items
    WHERE order_id = @order_id;

    RETURN ISNULL(@total, 0);
END;
GO

SELECT dbo.calculate_order_total(2) AS SiparisToplamTutar;

---------------------------------------------------------
-- FONKSÝYON 2: Müþterinin Toplam Harcamasý (Lifetime Value)
---------------------------------------------------------
CREATE FUNCTION customer_lifetime_value(@customer_id INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @lifetime_value DECIMAL(10,2);

    SELECT @lifetime_value = SUM(dbo.calculate_order_total(order_id))
    FROM orders
    WHERE customer_id = @customer_id AND status = 'Completed';

    RETURN ISNULL(@lifetime_value, 0);
END;
GO

SELECT dbo.customer_lifetime_value(2) AS MusteriToplamHarcama;

---------------------------------------------------------
-- FONKSÝYON 3: Stok Durumu Kontrolü
---------------------------------------------------------
CREATE FUNCTION stock_status(@product_id INT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @stock INT;
    DECLARE @status VARCHAR(20);

    SELECT @stock = stock FROM products WHERE product_id = @product_id;

    IF @stock IS NULL
        SET @status = 'Ürün Bulunamadý';
    ELSE IF @stock = 0
        SET @status = 'Tükendi';
    ELSE IF @stock < 10
        SET @status = 'Az';
    ELSE IF @stock BETWEEN 10 AND 30
        SET @status = 'Orta';
    ELSE
        SET @status = 'Çok';

    RETURN @status;
END;
GO

SELECT product_name, stock, dbo.stock_status(product_id) AS StokDurumu
FROM products;

---------------------------------------------------------
-- TRIGGER 1: Sipariþ oluþturulunca stok azaltma
---------------------------------------------------------
CREATE TRIGGER trg_reduce_stock_on_order
ON order_items
AFTER INSERT
AS
BEGIN
    UPDATE products
    SET stock = stock - i.quantity
    FROM products p
    INNER JOIN inserted i ON p.product_id = i.product_id;
END;
GO

INSERT INTO order_items(order_id, product_id, quantity, unit_price)
VALUES (1, 1, 5, 450.00);

SELECT product_name, stock FROM products WHERE product_id = 1; -- 5 azalmalý

---------------------------------------------------------
-- PRODUCT PRICE LOG TABLE
---------------------------------------------------------
CREATE TABLE product_price_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    changed_at DATETIME DEFAULT GETDATE()
);
GO

---------------------------------------------------------
-- TRIGGER 2: Ürün fiyatý deðiþince log kaydý
---------------------------------------------------------
CREATE TRIGGER trg_product_price_log
ON products
AFTER UPDATE
AS
BEGIN
    IF UPDATE(price)
    BEGIN
        INSERT INTO product_price_log(product_id, old_price, new_price)
        SELECT d.product_id, d.price, i.price
        FROM deleted d
        INNER JOIN inserted i ON d.product_id = i.product_id;
    END
END;
GO

UPDATE products SET price = 500.00 WHERE product_id = 1;
SELECT * FROM product_price_log; -- yeni kayýt görünmeli

---------------------------------------------------------
-- TRIGGER 3: Sipariþ iptalinde stok geri yükleme
---------------------------------------------------------
CREATE TRIGGER trg_restore_stock_on_cancel
ON orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(status)
    BEGIN
        UPDATE p
        SET p.stock = p.stock + oi.quantity
        FROM products p
        INNER JOIN order_items oi ON p.product_id = oi.product_id
        INNER JOIN inserted i ON i.order_id = oi.order_id
        WHERE i.status = 'Cancelled';
    END
END;
GO

UPDATE orders SET status = 'Cancelled' WHERE order_id = 1;
SELECT product_name, stock FROM products WHERE product_id = 1; -- stok geri artmalý

---------------------------------------------------------
-- SP 1: Sipariþ Verme Ýþlemi
---------------------------------------------------------
CREATE PROCEDURE sp_place_order
    @customer_id INT,
    @product_id INT,
    @quantity INT
AS
BEGIN
    DECLARE @stock INT, @order_id INT, @price DECIMAL(10,2);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Ürün stok kontrolü
        SELECT @stock = stock, @price = price FROM products WHERE product_id = @product_id;

        IF @stock < @quantity
        BEGIN
            RAISERROR('Yeterli stok yok!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Sipariþ oluþtur
        INSERT INTO orders (customer_id, status)
        VALUES (@customer_id, 'Pending');

        SET @order_id = SCOPE_IDENTITY();

        -- Sipariþ detay ekleme
        INSERT INTO order_items (order_id, product_id, quantity, unit_price)
        VALUES (@order_id, @product_id, @quantity, @price);

        -- Baþarýlý sipariþ
        UPDATE orders SET status = 'Completed' WHERE order_id = @order_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR('Sipariþ oluþturulurken hata oluþtu!', 16, 1);
    END CATCH
END;
GO

EXEC sp_place_order @customer_id = 1, @product_id = 1, @quantity = 2;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT stock FROM products WHERE product_id = 1; -- 2 düþmeli

---------------------------------------------------------
-- SP 2: Sipariþ Ýptal Etme Ýþlemi
---------------------------------------------------------
CREATE PROCEDURE sp_cancel_order
    @order_id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS(SELECT 1 FROM orders WHERE order_id = @order_id)
        BEGIN
            RAISERROR('Sipariþ bulunamadý!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE orders
        SET status = 'Cancelled'
        WHERE order_id = @order_id;

        -- stok geri yükleme trigger ile otomatik çalýþýr

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR('Sipariþ iptal edilirken hata oluþtu!', 16, 1);
    END CATCH
END;
GO

EXEC sp_cancel_order @order_id = 1;
SELECT status FROM orders WHERE order_id = 1;
SELECT stock FROM products; -- ilgili ürünlerin stoðu geri artmýþ olmalý

-- ============================================
-- VIEW: vw_category_sales_stats
-- Açýklama: Kategorilere göre satýþ istatistiklerini gösterir
-- ============================================

CREATE VIEW vw_category_sales_stats AS
SELECT 
    c.category_name AS CategoryName,
    SUM(oi.quantity) AS TotalUnitsSold,                        -- Satýlan toplam ürün adedi
    SUM(oi.quantity * oi.unit_price) AS TotalSalesAmount,      -- Toplam satýþ tutarý (TL)
    AVG(oi.unit_price) AS AverageUnitPrice                    -- Ortalama satýþ fiyatý
FROM categories c
JOIN products p ON p.category_id = c.category_id
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'Completed'   -- Tamamlanan sipariþler
GROUP BY c.category_name;
GO

SELECT * FROM vw_category_sales_stats;

-- VIEW 2: Müþteri Sipariþ Özeti
-- Amaç: Her müþterinin toplam sipariþ sayýsý, toplam harcamasý
-- ve ortalama sepet tutarýný göstermektedir.
---------------------------------------------------------
CREATE VIEW vw_customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,   -- Müþteri Ad Soyad
    COUNT(o.order_id) AS total_orders,                   -- Toplam sipariþ sayýsý
    SUM(oi.quantity * oi.unit_price) AS total_spent,     -- Toplam harcama (TL)
    AVG(dbo.calculate_order_total(o.order_id)) AS average_order_value -- Ortalama sepet
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id AND o.status = 'Completed'
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;
GO

SELECT * FROM vw_customer_order_summary;

---------------------------------------------------------
-- KOMPLEKS SORGU 1: En Çok Satan Ürünler (TOP 10)
---------------------------------------------------------
SELECT TOP 10
    p.product_name AS UrunAdi,
    c.category_name AS Kategori,
    SUM(oi.quantity) AS ToplamSatisAdedi,
    SUM(oi.quantity * oi.unit_price) AS ToplamCiro
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY ToplamSatisAdedi DESC; -- En çok satandan aza
GO


---------------------------------------------------------
-- KOMPLEKS SORGU 2: Kategorilere Göre Ortalama Fiyat ve Stok Durumu
---------------------------------------------------------
SELECT 
    c.category_name AS Kategori,
    COUNT(p.product_id) AS UrunSayisi,
    AVG(p.price) AS OrtalamaFiyat,
    SUM(p.stock) AS ToplamStok,
    CASE 
        WHEN SUM(p.stock) > 100 THEN 'Bol'
        WHEN SUM(p.stock) BETWEEN 50 AND 100 THEN 'Orta'
        WHEN SUM(p.stock) BETWEEN 1 AND 49 THEN 'Az'
        ELSE 'Tükendi'
    END AS StokDurumu
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY OrtalamaFiyat DESC;
GO

---------------------------------------------------------
-- KOMPLEKS SORGU 3: Ortalama Sipariþ Tutarýndan Yüksek Sipariþler
---------------------------------------------------------
SELECT 
    o.order_id,
    c.first_name + ' ' + c.last_name AS CustomerName,
    SUM(oi.quantity * oi.unit_price) AS OrderTotal
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.order_id, c.first_name, c.last_name
HAVING SUM(oi.quantity * oi.unit_price) > (
    -- Ortalama sipariþ tutarý (tüm tamamlanmýþ sipariþler)
    SELECT AVG(sub.TotalAmount)
    FROM (
        SELECT SUM(quantity * unit_price) AS TotalAmount
        FROM order_items
        INNER JOIN orders ON orders.order_id = order_items.order_id
        WHERE orders.status = 'Completed'
        GROUP BY order_items.order_id
    ) AS sub
)
ORDER BY OrderTotal DESC;
GO
