-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 29 2023 г., 19:17
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
-- Структура таблицы `all_product`
--

CREATE TABLE `all_product` (
  `id` int(11) NOT NULL,
  `name` text,
  `pic` text,
  `product_type` text NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `price` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `all_product`
--

INSERT INTO `all_product` (`id`, `name`, `pic`, `product_type`, `quantity`, `price`) VALUES
(1, 'AMD ASUS 6650 XT', '/assets/images/products/gpu/1.jpg', 'gpu', 2, 33005),
(2, 'AMD ASUS 7700 XT', '/assets/images/products/gpu/2.jpg', 'gpu', 3, 60999),
(3, 'AMD ASUS 7800 XT', '/assets/images/products/gpu/3.jpg', 'gpu', 1, 92499),
(4, 'AMD ASUS 7900 XTX', '/assets/images/products/gpu/4.jpg', 'gpu', 1, 144999),
(5, 'AMD GIGABYTE 6600', '/assets/images/products/gpu/5.jpg', 'gpu', 1, 29899),
(6, 'AMD MSI 6750 XT', '/assets/images/products/gpu/6.jpg', 'gpu', 1, 45499),
(7, 'AMD MSI 6750 XT', '/assets/images/products/gpu/7.jpg', 'gpu', 1, 49999),
(8, 'RTX ASUS 4070', '/assets/images/products/gpu/8.jpg', 'gpu', 1, 83999),
(9, 'RTX ASUS ProArt 4060', '/assets/images/products/gpu/9.jpg', 'gpu', 1, 49799),
(10, 'RTX GIGABYTE 3060', '/assets/images/products/gpu/10.jpg', 'gpu', 1, 41299),
(11, 'RTX GIGABYTE 4070', '/assets/images/products/gpu/11.jpg', 'gpu', 1, 75499),
(12, 'RTX GIGABYTE 4080', '/assets/images/products/gpu/12.jpg', 'gpu', 1, 140999),
(13, 'RTX MSI Ventus2 4060 Ti', '/assets/images/products/gpu/13.jpg', 'gpu', 1, 50299),
(14, 'RTX MSI Ventus3 4060 Ti', '/assets/images/products/gpu/14.jpg', 'gpu', 1, 61499),
(15, 'RTX Noctua ASUS 4080', '/assets/images/products/gpu/15.jpg', 'gpu', 1, 176999),
(16, 'RTX White ASUS Rog Strix 4080', '/assets/images/products/gpu/16.jpg', 'gpu', 1, 246999),
(17, 'RTX White GIGABYTE 4070', '/assets/images/products/gpu/17.jpg', 'gpu', 1, 92399),
(18, 'AMD Ryzen 5 5600X', '/assets/images/products/сpu/18.jpg', 'cpu', 3, 16499),
(19, 'AMD Ryzen 5 7600', '/assets/images/products/сpu/19.jpg', 'cpu', 4, 21499),
(20, 'AMD Ryzen 7 5800X', '/assets/images/products/сpu/20.jpg', 'cpu', 4, 23999),
(21, 'AMD Ryzen 9 7900', '/assets/images/products/сpu/21.jpg', 'cpu', 3, 41999),
(22, 'AMD Ryzen 9 7950X3D', '/assets/images/products/сpu/22.jpg', 'cpu', 3, 79799),
(23, 'INTEL i5-13600K', '/assets/images/products/сpu/23.jpg', 'cpu', 4, 36999),
(24, 'INTEL i5-13600KF', '/assets/images/products/сpu/24.jpg', 'cpu', 3, 34999),
(25, 'INTEL i5-14600K', '/assets/images/products/сpu/25.jpg', 'cpu', 4, 43799),
(26, 'INTEL i7-14700KF', '/assets/images/products/сpu/26.jpg', 'cpu', 3, 54999),
(27, 'INTEL i9-13900K', '/assets/images/products/сpu/27.jpg', 'cpu', 3, 76999),
(28, 'INTEL i9-14900KF', '/assets/images/products/сpu/28.jpg', 'cpu', 7, 69999),
(29, 'Corsair Vengeance DDR4 32', '/assets/images/products/ram/29.jpg', 'ram', 1, 6999),
(30, 'Corsair VENGEANCE DDR5 32', '/assets/images/products/ram/30.jpg', 'ram', 1, 12899),
(31, 'Corsair Vengeance RGB DDR4 32', '/assets/images/products/ram/31.jpg', 'ram', 1, 8599),
(32, 'Corsair VENGEANCE RGB DDR5 32', '/assets/images/products/ram/32.jpg', 'ram', 1, 19999),
(33, 'Corsair VENGEANCE RGB White DDR4 32', '/assets/images/products/ram/33.jpg', 'ram', 1, 8899),
(34, 'Crucial Pro DDR4 32', '/assets/images/products/ram/34.jpg', 'ram', 1, 7499),
(35, 'Corsair Vengeance RGB PRO DDR4 16', '/assets/images/products/ram/35.jpg', 'ram', 1, 3699),
(36, 'Corsair VENGEANCE RGB PRO DDR4 16', '/assets/images/products/ram/36.jpg', 'ram', 1, 3999),
(37, 'ASUS Prime B450M-A', '/assets/images/products/mb/37.jpg', 'mb', 4, 9499),
(38, 'ASUS Prime H510M-K', '/assets/images/products/mb/38.jpg', 'mb', 5, 8999),
(39, 'ASUS Prime Z790-A', '/assets/images/products/mb/39.jpg', 'mb', 4, 33999),
(40, 'ASUS ROG Maximus XIII Extreme Z590', '/assets/images/products/mb/40.jpg', 'mb', 4, 64499),
(41, 'ASUS ROG Strix B550-F', '/assets/images/products/mb/41.jpg', 'mb', 3, 23599),
(42, 'ASUS ROG STRIX B560-E', '/assets/images/products/mb/42.jpg', 'mb', 5, 26999),
(43, 'ASUS ROG STRIX B650E', '/assets/images/products/mb/43.jpg', 'mb', 3, 37299),
(44, 'ASUS ROG STRIX B760-F', '/assets/images/products/mb/44.jpg', 'mb', 3, 26999),
(45, 'ASUS ROG STRIX Z790-H', '/assets/images/products/mb/45.jpg', 'mb', 3, 41999),
(46, 'ASUS TUF Gaming H770-PRO', '/assets/images/products/mb/46.jpg', 'mb', 3, 24999),
(47, 'ASUS TUF Z790 PLUS', '/assets/images/products/mb/47.jpg', 'mb', 5, 31999);

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
-- AUTO_INCREMENT для таблицы `all_product`
--
ALTER TABLE `all_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT для таблицы `cpu`
--
ALTER TABLE `cpu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

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
