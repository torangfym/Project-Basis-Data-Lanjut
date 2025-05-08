create database ecommerce;
use ecommerce;

CREATE TABLE User (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(100),
  role VARCHAR(20)
);

CREATE TABLE Category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100),
  deskripsi TEXT,
  status VARCHAR(20)
);

CREATE TABLE Product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100),
  deskripsi TEXT,
  harga INT,
  stock INT,
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_id INT,
  quantity INT,
  varian VARCHAR(50),
  status VARCHAR(20),
  FOREIGN KEY (user_id) REFERENCES User(user_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  total_price INT,
  status VARCHAR(20),
  order_date DATE,
  shipping_address VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Order_Item (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  harga INT,
  varian VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  user_id INT,
  payment_method VARCHAR(50),
  payment_date DATE,
  payment_status VARCHAR(20),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Shipping (
  shipping_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  user_id INT,
  courier VARCHAR(50),
  tracking_number VARCHAR(100),
  shipping_status VARCHAR(50),
  shipping_date DATE,
  delivery_date DATE,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Review (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  category_id INT,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  review_date DATE,
  FOREIGN KEY (user_id) REFERENCES User(user_id),
  FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
INSERT INTO User (nama, email, password, role) VALUES
('Andi Saputra', 'andisaputra@gmail.com', 'password1', 'admin'),
('Budi Santoso', 'budisantoso@gmail.com', 'password2', 'customer'),
('Citra Lestari', 'citralestari@gmail.com', 'password3', 'customer'),
('Dewi Maharani', 'dewimaharani@gmail.com', 'password4', 'customer'),
('Eko Prasetyo', 'ekoprasetyo@gmail.com', 'password5', 'customer'),
('Fitriani Ayu', 'fitrianiayu@gmail.com', 'password6', 'customer'),
('Gilang Ramadhan', 'gilangramadhan@gmail.com', 'password7', 'customer'),
('Hesti Wulandari', 'hestiwulandari@gmail.com', 'password8', 'customer'),
('Imam Hidayat', 'imamhidayat@gmail.com', 'password9', 'customer'),
('Joko Suharto', 'jokosuharto@gmail.com', 'password10', 'customer');

INSERT INTO Category (nama, deskripsi, status) VALUES
('Elektronik', 'Perangkat dan gadget seperti ponsel, laptop, dan aksesori', 'tersedia'),
('Pakaian', 'Pakaian untuk pria, wanita, dan anak-anak', 'tersedia'),
('Rumah & Dapur', 'Peralatan rumah tangga dan perlengkapan dapur', 'tersedia'),
('Buku', 'Fiksi, non-fiksi, edukasi, dan lainnya', 'tersedia'),
('Kecantikan', 'Produk perawatan kulit, makeup, dan perawatan diri', 'tersedia'),
('Olahraga', 'Peralatan olahraga, kebugaran, dan kegiatan luar ruangan', 'tersedia'),
('Mainan', 'Mainan dan permainan untuk segala usia', 'tersedia'),
('Otomotif', 'Aksesori mobil dan peralatan otomotif', 'tersedia'),
('Kesehatan', 'Produk perawatan kesehatan dan suplemen', 'tersedia'),
('Perlengkapan Kantor', 'Alat tulis, elektronik kantor, dan furnitur kantor', 'tersedia');

INSERT INTO Product (nama, deskripsi, harga, stock, category_id) VALUES
('iPhone 14', 'Smartphone Apple dengan chip A15 Bionic dan penyimpanan 128GB', 23000000, 20, 1),
('Jaket Denim Pria', 'Jaket denim pria yang stylish dan tahan lama', 320000, 38, 2),
('Air Fryer', 'Penggoreng tanpa minyak untuk memasak sehat', 700000, 66, 3),
('The Great Gatsby', 'Novel klasik karya F. Scott Fitzgerald', 90000, 57, 4),
('Krim Pelembab', 'Krim hidrasi untuk kulit kering dan sensitif', 120000, 18, 5),
('Matras Yoga', 'Matras anti slip untuk yoga dan olahraga', 175000, 53, 6),
('Set LEGO City', 'Mainan balok bangunan kreatif untuk anak usia 6+', 350000, 37, 7),
('Vacuum Cleaner Mobil', 'Penyedot debu portabel untuk interior mobil', 450000, 64, 8),
('Tablet Vitamin C', 'Tingkatkan daya tahan tubuh dengan vitamin C harian', 75000, 45, 9),
('Kursi Kantor Ergonomis', 'Kursi untuk kenyamanan kerja', 900000, 47, 10);

INSERT INTO Cart (user_id, product_id, quantity, varian, status) VALUES
(2, 7, 1, 'Standard', 'aktif'),
(4, 8, 2, 'Hitam', 'aktif'),
(6, 9, 1, '1000mg', 'aktif'),
(8, 10, 4, 'Hitam', 'aktif'),
(10, 4, 1, 'Softcover', 'aktif'),
(1, 5, 1, '100ml', 'aktif'),
(3, 2, 1, 'XL', 'aktif'),
(5, 3, 2, '3.5L', 'aktif'),
(7, 6, 1, 'Ungu', 'aktif'),
(9, 1, 1, '128GB', 'aktif');

INSERT INTO Orders (user_id, total_price, status, order_date, shipping_address) VALUES
(2, 350000, 'diproses', '2025-05-02', 'Jl. Cendana No. 3'),
(4, 450000, 'dikirim', '2025-05-02', 'Jl. Sawo No. 7'),
(6, 75000, 'selesai', '2025-04-30', 'Jl. Nangka No. 12'),
(8, 900000, 'selesai', '2025-04-29', 'Jl. Rambutan No. 20'),
(10, 90000, 'diproses', '2025-05-01', 'Jl. Pepaya No. 5'),
(1, 120000, 'dibatalkan', '2025-05-02', 'Jl. Jeruk No. 15'),
(3, 320000, 'selesai', '2025-05-01', 'Jl. Kedondong No. 8'),
(5, 700000, 'dikirim', '2025-05-02', 'Jl. Semangka No. 4'),
(7, 175000, 'selesai', '2025-04-30', 'Jl. Belimbing No. 9'),
(9, 23000000, 'diproses', '2025-05-02', 'Jl. Durian No. 18');

INSERT INTO Order_Item (order_id, product_id, quantity, harga, varian) VALUES
(2, 7, 1, 350000, 'Standard'),
(10, 8, 2, 450000, 'Hitam'),
(8, 9, 1, 75000, '1000mg'),
(3, 10, 4, 900000, 'Hitam'),
(9, 4, 1, 90000, 'Softcover'),
(5, 5, 1, 120000, '100ml'),
(7, 2, 1, 320000, 'XL'),
(4, 3, 2, 700000, '3.5L'),
(6, 6, 1, 175000, 'Ungu'),
(1, 1, 1, 23000000, '128GB');

INSERT INTO Payment (order_id, user_id, payment_method, payment_date, payment_status) VALUES
(4, 2, 'E-Wallet', '2025-05-02', 'berhasil'),
(1, 4, 'Kartu Kredit', '2025-05-02', 'berhasil'),
(10, 6, 'Transfer Bank', '2025-04-30', 'berhasil'),
(9, 8, 'E-Wallet', '2025-04-29', 'berhasil'),
(2, 10, 'Kartu Kredit', '2025-05-01', 'berhasil'),
(8, 1, 'Transfer Bank', '2025-05-02', 'gagal'),
(7, 3, 'E-Wallet', '2025-05-01', 'berhasil'),
(6, 5, 'COD', '2025-05-02', 'berhasil'),
(5, 7, 'Kartu Kredit', '2025-04-30', 'berhasil'),
(3, 9, 'E-Wallet', '2025-05-02', 'berhasil');

INSERT INTO Shipping (order_id, user_id, courier, tracking_number, shipping_status, shipping_date, delivery_date) VALUES
(6, 2, 'JNE', 'JNE234567', 'diproses', '2025-05-02', NULL),
(7, 4, 'SiCepat', 'SC890123', 'dikirim', '2025-05-02', NULL),
(8, 6, 'J&T', 'JT456789', 'sampai', '2025-04-30', '2025-05-04'),
(9, 8, 'Tiki', 'TK678901', 'sampai', '2025-04-29', '2025-05-04'),
(10, 10, 'POS Indonesia', 'POS012345', 'diproses', NULL, NULL),
(1, 1, 'JNE', 'JNE987654', 'dibatalkan', NULL, NULL),
(2, 3, 'SiCepat', 'SC345678', 'sampai', '2025-05-01', '2025-05-07'),
(3, 5, 'J&T', 'JT567890', 'dikirim', '2025-05-02', NULL),
(4, 7, 'Tiki', 'TK789012', 'sampai', '2025-04-30', '2025-05-05'),
(5, 9, 'POS Indonesia', 'POS234567', 'diproses', NULL, NULL);

INSERT INTO Review (user_id, category_id, rating, comment, review_date) VALUES
(7, 2, 5, 'Produk sangat bagus dan berkualitas!', '2025-05-02'),
(8, 4, 4, 'Sangat nyaman dipakai, namun agak ketat.', '2025-05-02'),
(9, 6, 3, 'Cukup baik, namun saya mengharapkan lebih.', '2025-04-30'),
(10, 8, 5, 'Sangat puas dengan pengirimannya, produk sesuai deskripsi!', '2025-04-29'),
(4, 10, 4, 'Buku ini sangat menarik, tapi agak lambat pengirimannya.', '2025-05-01'),
(5, 1, 3, 'Krim pelembab ini oke, tapi kurang cocok untuk kulit saya.', '2025-05-02'),
(2, 3, 5, 'Jaket ini sangat stylish dan nyaman.', '2025-05-01'),
(3, 5, 4, 'Penggorengan tanpa minyak ini sangat memudahkan.', '2025-05-02'),
(6, 7, 4, 'Matras ini cukup tebal dan nyaman untuk yoga.', '2025-04-30'),
(1, 9, 5, 'iPhone 14 sangat cepat dan layarnya tajam!', '2025-05-02');

-- JOIN QUERY
SELECT o.order_id, u.nama AS nama_user, p.nama AS nama_produk, oi.quantity, oi.harga
FROM Orders o 
INNER JOIN User u ON o.user_id = u.user_id 
INNER JOIN Order_Item oi ON o.order_id = oi.order_id
INNER JOIN Product p ON oi.product_id = p.product_id;

SELECT u.user_id, u.nama, o.order_id, o.total_price
FROM User u LEFT JOIN Orders o ON u.user_id = o.user_id;

SELECT p.product_id, p.nama AS nama_produk, oi.order_id, oi.quantity
FROM Product p RIGHT JOIN Order_Item oi ON p.product_id = oi.product_id;

SELECT u.user_id, u.nama, o.order_id, o.total_price
FROM User u LEFT JOIN Orders o ON u.user_id = o.user_id 
UNION
SELECT u.user_id, u.nama, o.order_id, o.total_price
FROM User u RIGHT JOIN Orders o ON u.user_id = o.user_id;

-- ALIAS DAN OPERATOR

SELECT p.nama AS product_name, SUM(oi.quantity) AS total_sold
FROM Product p JOIN Order_Item oi ON p.product_id = oi.product_id
GROUP BY p.nama ORDER BY total_sold DESC;


SELECT u.nama AS customer_name, COUNT(o.order_id) AS number_of_orders, SUM(o.total_price) AS total_spent
FROM User u JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.nama HAVING total_spent > 1000000;

    
SELECT u.nama AS nama_pengguna, p.nama AS nama_produk, c.quantity AS jumlah, p.harga AS harga_satuan,
(p.harga * c.quantity) AS total_harga
FROM Cart AS c 
JOIN User AS u ON c.user_id = u.user_id
JOIN Product AS p ON c.product_id = p.product_id;


SELECT o.order_id AS id_pesanan, u.nama AS nama_pelanggan, o.status AS status_pesanan
FROM Orders AS o JOIN User AS u ON o.user_id = u.user_id
WHERE o.status = 'diproses' OR o.status = 'dikirim';


SELECT c.nama AS nama_kategori, SUM(p.harga * oi.quantity) AS total_pendapatan
FROM Order_Item AS oi 
JOIN Product AS p ON oi.product_id = p.product_id
JOIN Category AS c ON p.category_id = c.category_id 
GROUP BY c.nama;


SELECT o.order_id AS id_pesanan, u.nama AS nama_pelanggan, o.order_date AS tanggal_pesanan
FROM Orders AS o JOIN User AS u ON o.user_id = u.user_id
WHERE o.order_date BETWEEN '2025-05-01' AND '2025-05-03';


SELECT
  p.payment_id AS id_pembayaran,
  u.nama AS nama_pelanggan,
  CASE
    WHEN p.payment_status = 'berhasil' THEN 'Pembayaran Sukses'
    WHEN p.payment_status = 'gagal' THEN 'Pembayaran Gagal'
    ELSE 'Status Tidak Diketahui'
  END AS deskripsi_status
FROM Payment AS p
JOIN User AS u ON p.user_id = u.user_id;


SELECT p.nama AS nama_produk, p.harga AS harga_produk
FROM Product AS p
WHERE p.nama LIKE '%Kursi%';


SELECT o.order_id AS id_pesanan, o.status AS status_pesanan
FROM Orders AS o
WHERE o.status IN ('diproses', 'dikirim', 'selesai');


SELECT s.shipping_id AS id_pengiriman, o.order_id AS id_pesanan, s.shipping_date AS tanggal_pengiriman
FROM Shipping AS s
JOIN Orders AS o ON s.order_id = o.order_id
WHERE s.shipping_date IS NULL;

-- FUNCTION, GROUPING, SORTING

SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  COUNT(*) AS order_count
FROM
  Orders
GROUP BY
  DATE_FORMAT(order_date, '%Y-%m')
ORDER BY
  month;


SELECT
  c.nama AS category_name,
  AVG(r.rating) AS average_rating
FROM
  Review r
  JOIN Category c ON r.category_id = c.category_id
GROUP BY
  c.nama
ORDER BY
  average_rating DESC;


SELECT
  c.nama AS category_name,
  SUM(p.stock) AS total_stock
FROM
  Product p
  JOIN Category c ON p.category_id = c.category_id
GROUP BY
  c.nama
ORDER BY
  total_stock DESC;

SELECT
  order_date,
  SUM(total_price) AS daily_revenue
FROM
  Orders
GROUP BY
  order_date
ORDER BY
  order_date;


SELECT
  u.nama AS customer_name,
  AVG(o.total_price) AS average_order_value
FROM
  Orders o
  JOIN User u ON o.user_id = u.user_id
GROUP BY
  u.nama
ORDER BY
  average_order_value DESC;

-- STORED PROCEDURE

DELIMITER $$
CREATE PROCEDURE TambahProduk(
    IN p_nama VARCHAR(100),
    IN p_deskripsi TEXT,
    IN p_harga INT,
    IN p_stock INT,
    IN p_category_id INT
)
BEGIN
    INSERT INTO Product (nama, deskripsi, harga, stock, category_id)
    VALUES (p_nama, p_deskripsi, p_harga, p_stock, p_category_id);
    
    UPDATE Category 
    SET status = CASE
        WHEN (SELECT COUNT(*) FROM Product WHERE category_id = p_category_id) > 0 THEN 'tersedia'
        ELSE 'habis'
    END
    WHERE category_id = p_category_id;
END
$$ DELIMITER ;

CALL TambahProduk('Smartphone XYZ', 'Smartphone canggih dengan kamera 48 MP', 5000000, 20, 1);

DELIMITER $$
CREATE PROCEDURE BuatPesanan (
    IN p_user_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_varian VARCHAR(50),
    IN p_alamat VARCHAR(50)
)
BEGIN
    DECLARE harga_produk INT;
    DECLARE total INT;
    DECLARE last_order_id INT;
   
    SELECT harga INTO harga_produk FROM Product WHERE product_id = p_product_id;
    SET total = harga_produk * p_quantity;

    INSERT INTO Orders(user_id, total_price, status, order_date, shipping_address)
    VALUES(p_user_id, total, 'diproses', CURDATE(), p_alamat);
    SET last_order_id = LAST_INSERT_ID();
 
    INSERT INTO Order_Item(order_id, product_id, quantity, harga, varian)
    VALUES(last_order_id, p_product_id, p_quantity, harga_produk, p_varian);
END 
$$ DELIMITER ;

CALL BuatPesanan(5, 2, 10, 'M', 'Jl. Melati No. 25, Bengkulu');

-- NESTED 
SELECT u.user_id, u.nama, (
    SELECT SUM(o.total_price)
    FROM Orders o
    WHERE o.user_id = u.user_id
) AS total_belanja
FROM User u
ORDER BY total_belanja DESC;

SELECT c.nama, (
  SELECT AVG(r.rating)
  FROM Review r
  WHERE r.category_id = c.category_id
) AS rata_rating
FROM Category c
ORDER BY rata_rating DESC;

-- TRIGGER
DELIMITER $$
CREATE TRIGGER cek_stok
BEFORE INSERT ON Order_Item
FOR EACH ROW
BEGIN
  DECLARE stok_saat_ini INT;

  SELECT stock INTO stok_saat_ini
  FROM Product
  WHERE product_id = NEW.product_id;

  IF stok_saat_ini < NEW.quantity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Stok tidak mencukupi untuk produk ini';
  END IF;
END 
$$ DELIMITER ;

DELIMITER $$
CREATE TRIGGER kurangi_stok
AFTER INSERT ON Order_Item
FOR EACH ROW
BEGIN
    UPDATE Product
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END 
$$ DELIMITER ;

-- DCL
CREATE USER 'kasir'@'localhost' IDENTIFIED BY 'securepass123';

GRANT SELECT, INSERT ON ecommerce.Orders TO 'kasir'@'localhost';
GRANT SELECT, INSERT ON ecommerce.Order_Item TO 'kasir'@'localhost';

REVOKE UPDATE ON ecommerce.Orders FROM 'kasir'@'localhost';
SHOW GRANTS FOR 'kasir'@'localhost';