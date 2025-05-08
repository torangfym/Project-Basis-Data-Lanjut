-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 08, 2025 at 01:53 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sewakost`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `TambahSewa` (IN `peng_id` INT, IN `kamar_nomor` VARCHAR(10), IN `tgl_masuk` DATE, IN `tgl_keluar` DATE, IN `total` DECIMAL(12,2))   BEGIN
    INSERT INTO Sewa (id_penghuni, no_kamar, tanggal_masuk, tanggal_keluar, total_bayar)
    VALUES (peng_id, kamar_nomor, tgl_masuk, tgl_keluar, total);

    UPDATE Kamar SET status = 'Terisi' WHERE no_kamar = kamar_nomor;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `no_kamar` varchar(10) NOT NULL,
  `tipe` varchar(50) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `status` enum('Tersedia','Terisi') DEFAULT 'Tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`no_kamar`, `tipe`, `harga`, `status`) VALUES
('A101', 'Standar', '750000.00', 'Terisi'),
('A102', 'Standar', '750000.00', 'Terisi'),
('B201', 'Deluxe', '1000000.00', 'Terisi'),
('B202', 'Deluxe', '1000000.00', 'Terisi'),
('C301', 'Premium', '1500000.00', 'Terisi'),
('C302', 'Premium', '1500000.00', 'Tersedia'),
('D101', 'Standar', '750000.00', 'Tersedia'),
('D102', 'Standar', '750000.00', 'Tersedia'),
('E201', 'Deluxe', '1000000.00', 'Tersedia'),
('E202', 'Deluxe', '1000000.00', 'Tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int NOT NULL,
  `id_sewa` int DEFAULT NULL,
  `tanggal_bayar` date DEFAULT NULL,
  `jumlah_bayar` decimal(12,2) DEFAULT NULL,
  `metode_pembayaran` varchar(50) DEFAULT NULL,
  `keterangan` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_sewa`, `tanggal_bayar`, `jumlah_bayar`, `metode_pembayaran`, `keterangan`) VALUES
(1, 1, '2025-04-01', '750000.00', 'Transfer Bank', 'Pembayaran bulan 1'),
(2, 1, '2025-05-01', '750000.00', 'Transfer Bank', 'Pembayaran bulan 2'),
(3, 1, '2025-06-01', '750000.00', 'Transfer Bank', 'Pembayaran bulan 3'),
(4, 2, '2025-03-10', '750000.00', 'Cash', 'Pembayaran bulan 1'),
(5, 2, '2025-04-10', '750000.00', 'Cash', 'Pembayaran bulan 2'),
(6, 2, '2025-05-10', '750000.00', 'Cash', 'Pembayaran bulan 3'),
(7, 3, '2025-01-15', '1000000.00', 'E-Wallet', 'Pembayaran bulan 1'),
(8, 3, '2025-02-15', '1000000.00', 'E-Wallet', 'Pembayaran bulan 2'),
(9, 3, '2025-03-15', '1000000.00', 'E-Wallet', 'Pembayaran bulan 3'),
(10, 4, '2025-02-01', '1000000.00', 'Transfer Bank', 'Pembayaran bulan 1'),
(11, 4, '2025-03-01', '1000000.00', 'Transfer Bank', 'Pembayaran bulan 2'),
(12, 4, '2025-04-01', '1000000.00', 'Transfer Bank', 'Pembayaran bulan 3'),
(13, 5, '2025-03-20', '1500000.00', 'Virtual Account', 'Pembayaran bulan 1'),
(14, 5, '2025-04-20', '1500000.00', 'Virtual Account', 'Pembayaran bulan 2'),
(15, 5, '2025-05-20', '1500000.00', 'Virtual Account', 'Pembayaran bulan 3');

-- --------------------------------------------------------

--
-- Table structure for table `penghuni`
--

CREATE TABLE `penghuni` (
  `id_penghuni` int NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `no_ktp` varchar(20) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `penghuni`
--

INSERT INTO `penghuni` (`id_penghuni`, `nama`, `no_ktp`, `no_hp`, `email`) VALUES
(1, 'Agyl Wendi Pratama', '3201010100010001', '081234567891', 'agyl.pratama@gmail.com'),
(2, 'Habib Al Qodri', '3201010100010002', '081234567892', 'habib.qodri@gmail.com'),
(3, 'Ricardo Gellael', '3201010100010003', '081234567893', 'ricardo.gellael@gmail.com'),
(4, 'Juan Argaprana Putra', '3201010100010004', '081234567894', 'juan.arga@gmail.com'),
(5, 'Muhammad Ryan Al-Habsy', '3201010100010005', '081234567895', 'ryan.alhabsy@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `sewa`
--

CREATE TABLE `sewa` (
  `id_sewa` int NOT NULL,
  `id_penghuni` int DEFAULT NULL,
  `no_kamar` varchar(10) DEFAULT NULL,
  `tanggal_masuk` date DEFAULT NULL,
  `tanggal_keluar` date DEFAULT NULL,
  `total_bayar` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sewa`
--

INSERT INTO `sewa` (`id_sewa`, `id_penghuni`, `no_kamar`, `tanggal_masuk`, `tanggal_keluar`, `total_bayar`) VALUES
(1, 1, 'A101', '2025-04-01', '2025-07-01', '2250000.00'),
(2, 2, 'A102', '2025-03-10', '2025-06-10', '2250000.00'),
(3, 3, 'B201', '2025-01-15', '2025-04-15', '3000000.00'),
(4, 4, 'B202', '2025-02-01', '2025-05-01', '3000000.00'),
(5, 5, 'C301', '2025-03-20', '2025-06-20', '4500000.00');

--
-- Triggers `sewa`
--
DELIMITER $$
CREATE TRIGGER `after_delete_sewa` AFTER DELETE ON `sewa` FOR EACH ROW BEGIN
    UPDATE Kamar SET status = 'Tersedia' WHERE no_kamar = OLD.no_kamar;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_data_sewa`
-- (See below for the actual view)
--
CREATE TABLE `vw_data_sewa` (
`id_sewa` int
,`nama` varchar(100)
,`no_kamar` varchar(10)
,`tanggal_masuk` date
,`tanggal_keluar` date
,`total_bayar` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_data_sewa`
--
DROP TABLE IF EXISTS `vw_data_sewa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_data_sewa`  AS SELECT `s`.`id_sewa` AS `id_sewa`, `p`.`nama` AS `nama`, `s`.`no_kamar` AS `no_kamar`, `s`.`tanggal_masuk` AS `tanggal_masuk`, `s`.`tanggal_keluar` AS `tanggal_keluar`, `s`.`total_bayar` AS `total_bayar` FROM ((`sewa` `s` join `penghuni` `p` on((`s`.`id_penghuni` = `p`.`id_penghuni`))) join `kamar` `k` on((`s`.`no_kamar` = `k`.`no_kamar`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`no_kamar`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_sewa` (`id_sewa`);

--
-- Indexes for table `penghuni`
--
ALTER TABLE `penghuni`
  ADD PRIMARY KEY (`id_penghuni`);

--
-- Indexes for table `sewa`
--
ALTER TABLE `sewa`
  ADD PRIMARY KEY (`id_sewa`),
  ADD KEY `id_penghuni` (`id_penghuni`),
  ADD KEY `no_kamar` (`no_kamar`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `penghuni`
--
ALTER TABLE `penghuni`
  MODIFY `id_penghuni` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sewa`
--
ALTER TABLE `sewa`
  MODIFY `id_sewa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_sewa`) REFERENCES `sewa` (`id_sewa`);

--
-- Constraints for table `sewa`
--
ALTER TABLE `sewa`
  ADD CONSTRAINT `sewa_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id_penghuni`),
  ADD CONSTRAINT `sewa_ibfk_2` FOREIGN KEY (`no_kamar`) REFERENCES `kamar` (`no_kamar`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
