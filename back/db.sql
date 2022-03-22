-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2021 at 01:12 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cus_id` int(10) NOT NULL,
  `f_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `l_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('Male','Female') COLLATE utf8_unicode_ci NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cus_address` text COLLATE utf8_unicode_ci NOT NULL,
  `cus_tel` char(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cus_id`, `f_name`, `l_name`, `gender`, `dob`, `email`, `username`, `password`, `cus_address`, `cus_tel`) VALUES
(1, 'Kyosuke', 'Hirokawa', 'Male', '2000-06-25', 'kana24@lachzentrum-wiesbaden.de', 'Unoakira', 'GVFMCvW2O', '374-1185, Kita 3-johigashi, Chuo-ku Sapporo-shi, Hokkaido', '7359365432'),
(2, 'Takuma', 'Uno', 'Female', '1981-10-18', 'eyoshimoto@na288.com', 'naoko27', 'w5Bo6MU1n', '412-1123, Nishishinjuku Shinjuku Nomurabiru(16-kai), Shinjuku-ku, Tokyo', '3322208581'),
(3, 'Mikako', 'Kobayashi', 'Female', '1997-05-09', 'cuno@travelovelinka.club', 'hiroshisuzuki', '3xt8qqe8SDvo', '441-1243, Inasacho Nishikuroda, Kita-ku Hamamatsu-shi, Shizuoka', '4559365432'),
(4, 'Kimura', 'Naoki', 'Male', '1996-03-30', 'akira.yoshimoto@maximilo.com', 'kudoakira', 'mZi5wotof', '147-1110, Hashibenkeicho, Nakagyo-ku-shi, Nakagyo-ku Kyoto-shi,  Kyoto', '3327765821'),
(5, 'Akemi', 'Yoshida', 'Female', '1989-01-02', 'kudo.momoko@llventures.co', 'kananagisa', 'HVBLn2Y', '110-1074, Higashinibancho, Hakusan-shi, Ishikawa', '1463190538'),
(6, 'Yui', 'Itaka', 'Female', '2002-02-28', 'ahirokawa@lachzentrum-wiesbaden.de', 'kana75', 'EwiY2456', '128-1240, Shinseto, Tateyama-machi Nakaniikawa-gun, Toyama', '9959465332'),
(7, 'Kenichi', 'Nagisa', 'Male', '2000-07-14', 'momoko.hirokawa@netfacc.com', 'hiroshinagisa', 'asdf123TY', '299-1257, Kisshoin Ikenochicho, Minami-ku-shi, Minami-ku Kyoto-shi, Kyoto', '5355465862'),
(8, 'Takada', 'Takachi', 'Male', '1999-02-10', 'takada@lachzentrum-wiesbaden.de', 'taka35', 'eqwe334E', '380-1065, Hinokicho, Ogaki-shi, Gifu', '9904303055'),
(9, 'Emi', 'Fukada', 'Female', '1999-05-18', 'fukada@lachzentrum-wiesbaden.de', 'emi518', 'zaxscdqwer4', '150-1037, Warizukacho, Kasugai-shi, Aichi', '7945673465'),
(10, 'Sawada', 'Tsuna', 'Male', '1997-11-19', 'tsunayoshi@lachzentrum-wiesbaden.de', 'yoyo119', 'vongolay', '380-1277, Bandaijima, Chuo-ku-shi, Chuo-ku Niigata-shi, Niigata', '9998768573');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(10) NOT NULL,
  `f_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `l_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('Male','Female') COLLATE utf8_unicode_ci NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `f_name`, `l_name`, `gender`, `dob`, `email`, `username`, `password`) VALUES
(1, 'Suchamad', 'Maliphan', 'Female', '1972-10-27', 'pinkie60@gmail.com', 'trantow45', '8k60n'),
(2, 'Dej', 'thienok', 'Male', '1975-01-03', 'ybogisich@gmail.com', 'cecelia43', 'ssdfSS234'),
(3, 'Khab', 'Worathipomma', 'Male', '1970-05-13', 'khab13313@gmail.com', 'qwer23W', '9qeI1'),
(4, 'Don', 'Wimotdee', 'Male', '1974-08-25', 'don22319@gmail.com', 'don22139', 'qwer5WE'),
(5, 'Chonlatee', 'Aussama', 'Male', '1974-06-13', 'teeza555@gmail.com', 'tee1306', 'rtyU8'),
(6, 'Mintra', 'Jaikraew', 'Female', '1976-03-01', 'minmin@gmail.com', 'min0301', 'werT1'),
(7, 'Supanicha', 'Klaewichiane', 'Female', '1975-07-18', 'jib23213@gmail.com', 'jib0718', 'Aasdfqwer1'),
(8, 'Asawarn', 'Klunpakdee', 'Female', '1974-12-21', 'gib1221@gmail.com', 'gib1221', 'zaxscdqwer5'),
(9, 'Songsak', 'Kromthong', 'Male', '1974-01-31', 'sak555@gmail.com', 'saksee', 'swswY34'),
(10, 'Saksit', 'Singto', 'Male', '1976-03-15', 'jeaker@gmail.com', 'jeaker0315', 'tItan15');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(10) NOT NULL,
  `order_datetime` datetime NOT NULL,
  `order_status` enum('รอจัดส่ง','กำลังจัดส่ง','จัดส่งสำเร็จ','จัดส่งไม่สำเร็จ') COLLATE utf8_unicode_ci NOT NULL,
  `paymenet_type` enum('บัตรเครดิต','โอนธนาคาร') COLLATE utf8_unicode_ci NOT NULL,
  `total_price` float(8,2) NOT NULL,
  `customer_cus_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `order_datetime`, `order_status`, `paymenet_type`, `total_price`, `customer_cus_id`) VALUES
(1, '2020-11-12 12:45:03', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 11000.00, 2),
(2, '2020-11-20 12:55:23', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 560.00, 3),
(3, '2020-12-01 10:45:53', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 5540.00, 5),
(4, '2020-12-10 10:45:36', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 400.00, 1),
(5, '2020-12-24 12:34:34', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 5500.00, 2),
(6, '2020-12-27 11:23:32', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 5500.00, 1),
(7, '2021-03-14 15:21:12', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 1150.00, 4),
(8, '2021-04-14 09:56:44', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 600.00, 5),
(9, '2021-02-10 21:33:34', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 200.00, 6),
(10, '2021-03-09 22:12:21', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 7300.00, 7),
(11, '2021-03-02 06:37:32', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 2000.00, 9),
(12, '2021-03-04 21:32:33', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 100.00, 9),
(13, '2021-03-04 22:21:37', 'จัดส่งไม่สำเร็จ', 'บัตรเครดิต', 3800.00, 10),
(14, '2021-03-04 13:45:23', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 2000.00, 10),
(15, '2021-03-04 16:32:46', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 1400.00, 3),
(16, '2021-03-04 23:32:12', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 555.00, 4),
(17, '2021-03-04 14:25:53', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 1200.00, 2),
(18, '2021-04-12 07:30:44', 'จัดส่งสำเร็จ', 'บัตรเครดิต', 7600.00, 8),
(19, '2021-04-13 06:30:55', 'จัดส่งสำเร็จ', 'โอนธนาคาร', 120.00, 9),
(20, '2021-04-14 04:00:23', 'กำลังจัดส่ง', 'บัตรเครดิต', 185.00, 4),
(21, '2021-04-14 13:23:35', 'กำลังจัดส่ง', 'บัตรเครดิต', 600.00, 2),
(22, '2021-04-14 13:23:35', 'กำลังจัดส่ง', 'บัตรเครดิต', 900.00, 2),
(23, '2021-04-14 14:14:26', 'กำลังจัดส่ง', 'โอนธนาคาร', 1200.00, 1),
(24, '2021-04-14 14:14:26', 'กำลังจัดส่ง', 'โอนธนาคาร', 2700.00, 1),
(25, '2021-04-14 15:30:32', 'กำลังจัดส่ง', 'โอนธนาคาร', 1500.00, 3);

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `no` int(10) NOT NULL,
  `unit_price` float(8,2) NOT NULL,
  `quantity` int(10) NOT NULL,
  `total_price` float(8,2) NOT NULL,
  `order_order_id` int(10) NOT NULL,
  `product_p_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`no`, `unit_price`, `quantity`, `total_price`, `order_order_id`, `product_p_id`) VALUES
(1, 5500.00, 2, 11000.00, 1, 103001),
(1, 280.00, 2, 560.00, 2, 101004),
(1, 10.00, 4, 40.00, 3, 103003),
(1, 400.00, 1, 400.00, 4, 103004),
(1, 5500.00, 1, 5500.00, 5, 103001),
(1, 5500.00, 1, 5500.00, 6, 103001),
(1, 230.00, 5, 1150.00, 7, 101006),
(1, 200.00, 3, 600.00, 8, 101005),
(1, 200.00, 1, 200.00, 9, 101005),
(1, 1800.00, 1, 1800.00, 10, 103006),
(1, 2000.00, 1, 2000.00, 11, 103007),
(1, 100.00, 1, 100.00, 12, 101002),
(1, 1900.00, 2, 3800.00, 13, 103010),
(1, 2000.00, 1, 2000.00, 14, 103009),
(1, 1400.00, 1, 1400.00, 15, 103008),
(1, 185.00, 3, 555.00, 16, 101001),
(1, 400.00, 3, 1200.00, 17, 103004),
(1, 10.00, 10, 100.00, 18, 103003),
(1, 120.00, 1, 120.00, 19, 101007),
(1, 185.00, 1, 185.00, 20, 101009),
(1, 300.00, 2, 600.00, 21, 102002),
(1, 300.00, 3, 900.00, 22, 102003),
(1, 300.00, 4, 1200.00, 23, 102007),
(1, 300.00, 9, 2700.00, 24, 102001),
(1, 300.00, 5, 1500.00, 25, 102004),
(2, 5500.00, 1, 5500.00, 3, 103001),
(2, 5500.00, 1, 5500.00, 10, 103001),
(2, 5500.00, 1, 5500.00, 18, 103001),
(3, 2000.00, 1, 2000.00, 18, 103007);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `p_id` int(10) NOT NULL,
  `p_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `p_desc` text COLLATE utf8_unicode_ci NOT NULL,
  `unit_price` float(8,2) NOT NULL,
  `quantity` int(10) NOT NULL,
  `img` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_type_type_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`p_id`, `p_name`, `p_desc`, `unit_price`, `quantity`, `img`, `product_type_type_id`) VALUES
(101001, 'Muay Thai pants', '* Minimum lot: 5 sheets / size / color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nMuay Thai pants size\r\n1. Children\'s size (XS-M)\r\n2. Adult size (M-XXXL)\r\n', 185.00, 1000, 'cloth01.jpg', 1),
(101002, 'Thai long pants for summer', '* Minimum lot: 10 or more per color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Material]\r\n・ Cotton + polyester\r\n【size】\r\n・ One size fits all\r\n・ Waist approx. 72 cm. Length approx. 99 cm.\r\n【Color variations】\r\n・ Khaki\r\n・ Raisins\r\n・ Stone gray\r\n·wine-red\r\n·Marigold\r\n・ Moss green\r\n・ Olive green\r\n・ Maroon\r\n・ Burnt Umber\r\n·Aquamarine\r\n・ Burnt Sienna\r\n【specification】\r\n・ Tie at the waste\r\n・ One pocket\r\n【Features】\r\n・ Since it is a basic product with a plain design, it is one of the popular products in Thailand.\r\n-Made of thin fabric and very airy, it may not be a suitable product for the summer season.\r\n・ Because it is a unisex product for both men and women, it can be fashionable no matter who wears it.\r\n【Precautions】\r\n・ The color may fade, so to prevent the color from fading,\r\nWhen washing, it is better to separate it from other items before washing.\r\n', 100.00, 1000, 'cloth02.jpg', 1),
(101003, 'Autumn turtleneck dress', '* Minimum lot: 20 or more\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Material]\r\n・ Cotton + polyester\r\n【size】\r\n・ One size fits all\r\n・ Chest circumference: 110 cm., Length: 85 cm., Sleeve length: 60 cm., Arm circumference: 44 cm.\r\n【Features】\r\n・ One piece made of Thai cotton and polyester for cool season (especially autumn)\r\n・ It\'s okay to wear it when it\'s cold, but it will be warmer if you wear it with Heat Tech.\r\n・ The pattern is designed by the Thai owner, so unlike other dresses, it will not be unique.\r\n【Precautions】\r\n・ The color may fade, so to prevent the color from fading,\r\nWhen washing, it is better to separate it from other items before washing.\r\n', 300.00, 500, 'cloth03.jpg', 1),
(101004, 'Thick dyed hoodie for winter', '* Minimum lot: 12 or more (size and color can be mixed)\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Material]\r\n・ Cotton + polyester\r\n【size】\r\n・ M (Chest circumference: 110 cm., Length: 65 cm., Sleeve length: 55 cm., Arm circumference: 44 cm.\r\n・ L (Chest circumference: 115 cm., Length: 67 cm., Sleeve length: 62 cm., Arm circumference: 46 cm.\r\n・ XL (Chest circumference: 120 cm., Length: 70 cm., Sleeve length: 65 cm., Arm circumference: 46 cm.\r\n【Features】\r\n・ The pattern is a special Thai dyeing method, so it has a good fashion sense and is not unique.\r\n-Since the material contains more than half thick cotton, it is one of the costumes suitable for cold weather.\r\n・ Because it is a unisex product for both men and women, it can be fashionable no matter who wears it.\r\n【Precautions】\r\n・ The color may fade, so to prevent the color from fading,\r\nWhen washing, it is better to separate it from other items before washing.\r\n', 280.00, 600, 'cloth04.jpg', 1),
(101005, 'Thick dyed sarouel pants', '* Minimum lot: 30 sheets / color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n  [Size]\r\nWaist 58-96 cm x Length 90 cm\r\n[Material]\r\npolyester\r\n【function】\r\n2 pockets on both sides, 1 pocket on the back\r\n', 300.00, 800, 'cloth05.jpg', 1),
(101006, 'Thick sarouel pants', '* Minimum lot: 20 sheets\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Size]\r\nWaist 58-96 cm x Length 86 cm\r\n[Material]\r\npolyester\r\n【function】\r\nSide pocket x1\r\n', 230.00, 750, 'cloth06.jpg', 1),
(101007, 'Saruel pants for summer', '* Minimum lot: 10 or more per color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Material]\r\n・ Cotton + polyester\r\n【size】\r\n・ One size fits all\r\n・ Waist approx. 56-100 cm., Length approx. 96 cm.\r\n【Color variations】\r\n・ Tail green\r\n·wine-red\r\n·Dark brown\r\n・ Glass green\r\n・ Navy\r\n・ Gray\r\n·light brown\r\n【specification】\r\n・ A string is attached to the waste and hem\r\n・ One pocket\r\n【Features】\r\n・ Since it is a basic product with a plain design, it is one of the popular products in Thailand.\r\n-The waste is made of rubber and has elasticity, and it also has a string, so you can adjust the size yourself.\r\n・ It\'s very well ventilated, so it\'s probably not a good product for the summer season.\r\n【Precautions】\r\n・ The color may fade, so to prevent the color from fading,\r\nWhen washing, it is better to separate it from other items before washing.\r\n', 120.00, 1000, 'cloth07.jpg', 1),
(101008, 'Muay Thai pants2', '* Minimum lot: 5 sheets / size / color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nMuay Thai pants size\r\n1. Children\'s size (XS-M)\r\n2. Adult size (M-XXXL)\r\n', 200.00, 1000, 'cloth08.jpg', 1),
(101009, 'Muay Thai pants3', '* Minimum lot: 5 sheets / size / color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nMuay Thai pants size\r\n1. Children\'s size (XS-M)\r\n2. Adult size (M-XXXL)\r\n', 185.00, 1000, 'cloth09.jpg', 1),
(101010, 'Muay Thai pants4', '* Minimum lot: 5 sheets / size / color\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nMuay Thai pants size\r\n1. Children\'s size (XS-M)\r\n2. Adult size (M-XXXL)\r\n', 185.00, 1000, 'cloth10.jpg', 1),
(102001, 'SM Silver Catalog', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces01.jpg', 2),
(102002, 'anklet', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces02.jpg', 2),
(102003, 'bracelet', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces03.jpg', 2),
(102004, 'Silver choker', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces04.jpg', 2),
(102005, 'bracelet2', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces05.jpg', 2),
(102006, 'bracelet3', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces06', 2),
(102007, 'bracelet4', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces07.jpg', 2),
(102008, 'bracelet5', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces08.jpg', 2),
(102009, 'bracelet6', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces09.jpg', 2),
(102010, 'bracelet7', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\nDo not click \"ADD TO CART\".\r\nIf you have a favorite product, please send the image and URL to ChatWork.\r\n* Pre-order\r\nAfter confirming your order, we will place an order with the factory.\r\n    delivery time\r\n    In stock: Approximately 2-3 days\r\n    Out of stock: Approximately 3-4 weeks\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 300.00, 1000, 'acces10.jpg', 2),
(103001, 'Crocodile handbag', '* Minimum lot: 1 piece / color\r\n* 10% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n【size】\r\nWidth 15 cm., Length 17 cm., Height 9.3 cm.\r\n【Color】\r\nBlack, navy\r\n[Material]\r\nOutside: Crocodile, Inside: Cowhide\r\n【specification】\r\nOutside: 1 free pocket, with shoulder strap\r\nInside: Main pocket x 1, Open pocket x 1, Zipper pocket x 1\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 5500.00, 100, 'bag01.jpg', 3),
(103002, 'Stingray braided round zipper wallet', '* Minimum lot: 1 or more\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Material]\r\n・ Outside: Stingray\r\n・ Inside: Cowhide + polyester\r\n【size】\r\n・ Width 10.5 cm., Length 19.5 cm., Thickness 3 cm.\r\n[Specifications]\r\n・ Wallet x 3\r\n・ Card holder x 12\r\n・ Free pocket x 2\r\n・ Zipper coin purse x 1\r\n【Features】\r\n・ Even though it is a handmade product, it is not profitable to purchase it at a reasonable price.\r\n-Made from polished stingray leather, it looks beautiful when exposed to light\r\n・ The braided finish is delicately made because we are looking for a craftsman with high technology.\r\n【Precautions】\r\n・ Because the price of natural leather fluctuates depending on the market price\r\nThe actual purchase price may differ from the price displayed on this site.\r\nThe actual purchase price will be notified in advance by chat work etc.\r\n', 2300.00, 250, 'bag02.jpg', 3),
(103003, 'Satin purse', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Zyce]\r\nWidth 17.2 cm. X Length 25.5 cm.\r\n[Material]\r\nsatin\r\n[Color]\r\nblack\r\n* Please note that the color of this item may fade.\r\n', 10.00, 1000, 'bag03.jpg', 3),
(103004, 'Cowhide tri-fold wallet', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Size]\r\nWidth 7.3 cm., Length 10.5 cm., Thickness 1.8 cm.\r\n【weight】\r\n76 g.\r\n【Color】\r\nNavy, white\r\n[Material]\r\nOutside: cowhide, inside: cowhide\r\n【specification】\r\nWallet x 1, coin purse x 2, card holder x 1, free pocket x 2\r\n[Wholesale market price 800 THB. (2,800 yen)]\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 400.00, 500, 'bag04.jpg', 3),
(103005, 'Thai nick fabric round zipper wallet', '* A 10% commission will be charged for direct purchase.\r\n* This price includes consumption tax.\r\n[Size]\r\nW (width) approx. 14 cm x H (height) approx. 11.5 cm x thickness approx. 1.4 cm\r\n【weight】\r\n64g\r\n[Material]\r\nOutside: cloth Inside: cloth\r\n', 200.00, 500, 'bag05.jpg', 3),
(103006, 'Cowhide carving wallet', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Size]\r\nWidth 19.5 cm, height 10.5 cm, thickness 2 cm\r\n【weight】\r\n327 g.\r\n[Material]\r\nOutside: cowhide, Stingray Inside: cowhide\r\n【specification】\r\nWallet x2, free pocket x2, card holder x12, coin purse x1\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 1800.00, 300, 'bag06.jpg', 3),
(103007, 'Stingray double round zipper wallet', '* Minimum lot: 1 or more\r\n* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Material]\r\n・ Outside: Stingray\r\n・ Inside: Cowhide + polyester\r\n【size】\r\n・ Width 10 cm. Length 19.5 cm. Thickness 4.5 cm.\r\n[Specifications]\r\n・ Wallet x 4\r\n・ Card holder x 16\r\n・ Free pocket x 4\r\n・ Zipper coin purse x 1\r\n【Features】\r\n-Since it is a little larger than a normal long wallet, you can store various things.\r\n-Since there is a star mark in the middle, it looks clear and beautiful.\r\n-It can also be used as a clutch bag, so it is one of the fashionable and fashionable products.\r\n【Precautions】\r\n・ Because the price of natural leather fluctuates depending on the market price\r\nThe actual purchase price may differ from the price displayed on this site.\r\nThe actual purchase price will be notified in advance by chat work etc.\r\n', 2000.00, 0, 'bag07.jpg', 3),
(103008, 'Cowhide crocodile embossed wallet', '', 1400.00, 210, 'bag08.jpg', 3),
(103009, 'Crocodile knit round zipper wallet', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n[Size]\r\nWidth 10.5 cm., Length 19.5 cm., Thickness 3.5 cm.\r\n【weight】\r\n300 g.\r\n[Material]\r\nOutside: Crocodile (knit), Inside: Cowhide\r\n【specification】\r\nWallet x 3, card holder x 12, coin purse x 1, free pocket x 2\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 2000.00, 0, 'bag09.jpg', 3),
(103010, 'Cowhide vintage rug wallet', '* 5% plus direct purchase fee from the product price\r\n* Thai consumption tax included\r\n【size】\r\n20 cm x 9 cm x 4.5 cm\r\n[Material]\r\nCowhide,\r\n【weight】\r\n374g\r\n【specification】\r\nWallet x2, coin purse x1, card holder x8, free pocket x1\r\n* Prices of natural leather, silver, etc. fluctuate depending on the market price.\r\nThe actual purchase price may differ from the price displayed on this site.\r\nWe will inform you of the actual purchase price in advance by chat work etc.\r\n', 1900.00, 350, 'bag10.jpg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `product_supplier`
--

CREATE TABLE `product_supplier` (
  `product_p_id` int(10) NOT NULL,
  `supplier_s_id` int(10) NOT NULL,
  `unit_price` float(8,2) NOT NULL,
  `quantity` int(10) NOT NULL,
  `update_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_type`
--

CREATE TABLE `product_type` (
  `type_id` int(10) NOT NULL,
  `type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `employee_emp_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product_type`
--

INSERT INTO `product_type` (`type_id`, `type_name`, `employee_emp_id`) VALUES
(1, 'Clothing', 1),
(2, 'Accessories', 2),
(3, 'Bag', 3);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `s_id` int(10) NOT NULL,
  `s_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `s_tel` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `s_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`s_id`, `s_name`, `s_tel`, `s_email`) VALUES
(1, 'Denchai', '0988281191', 'denchai1212@gmail.com'),
(2, 'Somkid', '0832923018', 'somkid11222@gmail.com'),
(3, 'Somrak', '0814329876', 'somrak5657@gmail.com'),
(4, 'Asawadej', '0957648553', 'dejdej@gmail.com'),
(5, 'Supoonsarn', '0983234576', 'Sunusoon@gmail.com'),
(6, 'Wanchai', '0949252242', 'Wanchai555@gmail.com'),
(7, 'Sukrit', '0867866646', 'Sukrit1234@gmail.com'),
(8, 'Oran', '0912342342', 'Oran2342@gmail.com'),
(9, 'Yongyut', '0957648550', 'Yongyuthi@gmail.com'),
(10, 'Chaiyut', '0928763975', 'Chaiyut1234@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cus_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `orders_ibfk_1` (`customer_cus_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`no`,`order_order_id`),
  ADD KEY `order_order_id` (`order_order_id`),
  ADD KEY `order_item_ibfk_2` (`product_p_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `product_type_type_id` (`product_type_type_id`);

--
-- Indexes for table `product_supplier`
--
ALTER TABLE `product_supplier`
  ADD PRIMARY KEY (`product_p_id`,`supplier_s_id`),
  ADD KEY `supplier_s_id` (`supplier_s_id`);

--
-- Indexes for table `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`type_id`),
  ADD KEY `employee_emp_id` (`employee_emp_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`s_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cus_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `product_type`
--
ALTER TABLE `product_type`
  MODIFY `type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `s_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `p_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10311;


--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_cus_id`) REFERENCES `customer` (`cus_id`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_p_id`) REFERENCES `product` (`p_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`product_type_type_id`) REFERENCES `product_type` (`type_id`);

--
-- Constraints for table `product_supplier`
--
ALTER TABLE `product_supplier`
  ADD CONSTRAINT `product_supplier_ibfk_1` FOREIGN KEY (`product_p_id`) REFERENCES `product` (`p_id`),
  ADD CONSTRAINT `product_supplier_ibfk_2` FOREIGN KEY (`supplier_s_id`) REFERENCES `supplier` (`s_id`);

--
-- Constraints for table `product_type`
--
ALTER TABLE `product_type`
  ADD CONSTRAINT `product_type_ibfk_1` FOREIGN KEY (`employee_emp_id`) REFERENCES `employee` (`emp_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;