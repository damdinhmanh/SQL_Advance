-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Sep 22, 2022 at 05:13 PM
-- Server version: 8.0.30
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Test`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`%` PROCEDURE `avg_skin_price` (OUT `avg_price` INT)   BEGIN
	SELECT AVG(price) INTO avg_price FROM skin;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `CheckCosLineExist` (OUT `result` TEXT)   BEGIN
	DECLARE checkCnt INT; 

	SELECT COUNT(*) INTO checkCnt
 	FROM costume_line
	WHERE name = 'Line 12';

    IF checkCnt = 0 THEN
    	SET result = 'Not Existed Yet';
    ELSE
    	SET result = 'Existed';
    END IF;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `count_fingure` (OUT `fcnt` INT)   BEGIN
	SELECT COUNT(id) INTO fcnt FROM fingure;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `count_line_type` (OUT `line_cnt` INT)   BEGIN
	SELECT COUNT(id) INTO line_cnt FROM costume_line
    WHERE day_buy LIKE '%09-15';
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `find_skin` (IN `type_in` TEXT)   BEGIN
	SELECT skin.name as SkinName, type.name as TypeName FROM skin JOIN type
    ON skin.type_id=type.id and type.name=type_in;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `insert_cos_line` (IN `start_index` INT)   BEGIN
	DECLARE cntval int;
    DECLARE cosline text;
    SET cntval = 0;
	WHILE cntval < 5 DO
        Set cosline = Concat('Line ', start_index);
        INSERT INTO costume_line 
VALUES(start_index, cosline, '2022-09-19', '2022-09-29');
SET start_index = start_index + 1;
        SET cntval = cntval + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `insert_val` (IN `id` INT, IN `name` TEXT, IN `combo` TEXT)   BEGIN
	INSERT into fingure VALUES(id, name, combo);
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `test_pro` (IN `id_` INT)   Begin 
	DECLARE result text;
	set result ='';
	while id_ <5 do
        SELECT COUNT(*) from skin;
        SET id_ = id_+1;
        set result= concat(result, id_,',');
        end while;
        select result;
End$$

CREATE DEFINER=`root`@`%` PROCEDURE `update_val` (IN `inid` INT, IN `val` INT)   BEGIN
	update skin
    set price = val
    WHERE id = inid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `costume_line`
--

CREATE TABLE `costume_line` (
  `id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `create_at` date NOT NULL,
  `day_buy` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `costume_line`
--

INSERT INTO `costume_line` (`id`, `name`, `create_at`, `day_buy`) VALUES
(1, 'Line 1', '2022-09-01', '2022-09-15'),
(2, 'Line 2', '2022-09-02', '2022-09-15'),
(3, 'Line 3', '2022-09-03', '2022-09-14'),
(4, 'Line 4', '2022-09-04', '2022-09-15'),
(5, 'Line 5', '2022-09-19', '2022-09-29'),
(6, 'Line 6', '2022-09-19', '2022-09-29'),
(7, 'Line 7', '2022-09-19', '2022-09-29'),
(8, 'Line 8', '2022-09-19', '2022-09-29'),
(9, 'Line 9', '2022-09-19', '2022-09-29'),
(10, 'Line 10', '2022-09-19', '2022-09-29');

-- --------------------------------------------------------

--
-- Table structure for table `costume_line_fingure`
--

CREATE TABLE `costume_line_fingure` (
  `id` int NOT NULL,
  `costume_line_id` int DEFAULT NULL,
  `fingure_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `costume_line_fingure`
--

INSERT INTO `costume_line_fingure` (`id`, `costume_line_id`, `fingure_id`) VALUES
(1, 1, 3),
(2, 1, 1),
(3, 2, 2),
(4, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `custume_line_skin`
--

CREATE TABLE `custume_line_skin` (
  `id` int NOT NULL,
  `skin_id` int NOT NULL,
  `custume_line_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fingure`
--

CREATE TABLE `fingure` (
  `id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `Combo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `fingure`
--

INSERT INTO `fingure` (`id`, `name`, `Combo`) VALUES
(1, 'Yasua', 'Flash + Ctrl 6'),
(2, 'Kathur', 'Die + R'),
(3, 'Yone', ' Q + Q + W'),
(4, 'Teemo', 'Only R'),
(5, 'test', 'testcombo');

-- --------------------------------------------------------

--
-- Table structure for table `skin`
--

CREATE TABLE `skin` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `limited` tinyint(1) NOT NULL,
  `type_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `skin`
--

INSERT INTO `skin` (`id`, `name`, `price`, `limited`, `type_id`) VALUES
(1, 'Yasua ma kiem', 599, 0, 1),
(2, 'Yone ba vuong hv chien binh', 369, 0, 1),
(3, 'lux vu khi toi thuong', 999, 1, 3),
(4, 'Kathur than chet', 120, 0, 4),
(5, 'Teemo sieu nhan', 999, 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`id`, `name`, `color`) VALUES
(1, 'Huyen thoai', 'Red'),
(2, 'Su thi', 'Blue'),
(3, 'Toi thuong', 'Yellow'),
(4, 'Normal', 'Silver');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `costume_line`
--
ALTER TABLE `costume_line`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `costume_line_fingure`
--
ALTER TABLE `costume_line_fingure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `costume_line_id` (`costume_line_id`),
  ADD KEY `fingure_id` (`fingure_id`);

--
-- Indexes for table `custume_line_skin`
--
ALTER TABLE `custume_line_skin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `custume_line_skin_id_fk` (`skin_id`),
  ADD KEY `custume_line_id_fk` (`custume_line_id`);

--
-- Indexes for table `fingure`
--
ALTER TABLE `fingure`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skin`
--
ALTER TABLE `skin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `skin_type_id_fk` (`type_id`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `costume_line`
--
ALTER TABLE `costume_line`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `costume_line_fingure`
--
ALTER TABLE `costume_line_fingure`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `custume_line_skin`
--
ALTER TABLE `custume_line_skin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fingure`
--
ALTER TABLE `fingure`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `skin`
--
ALTER TABLE `skin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `costume_line_fingure`
--
ALTER TABLE `costume_line_fingure`
  ADD CONSTRAINT `costume_line_fingure_ibfk_1` FOREIGN KEY (`costume_line_id`) REFERENCES `costume_line` (`id`),
  ADD CONSTRAINT `costume_line_fingure_ibfk_2` FOREIGN KEY (`fingure_id`) REFERENCES `fingure` (`id`);

--
-- Constraints for table `custume_line_skin`
--
ALTER TABLE `custume_line_skin`
  ADD CONSTRAINT `custume_line_id_fk` FOREIGN KEY (`custume_line_id`) REFERENCES `costume_line` (`id`),
  ADD CONSTRAINT `custume_line_skin_id_fk` FOREIGN KEY (`skin_id`) REFERENCES `skin` (`id`);

--
-- Constraints for table `skin`
--
ALTER TABLE `skin`
  ADD CONSTRAINT `skin_type_id_fk` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
