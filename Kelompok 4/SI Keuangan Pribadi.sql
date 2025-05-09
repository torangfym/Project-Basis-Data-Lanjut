CREATE DATABASE financial_management;
USE financial_management;

CREATE TABLE Pengguna (
    Id_Pengguna INT PRIMARY KEY,
    Nama VARCHAR(100),
    Email VARCHAR(100),
    No_Handphone VARCHAR(20)
);

CREATE TABLE Pengeluaran (
    Id_Pengeluaran INT PRIMARY KEY,
    Id_Pengguna INT,
    Tanggal DATE,
    Jumlah DECIMAL(12,2),
    FOREIGN KEY (Id_Pengguna) REFERENCES Pengguna(Id_Pengguna)
);

CREATE TABLE Pemasukan (
    Id_Pemasukan INT PRIMARY KEY,
    Id_Pengguna INT,
    Tanggal DATE,
    Jumlah DECIMAL(12,2),
    FOREIGN KEY (Id_Pengguna) REFERENCES Pengguna(Id_Pengguna)
);

CREATE TABLE Hutang (
    Id_Hutang INT PRIMARY KEY,
    Id_Pengguna INT,
    Tanggal_Hutang DATE,
    Jatuh_Tempo DATE,
    Jumlah DECIMAL(12,2),
    FOREIGN KEY (Id_Pengguna) REFERENCES Pengguna(Id_Pengguna)
);

CREATE TABLE Tabungan (
    Id_Tabungan INT PRIMARY KEY,
    Id_Pengguna INT,
    Jumlah DECIMAL(12,2),
    Target DECIMAL(12,2),
    FOREIGN KEY (Id_Pengguna) REFERENCES Pengguna(Id_Pengguna)
);

CREATE TABLE Asset (
    Id_Asset INT PRIMARY KEY,
    Id_Pengguna INT,
    Jenis VARCHAR(50),
    Nilai DECIMAL(12,2),
    FOREIGN KEY (Id_Pengguna) REFERENCES Pengguna(Id_Pengguna)
);

CREATE TABLE Laporan (
    Id_Laporan INT PRIMARY KEY,
    Id_Pengguna INT,
    Kategori VARCHAR(50),
    Tanggal DATE,
    FOREIGN KEY (Id_Pengguna) REFERENCES Pengguna(Id_Pengguna)
);

CREATE TABLE Catat_Pengeluaran (
    Id_Pengeluaran INT,
    Id_Laporan INT,
    FOREIGN KEY (Id_Pengeluaran) REFERENCES Pengeluaran(Id_Pengeluaran),
    FOREIGN KEY (Id_Laporan) REFERENCES Laporan(Id_Laporan)
);

CREATE TABLE Catat_Pemasukan (
    Id_Pemasukan INT,
    Id_Laporan INT,
    FOREIGN KEY (Id_Pemasukan) REFERENCES Pemasukan(Id_Pemasukan),
    FOREIGN KEY (Id_Laporan) REFERENCES Laporan(Id_Laporan)
);

CREATE TABLE Catat_Hutang (
    Id_Hutang INT,
    Id_Laporan INT,
    FOREIGN KEY (Id_Hutang) REFERENCES Hutang(Id_Hutang),
    FOREIGN KEY (Id_Laporan) REFERENCES Laporan(Id_Laporan)
);

CREATE TABLE Catat_Asset (
    Id_Asset INT,
    Id_Laporan INT,
    FOREIGN KEY (Id_Asset) REFERENCES Asset(Id_Asset),
    FOREIGN KEY (Id_Laporan) REFERENCES Laporan(Id_Laporan)
);

CREATE TABLE Catat_Tabungan (
    Id_Tabungan INT,
    Id_Laporan INT,
    FOREIGN KEY (Id_Tabungan) REFERENCES Tabungan(Id_Tabungan),
    FOREIGN KEY (Id_Laporan) REFERENCES Laporan(Id_Laporan)
);

INSERT INTO Pengguna VALUES 
(1, 'Ghazi', 'ghazi@mail.com', '08123456789'),
(2, 'Rayhan', 'rayhan@mail.com', '08123456780'),
(3, 'Agyl', 'agyl@mail.com', '08123456781'),
(4, 'Aulia', 'aulia@mail.com', '08123456782'),
(5, 'Dimas', 'dimas@mail.com', '08123456783'),
(6, 'Edo', 'edo@mail.com', '08123456784'),
(7, 'Salah', 'salah@mail.com', '08123456785'),
(8, 'Juan', 'juan@mail.com', '08123456786'),
(9, 'Memei', 'memei@mail.com', '08123456787'),
(10, 'Rahman', 'rahman@mail.com', '08123456788');

INSERT INTO Pengeluaran VALUES
(1, 1, '2025-05-01', 500000),
(2, 2, '2025-05-02', 400000),
(3, 3, '2025-05-03', 700000),
(4, 4, '2025-05-04', 600000),
(5, 5, '2025-05-05', 300000),
(6, 6, '2025-05-06', 200000),
(7, 7, '2025-05-07', 100000),
(8, 8, '2025-05-08', 900000),
(9, 9, '2025-05-09', 850000),
(10, 10, '2025-05-10', 750000);

INSERT INTO Pemasukan VALUES
(1, 1, '2025-05-02', 3000000),
(2, 2, '2025-05-02', 2500000),
(3, 3, '2025-05-02', 2000000),
(4, 4, '2025-05-02', 1800000),
(5, 5, '2025-05-02', 2200000),
(6, 6, '2025-05-02', 2700000),
(7, 7, '2025-05-02', 1500000),
(8, 8, '2025-05-02', 1900000),
(9, 9, '2025-05-02', 3100000),
(10, 10, '2025-05-02', 3300000);

INSERT INTO Hutang VALUES
(1, 1, '2025-05-03', '2025-06-01', 1000000),
(2, 2, '2025-05-03', '2025-06-01', 500000),
(3, 3, '2025-05-03', '2025-06-01', 750000),
(4, 4, '2025-05-03', '2025-06-01', 650000),
(5, 5, '2025-05-03', '2025-06-01', 900000),
(6, 6, '2025-05-03', '2025-06-01', 300000),
(7, 7, '2025-05-03', '2025-06-01', 450000),
(8, 8, '2025-05-03', '2025-06-01', 800000),
(9, 9, '2025-05-03', '2025-06-01', 700000),
(10, 10, '2025-05-03', '2025-06-01', 600000);

INSERT INTO Tabungan VALUES
(1, 1, 1500000, 5000000),
(2, 2, 1400000, 4000000),
(3, 3, 1300000, 3000000),
(4, 4, 1600000, 3500000),
(5, 5, 1700000, 3700000),
(6, 6, 1800000, 3600000),
(7, 7, 1200000, 3200000),
(8, 8, 1100000, 3300000),
(9, 9, 1900000, 3900000),
(10, 10, 2000000, 4000000);

INSERT INTO Asset VALUES
(1, 1, 'Motor', 12000000),
(2, 2, 'Laptop', 8000000),
(3, 3, 'Handphone', 4000000),
(4, 4, 'Sepeda', 3000000),
(5, 5, 'TV', 3500000),
(6, 6, 'PC', 7000000),
(7, 7, 'Tablet', 4500000),
(8, 8, 'Camera', 6000000),
(9, 9, 'Jam Tangan', 2000000),
(10, 10, 'Kulkas', 5000000);

INSERT INTO Laporan VALUES
(1, 1, 'Bulanan', '2025-05-04'),
(2, 2, 'Bulanan', '2025-05-04'),
(3, 3, 'Bulanan', '2025-05-04'),
(4, 4, 'Bulanan', '2025-05-04'),
(5, 5, 'Bulanan', '2025-05-04'),
(6, 6, 'Bulanan', '2025-05-04'),
(7, 7, 'Bulanan', '2025-05-04'),
(8, 8, 'Bulanan', '2025-05-04'),
(9, 9, 'Bulanan', '2025-05-04'),
(10, 10, 'Bulanan', '2025-05-04');

INSERT INTO Catat_Pengeluaran VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO Catat_Pemasukan VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO Catat_Hutang VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO Catat_Tabungan VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO Catat_Asset VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Join + Alias dan Operator
SELECT p.Nama, pem.Jumlah AS Pemasukan, peng.Jumlah AS Pengeluaran
FROM Pengguna p
JOIN Pemasukan pem ON p.Id_Pengguna = pem.Id_Pengguna
JOIN Pengeluaran peng ON p.Id_Pengguna = peng.Id_Pengguna
WHERE pem.Jumlah > 1000000;

SELECT p.Nama, pe.Tanggal, pe.Jumlah
FROM Pengguna p
INNER JOIN Pengeluaran pe ON p.Id_Pengguna = pe.Id_Pengguna;

SELECT p.Nama, t.Jumlah AS Jumlah_Tabungan
FROM Pengguna p
LEFT JOIN Tabungan t ON p.Id_Pengguna = t.Id_Pengguna;

SELECT l.Kategori, pm.Jumlah AS Jumlah_Pemasukan
FROM Laporan l
RIGHT JOIN Catat_Pemasukan cp ON l.Id_Laporan = cp.Id_Laporan
RIGHT JOIN Pemasukan pm ON cp.Id_Pemasukan = pm.Id_Pemasukan;

SELECT p.Nama, h.Jumlah AS Jumlah_Hutang
FROM Pengguna p
LEFT JOIN Hutang h ON p.Id_Pengguna = h.Id_Pengguna
UNION
SELECT p.Nama, h.Jumlah
FROM Pengguna p
RIGHT JOIN Hutang h ON p.Id_Pengguna = h.Id_Pengguna;

SELECT p.Nama, l.Kategori
FROM Pengguna p
CROSS JOIN (SELECT DISTINCT Kategori FROM Laporan) l;

-- Function
DELIMITER //
CREATE FUNCTION TotalTabungan(id INT) RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2);
    SELECT SUM(Jumlah) INTO total FROM Tabungan WHERE Id_Pengguna = id;
    RETURN IFNULL(total, 0.00);
END;
//
DELIMITER ;

SELECT TotalTabungan(5) AS Total_Uang;

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE sp_TambahPengguna(
    IN p_nama VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_no_hp VARCHAR(20)
)
BEGIN
    DECLARE new_id INT;
    
    SELECT IFNULL(MAX(Id_Pengguna), 0) + 1 INTO new_id FROM Pengguna;
    
    INSERT INTO Pengguna (Id_Pengguna, Nama, Email, No_Handphone)
    VALUES (new_id, p_nama, p_email, p_no_hp);
    
    INSERT INTO Tabungan (Id_Tabungan, Id_Pengguna, Jumlah, Target)
    VALUES (new_id, new_id, 0, 0);
END //
DELIMITER ;

CALL sp_TambahPengguna('Attar', 'attar@email.com', '08123456777');

SELECT * FROM Pengguna WHERE Nama = 'Attar';

-- Group By + Order By
SELECT Id_Pengguna, SUM(Jumlah) AS TotalPengeluaran
FROM Pengeluaran
GROUP BY Id_Pengguna
ORDER BY TotalPengeluaran DESC;

-- View
CREATE VIEW View_Laporan_Keuangan AS
SELECT p.Nama, l.Kategori, l.Tanggal
FROM Laporan l
JOIN Pengguna p ON l.Id_Pengguna = p.Id_Pengguna;

SELECT * FROM View_Laporan_Keuangan;

-- Nested Query
SELECT Nama FROM Pengguna
WHERE Id_Pengguna IN (
    SELECT Id_Pengguna FROM Pemasukan WHERE Jumlah > 2000000
);

-- Trigger
DELIMITER //
CREATE TRIGGER after_insert_pemasukan
AFTER INSERT ON Pemasukan
FOR EACH ROW
BEGIN
    UPDATE Tabungan SET Jumlah = Jumlah + NEW.Jumlah WHERE Id_Pengguna = NEW.Id_Pengguna;
END;//
DELIMITER ;


SELECT * FROM Tabungan WHERE Id_Pengguna = 1;

INSERT INTO Pemasukan (Id_Pemasukan, Id_Pengguna, Tanggal, Jumlah)
VALUES (11, 1, '2025-05-15', 1000000);

SELECT * FROM Tabungan WHERE Id_Pengguna = 1;

-- DCL
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'user123_';

GRANT SELECT, INSERT, UPDATE ON financial_management.Pengguna TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON financial_management.Pemasukan TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON financial_management.Pengeluaran TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON financial_management.Hutang TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON financial_management.Tabungan TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON financial_management.Asset TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON financial_management.Laporan TO 'app_user'@'localhost';

GRANT SELECT ON financial_management.View_Laporan_Keuangan TO 'app_user'@'localhost';
GRANT EXECUTE ON FUNCTION financial_management.TotalTabungan TO 'app_user'@'localhost';
GRANT EXECUTE ON PROCEDURE financial_management.InsertPemasukan TO 'app_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123_';

GRANT ALL PRIVILEGES ON financial_management.* TO 'admin_user'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;