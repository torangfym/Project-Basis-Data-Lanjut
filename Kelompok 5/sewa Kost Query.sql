CREATE DATABASE SewaKost;
USE SewaKost;

-- Tabel Penghuni
CREATE TABLE Penghuni (
    id_penghuni INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    no_ktp VARCHAR(20),
    no_hp VARCHAR(15),
    email VARCHAR(100)
);

-- Tabel Kamar dengan no_kamar sebagai PRIMARY KEY
CREATE TABLE Kamar (
    no_kamar VARCHAR(10) PRIMARY KEY,
    tipe VARCHAR(50),
    harga DECIMAL(10,2),
    status ENUM('Tersedia', 'Terisi') DEFAULT 'Tersedia'
);

-- Tabel Sewa: ganti id_kamar → no_kamar
CREATE TABLE Sewa (
    id_sewa INT AUTO_INCREMENT PRIMARY KEY,
    id_penghuni INT,
    no_kamar VARCHAR(10),  -- ini penting
    tanggal_masuk DATE,
    tanggal_keluar DATE,
    total_bayar DECIMAL(12,2),
    FOREIGN KEY (id_penghuni) REFERENCES Penghuni(id_penghuni),
    FOREIGN KEY (no_kamar) REFERENCES Kamar(no_kamar)
);

CREATE TABLE Pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_sewa INT,
    tanggal_bayar DATE,
    jumlah_bayar DECIMAL(12,2),
    metode_pembayaran VARCHAR(50),
    keterangan TEXT,
    FOREIGN KEY (id_sewa) REFERENCES Sewa(id_sewa)
);

-- Data penghuni tetap
INSERT INTO Penghuni (nama, no_ktp, no_hp, email) VALUES
('Agyl Wendi Pratama', '3201010100010001', '081234567891', 'agyl.pratama@gmail.com'),
('Habib Al Qodri', '3201010100010002', '081234567892', 'habib.qodri@gmail.com'),
('Ricardo Gellael', '3201010100010003', '081234567893', 'ricardo.gellael@gmail.com'),
('Juan Argaprana Putra', '3201010100010004', '081234567894', 'juan.arga@gmail.com'),
('Muhammad Ryan Al-Habsy', '3201010100010005', '081234567895', 'ryan.alhabsy@gmail.com');

-- Data kamar dengan no_kamar sebagai PK
INSERT INTO Kamar (no_kamar, tipe, harga, status) VALUES
('A101', 'Standar', 750000.00, 'Terisi'),     -- Agyl
('A102', 'Standar', 750000.00, 'Terisi'),     -- Habib
('B201', 'Deluxe', 1000000.00, 'Terisi'),     -- Ricardo
('B202', 'Deluxe', 1000000.00, 'Terisi'),     -- Juan
('C301', 'Premium', 1500000.00, 'Terisi'),    -- Ryan
('C302', 'Premium', 1500000.00, 'Tersedia'),
('D101', 'Standar', 750000.00, 'Tersedia'),
('D102', 'Standar', 750000.00, 'Tersedia'),
('E201', 'Deluxe', 1000000.00, 'Tersedia'),
('E202', 'Deluxe', 1000000.00, 'Tersedia');

-- Data sewa: no_kamar disesuaikan
INSERT INTO Sewa (id_penghuni, no_kamar, tanggal_masuk, tanggal_keluar, total_bayar) VALUES
(1, 'A101', '2025-04-01', '2025-07-01', 2250000.00),  -- Agyl
(2, 'A102', '2025-03-10', '2025-06-10', 2250000.00),  -- Habib
(3, 'B201', '2025-01-15', '2025-04-15', 3000000.00),  -- Ricardo
(4, 'B202', '2025-02-01', '2025-05-01', 3000000.00),  -- Juan
(5, 'C301', '2025-03-20', '2025-06-20', 4500000.00);  -- Ryan

INSERT INTO Pembayaran (id_sewa, tanggal_bayar, jumlah_bayar, metode_pembayaran, keterangan) VALUES
-- Agyl Wendi Pratama (A101), total: 2.250.000 (3 bulan x 750.000)
(1, '2025-04-01', 750000.00, 'Transfer Bank', 'Pembayaran bulan 1'),
(1, '2025-05-01', 750000.00, 'Transfer Bank', 'Pembayaran bulan 2'),
(1, '2025-06-01', 750000.00, 'Transfer Bank', 'Pembayaran bulan 3'),

-- Habib Al Qodri (A102), total: 2.250.000 (3 bulan x 750.000)
(2, '2025-03-10', 750000.00, 'Cash', 'Pembayaran bulan 1'),
(2, '2025-04-10', 750000.00, 'Cash', 'Pembayaran bulan 2'),
(2, '2025-05-10', 750000.00, 'Cash', 'Pembayaran bulan 3'),

-- Ricardo Gellael (B201), total: 3.000.000 (3 bulan x 1.000.000)
(3, '2025-01-15', 1000000.00, 'E-Wallet', 'Pembayaran bulan 1'),
(3, '2025-02-15', 1000000.00, 'E-Wallet', 'Pembayaran bulan 2'),
(3, '2025-03-15', 1000000.00, 'E-Wallet', 'Pembayaran bulan 3'),

-- Juan Argaprana Putra (B202), total: 3.000.000 (3 bulan x 1.000.000)
(4, '2025-02-01', 1000000.00, 'Transfer Bank', 'Pembayaran bulan 1'),
(4, '2025-03-01', 1000000.00, 'Transfer Bank', 'Pembayaran bulan 2'),
(4, '2025-04-01', 1000000.00, 'Transfer Bank', 'Pembayaran bulan 3'),

-- Muhammad Ryan Al-Habsy (C301), total: 4.500.000 (3 bulan x 1.500.000)
(5, '2025-03-20', 1500000.00, 'Virtual Account', 'Pembayaran bulan 1'),
(5, '2025-04-20', 1500000.00, 'Virtual Account', 'Pembayaran bulan 2'),
(5, '2025-05-20', 1500000.00, 'Virtual Account', 'Pembayaran bulan 3');

SELECT * From Sewa;
SELECT * From Penghuni;
SELECT * From Pembayaran;
SELECT * From Kamar;

-- Tampilkan semua sewa lengkap dengan nama penghuni dan no kamar
SELECT 
    s.id_sewa,
    p.nama AS Nama_Penghuni,
    k.no_kamar AS Nomor_Kamar,
    k.harga,
    s.total_bayar,
    IF(s.total_bayar >= k.harga, 'LUNAS', 'BELUM LUNAS') AS Status_Pembayaran
FROM Sewa s
JOIN Penghuni p ON s.id_penghuni = p.id_penghuni
JOIN Kamar k ON s.no_kamar = k.no_kamar;

-- Rata-rata harga kamar per tipe, diurutkan dari yang tertinggi
SELECT 
    tipe,
    COUNT(*) AS Jumlah_Kamar,
    AVG(harga) AS Rata_Harga
FROM Kamar
GROUP BY tipe
ORDER BY Rata_Harga DESC;

-- Query Gabungan Total Pembayaran dan Total Tagihan
SELECT 
    p.nama AS Nama_Penghuni,
    s.no_kamar,
    s.total_bayar AS Total_Tagihan,
    COALESCE(SUM(pb.jumlah_bayar), 0) AS Total_Dibayar,
    (s.total_bayar - COALESCE(SUM(pb.jumlah_bayar), 0)) AS Sisa_Bayar
FROM Sewa s
JOIN Penghuni p ON s.id_penghuni = p.id_penghuni
LEFT JOIN Pembayaran pb ON s.id_sewa = pb.id_sewa
GROUP BY s.id_sewa;

-- View untuk mempermudah melihat data penyewaan
CREATE VIEW vw_data_sewa AS
SELECT 
    s.id_sewa,
    p.nama,
    s.no_kamar,
    s.tanggal_masuk,
    s.tanggal_keluar,
    s.total_bayar
FROM Sewa s
JOIN Penghuni p ON s.id_penghuni = p.id_penghuni
JOIN Kamar k ON s.no_kamar = k.no_kamar;

SELECT * From vw_data_sewa

-- Procedure untuk menambah data penyewaan
DELIMITER //

CREATE PROCEDURE TambahSewa(
    IN peng_id INT,
    IN kamar_nomor VARCHAR(10),
    IN tgl_masuk DATE,
    IN tgl_keluar DATE,
    IN total DECIMAL(12,2)
)
BEGIN
    INSERT INTO Sewa (id_penghuni, no_kamar, tanggal_masuk, tanggal_keluar, total_bayar)
    VALUES (peng_id, kamar_nomor, tgl_masuk, tgl_keluar, total);

    UPDATE Kamar SET status = 'Terisi' WHERE no_kamar = kamar_nomor;
END //

DELIMITER ;

-- Cari penghuni yang menyewa kamar dengan harga tertinggi
SELECT nama FROM Penghuni
WHERE id_penghuni IN (
    SELECT id_penghuni FROM Sewa
    WHERE no_kamar = (
        SELECT no_kamar FROM Kamar ORDER BY harga DESC LIMIT 1
    )
);

-- Trigger untuk update status kamar jadi 'Tersedia' setelah data sewa dihapus
DELIMITER //

CREATE TRIGGER after_delete_sewa
AFTER DELETE ON Sewa
FOR EACH ROW
BEGIN
    UPDATE Kamar SET status = 'Tersedia' WHERE no_kamar = OLD.no_kamar;
END //

DELIMITER ;

-- Fungsi Menggunakan DDL

-- Mengakses view yang sudah dibuat
SELECT * FROM vw_data_sewa;

-- Mengakses view dengan filter
SELECT * FROM vw_data_sewa WHERE nama LIKE '%Ryan%';

-- Mengurutkan data dari view
SELECT * FROM vw_data_sewa ORDER BY tanggal_masuk DESC;

-- Menampilkan sebagian kolom dari view
SELECT nama, no_kamar, tanggal_masuk, tanggal_keluar FROM vw_data_sewa;

-- Memanggil prosedur TambahSewa untuk menambah data penyewaan baru
CALL TambahSewa(1, 'D101', '2025-05-01', '2025-08-01', 2250000.00);

-- 1. Tambahkan penghuni baru terlebih dahulu
INSERT INTO Penghuni (nama, no_ktp, no_hp, email)
VALUES ('Budi Santoso', '3201010100010006', '081234567896', 'budi.santoso@gmail.com');

-- 2. Ambil ID penghuni tersebut (jika menggunakan AUTO_INCREMENT)
SET @new_penghuni_id = LAST_INSERT_ID();

-- 3. Gunakan ID tersebut untuk memanggil prosedur
CALL TambahSewa(@new_penghuni_id, 'E201', '2025-05-10', '2025-08-10', 3000000.00);

-- Penggunaan Trigger untuk menambahkan penghuni baru

-- 1. Tambahkan penghuni baru
INSERT INTO Penghuni (nama, no_ktp, no_hp, email)
VALUES ('Dina Mardiana', '3201010100010007', '081234567897', 'dina.mardiana@gmail.com');

-- 2. Dapatkan ID penghuni baru
SET @new_id = LAST_INSERT_ID();

-- 3. Gunakan prosedur TambahSewa untuk menyewakan kamar
CALL TambahSewa(@new_id, 'C302', '2025-05-15', '2025-08-15', 4500000.00);

-- 4. Lihat data sewa menggunakan view
SELECT * FROM vw_data_sewa WHERE nama = 'Dina Mardiana';

-- Fungsi trigger untuk Mengakhiri Sewa

-- 1. Identifikasi ID sewa yang akan dihapus
SELECT id_sewa FROM Sewa WHERE no_kamar = 'B201';

-- 2. Hapus pembayaran terkait terlebih dahulu (untuk menjaga integritas referensial)
DELETE FROM Pembayaran WHERE id_sewa = 3;

-- 3. Hapus data sewa yang akan mengaktifkan trigger
DELETE FROM Sewa WHERE id_sewa = 3;

-- 4. Verifikasi status kamar telah berubah menjadi 'Tersedia'
SELECT no_kamar, status FROM Kamar WHERE no_kamar = 'B201';

-- Buat user khusus admin kost
CREATE USER 'admin_kost'@'localhost' IDENTIFIED BY 'admin123';

-- Beri hak akses hanya untuk membaca data
GRANT SELECT ON SewaKost.* TO 'admin_kost'@'localhost';

-- Beri hak akses penuh ke user operator
CREATE USER 'operator'@'localhost' IDENTIFIED BY 'op123';
GRANT ALL PRIVILEGES ON SewaKost.* TO 'operator'@'localhost';

-- Terapkan perubahan hak akses
FLUSH PRIVILEGES;

DROP database SewaKost;