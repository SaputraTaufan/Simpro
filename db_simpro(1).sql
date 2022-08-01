-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Bulan Mei 2021 pada 12.38
-- Versi server: 10.4.10-MariaDB
-- Versi PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_simpro(1)`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_in_products`
--

CREATE TABLE `detail_in_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `in_product_id` int(50) DEFAULT NULL,
  `request_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `detail_in_products`
--

INSERT INTO `detail_in_products` (`id`, `in_product_id`, `request_id`, `warehouse_id`, `tenant_id`, `product_id`, `quantity`) VALUES
(1, 1, 'REQ0001', 'WH0005', 'SCKP0001', 'P0011', 10),
(2, 1, 'REQ0001', 'WH0005', 'SCKP0001', 'P0031', 15),
(3, 1, 'REQ0001', 'WH0005', 'SCKP0001', 'P0042', 5000),
(4, 2, 'REQ0004', 'WH0005', 'SCKP0002', 'P0022', 10),
(5, 2, 'REQ0004', 'WH0005', 'SCKP0002', 'P0039', 8000),
(6, 2, 'REQ0004', 'WH0005', 'SCKP0002', 'P0064', 2),
(7, 3, 'REQ0002', 'WH0006', 'SCKP0003', 'P0002', 15),
(8, 3, 'REQ0002', 'WH0006', 'SCKP0003', 'P0031', 20),
(9, 3, 'REQ0002', 'WH0006', 'SCKP0003', 'P0038', 15),
(10, 3, 'REQ0002', 'WH0006', 'SCKP0003', 'P0069', 10),
(11, NULL, 'REQ0001', 'WH0005', 'SCKP0001', 'P0011', 2);

--
-- Trigger `detail_in_products`
--
DELIMITER $$
CREATE TRIGGER `log_input` AFTER INSERT ON `detail_in_products` FOR EACH ROW BEGIN
	UPDATE stock_warehouses 
    SET stock = stock+NEW.quantity,
    	remaining = remaining-NEW.quantity
    WHERE product_id = NEW.product_id COLLATE 'utf8mb4_general_ci' 
    AND request_id = NEW.request_id COLLATE 'utf8mb4_general_ci';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_out_products`
--

CREATE TABLE `detail_out_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `request_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `detail_out_products`
--

INSERT INTO `detail_out_products` (`id`, `product_id`, `out_product_id`, `quantity`, `request_id`) VALUES
(1, 'P0011', 1, 2, 'REQ0001'),
(2, 'P0031', 1, 5, 'REQ0001'),
(3, 'P0042', 1, 1500, 'REQ0001'),
(4, 'P0011', 2, 5, 'REQ0001'),
(5, 'P0031', 2, 8, 'REQ0001'),
(6, 'P0042', 2, 2500, 'REQ0001'),
(7, 'P0022', 3, 5, 'REQ0004'),
(8, 'P0011', NULL, 2, 'REQ0001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_requests`
--

CREATE TABLE `detail_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `request_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `explanation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `detail_requests`
--

INSERT INTO `detail_requests` (`id`, `request_id`, `product_id`, `quantity`, `unit_price`, `total`, `explanation`, `status`) VALUES
(1, 'REQ0001', 'P0011', 15, 450000, 6750000, '', 'Not Yet'),
(2, 'REQ0001', 'P0031', 25, 470000, 11750000, '', 'Not Yet'),
(3, 'REQ0001', 'P0042', 10000, 16875, 168750000, '', 'Not Yet'),
(4, 'REQ0002', 'P0002', 35, 56000, 1960000, '', 'Not Yet'),
(5, 'REQ0002', 'P0031', 25, 470000, 11750000, '', 'Not Yet'),
(6, 'REQ0002', 'P0038', 15, 1000000, 15000000, '', 'Not Yet'),
(7, 'REQ0002', 'P0069', 20, 790000, 15800000, '', 'Not Yet'),
(8, 'REQ0003', 'P0011', 20, 450000, 9000000, '', 'Not Yet'),
(9, 'REQ0003', 'P0031', 10, 470000, 4700000, '', 'Not Yet'),
(10, 'REQ0003', 'P0042', 25000, 16875, 421875000, '', 'Not Yet'),
(11, 'REQ0004', 'P0039', 10000, 5000, 50000000, '', 'Not Yet'),
(12, 'REQ0004', 'P0022', 20, 515000, 10300000, '', 'Not Yet'),
(13, 'REQ0004', 'P0064', 2, 640000, 1280000, '', 'Not Yet');

--
-- Trigger `detail_requests`
--
DELIMITER $$
CREATE TRIGGER `log_req` AFTER INSERT ON `detail_requests` FOR EACH ROW BEGIN
	INSERT INTO stock_warehouses 
    SET product_id = New.product_id,
    request_id = New.request_id,
    quantity = New.quantity,
    remaining = quantity ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `in_products`
--

CREATE TABLE `in_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `request_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manifest_in` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_in` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `in_products`
--

INSERT INTO `in_products` (`id`, `request_id`, `warehouse_id`, `manifest_in`, `date_in`) VALUES
(1, 'REQ0001', 'WH0005', 'SJ0001', '2021-04-24 06:14:02'),
(2, 'REQ0004', 'WH0005', 'SJ0002', '2021-04-24 06:16:26'),
(3, 'REQ0002', 'WH0006', 'SJ0003', '2021-04-24 06:17:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `out_products`
--

CREATE TABLE `out_products` (
  `id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_out` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manifest_out` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_out` date NOT NULL,
  `Activity` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `out_products`
--

INSERT INTO `out_products` (`id`, `request_id`, `warehouse_id`, `tenant_id`, `pic_out`, `manifest_out`, `date_out`, `Activity`) VALUES
('1', 'REQ0001', 'WH0005', 'SCKP0001', 'Dede', 'SJO0001', '2021-04-24', 'Progress Ceger'),
('2', 'REQ0001', 'WH0005', 'SCKP0001', 'Rizal', 'SJO0002', '2021-04-24', 'Progress Ratna'),
('3', 'REQ0004', 'WH0005', 'SCKP0002', 'Bambang', 'SJO0003', '2021-04-24', 'Progress Cibitung');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_book` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `type`, `name`, `price_book`) VALUES
('P0001', 'Accesoris', 'Anchoring Lubang 3', 14000),
('P0002', 'Besi Beton', 'Besi Beton Polos 10 mm x `12 mtr merk BHS 10 SNI', 56000),
('P0003', 'Besi Beton', 'Besi Beton Polos 10 mm x 12 mtr merk SNI', 48000),
('P0004', 'Besi Beton', 'Besi Beton Polos 8 mm x 12 mtr merk SNI', 31000),
('P0005', 'Besi Beton', 'Besi Beton Polos 8 mm x 12 mtr merk SSS SNI', 37500),
('P0006', 'Besi Beton', 'Besi Beton Polos 8 mm x 12 mtr merk TJ SNI', 33500),
('P0007', 'Accesoris', 'Bracket kecil u/anchoring lubang 3', 5000),
('P0008', 'Accesoris', '\"Buldogrip 3/8\"\" (M10)\"', 4000),
('P0009', 'Accesoris', 'Buldogrip M8', 3000),
('P0010', 'Close Rack', '\"Close Rack FTM High Capacity (Close Rack 19\"\")\"', 11500000),
('P0011', 'ODP', 'DP FO kap. 16 port Litech (Embossed) ', 450000),
('P0012', 'ODP', 'DP FO kap. 16 port PAZ (Embossed) ', 435000),
('P0013', 'ODP', 'DP FO kap. 24 port NWC (Embossed)', 515000),
('P0014', 'ODP', 'DP FO kap. 24 port PAZ (Embossed)', 475000),
('P0015', 'Accesoris', '\"Flexible Conduit Alumunium Warna Hitam uk. 3/4\"\" p. 50 mtr/roll\"', 400000),
('P0016', 'Accesoris', '\"Flexible Plastik Warna Putih uk. 3/4\"\" p. 40 mtr/roll\"', 35000),
('P0017', 'Accesoris', 'Frem Handhole 1 ttp uk. 60x60 cm', 600000),
('P0018', 'Accesoris', 'Frem Handhole 1 ttp uk. 80x80 cm', 850000),
('P0019', 'Accesoris', 'Frem Handhole 1 ttp uk. 90x90 cm', 850000),
('P0020', 'Accesoris', 'Fusion Splicer Inno View 5', 40000000),
('P0021', 'Accesoris', 'Hanger Handhole', 30000),
('P0022', 'Closure', 'Joint Closure 12 core DOME PAZ', 515000),
('P0023', 'Closure', 'Joint Closure 12 core DOME NWC', 515000),
('P0024', 'Closure', 'Joint closure 288 core (In-line) NWC', 1830000),
('P0025', 'Closure', 'Joint closure 144 core (In-line) NWC', 1820000),
('P0026', 'Closure', 'Joint Closure 144 core (In-line) PAZ', 1300000),
('P0027', 'Closure', 'Joint closure 144 core Dome NWC', 775000),
('P0028', 'Closure', 'Joint closure 144 core Dome PAZ', 775000),
('P0029', 'Closure', 'Joint Closure 24 core (In-line) PAZ', 475000),
('P0030', 'Closure', 'Joint Closure 24 core DOME NWC', 525000),
('P0031', 'Closure', 'Joint Closure 48 core (In-line) PAZ', 470000),
('P0032', 'Closure', 'Joint closure 48 core Dome NWC', 560000),
('P0033', 'Closure', 'Joint closure 72 core (In-line) NWC', 1550000),
('P0034', 'Closure', 'Joint closure 96 core (In-line) NWC', 1600000),
('P0035', 'Closure', 'Joint Closure 96 core (In-line) PAZ', 640000),
('P0036', 'Closure', 'Joint closure 96 core Dome NWC', 635000),
('P0037', 'Closure', 'Joint Closure 96 core DOME PAZ', 635000),
('P0038', 'Joint Box', 'Jointbox 1 ttp uk. 59x119 cm', 1000000),
('P0039', 'Cable FO', 'Kabel FO ADSS SS 100 12 core/2T Type G.652D', 6320),
('P0040', 'Cable FO', 'Kabel FO ADSS SS 100 96 core/8T Type G.652D', 18150),
('P0041', 'Cable FO', 'Kabel FO ADSS SS 100 144 core/12T Type G.652D', 34000),
('P0042', 'Cable FO', 'Kabel FO Duct 72 core/6T Type G.652D', 16875),
('P0043', 'Cable FO', 'Kabel FO Udara 72 core/6T Type G.652D', 20050),
('P0044', 'Cable FO', 'Kabel FO Udara 96 core/8T Type G.652D', 21525),
('P0045', 'Cable FO', 'Kabel FO Udara 144 core/12T Type G.652D', 24900),
('P0046', 'Kawat Duri', 'Kawat Duri p. 28 mtr/roll', 65000),
('P0047', 'Kawat Seling', 'Kawat Seling 6 mm Full Baja Made In China @1000 mtr/roll', 11000),
('P0048', 'Kawat Seling', 'Kawat Seling 10 mm Full Baja Made In China @500 mtr/roll', 20000),
('P0049', 'Kawat Seling', 'Kawat Seling 12 mm Full Baja Made In China @500 mtr/roll', 22000),
('P0050', 'Accesoris', '\"Klem Begel 5', 5),
('P0051', 'Accesoris', '\"Klem Begel 6\"\" tbl 5 mm (u/tiang Beton 11 mtr)\"', 30000),
('P0052', 'Accesoris', 'Klem Begel tbl 5 mm u/Tiang Beton 11 mtr', 30000),
('P0053', 'Accesoris', 'Klem Begel tbl 5 mm u/Tiang Beton 9 mtr', 25000),
('P0054', 'Accesoris', 'Klem Begel u/tiang besi7 mtr', 12000),
('P0055', 'Accesoris', 'Klem Pole', 20000),
('P0056', 'Accesoris', 'Klem Ring 5 Mata', 11000),
('P0057', 'Accesoris', '\"Klem Sling 3/8\"\" (M10)\"', 3300),
('P0058', 'Accesoris', 'Klem subduct u/subduct 40/32 mm', 3250),
('P0059', 'Accesoris', 'Klem subduct u/subduct 40/33 mm', 3250),
('P0060', 'Accesoris', 'Klem subduct u/subduct 40/34 mm', 3250),
('P0061', 'Accesoris', 'Klem Tanduk (baut 7 cm)', 23000),
('P0062', 'Accesoris', 'Ling', 1250),
('P0063', 'Open Rack', '\"Open Rack 19\"\"\"', 1100000),
('P0064', 'OTB', 'OTB 12 core FC merk PAZ G.652D', 640000),
('P0065', 'OTB', 'OTB 12 core SC merk NWC G.652D', 751600),
('P0066', 'OTB', 'OTB 144 core FC merk NWC G.652D', 6600000),
('P0067', 'OTB', 'OTB 24 core FC merk NWC G.652D', 1070000),
('P0068', 'OTB', 'OTB 24 core SC merk NWC G.652D', 1070000),
('P0069', 'OTB', 'OTB 24 core SC merk PAZ G.652D', 790000),
('P0070', 'OTB', 'OTB 24 core SC merk SIEGES G.652D', 1100000),
('P0071', 'OTB', 'OTB 72 core FC merk NWC G.652D', 2760000),
('P0072', 'OTB', 'OTB 72 core SC merk NWC G.652D', 2760000),
('P0073', 'OTB', 'OTB 72 core FC merk SIEGES G.652D', 3700000),
('P0074', 'OTB', 'OTB 72 core SC merk SIEGES G.652D', 3700000),
('P0075', 'OTB', 'OTB 96 core NWC + Pigtail SC G.652D', 4000000),
('P0076', 'OTB', 'OTB Rack 48 core FC-FC merk PAZ G.655C', 1375000),
('P0077', 'OTB', 'OTB Rack 48 core SC merk PAZ G.655C', 1375000),
('P0078', 'OTDR', 'OTDR FX 150veex 1310/1550 32 db', 29000000),
('P0079', 'Accesoris', 'Palangan Tiang uk. 60x60 ', 70000),
('P0080', 'Accesoris', 'Palangan Tiang uk. 75x75 ', 90000),
('P0081', 'Accesoris', 'Palangan Tiang uk. 80x80 ', 80000),
('P0082', 'Accesoris', 'Palangan Tiang uk. 90x90', 125000),
('P0083', 'Patchcord', 'Patchcord FC-FC 10 mtr Duplex G.652D', 100000),
('P0084', 'Patchcord', 'Patchcord FC-FC 10 mtr Simplex G.652D', 50000),
('P0085', 'Patchcord', 'Patchcord FC-FC 2 mtr Duplex G.652D', 50000),
('P0086', 'Patchcord', '\"Patchcord FC-LC', 20),
('P0087', 'Patchcord', '\"Patchcord FC-LC', 30),
('P0088', 'Patchcord', 'Patchcord FC-SC 10 mtr Duplex G.652D', 100000),
('P0089', 'Patchcord', 'Patchcord FC-SC 2 mtr Duplex G.652D', 50000),
('P0090', 'Patchcord', 'Patchcord LC-LC 20 mtr Simplex G.652D', 75000),
('P0091', 'Patchcord', 'Patchcord LC-LC 30 mtr Simplex G.652D', 95000),
('P0092', 'Patchcord', 'Patchcord SC-FC 15 mtr Simplex G.652D', 50000),
('P0093', 'Patchcord', 'Patchcord SC-LC 10 mtr Duplex G.652D', 100000),
('P0094', 'Patchcord', 'Patchcord SC-LC 15 mtr Duplex G.652D', 100000),
('P0095', 'Patchcord', 'Patchcord SC-LC 15 mtr Simplex G.652D', 50000),
('P0096', 'Patchcord', 'Patchcord SC-SC 20 mtr Simplex G.652D', 60000),
('P0097', 'Patchcord', 'Patchcord SC-SC 3 mtr Simplex G.652D', 27500),
('P0098', 'Pigtail', 'Pigtail FC/UPC SM 2 mtr G.652D', 10000),
('P0099', 'Pigtail', '\"Pigtail FC/UPC', 1),
('P0100', 'Pigtail', '\"Pigtail SC/UPC', 2),
('P0101', 'Pipa Galvanis', '\"Pipa Galvanis 1', 5),
('P0102', 'Pipa Galvanis', '\"Pipa Galvanis 1', 5),
('P0103', 'Pipa Galvanis', '\"Pipa Galvanis 2\"\" tbl 1', 2),
('P0104', 'Pipa Galvanis', '\"Pipa Galvanis 2\"\" tbl 2 mm Full Asli p. 6 mtr\"', 185000),
('P0105', 'Pipa Galvanis', '\"Pipa Galvanis 3\"\" tbl 2 mm Full Asli p. 6 mtr\"', 380000),
('P0106', 'Pipa Galvanis', '\"Pipa Galvanis 5\"\" tbl 2', 8),
('P0107', 'Pipa PVC', '\"Pipa PVC 4\"\" AW Merk Rucika p. 6 mtr\"', 290000),
('P0108', 'Pipa PVC', '\"Pipa PVC 4\"\" tbl 5', 5),
('P0109', 'Pole', 'Pole Strap u/tiang Besi ', 12000),
('P0110', 'Protection Sleeve', 'Protection Sleeve', 500),
('P0111', 'Socket', 'Socket Subduct u/Subduct 40/32 mm warna hijau - hitam', 7500),
('P0112', 'Socket', 'Socket Subduct u/Subduct 40/34 mm warna Pink - Hitam', 7500),
('P0113', 'Socket', '\"Socket T 1 1/4\"\" D Merk Rucika @55 bh/dus\"', 3027),
('P0114', 'Spanskrup', '\"Spanskrup 5/8\"\" (M16)\"', 31500),
('P0115', 'Spanwartel', '\"Spanwartel 5/8\"\" (M16)\"', 43000),
('P0116', 'Spanwartel', 'Spanwartel M10', 12000),
('P0117', 'Splicer', 'Splicer Inno View 7', 54000000),
('P0118', 'Splitter', 'Splitter 1:8 (micro)', 130000),
('P0119', 'Splitter', 'Splitter 1:8 SUNSEA (micro)', 155000),
('P0120', 'Stenliss', 'Stenliss Steelbelt (mengkilap)', 170000),
('P0121', 'Stenliss', 'Stenliss Steelbelt F* Non Magnet', 1500000),
('P0122', 'Stoping ', 'Stoping ', 500),
('P0123', 'Stoping ', 'Stoping + Ling ', 1100),
('P0124', 'Subdcut', 'Subdcut 40/34 mm warna biru polos', 8150),
('P0125', 'Subdcut', '\"Subdcut 40/34 mm warna biru polos', 0),
('P0126', 'Subdcut', 'Subduct 28/32 mm warna hitam polos ', 4400),
('P0127', 'Subdcut', 'Subduct 40/32 mm warna biru polos', 8150),
('P0128', 'Subdcut', 'Subduct 40/32 mm warna hijau - hitam', 10700),
('P0129', 'Subdcut', 'Subduct 50/42 mm warna Biru Polos', 14500),
('P0130', 'Subdcut', 'Subduct 50/42 mm warna Biru - hitam', 14000),
('P0131', 'Subdcut', 'Subduct 50/42 mm warna Hitam - Biru', 14500),
('P0132', 'Subdcut', 'Subduct 50/42 mm warna Orange - Biru', 14500),
('P0133', 'Suspension ', 'Suspension ', 13500),
('P0134', 'Suspension ', 'Suspension ADSS/ Corong (Spie)', 17500),
('P0135', 'Suspension ', 'Suspension Karet (Sesuai Contoh)', 14500),
('P0136', 'Tambang', 'Tambang 2 mm p. 100 mtr/roll', 14500),
('P0137', 'Tambang', '\"Tambang 2,5 mm p. 100 mtr/roll', 18000),
('P0138', 'Tambang', '\"Tambang 2,5 mm p. 103 mtr/roll', 17000),
('P0139', 'Temberang', 'Temberang Tarik Besi 16 mm', 70000),
('P0140', 'Temberang', 'Temberang Tarik Besi 16 mm (Steak + Footplat)', 80000),
('P0141', 'Pole', '\"Tiang Telepon 7 mtr 4\"\" (2 Segment)\"', 670000),
('P0142', 'Pole', '\"Tiang Telepon 7 mtr 5\"\"\"', 750000),
('P0143', 'Pole', '\"Tiang Telepon 9 mtr 4\"\" (2 Segment)\"', 830000),
('P0144', 'Pole', '\"Tiang Telepon 9 mtr 5\"\"\"', 960000),
('P0145', 'Accesoris', 'Vikset + breket uk. 25.50 ', 17500),
('P0146', 'Accesoris', 'Vikset + breket uk. 50.70', 19000),
('P0147', 'Accesoris', 'Vikset + breket uk. 70.95', 25000),
('P0148', 'Warning Tape', '\"Warning Tape Polos 15 cm \"\"Hati-hati galian fiber optic\"\"\"', 320),
('P0149', 'Warning Tape', 'Warning Tape XL (Metalized) @500 mtr/roll', 870);

-- --------------------------------------------------------

--
-- Struktur dari tabel `request_materials`
--

CREATE TABLE `request_materials` (
  `id_request` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_po` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenant_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_request` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `request_materials`
--

INSERT INTO `request_materials` (`id_request`, `no_po`, `tenant_id`, `warehouse_id`, `pic_name`, `pic_phone`, `date_request`, `status`) VALUES
('REQ0001', '111.222.333', 'SCKP0001', 'WH0005', 'Waluyo', '08788772382', '2021-04-02', 'On Proses'),
('REQ0002', '222.333.444', 'SCKP0003', 'WH0006', 'Afrian', '0898878867', '2021-04-02', 'On Proses'),
('REQ0003', '444.555.666', 'SCKP0006', 'WH0005', 'Dhika', '085688223341', '2021-04-02', 'On Proses'),
('REQ0004', '1111.1', 'SCKP0002', 'WH0005', 'Sumarta', '08970875122', '2021-04-10', 'On Proses');

-- --------------------------------------------------------

--
-- Struktur dari tabel `stock_warehouses`
--

CREATE TABLE `stock_warehouses` (
  `id` int(20) NOT NULL,
  `request_id` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `quantity` int(20) DEFAULT NULL,
  `remaining` int(20) DEFAULT NULL,
  `stock` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `stock_warehouses`
--

INSERT INTO `stock_warehouses` (`id`, `request_id`, `product_id`, `quantity`, `remaining`, `stock`) VALUES
(12, 'REQ0003', 'P0096', 45, 5, 40),
(13, 'REQ0003', 'P0062', 70, 10, 60),
(14, 'REQ0004', 'P0096', 51, 20, 31),
(15, 'REQ0004', 'P0062', 170, 15, 155),
(16, 'REQ0001', 'P0011', 15, -92, 107),
(17, 'REQ0001', 'P0031', 25, -33, 58),
(18, 'REQ0001', 'P0042', 10000, -7600, 17600),
(19, 'REQ0002', 'P0002', 35, -10, 45),
(20, 'REQ0002', 'P0031', 25, -30, 55),
(21, 'REQ0002', 'P0038', 15, -5, 20),
(22, 'REQ0002', 'P0069', 20, 0, 20),
(23, 'REQ0003', 'P0011', 20, -37, 57),
(24, 'REQ0003', 'P0031', 10, -7, 17),
(25, 'REQ0003', 'P0042', 25000, -28000, 53000),
(26, 'REQ0004', 'P0039', 10000, -8000, 18000),
(27, 'REQ0004', 'P0022', 20, -10, 30),
(28, 'REQ0004', 'P0064', 2, -2, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tenants`
--

CREATE TABLE `tenants` (
  `id` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tenants`
--

INSERT INTO `tenants` (`id`, `name`, `address`, `phone`) VALUES
('SCKP0001', 'PT. Indosat Tbk', 'Jl. Medan Merdeka Barat No. 21 (\nJln Budi Kemulyaan), Jakarta \nPusat, Jakarta 10110', '(021) 30003001'),
('SCKP0002', 'PT XL Axiata Indonesia.tbk', 'Jl.H.R.Rasuna Said \nNo.7,RT.7/RW.2, \nKuningan,Kuningan Tim,\nKecamatan Setiabudi, \nKota Jakarta Selatan, \nDaerah Khusus \nIbukota Jakarta 12950', '(021) 5761881'),
('SCKP0003', 'Biznet', 'Midplaza 1, Jl. Jend. Sudirman\nNo.10-11, RT.10/RW.11, \nKaret Tengsin, Kota \nJakarta Pusat, Daerah Khusus \nIbukota Jakarta 10220', '(021) 57981788'),
('SCKP0004', 'PT. Mora Telematika Indonesia (Moratelindo)', 'Graha 9, Jl. Penataran \nJl. Proklamasi No.9, RW.2, \nPegangsaan, Kec. Menteng, \nKota Jakarta Pusat, \nDaerah Khusus Ibukota \nJakarta 10320', '(021) 31998600'),
('SCKP0005', 'Indosat M2', 'Jl. Kebagusan Raya No.36, \nRT.1/RW.1, Kebagusan, \nKec. Ps. Minggu, \nKota Jakarta Selatan, \nDaerah Khusus Ibukota \nJakarta 12550', '(021) 30008888'),
('SCKP0006', 'FiberStar', 'Menara Kadin Indonesia, \nMenara Kadin 6th Floor, \nJl. H. R. Rasuna Said, \nRT.1/RW.2, Kuningan, \nKuningan Tim., Kecamatan \nSetiabudi, Kota Jakarta \nSelatan, Daerah Khusus \nIbukota Jakarta 12950', '(021) 80621200'),
('SCKP0007', 'Trans Indonesia Superkoridor', 'Artha Gading Niaga, \nJl. Boulevard Artha Gading \nNo.25, RT.18/RW.8, \nWest Kelapa Gading, \nKelapa Gading, North Jakarta \nCity, Jakarta 14240', '(021) 48350885');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `warehouses`
--

CREATE TABLE `warehouses` (
  `id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `warehouses`
--

INSERT INTO `warehouses` (`id`, `region`, `city`, `address`) VALUES
('WH0001', 'BNRO', 'Denpasar', 'Jl. Gunung Talang No.7 Denpasar Bali '),
('WH0002', 'EJRO', 'Sidoarjo', 'Gudang SMI Pergudangan 88 Blok D-20. Raya Pabean Sedati Juanda. Sidoarjo '),
('WH0003', 'EJRO', 'Surabaya ', 'Rungkut Asri Barat XI No.34 Surabaya '),
('WH0004', 'EJRO', 'Malang ', 'Jl. Raya Pakisaji Malang No. 173 RT.14/03 '),
('WH0005', 'JBRO', 'Jakarta', 'Jl. H.Karim No.62 Rt 005 \nRw 05 Setu Cipayung \nJakarta Timur '),
('WH0006', 'WJRO', 'Bandung ', 'Jl. Pak Gatot 1 No. 5 /G kPAD Gegerkalong Bandung '),
('WH0007', 'EJRO', 'Probolinggo', 'Desa Triwung Kidul. RT 03/03 Kec. Kademangan Kota Probolinggo'),
('WH0008', 'CJRO', 'Sidoarjo', 'Gudang sragen Mungkung  rt 03 rw 10 kecamatan  sidaharjo.  kelurahan jetak  Sragen jateng PIC: Salim '),
('WH0009', 'CJRO', 'Yogyakarta', 'Site gamping. gudang yogya Jl. Jambon V. Kricak. Kec. Tegalrejo. Kota Yogyakarta. Daerah Istimewa Yogyakarta 55242'),
('WH0010', 'EJRO', 'Sidoarjo', 'PT Sinar Monas Industries. Jl Raya Pabean Sedati ? Juanda Pergudangan 88 Blok D No. 20 Sidoarjo '),
('WH0011', 'CJRO', 'Margorejo Pati', 'Pondok Dahar Dan Cafe Joglo Kebon Tebu Jl. Raya Pati - Kudus km.3 Margorejo Pati PIC. Sidik '),
('WH0012', 'EJRO', 'Jombang ', 'Dusun banjar agung desa banjar dowo RT.01/04 Jombang '),
('WH0013', 'WJRO', 'Bandung ', 'Jl.Sapta Taruna Raya Rw 08 Bandung ');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_in_products`
--
ALTER TABLE `detail_in_products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `detail_out_products`
--
ALTER TABLE `detail_out_products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `detail_requests`
--
ALTER TABLE `detail_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `in_products`
--
ALTER TABLE `in_products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `out_products`
--
ALTER TABLE `out_products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `request_materials`
--
ALTER TABLE `request_materials`
  ADD PRIMARY KEY (`id_request`);

--
-- Indeks untuk tabel `stock_warehouses`
--
ALTER TABLE `stock_warehouses`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_in_products`
--
ALTER TABLE `detail_in_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `detail_out_products`
--
ALTER TABLE `detail_out_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `detail_requests`
--
ALTER TABLE `detail_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `in_products`
--
ALTER TABLE `in_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `stock_warehouses`
--
ALTER TABLE `stock_warehouses`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
