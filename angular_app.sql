-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 03 2024 г., 11:38
-- Версия сервера: 5.6.51-log
-- Версия PHP: 8.0.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `angular_app`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`%` PROCEDURE `update_gpu_values` (IN `new_id` INT, IN `new_id_brand` INT, IN `new_id_distributor` INT, IN `new_id_memory_size` INT, IN `new_id_coolers` INT)   BEGIN
    UPDATE gpu
    JOIN gpu_brand ON gpu.id_brand = new_id_brand
    JOIN gpu_distributor ON gpu.id_distributor = new_id_distributor
    JOIN gpu_memory ON gpu.id_memory_size = new_id_memory_size
    JOIN gpu_coolers ON gpu.id_coolers = new_id_coolers
    SET
        gpu.brand = gpu_brand.brand,
        gpu.distributor = gpu_distributor.distributor,
        gpu.memory_size = gpu_memory.memory_size,
        gpu.coolers = gpu_coolers.coolers
    WHERE gpu.id = new_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `login` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `account`
--

INSERT INTO `account` (`id`, `login`, `password`) VALUES
(1, 'admin@gmail.com', 'admin123'),
(2, 'admin@yandex.ru', 'admin123'),
(4, 'admin@gg.com', 'scrypt:32768:8:1$xrisdVMy7vYrpV3A$0f5e3d264544e9528d7d6b9d630d7fc01de71bd5941333e5e0372a9d66bc170ce236ba97f86dde366d41b2d2a8bb0dbb3976f3fb8c04a63d67e66848ed8032c7'),
(5, 'admin@rambler.ru', 'scrypt:32768:8:1$5VxRDMvSG7rY1T2p$e27c67e5361d369d3fb9b5032418745f2d8a0a68260096e94f4216436d95c02767ab1ffd9cb2b6caee3515c0f5081696bfd91929e002bb3e9c9675908e3414c2');

--
-- Триггеры `account`
--
DELIMITER $$
CREATE TRIGGER `after_delete_account` AFTER DELETE ON `account` FOR EACH ROW BEGIN
    DELETE FROM account_admin WHERE id = OLD.id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_account` AFTER INSERT ON `account` FOR EACH ROW BEGIN 
    INSERT INTO account_admin (id, isadmin)
    VALUES (NEW.id, 0);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `account_admin`
--

CREATE TABLE `account_admin` (
  `id` int(11) NOT NULL,
  `isadmin` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `account_admin`
--

INSERT INTO `account_admin` (`id`, `isadmin`) VALUES
(1, 1),
(2, 0),
(4, 0),
(5, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `all_product`
--

CREATE TABLE `all_product` (
  `id` int(11) NOT NULL,
  `name` text,
  `pic` text,
  `product_type` text NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `price` int(11) NOT NULL DEFAULT '0',
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `all_product`
--

INSERT INTO `all_product` (`id`, `name`, `pic`, `product_type`, `quantity`, `price`, `description`) VALUES
(1, 'AMD ASUS 6650 XT', '/assets/images/products/gpu/1.jpg', 'gpu', 15, 33005, 'ROG Strix Radeon RX 6650 XT V2 OC Edition 8GB GDDR6 Graphics Card (AMD Radeon RX 6650XT,Aura Sync RGB Lighting,PCIe 4.0, 1x HDMI 2.1, 3x DisplayPort 1.4a,ROG-STRIX-RX6650XT-O8G-V2-GAMING)'),
(2, 'AMD ASUS 7700 XT', '/assets/images/products/gpu/2.jpg', 'gpu', 12, 60999, 'TUF Gaming Radeon RX 7700 XT OC Edition 12GB GDDR6 Gaming Graphics Card (AMD Radeon RX7700XT, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 2.1, TUF-RX7700XT-O12G-GAMING)'),
(3, 'AMD ASUS 7800 XT', '/assets/images/products/gpu/3.jpg', 'gpu', 16, 92499, 'TUF Gaming Radeon RX 7800 XT OC Edition 16GB GDDR6 Gaming Graphics Card Black (AMD Radeon RX7800XT, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 2.1, TUF-RX7800XT-O16G-GAMING)'),
(4, 'AMD ASUS 7900 XTX', '/assets/images/products/gpu/4.jpg', 'gpu', 16, 144999, 'TUF Gaming AMD Radeon RX 7900 XTX OC Edition 24GB GDDR6 Gaming Graphics Card (PCIe 4.0, Memory, 1x HDMI 2.1, 3X DisplayPort 2.1, GPU Tweak III, TUF-RX7900XTX-O24G-GAMING)'),
(5, 'AMD GIGABYTE 6600', '/assets/images/products/gpu/5.jpg', 'gpu', 16, 29899, 'Dual Radeon RX 6600 V2 8GB GDDR6 Gaming Graphics Card (AMD Radeon RX6600, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 1.4a, DUAL-RX6600-8G-V2)'),
(6, 'AMD MSI 6750 XT', '/assets/images/products/gpu/6.jpg', 'gpu', 14, 45499, 'Radeon RX 6750XT CORE Gaming Graphics Card with 12GB GDDR6 HDMI 3xDP, AMD RDNA™ 2 (RX-675XYJFDP) '),
(7, 'AMD MSI 6750 XT', '/assets/images/products/gpu/7.jpg', 'gpu', 11, 49999, 'MSI Radeon RX 7750 XT OC Edition 12GB GDDR6 Gaming Graphics Card (AMD Radeon RX7700XT, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 2.1, O12G-GAMING'),
(8, 'RTX ASUS 4070', '/assets/images/products/gpu/8.jpg', 'gpu', 17, 83999, 'TUF Gaming GeForce RTX 4070 12GB GDDR6X OC Edition Gaming Graphics Card (NVIDIA GeForce RTX4070 DLSS 3, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 1.4a, TUF-RTX4070-O12G-GAMING)'),
(9, 'RTX ASUS ProArt 4060', '/assets/images/products/gpu/9.jpg', 'gpu', 11, 49799, 'ProArt GeForce RTX 4060 OC Edition 8GB GDDR6 Gaming Graphics Card (NVIDIA GeForce RTX4060 DLSS 3, PCIe 4.0, 1x HDMI 2.1a, 3X DisplayPort 1.4a, PROART-RTX4060TI-O8G)'),
(10, 'RTX GIGABYTE 3060', '/assets/images/products/gpu/10.jpg', 'gpu', 12, 41299, 'Computer Vaizdo GeForce RTX 3060 WINDFORCE OC 12GB GDDR6 2xHDMI 2xDP'),
(11, 'RTX GIGABYTE 4070', '/assets/images/products/gpu/11.jpg', 'gpu', 10, 75499, 'GV-N4070WF3OC-12GD - GeForce RTX 4070-12 GB - GDDR6X - 192 bit - 7680 x 4320 pixels - PCI Express 4.0'),
(12, 'RTX GIGABYTE 4080', '/assets/images/products/gpu/12.jpg', 'gpu', 10, 140999, 'NVIDIA GeForce RTX 4080 Windforce Graphics Card - 16GB GDDR6X, 256-bit, PCI-E 4.0, 2505MHz Core Clock, 3X DP 1.4, 1x HDMI 2.1a, NVIDIA DLSS 3 - GV-N4080WF3-16GD'),
(13, 'RTX MSI Ventus2 4060 Ti', '/assets/images/products/gpu/13.jpg', 'gpu', 6, 50299, 'GeForce RTX 4060Ti Ventus 2X 16G OC'),
(14, 'RTX MSI Ventus3 4060 Ti', '/assets/images/products/gpu/14.jpg', 'gpu', 5, 61499, 'Gaming GeForce RTX 4060 Ti 16GB GDRR6 Boost Clock: 2685MHz 128-Bit HDMI/DP Nvlink TORX Fan 4.0 Ada Lovelace Architecture Graphics Card (RTX 4060 Ti Gaming X Slim 16G)'),
(15, 'RTX Noctua ASUS 4080', '/assets/images/products/gpu/15.jpg', 'gpu', 19, 176999, 'GeForce RTX 4080 16GB Noctua OC Edition GDDR6X Gaming Graphics Card (DLSS 3, PCIe 4.0, 16GB GDDR6X, 2X HDMI 2.1a, 3X DisplayPort 1.4a, RTX4080-O16G-NOCTUA)'),
(16, 'RTX White ASUS Rog Strix 4080', '/assets/images/products/gpu/16.jpg', 'gpu', 14, 246999, 'ROG Strix GeForce RTX 4080 16GB White Edition GDDR6X Gaming Graphics Card'),
(17, 'RTX White GIGABYTE 4070', '/assets/images/products/gpu/17.jpg', 'gpu', 17, 92399, 'Dual GeForce RTX 4070 OC White Edition 12GB GDDR6X Gaming Graphics Card (NVIDIA GeForce RTX4070 DLSS3, PCIe 4.0, 1x HMDI 2.1, 3X DisplayPort 1.4a, DUAL-RTX4070-O12G-WHITE) White'),
(18, 'AMD Ryzen 5 5600X', '/assets/images/products/сpu/18.jpg', 'cpu', 21, 16499, 'AMD Ryzen 5 5600X - Ryzen 5 5000 Series Vermeer (Zen 3) 6-Core 3.7 GHz Socket AM4 65W None Integrated Graphics Desktop Processor'),
(19, 'AMD Ryzen 5 7600', '/assets/images/products/сpu/19.jpg', 'cpu', 12, 21499, 'AMD Ryzen 5 7600 - Ryzen 5 7000 Series 6-Core 3.8 GHz Socket AM5 65W AMD Radeon Graphics Processor'),
(20, 'AMD Ryzen 7 5800X', '/assets/images/products/сpu/20.jpg', 'cpu', 19, 23999, 'AMD Ryzen 7 5800X - Ryzen 7 5000 Series Vermeer (Zen 3) 8-Core 3.8 GHz Socket AM4 105W None Integrated Graphics Desktop Processor'),
(21, 'AMD Ryzen 9 7900', '/assets/images/products/сpu/21.jpg', 'cpu', 18, 41999, 'AMD Ryzen 9 7900 - Ryzen 9 7000 Series 12-Core 3.7 GHz Socket AM5 65W AMD Radeon Graphics Processor'),
(22, 'AMD Ryzen 9 7950X3D', '/assets/images/products/сpu/22.jpg', 'cpu', 19, 79799, 'AMD Ryzen 9 7950X3D - Ryzen 9 7000 Series 16-Core 4.2 GHz Socket AM5 120W AMD Radeon Graphics Desktop Processor'),
(23, 'INTEL i5-13600K', '/assets/images/products/сpu/23.jpg', 'cpu', 20, 36999, 'Intel Core i5-13600K - Core i5 13th Gen Raptor Lake 14-Core (6P+8E) 3.5 GHz LGA 1700 125W Intel UHD Graphics 770 Desktop Processor'),
(24, 'INTEL i5-13600KF', '/assets/images/products/сpu/24.jpg', 'cpu', 30, 34999, 'Intel Core i5-13600KF - Core i5 13th Gen Raptor Lake 14-Core (6P+8E) 3.5 GHz LGA 1700 125W None Integrated Graphics Desktop Processor'),
(25, 'INTEL i5-14600K', '/assets/images/products/сpu/25.jpg', 'cpu', 27, 43799, 'Intel Core i5-14600K - Core i5 14th Gen 14-Core (6P+8E) LGA 1700 125W Intel UHD Graphics 770 Processor'),
(26, 'INTEL i7-14700KF', '/assets/images/products/сpu/26.jpg', 'cpu', 29, 54999, 'Intel Core i7-14700KF - Core i7 14th Gen 20-Core (8P+12E) LGA 1700 125W None Integrated Graphics Desktop Processor'),
(27, 'INTEL i9-13900K', '/assets/images/products/сpu/27.jpg', 'cpu', 24, 76999, 'Intel Core i9-13900K - Core i9 13th Gen Raptor Lake 24-Core (8P+16E) P-core Base Frequency: 3.0 GHz E-core Base Frequency: 2.2 GHz LGA 1700 125W Intel UHD Graphics 770 Desktop Processor'),
(28, 'INTEL i9-14900KF', '/assets/images/products/сpu/28.jpg', 'cpu', 7, 69999, 'Intel Core i9-14900KF - Core i9 14th Gen 24-Core (8P+16E) LGA 1700 125W None Integrated Graphics Processor'),
(29, 'Corsair Vengeance DDR4 32', '/assets/images/products/ram/29.jpg', 'ram', 20, 6999, 'CORSAIR Vengeance 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3600 (PC4 28800) Desktop Memory Model'),
(30, 'Corsair VENGEANCE DDR5 32', '/assets/images/products/ram/30.jpg', 'ram', 10, 12899, 'CORSAIR Vengeance RGB 32GB (2 x 16GB) 288-Pin PC RAM DDR5 6000 (PC5 48000) Desktop Memory Model'),
(31, 'Corsair Vengeance RGB DDR4 32', '/assets/images/products/ram/31.jpg', 'ram', 20, 8599, 'CORSAIR Vengeance RGB Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3600 (PC4 28800) '),
(32, 'Corsair VENGEANCE RGB DDR5 32', '/assets/images/products/ram/32.jpg', 'ram', 19, 19999, 'CORSAIR Vengeance RGB 32GB (2 x 16GB) 288-Pin PC RAM DDR5 6000 (PC5 48000) Desktop Memory Model '),
(33, 'Corsair VENGEANCE RGB White DDR4 32', '/assets/images/products/ram/33.jpg', 'ram', 14, 8899, 'CORSAIR Vengeance RGB Pro SL 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3600 (PC4 28800) Desktop Memory Model'),
(34, 'Crucial Pro DDR4 32', '/assets/images/products/ram/34.jpg', 'ram', 15, 7499, 'Crucial Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model'),
(35, 'Corsair Vengeance RGB PRO DDR4 16', '/assets/images/products/ram/35.jpg', 'ram', 9, 3699, 'CORSAIR Vengeance RGB Pro 16GB (2 x 8GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model'),
(36, 'Corsair VENGEANCE RGB PRO DDR4 16', '/assets/images/products/ram/36.jpg', 'ram', 5, 3999, 'CORSAIR Vengeance RGB Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model'),
(37, 'ASUS Prime B450M-A', '/assets/images/products/mb/37.jpg', 'mb', 20, 9499, 'ASUS Prime B450M-A II AMD AM4 (Ryzen 5000, 3rd/2nd/1st Gen Ryzen Micro ATX Motherboard (128GB DDR4, 4400 O.C.), NVMe, HDMI 2.0b/DVI/D-Sub, USB 3.2 Gen 2, BIOS Flashback, and Aura Sync)'),
(38, 'ASUS Prime H510M-K', '/assets/images/products/mb/38.jpg', 'mb', 24, 8999, 'ASUS PRIME H510M-K Intel H510 LGA 1200 Micro ATX Motherboard'),
(39, 'ASUS Prime Z790-A', '/assets/images/products/mb/39.jpg', 'mb', 30, 33999, 'ASUS Prime Z790-A WiFi 6E LGA 1700(Intel®14th &13th&12th Gen) ATX motherboard (16+1 DrMOS,PCIe 5.0,DDR5,4x M.2 slots,Intel® 2.5 Gb LAN,USB 3.2 Gen 2 front panel Type-C,Thunderbolt™ 4(USB4),DP,Aura Sync RGB lighting)'),
(40, 'ASUS ROG Maximus XIII Extreme Z590', '/assets/images/products/mb/40.jpg', 'mb', 20, 64499, 'ASUS ROG MAXIMUS XIII EXTREME LGA 1200 Intel Z590 SATA 6Gb/s Extended ATX Intel Motherboard'),
(41, 'ASUS ROG Strix B550-F', '/assets/images/products/mb/41.jpg', 'mb', 16, 23599, 'Asus ROG STRIX B550-F GAMING WIFI II AMD AM4 (3rd Gen Ryzen) ATX Gaming Motherboard (PCIe 4.0,WiFi 6E, 2.5Gb LAN, BIOS FlashBack, HDMI 2.1, Addressable Gen 2 RGB Header and AURA Sync)'),
(42, 'ASUS ROG STRIX B560-E', '/assets/images/products/mb/42.jpg', 'mb', 20, 26999, 'ASUS ROG STRIX B560-E GAMING WIFI LGA 1200 Intel B560 DDR4 ATX Motherboard (90MB1880-M0EAY0)'),
(43, 'ASUS ROG STRIX B650E', '/assets/images/products/mb/43.jpg', 'mb', 26, 37299, 'ASUS ROG STRIX B650E-F GAMING WiFi Socket AM5 (LGA 1718) Ryzen 7000 gaming motherboard(12 + 2 power stages, DDR5, three M.2 slots, PCIe 5.0, WiFi 6E, 2.5G LAN, USB 3.2 Gen 2x2 Type-C® port, Aura Sync RGBc)'),
(44, 'ASUS ROG STRIX B760-F', '/assets/images/products/mb/44.jpg', 'mb', 19, 26999, 'ASUS ROG Strix B760-F Gaming WiFi Intel B760(13th and 12th Gen) LGA 1700 ATX motherboard, 16 + 1 power stages, DDR5 up to 7800 MT/s, PCIe 5.0, three M.2 slots, WiFi 6E, USB 3.2 Gen 2x2 Type-C®, and Aura Sync RGB'),
(45, 'ASUS ROG STRIX Z790-H', '/assets/images/products/mb/45.jpg', 'mb', 12, 41999, 'ASUS ROG STRIX Z790-H Gaming (WiFi 6E) LGA 1700(Intel14th &13th&12th Gen) ATX gaming motherboard(DDR5 up to 7800 MT/s, PCIe 5.0 x16 SafeSlot with Q-Release, 4xPCIe 4.0 M.2 slots,USB 3.2 Gen 2x2 Type-C, front-panel connector, AI Motherboard)'),
(46, 'ASUS TUF Gaming H770-PRO', '/assets/images/products/mb/46.jpg', 'mb', 10, 24999, 'ASUS TUF GAMING H770-PRO WIFI - motherboard - ATX - LGA1700 Socket - H770'),
(47, 'ASUS TUF Z790 PLUS', '/assets/images/products/mb/47.jpg', 'mb', 19, 31999, 'ASUS TUF Gaming Z790-Plus WiFi LGA 1700(Intel14th & 13th & 12th Gen) ATX gaming motherboard(PCIe 5.0, DDR5,4xM.2 Slots,16+1 DrMOS,WiFi 6,Intel 2.5Gb LAN,front USB 3.2 Gen 2 Type-C,Thunderbolt 4(USB4), Aura RGB lighting)');

-- --------------------------------------------------------

--
-- Структура таблицы `cpu`
--

CREATE TABLE `cpu` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `brand` text,
  `cores` int(11) DEFAULT NULL,
  `id_brand` int(11) NOT NULL,
  `id_cores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cpu';

--
-- Дамп данных таблицы `cpu`
--

INSERT INTO `cpu` (`id`, `name`, `brand`, `cores`, `id_brand`, `id_cores`) VALUES
(18, 'AMD Ryzen 5 5600X', 'AMD', 12, 1, 2),
(19, 'AMD Ryzen 5 7600', 'AMD', 12, 1, 2),
(20, 'AMD Ryzen 7 5800X', 'AMD', 16, 1, 3),
(21, 'AMD Ryzen 9 7900', 'AMD', 24, 1, 5),
(22, 'AMD Ryzen 9 7950X3D', 'AMD', 24, 1, 5),
(23, 'INTEL i5-13600K', 'AMD', 20, 1, 4),
(24, 'INTEL i5-13600KF', 'INTEL', 20, 2, 4),
(25, 'INTEL i5-14600K', 'INTEL', 20, 2, 4),
(26, 'INTEL i7-14700KF', 'INTEL', 28, 2, 6),
(27, 'INTEL i9-13900K', 'INTEL', 32, 2, 7),
(28, 'INTEL i9-14900KF', 'INTEL', 32, 2, 7);

--
-- Триггеры `cpu`
--
DELIMITER $$
CREATE TRIGGER `after_delete_cpu` AFTER DELETE ON `cpu` FOR EACH ROW BEGIN
	DELETE FROM all_product 
	WHERE all_product.id = OLD.id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_cpu` AFTER INSERT ON `cpu` FOR EACH ROW BEGIN
  DECLARE duplicate_check INT;

  SELECT COUNT(*)
  INTO duplicate_check
  FROM all_product
  WHERE id = NEW.id;

  IF duplicate_check = 0 THEN
    INSERT INTO all_product (id, name, pic, product_type)
    VALUES (NEW.id, NEW.name, NULL, 'cpu');
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_common_id_cpu` BEFORE INSERT ON `cpu` FOR EACH ROW BEGIN
  DECLARE max_id INT;

  -- Находим максимальное значение id среди таблиц gpu, cpu, mb и ram
  SELECT MAX(id) INTO max_id FROM (
    SELECT id FROM gpu
    UNION
    SELECT id FROM cpu
    UNION
    SELECT id FROM mb
    UNION
    SELECT id FROM ram
  ) AS all_ids;

  -- Устанавливаем новое значение id для текущей вставки
  SET NEW.id = IFNULL(max_id, 0) + 1;
  
    SELECT brand INTO @brand FROM cpu_brand WHERE cpu_brand.id = NEW.id_brand;
    SELECT cores INTO @cores FROM cpu_cores WHERE cpu_cores.id = NEW.id_cores;

    -- Устанавливаем значения для новой записи
    SET NEW.brand = @brand;
    SET NEW.cores = @cores;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `cpu_brand`
--

CREATE TABLE `cpu_brand` (
  `id` int(11) NOT NULL,
  `brand` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cpu_brand`
--

INSERT INTO `cpu_brand` (`id`, `brand`) VALUES
(1, 'AMD'),
(2, 'INTEL');

-- --------------------------------------------------------

--
-- Структура таблицы `cpu_cores`
--

CREATE TABLE `cpu_cores` (
  `id` int(11) NOT NULL,
  `cores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cpu_cores`
--

INSERT INTO `cpu_cores` (`id`, `cores`) VALUES
(1, 8),
(2, 12),
(3, 16),
(4, 20),
(5, 24),
(6, 28),
(7, 32);

-- --------------------------------------------------------

--
-- Структура таблицы `gpu`
--

CREATE TABLE `gpu` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `brand` text,
  `distributor` text,
  `memory_size` int(11) DEFAULT NULL,
  `coolers` int(11) DEFAULT NULL,
  `id_brand` int(11) NOT NULL,
  `id_distributor` int(11) NOT NULL,
  `id_memory_size` int(11) NOT NULL,
  `id_coolers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='gpu';

--
-- Дамп данных таблицы `gpu`
--

INSERT INTO `gpu` (`id`, `name`, `brand`, `distributor`, `memory_size`, `coolers`, `id_brand`, `id_distributor`, `id_memory_size`, `id_coolers`) VALUES
(1, 'AMD ASUS 6650 XT', 'AMD', 'ASUS', 8, 2, 1, 3, 1, 2),
(2, 'AMD ASUS 7700 XT', 'AMD', 'ASUS', 12, 3, 1, 3, 2, 3),
(3, 'AMD ASUS 7800 XT', 'AMD', 'ASUS', 12, 3, 1, 3, 2, 3),
(4, 'AMD ASUS 7900 XTX', 'AMD', 'ASUS', 24, 3, 1, 3, 5, 3),
(5, 'AMD GIGABYTE 6600', 'AMD', 'GIGABYTE', 8, 3, 1, 1, 1, 3),
(6, 'AMD MSI 6750 XT', 'AMD', 'ASUS', 12, 2, 1, 3, 2, 2),
(7, 'AMD MSI 6750 XT', 'AMD', 'MSI', 12, 3, 1, 2, 2, 3),
(8, 'RTX ASUS 4070', 'RTX', 'ASUS', 12, 3, 2, 3, 2, 3),
(9, 'RTX ASUS ProArt 4060', 'RTX', 'ASUS', 8, 3, 2, 3, 1, 3),
(10, 'RTX GIGABYTE 3060', 'RTX', 'GIGABYTE', 12, 3, 2, 1, 2, 3),
(11, 'RTX GIGABYTE 4070', 'RTX', 'GIGABYTE', 12, 3, 2, 1, 2, 3),
(12, 'RTX GIGABYTE 4080', 'RTX', 'GIGABYTE', 16, 3, 2, 1, 3, 3),
(13, 'RTX MSI Ventus2 4060 Ti', 'RTX', 'MSI', 8, 2, 2, 2, 1, 2),
(14, 'RTX MSI Ventus3 4060 Ti', 'RTX', 'MSI', 8, 3, 2, 2, 1, 3),
(15, 'RTX Noctua ASUS 4080', 'RTX', 'ASUS', 16, 2, 2, 3, 3, 2),
(16, 'RTX White ASUS Rog Strix 4080', 'RTX', 'ASUS', 16, 3, 2, 3, 3, 3),
(17, 'RTX White GIGABYTE 4070', 'RTX', 'GIGABYTE', 12, 3, 2, 1, 2, 3);

--
-- Триггеры `gpu`
--
DELIMITER $$
CREATE TRIGGER `after_delete_gpu` AFTER DELETE ON `gpu` FOR EACH ROW BEGIN
	DELETE FROM all_product 
	WHERE all_product.id = OLD.id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_gpu` AFTER INSERT ON `gpu` FOR EACH ROW BEGIN
  DECLARE duplicate_check INT;

  SELECT COUNT(*)
  INTO duplicate_check
  FROM all_product
  WHERE id = NEW.id;

  IF duplicate_check = 0 THEN
    INSERT INTO all_product (id, name, pic, product_type)
    VALUES (NEW.id, NEW.name, NULL, 'gpu');
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_common_id_gpu` BEFORE INSERT ON `gpu` FOR EACH ROW BEGIN
  DECLARE max_id INT;

  -- Находим максимальное значение id среди таблиц gpu, cpu, mb и ram
  SELECT MAX(id) INTO max_id FROM (
    SELECT id FROM gpu
    UNION
    SELECT id FROM cpu
    UNION
    SELECT id FROM mb
    UNION
    SELECT id FROM ram
  ) AS all_ids;

  -- Устанавливаем новое значение id для текущей вставки
  SET NEW.id = IFNULL(max_id, 0) + 1;
  
    SELECT brand INTO @brand FROM gpu_brand WHERE gpu_brand.id = NEW.id_brand;
    SELECT distributor INTO @distributor FROM gpu_distributor WHERE gpu_distributor.id = NEW.id_distributor;
    SELECT memory_size INTO @memory_size FROM gpu_memory_size WHERE gpu_memory_size.id = NEW.id_memory_size;
    SELECT coolers INTO @coolers FROM gpu_coolers WHERE gpu_coolers.id = NEW.id_coolers;

    -- Устанавливаем значения для новой записи
    SET NEW.brand = @brand;
    SET NEW.distributor = @distributor;
    SET NEW.memory_size = @memory_size;
    SET NEW.coolers = @coolers;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `gpu_brand`
--

CREATE TABLE `gpu_brand` (
  `id` int(11) NOT NULL,
  `brand` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `gpu_brand`
--

INSERT INTO `gpu_brand` (`id`, `brand`) VALUES
(1, 'AMD'),
(2, 'RTX');

-- --------------------------------------------------------

--
-- Структура таблицы `gpu_coolers`
--

CREATE TABLE `gpu_coolers` (
  `id` int(11) NOT NULL,
  `coolers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `gpu_coolers`
--

INSERT INTO `gpu_coolers` (`id`, `coolers`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `gpu_distributor`
--

CREATE TABLE `gpu_distributor` (
  `id` int(11) NOT NULL,
  `distributor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `gpu_distributor`
--

INSERT INTO `gpu_distributor` (`id`, `distributor`) VALUES
(1, 'GIGABYTE'),
(2, 'MSI'),
(3, 'ASUS');

-- --------------------------------------------------------

--
-- Структура таблицы `gpu_memory_size`
--

CREATE TABLE `gpu_memory_size` (
  `id` int(11) NOT NULL,
  `memory_size` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `gpu_memory_size`
--

INSERT INTO `gpu_memory_size` (`id`, `memory_size`) VALUES
(1, 8),
(2, 12),
(3, 16),
(4, 20),
(5, 24);

-- --------------------------------------------------------

--
-- Структура таблицы `mb`
--

CREATE TABLE `mb` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `format` text,
  `socket` text,
  `wi_fi` text,
  `id_format` int(11) NOT NULL,
  `id_socket` int(11) NOT NULL,
  `id_wi_fi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mb`
--

INSERT INTO `mb` (`id`, `name`, `format`, `socket`, `wi_fi`, `id_format`, `id_socket`, `id_wi_fi`) VALUES
(37, 'ASUS Prime B450M-A', 'mATX', 'AM4', 'No', 1, 1, 2),
(38, 'ASUS Prime H510M-K', 'mATX', 'LGA 1200', 'No', 1, 3, 2),
(39, 'ASUS Prime Z790-A', 'ATX', 'LGA 1700', 'Yes', 2, 4, 1),
(40, 'ASUS ROG Maximus XIII Extreme Z590', 'ATX', 'LGA 1200', 'No', 2, 3, 2),
(41, 'ASUS ROG Strix B550-F', 'ATX', 'AM4', 'No', 2, 1, 2),
(42, 'ASUS ROG STRIX B560-E', 'ATX', 'LGA 1200', 'Yes', 2, 3, 1),
(43, 'ASUS ROG STRIX B650E', 'ATX', 'AM5', 'Yes', 2, 2, 1),
(44, 'ASUS ROG STRIX B760-F', 'ATX', 'LGA 1700', 'Yes', 2, 4, 1),
(45, 'ASUS ROG STRIX Z790-H', 'ATX', 'LGA 1700', 'Yes', 2, 4, 1),
(46, 'ASUS TUF Gaming H770-PRO', 'ATX', 'LGA 1700', 'Yes', 2, 4, 1),
(47, 'ASUS TUF Z790 PLUS', 'ATX', 'LGA 1700', 'Yes', 2, 4, 1);

--
-- Триггеры `mb`
--
DELIMITER $$
CREATE TRIGGER `after_delete_mb` AFTER DELETE ON `mb` FOR EACH ROW BEGIN
	DELETE FROM all_product 
	WHERE all_product.id = OLD.id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_mb` AFTER INSERT ON `mb` FOR EACH ROW BEGIN
  DECLARE duplicate_check INT;

  SELECT COUNT(*)
  INTO duplicate_check
  FROM all_product
  WHERE id = NEW.id;

  IF duplicate_check = 0 THEN
    INSERT INTO all_product (id, name, pic, product_type)
    VALUES (NEW.id, NEW.name, NULL, 'mb');
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_common_id_mb` BEFORE INSERT ON `mb` FOR EACH ROW BEGIN
  DECLARE max_id INT;

  -- Находим максимальное значение id среди таблиц gpu, cpu, mb и ram
  SELECT MAX(id) INTO max_id FROM (
    SELECT id FROM gpu
    UNION
    SELECT id FROM cpu
    UNION
    SELECT id FROM mb
    UNION
    SELECT id FROM ram
  ) AS all_ids;

  -- Устанавливаем новое значение id для текущей вставки
  SET NEW.id = IFNULL(max_id, 0) + 1;
  
  
    SELECT format INTO @format FROM mb_format WHERE mb_format.id = NEW.id_format;
    SELECT socket INTO @socket FROM mb_socket WHERE mb_socket.id = NEW.id_socket;
    SELECT wi_fi INTO @wi_fi FROM mb_wi_fi WHERE mb_wi_fi.id = NEW.id_wi_fi;
    

    -- Устанавливаем значения для новой записи
    SET NEW.format = @format;
    SET NEW.socket = @socket;
    SET NEW.wi_fi = @wi_fi;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `mb_format`
--

CREATE TABLE `mb_format` (
  `id` int(11) NOT NULL,
  `format` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mb_format`
--

INSERT INTO `mb_format` (`id`, `format`) VALUES
(1, 'mATX'),
(2, 'ATX');

-- --------------------------------------------------------

--
-- Структура таблицы `mb_socket`
--

CREATE TABLE `mb_socket` (
  `id` int(11) NOT NULL,
  `socket` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mb_socket`
--

INSERT INTO `mb_socket` (`id`, `socket`) VALUES
(1, 'AM4'),
(2, 'AM5'),
(3, 'LGA 1200'),
(4, 'LGA 1700');

-- --------------------------------------------------------

--
-- Структура таблицы `mb_wi_fi`
--

CREATE TABLE `mb_wi_fi` (
  `id` int(11) NOT NULL,
  `wi_fi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mb_wi_fi`
--

INSERT INTO `mb_wi_fi` (`id`, `wi_fi`) VALUES
(1, 'Yes'),
(2, 'No');

-- --------------------------------------------------------

--
-- Структура таблицы `order_cart`
--

CREATE TABLE `order_cart` (
  `id` int(11) NOT NULL,
  `cart_products` mediumtext NOT NULL,
  `id_acc` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `total_amount` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `order_cart`
--

INSERT INTO `order_cart` (`id`, `cart_products`, `id_acc`, `order_date`, `total_amount`) VALUES
(1, '[{\"product\":{\"description\":\"MSI Radeon RX 7750 XT OC Edition 12GB GDDR6 Gaming Graphics Card (AMD Radeon RX7700XT, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 2.1, O12G-GAMING\",\"id\":7,\"name\":\"AMD MSI 6750 XT\",\"pic\":\"/assets/images/products/gpu/7.jpg\",\"price\":49999,\"product_type\":\"gpu\",\"quantity\":11,\"imageUrl\":\"blob:http://localhost:4200/78c69a8c-722d-4195-974c-dca89ea32fe4\"},\"quantity\":1},{\"product\":{\"description\":\"GV-N4070WF3OC-12GD - GeForce RTX 4070-12 GB - GDDR6X - 192 bit - 7680 x 4320 pixels - PCI Express 4.0\",\"id\":11,\"name\":\"RTX GIGABYTE 4070\",\"pic\":\"/assets/images/products/gpu/11.jpg\",\"price\":75499,\"product_type\":\"gpu\",\"quantity\":1,\"imageUrl\":\"blob:http://localhost:4200/83ccdb32-1e21-45db-b76e-9b4739a783c2\"},\"quantity\":3},{\"product\":{\"description\":\"GeForce RTX 4080 16GB Noctua OC Edition GDDR6X Gaming Graphics Card (DLSS 3, PCIe 4.0, 16GB GDDR6X, 2X HDMI 2.1a, 3X DisplayPort 1.4a, RTX4080-O16G-NOCTUA)\",\"id\":15,\"name\":\"RTX Noctua ASUS 4080\",\"pic\":\"/assets/images/products/gpu/15.jpg\",\"price\":176999,\"product_type\":\"gpu\",\"quantity\":5,\"imageUrl\":\"blob:http://localhost:4200/deee534d-6160-4cb4-995e-a6d81bc390e7\"},\"quantity\":3},{\"product\":{\"description\":\"AMD Ryzen 5 5600X - Ryzen 5 5000 Series Vermeer (Zen 3) 6-Core 3.7 GHz Socket AM4 65W None Integrated Graphics Desktop Processor\",\"id\":18,\"name\":\"AMD Ryzen 5 5600X\",\"pic\":\"/assets/images/products/сpu/18.jpg\",\"price\":16499,\"product_type\":\"cpu\",\"quantity\":3,\"imageUrl\":\"blob:http://localhost:4200/939a17cc-6594-4de9-a463-3dcde2ed93c0\"},\"quantity\":2},{\"product\":{\"description\":\"AMD Ryzen 7 5800X - Ryzen 7 5000 Series Vermeer (Zen 3) 8-Core 3.8 GHz Socket AM4 105W None Integrated Graphics Desktop Processor\",\"id\":20,\"name\":\"AMD Ryzen 7 5800X\",\"pic\":\"/assets/images/products/сpu/20.jpg\",\"price\":23999,\"product_type\":\"cpu\",\"quantity\":4,\"imageUrl\":\"blob:http://localhost:4200/4ff0d1b2-b257-4376-8945-645df252e46d\"},\"quantity\":2},{\"product\":{\"description\":\"ROG Strix Radeon RX 6650 XT V2 OC Edition 8GB GDDR6 Graphics Card (AMD Radeon RX 6650XT,Aura Sync RGB Lighting,PCIe 4.0, 1x HDMI 2.1, 3x DisplayPort 1.4a,ROG-STRIX-RX6650XT-O8G-V2-GAMING)\",\"id\":1,\"name\":\"AMD ASUS 6650 XT\",\"pic\":\"/assets/images/products/gpu/1.jpg\",\"price\":33005,\"product_type\":\"gpu\",\"quantity\":7,\"imageUrl\":\"blob:http://localhost:4200/10dd0be1-aff9-4faa-aa87-6cd84c3bbd68\"},\"quantity\":3}]', 2, '2024-05-10 17:17:18', 987504),
(2, '[{\"product\":{\"description\":\"Intel Core i5-13600KF - Core i5 13th Gen Raptor Lake 14-Core (6P+8E) 3.5 GHz LGA 1700 125W None Integrated Graphics Desktop Processor\",\"id\":24,\"name\":\"INTEL i5-13600KF\",\"pic\":\"/assets/images/products/сpu/24.jpg\",\"price\":34999,\"product_type\":\"cpu\",\"quantity\":3,\"imageUrl\":\"blob:http://localhost:4200/1f90beaf-c745-4e73-b97f-ae82b62c75db\"},\"quantity\":1},{\"product\":{\"description\":\"CORSAIR Vengeance RGB 32GB (2 x 16GB) 288-Pin PC RAM DDR5 6000 (PC5 48000) Desktop Memory Model \",\"id\":32,\"name\":\"Corsair VENGEANCE RGB DDR5 32\",\"pic\":\"/assets/images/products/ram/32.jpg\",\"price\":19999,\"product_type\":\"ram\",\"quantity\":1,\"imageUrl\":\"blob:http://localhost:4200/39895379-77b5-4fcd-a330-9892c74e52c3\"},\"quantity\":1},{\"product\":{\"description\":\"ASUS ROG STRIX Z790-H Gaming (WiFi 6E) LGA 1700(Intel14th &13th&12th Gen) ATX gaming motherboard(DDR5 up to 7800 MT/s, PCIe 5.0 x16 SafeSlot with Q-Release, 4xPCIe 4.0 M.2 slots,USB 3.2 Gen 2x2 Type-C, front-panel connector, AI Motherboard)\",\"id\":45,\"name\":\"ASUS ROG STRIX Z790-H\",\"pic\":\"/assets/images/products/mb/45.jpg\",\"price\":41999,\"product_type\":\"mb\",\"quantity\":3,\"imageUrl\":\"blob:http://localhost:4200/3d01e2ae-395c-4136-b6a2-4337e5041c5b\"},\"quantity\":1},{\"product\":{\"description\":\"Crucial Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model\",\"id\":34,\"name\":\"Crucial Pro DDR4 32\",\"pic\":\"/assets/images/products/ram/34.jpg\",\"price\":7499,\"product_type\":\"ram\",\"quantity\":1,\"imageUrl\":\"blob:http://localhost:4200/49d6301d-1944-4374-a5ad-5e40bfe89d02\"},\"quantity\":1}]', 2, '2024-05-10 17:19:49', 104496),
(3, '[{\"product\":{\"description\":\"Intel Core i5-13600KF - Core i5 13th Gen Raptor Lake 14-Core (6P+8E) 3.5 GHz LGA 1700 125W None Integrated Graphics Desktop Processor\",\"id\":24,\"name\":\"INTEL i5-13600KF\",\"pic\":\"/assets/images/products/сpu/24.jpg\",\"price\":34999,\"product_type\":\"cpu\",\"quantity\":3,\"imageUrl\":\"blob:http://localhost:4200/1f90beaf-c745-4e73-b97f-ae82b62c75db\"},\"quantity\":1},{\"product\":{\"description\":\"CORSAIR Vengeance RGB 32GB (2 x 16GB) 288-Pin PC RAM DDR5 6000 (PC5 48000) Desktop Memory Model \",\"id\":32,\"name\":\"Corsair VENGEANCE RGB DDR5 32\",\"pic\":\"/assets/images/products/ram/32.jpg\",\"price\":19999,\"product_type\":\"ram\",\"quantity\":1,\"imageUrl\":\"blob:http://localhost:4200/39895379-77b5-4fcd-a330-9892c74e52c3\"},\"quantity\":1},{\"product\":{\"description\":\"ASUS ROG STRIX Z790-H Gaming (WiFi 6E) LGA 1700(Intel14th &13th&12th Gen) ATX gaming motherboard(DDR5 up to 7800 MT/s, PCIe 5.0 x16 SafeSlot with Q-Release, 4xPCIe 4.0 M.2 slots,USB 3.2 Gen 2x2 Type-C, front-panel connector, AI Motherboard)\",\"id\":45,\"name\":\"ASUS ROG STRIX Z790-H\",\"pic\":\"/assets/images/products/mb/45.jpg\",\"price\":41999,\"product_type\":\"mb\",\"quantity\":3,\"imageUrl\":\"blob:http://localhost:4200/3d01e2ae-395c-4136-b6a2-4337e5041c5b\"},\"quantity\":1},{\"product\":{\"description\":\"Crucial Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model\",\"id\":34,\"name\":\"Crucial Pro DDR4 32\",\"pic\":\"/assets/images/products/ram/34.jpg\",\"price\":7499,\"product_type\":\"ram\",\"quantity\":1,\"imageUrl\":\"blob:http://localhost:4200/49d6301d-1944-4374-a5ad-5e40bfe89d02\"},\"quantity\":1},{\"product\":{\"description\":\"ASUS ROG STRIX B560-E GAMING WIFI LGA 1200 Intel B560 DDR4 ATX Motherboard (90MB1880-M0EAY0)\",\"id\":42,\"name\":\"ASUS ROG STRIX B560-E\",\"pic\":\"/assets/images/products/mb/42.jpg\",\"price\":26999,\"product_type\":\"mb\",\"quantity\":5,\"imageUrl\":\"blob:http://localhost:4200/b66cf2aa-128d-4945-ae60-37ae29e76ffc\"},\"quantity\":1},{\"product\":{\"description\":\"Asus ROG STRIX B550-F GAMING WIFI II AMD AM4 (3rd Gen Ryzen) ATX Gaming Motherboard (PCIe 4.0,WiFi 6E, 2.5Gb LAN, BIOS FlashBack, HDMI 2.1, Addressable Gen 2 RGB Header and AURA Sync)\",\"id\":41,\"name\":\"ASUS ROG Strix B550-F\",\"pic\":\"/assets/images/products/mb/41.jpg\",\"price\":23599,\"product_type\":\"mb\",\"quantity\":3,\"imageUrl\":\"blob:http://localhost:4200/8fbeb27b-e9ec-44c6-9131-684d6d42c2cc\"},\"quantity\":1},{\"product\":{\"description\":\"ASUS TUF Gaming Z790-Plus WiFi LGA 1700(Intel14th & 13th & 12th Gen) ATX gaming motherboard(PCIe 5.0, DDR5,4xM.2 Slots,16+1 DrMOS,WiFi 6,Intel 2.5Gb LAN,front USB 3.2 Gen 2 Type-C,Thunderbolt 4(USB4), Aura RGB lighting)\",\"id\":47,\"name\":\"ASUS TUF Z790 PLUS\",\"pic\":\"/assets/images/products/mb/47.jpg\",\"price\":31999,\"product_type\":\"mb\",\"quantity\":5,\"imageUrl\":\"blob:http://localhost:4200/2fe5b605-7f80-4dc7-9d83-899c4d907761\"},\"quantity\":1}]', 2, '2024-05-10 17:58:20', 187093),
(4, '[{\"product\": {\"description\": \"ROG Strix Radeon RX 6650 XT V2 OC Edition 8GB GDDR6 Graphics Card (AMD Radeon RX 6650XT,Aura Sync RGB Lighting,PCIe 4.0, 1x HDMI 2.1, 3x DisplayPort 1.4a,ROG-STRIX-RX6650XT-O8G-V2-GAMING)\", \"id\": 1, \"name\": \"AMD ASUS 6650 XT\", \"pic\": \"/assets/images/products/gpu/1.jpg\", \"price\": 33005, \"product_type\": \"gpu\", \"quantity\": 12, \"imageUrl\": \"blob:http://localhost:4200/79aeeaf9-7832-4bbc-87db-470b25d85988\"}, \"quantity\": 1}, {\"product\": {\"description\": \"TUF Gaming Radeon RX 7700 XT OC Edition 12GB GDDR6 Gaming Graphics Card (AMD Radeon RX7700XT, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 2.1, TUF-RX7700XT-O12G-GAMING)\", \"id\": 2, \"name\": \"AMD ASUS 7700 XT\", \"pic\": \"/assets/images/products/gpu/2.jpg\", \"price\": 60999, \"product_type\": \"gpu\", \"quantity\": 7, \"imageUrl\": \"blob:http://localhost:4200/fed4389f-1830-4ada-b44d-26fea41f8000\"}, \"quantity\": 1}]', 2, '2024-05-10 18:54:46', 94004),
(5, '[{\"product\": {\"description\": \"ROG Strix Radeon RX 6650 XT V2 OC Edition 8GB GDDR6 Graphics Card (AMD Radeon RX 6650XT,Aura Sync RGB Lighting,PCIe 4.0, 1x HDMI 2.1, 3x DisplayPort 1.4a,ROG-STRIX-RX6650XT-O8G-V2-GAMING)\", \"id\": 1, \"name\": \"AMD ASUS 6650 XT\", \"pic\": \"/assets/images/products/gpu/1.jpg\", \"price\": 33005, \"product_type\": \"gpu\", \"quantity\": 11, \"imageUrl\": \"blob:http://localhost:4200/cec882e6-52fb-41a7-a43d-61237458aa93\"}, \"quantity\": 1}]', 2, '2024-05-10 18:56:11', 33005),
(6, '[{\"product\": {\"description\": \"ROG Strix GeForce RTX 4080 16GB White Edition GDDR6X Gaming Graphics Card\", \"id\": 16, \"name\": \"RTX White ASUS Rog Strix 4080\", \"pic\": \"/assets/images/products/gpu/16.jpg\", \"price\": 246999, \"product_type\": \"gpu\", \"quantity\": 15, \"imageUrl\": \"blob:http://localhost:4200/20a26188-e823-4457-b431-430618bcc615\"}, \"quantity\": 1}, {\"product\": {\"description\": \"Dual GeForce RTX 4070 OC White Edition 12GB GDDR6X Gaming Graphics Card (NVIDIA GeForce RTX4070 DLSS3, PCIe 4.0, 1x HMDI 2.1, 3X DisplayPort 1.4a, DUAL-RTX4070-O12G-WHITE) White\", \"id\": 17, \"name\": \"RTX White GIGABYTE 4070\", \"pic\": \"/assets/images/products/gpu/17.jpg\", \"price\": 92399, \"product_type\": \"gpu\", \"quantity\": 19, \"imageUrl\": \"blob:http://localhost:4200/a541bc0d-8065-44c0-b8f1-f6e562d4f61a\"}, \"quantity\": 2}, {\"product\": {\"description\": \"ROG Strix Radeon RX 6650 XT V2 OC Edition 8GB GDDR6 Graphics Card (AMD Radeon RX 6650XT,Aura Sync RGB Lighting,PCIe 4.0, 1x HDMI 2.1, 3x DisplayPort 1.4a,ROG-STRIX-RX6650XT-O8G-V2-GAMING)\", \"id\": 1, \"name\": \"AMD ASUS 6650 XT\", \"pic\": \"/assets/images/products/gpu/1.jpg\", \"price\": 33005, \"product_type\": \"gpu\", \"quantity\": 10, \"imageUrl\": \"blob:http://localhost:4200/164ae933-6b35-42c6-8a3f-8f842ba05028\"}, \"quantity\": 1}, {\"product\": {\"description\": \"AMD Ryzen 9 7900 - Ryzen 9 7000 Series 12-Core 3.7 GHz Socket AM5 65W AMD Radeon Graphics Processor\", \"id\": 21, \"name\": \"AMD Ryzen 9 7900\", \"pic\": \"/assets/images/products/\\u0441pu/21.jpg\", \"price\": 41999, \"product_type\": \"cpu\", \"quantity\": 20, \"imageUrl\": \"blob:http://localhost:4200/4d02a2cf-b9e5-4fd8-bffc-009f1d00d168\"}, \"quantity\": 2}]', 4, '2024-05-10 23:35:59', 548800),
(7, '[{\"product\": {\"description\": \"TUF Gaming Radeon RX 7700 XT OC Edition 12GB GDDR6 Gaming Graphics Card (AMD Radeon RX7700XT, PCIe 4.0, 1x HDMI 2.1, 3X DisplayPort 2.1, TUF-RX7700XT-O12G-GAMING)\", \"id\": 2, \"name\": \"AMD ASUS 7700 XT\", \"pic\": \"/assets/images/products/gpu/2.jpg\", \"price\": 60999, \"product_type\": \"gpu\", \"quantity\": 6, \"imageUrl\": \"blob:http://localhost:4200/e2f5ddab-4081-4d68-86dc-177e31731a1e\"}, \"quantity\": 1}, {\"product\": {\"description\": \"CORSAIR Vengeance RGB Pro 16GB (2 x 8GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model\", \"id\": 35, \"name\": \"Corsair Vengeance RGB PRO DDR4 16\", \"pic\": \"/assets/images/products/ram/35.jpg\", \"price\": 3699, \"product_type\": \"ram\", \"quantity\": 10, \"imageUrl\": \"blob:http://localhost:4200/b8017f6c-623e-41bb-91dc-761924ec618e\"}, \"quantity\": 1}, {\"product\": {\"description\": \"CORSAIR Vengeance RGB Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model\", \"id\": 36, \"name\": \"Corsair VENGEANCE RGB PRO DDR4 16\", \"pic\": \"/assets/images/products/ram/36.jpg\", \"price\": 3999, \"product_type\": \"ram\", \"quantity\": 8, \"imageUrl\": \"blob:http://localhost:4200/199c74f2-d759-478d-9bbc-0a19dd76d72d\"}, \"quantity\": 1}, {\"product\": {\"description\": \"ASUS ROG Strix B760-F Gaming WiFi Intel B760(13th and 12th Gen) LGA 1700 ATX motherboard, 16 + 1 power stages, DDR5 up to 7800 MT/s, PCIe 5.0, three M.2 slots, WiFi 6E, USB 3.2 Gen 2x2 Type-C\\u00ae, and Aura Sync RGB\", \"id\": 44, \"name\": \"ASUS ROG STRIX B760-F\", \"pic\": \"/assets/images/products/mb/44.jpg\", \"price\": 26999, \"product_type\": \"mb\", \"quantity\": 20, \"imageUrl\": \"blob:http://localhost:4200/ebbe3134-4a01-41a1-ac87-f59d0938990c\"}, \"quantity\": 1}]', 4, '2024-05-10 23:37:33', 95696),
(8, '[{\"product\": {\"description\": \"TUF Gaming AMD Radeon RX 7900 XTX OC Edition 24GB GDDR6 Gaming Graphics Card (PCIe 4.0, Memory, 1x HDMI 2.1, 3X DisplayPort 2.1, GPU Tweak III, TUF-RX7900XTX-O24G-GAMING)\", \"id\": 4, \"name\": \"AMD ASUS 7900 XTX\", \"pic\": \"/assets/images/products/gpu/4.jpg\", \"price\": 144999, \"product_type\": \"gpu\", \"quantity\": 12, \"imageUrl\": \"blob:http://localhost:4200/74d3b245-994a-484b-8123-205babbefd4a\"}, \"quantity\": 3}, {\"product\": {\"description\": \"ProArt GeForce RTX 4060 OC Edition 8GB GDDR6 Gaming Graphics Card (NVIDIA GeForce RTX4060 DLSS 3, PCIe 4.0, 1x HDMI 2.1a, 3X DisplayPort 1.4a, PROART-RTX4060TI-O8G)\", \"id\": 9, \"name\": \"RTX ASUS ProArt 4060\", \"pic\": \"/assets/images/products/gpu/9.jpg\", \"price\": 49799, \"product_type\": \"gpu\", \"quantity\": 9, \"imageUrl\": \"blob:http://localhost:4200/152fa0c5-c750-44ca-abb8-aa1a389d1fc3\"}, \"quantity\": 1}, {\"product\": {\"description\": \"ROG Strix Radeon RX 6650 XT V2 OC Edition 8GB GDDR6 Graphics Card (AMD Radeon RX 6650XT,Aura Sync RGB Lighting,PCIe 4.0, 1x HDMI 2.1, 3x DisplayPort 1.4a,ROG-STRIX-RX6650XT-O8G-V2-GAMING)\", \"id\": 1, \"name\": \"AMD ASUS 6650 XT\", \"pic\": \"/assets/images/products/gpu/1.jpg\", \"price\": 33005, \"product_type\": \"gpu\", \"quantity\": 9, \"imageUrl\": \"blob:http://localhost:4200/8456bfa8-78cd-46e9-b482-a63508812767\"}, \"quantity\": 3}]', 4, '2024-05-16 12:10:56', 583811),
(9, '[{\"product\": {\"description\": \"CORSAIR Vengeance RGB Pro 32GB (2 x 16GB) 288-Pin PC RAM DDR4 3200 (PC4 25600) Desktop Memory Model\", \"id\": 36, \"name\": \"Corsair VENGEANCE RGB PRO DDR4 16\", \"pic\": \"/assets/images/products/ram/36.jpg\", \"price\": 3999, \"product_type\": \"ram\", \"quantity\": 7, \"imageUrl\": \"blob:http://localhost:4200/2f6759e7-45eb-4e46-a820-72b354653c9d\"}, \"quantity\": 2}, {\"product\": {\"description\": \"ASUS PRIME H510M-K Intel H510 LGA 1200 Micro ATX Motherboard\", \"id\": 38, \"name\": \"ASUS Prime H510M-K\", \"pic\": \"/assets/images/products/mb/38.jpg\", \"price\": 8999, \"product_type\": \"mb\", \"quantity\": 25, \"imageUrl\": \"blob:http://localhost:4200/f31db45e-f068-4720-b97b-224f4d900ae7\"}, \"quantity\": 1}]', 4, '2024-05-26 19:17:02', 16997);

-- --------------------------------------------------------

--
-- Структура таблицы `ram`
--

CREATE TABLE `ram` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `brand` text,
  `memory_type` text,
  `capacity` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `id_brand` int(11) NOT NULL,
  `id_memory_type` int(11) NOT NULL,
  `id_capacity` int(11) NOT NULL,
  `id_frequency` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ram`
--

INSERT INTO `ram` (`id`, `name`, `brand`, `memory_type`, `capacity`, `frequency`, `id_brand`, `id_memory_type`, `id_capacity`, `id_frequency`) VALUES
(29, 'Corsair Vengeance DDR4 32', 'Corsair', 'DDR4', 32, 3200, 1, 1, 3, 1),
(30, 'Corsair VENGEANCE DDR5 32', 'Corsair', 'DDR5', 32, 6000, 1, 2, 3, 3),
(31, 'Corsair Vengeance RGB DDR4 32', 'Corsair', 'DDR4', 32, 3600, 1, 1, 3, 2),
(32, 'Corsair VENGEANCE RGB DDR5 32', 'Corsair', 'DDR5', 32, 6000, 1, 2, 3, 3),
(33, 'Corsair VENGEANCE RGB White DDR4 32', 'Corsair', 'DDR4', 32, 3600, 1, 1, 3, 2),
(34, 'Crucial Pro DDR4 32', 'Crucial', 'DDR4', 32, 3200, 2, 1, 3, 1),
(35, 'Corsair Vengeance RGB PRO DDR4 16', 'Corsair', 'DDR4', 16, 3200, 1, 1, 2, 1),
(36, 'Corsair VENGEANCE RGB PRO DDR4 16', 'Corsair', 'DDR4', 16, 3600, 1, 1, 2, 2);

--
-- Триггеры `ram`
--
DELIMITER $$
CREATE TRIGGER `after_delete_ram` AFTER DELETE ON `ram` FOR EACH ROW BEGIN
	DELETE FROM all_product 
	WHERE all_product.id = OLD.id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_ram` AFTER INSERT ON `ram` FOR EACH ROW BEGIN
  DECLARE duplicate_check INT;

  SELECT COUNT(*)
  INTO duplicate_check
  FROM all_product
  WHERE id = NEW.id;

  IF duplicate_check = 0 THEN
    INSERT INTO all_product (id, name, pic, product_type)
    VALUES (NEW.id, NEW.name, NULL, 'ram');
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_common_id_ram` BEFORE INSERT ON `ram` FOR EACH ROW BEGIN
  DECLARE max_id INT;

  -- Находим максимальное значение id среди таблиц gpu, cpu, mb и ram
  SELECT MAX(id) INTO max_id FROM (
    SELECT id FROM gpu
    UNION
    SELECT id FROM cpu
    UNION
    SELECT id FROM mb
    UNION
    SELECT id FROM ram
  ) AS all_ids;

  -- Устанавливаем новое значение id для текущей вставки
  SET NEW.id = IFNULL(max_id, 0) + 1;
  
  SELECT brand INTO @brand FROM ram_brand WHERE ram_brand.id = NEW.id_brand;
  SELECT memory_type INTO @memory_type FROM ram_memory_type WHERE ram_memory_type.id = NEW.id_memory_type;
  SELECT capacity INTO @capacity FROM ram_capacity WHERE ram_capacity.id = NEW.id_capacity;
  SELECT frequency INTO @frequency FROM ram_frequency WHERE ram_frequency.id = NEW.id_frequency;

    -- Устанавливаем значения для новой записи
    SET NEW.brand = @brand;
    SET NEW.memory_type = @memory_type;
    SET NEW.capacity = @capacity;
	SET NEW.frequency = @frequency;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `ram_brand`
--

CREATE TABLE `ram_brand` (
  `id` int(11) NOT NULL,
  `brand` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ram_brand`
--

INSERT INTO `ram_brand` (`id`, `brand`) VALUES
(1, 'Corsair'),
(2, 'Crucial');

-- --------------------------------------------------------

--
-- Структура таблицы `ram_capacity`
--

CREATE TABLE `ram_capacity` (
  `id` int(11) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ram_capacity`
--

INSERT INTO `ram_capacity` (`id`, `capacity`) VALUES
(1, 8),
(2, 16),
(3, 32),
(4, 64);

-- --------------------------------------------------------

--
-- Структура таблицы `ram_frequency`
--

CREATE TABLE `ram_frequency` (
  `id` int(11) NOT NULL,
  `frequency` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ram_frequency`
--

INSERT INTO `ram_frequency` (`id`, `frequency`) VALUES
(1, 3200),
(2, 3600),
(3, 6000);

-- --------------------------------------------------------

--
-- Структура таблицы `ram_memory_type`
--

CREATE TABLE `ram_memory_type` (
  `id` int(11) NOT NULL,
  `memory_type` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ram_memory_type`
--

INSERT INTO `ram_memory_type` (`id`, `memory_type`) VALUES
(1, 'DDR4'),
(2, 'DDR5');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login_unique` (`login`(255));

--
-- Индексы таблицы `account_admin`
--
ALTER TABLE `account_admin`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `all_product`
--
ALTER TABLE `all_product`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cpu`
--
ALTER TABLE `cpu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cpu_brand` (`id_brand`),
  ADD KEY `fk_cpu_cores` (`id_cores`);

--
-- Индексы таблицы `cpu_brand`
--
ALTER TABLE `cpu_brand`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cpu_cores`
--
ALTER TABLE `cpu_cores`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gpu`
--
ALTER TABLE `gpu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_gpu_brand` (`id_brand`),
  ADD KEY `fk_gpu_distributor` (`id_distributor`),
  ADD KEY `fk_gpu_memory` (`id_memory_size`),
  ADD KEY `fk_gpu_coolers` (`id_coolers`);

--
-- Индексы таблицы `gpu_brand`
--
ALTER TABLE `gpu_brand`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gpu_coolers`
--
ALTER TABLE `gpu_coolers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gpu_distributor`
--
ALTER TABLE `gpu_distributor`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gpu_memory_size`
--
ALTER TABLE `gpu_memory_size`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `mb`
--
ALTER TABLE `mb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mb_format` (`id_format`),
  ADD KEY `fk_mb_socket` (`id_socket`),
  ADD KEY `fk_mb_wi_fi` (`id_wi_fi`);

--
-- Индексы таблицы `mb_format`
--
ALTER TABLE `mb_format`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `mb_socket`
--
ALTER TABLE `mb_socket`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `mb_wi_fi`
--
ALTER TABLE `mb_wi_fi`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_cart`
--
ALTER TABLE `order_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_acc_cart_id` (`id_acc`);

--
-- Индексы таблицы `ram`
--
ALTER TABLE `ram`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ram_brand` (`id_brand`),
  ADD KEY `fk_ram_capacity` (`id_capacity`),
  ADD KEY `fk_ram_frequency` (`id_frequency`),
  ADD KEY `fk_ram_memoty_type` (`id_memory_type`);

--
-- Индексы таблицы `ram_brand`
--
ALTER TABLE `ram_brand`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ram_capacity`
--
ALTER TABLE `ram_capacity`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ram_frequency`
--
ALTER TABLE `ram_frequency`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ram_memory_type`
--
ALTER TABLE `ram_memory_type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `account_admin`
--
ALTER TABLE `account_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `all_product`
--
ALTER TABLE `all_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT для таблицы `cpu`
--
ALTER TABLE `cpu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `cpu_brand`
--
ALTER TABLE `cpu_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `cpu_cores`
--
ALTER TABLE `cpu_cores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `gpu`
--
ALTER TABLE `gpu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `gpu_brand`
--
ALTER TABLE `gpu_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `gpu_coolers`
--
ALTER TABLE `gpu_coolers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `gpu_distributor`
--
ALTER TABLE `gpu_distributor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `gpu_memory_size`
--
ALTER TABLE `gpu_memory_size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `mb`
--
ALTER TABLE `mb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT для таблицы `mb_format`
--
ALTER TABLE `mb_format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `mb_socket`
--
ALTER TABLE `mb_socket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `mb_wi_fi`
--
ALTER TABLE `mb_wi_fi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `order_cart`
--
ALTER TABLE `order_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `ram`
--
ALTER TABLE `ram`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `ram_brand`
--
ALTER TABLE `ram_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `ram_capacity`
--
ALTER TABLE `ram_capacity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `ram_frequency`
--
ALTER TABLE `ram_frequency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `ram_memory_type`
--
ALTER TABLE `ram_memory_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `account_admin`
--
ALTER TABLE `account_admin`
  ADD CONSTRAINT `fk_id_admin` FOREIGN KEY (`id`) REFERENCES `account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `cpu`
--
ALTER TABLE `cpu`
  ADD CONSTRAINT `fk_cpu_brand` FOREIGN KEY (`id_brand`) REFERENCES `cpu_brand` (`id`),
  ADD CONSTRAINT `fk_cpu_cores` FOREIGN KEY (`id_cores`) REFERENCES `cpu_cores` (`id`);

--
-- Ограничения внешнего ключа таблицы `gpu`
--
ALTER TABLE `gpu`
  ADD CONSTRAINT `fk_gpu_brand` FOREIGN KEY (`id_brand`) REFERENCES `gpu_brand` (`id`),
  ADD CONSTRAINT `fk_gpu_coolers` FOREIGN KEY (`id_coolers`) REFERENCES `gpu_coolers` (`id`),
  ADD CONSTRAINT `fk_gpu_distributor` FOREIGN KEY (`id_distributor`) REFERENCES `gpu_distributor` (`id`),
  ADD CONSTRAINT `fk_gpu_memory` FOREIGN KEY (`id_memory_size`) REFERENCES `gpu_memory_size` (`id`);

--
-- Ограничения внешнего ключа таблицы `mb`
--
ALTER TABLE `mb`
  ADD CONSTRAINT `fk_mb_format` FOREIGN KEY (`id_format`) REFERENCES `mb_format` (`id`),
  ADD CONSTRAINT `fk_mb_socket` FOREIGN KEY (`id_socket`) REFERENCES `mb_socket` (`id`),
  ADD CONSTRAINT `fk_mb_wi_fi` FOREIGN KEY (`id_wi_fi`) REFERENCES `mb_wi_fi` (`id`);

--
-- Ограничения внешнего ключа таблицы `order_cart`
--
ALTER TABLE `order_cart`
  ADD CONSTRAINT `fk_acc_cart_id` FOREIGN KEY (`id_acc`) REFERENCES `account` (`id`);

--
-- Ограничения внешнего ключа таблицы `ram`
--
ALTER TABLE `ram`
  ADD CONSTRAINT `fk_ram_brand` FOREIGN KEY (`id_brand`) REFERENCES `ram_brand` (`id`),
  ADD CONSTRAINT `fk_ram_capacity` FOREIGN KEY (`id_capacity`) REFERENCES `ram_capacity` (`id`),
  ADD CONSTRAINT `fk_ram_frequency` FOREIGN KEY (`id_frequency`) REFERENCES `ram_frequency` (`id`),
  ADD CONSTRAINT `fk_ram_memoty_type` FOREIGN KEY (`id_memory_type`) REFERENCES `ram_memory_type` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
