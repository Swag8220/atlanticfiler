-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 15. 03 2021 kl. 14:55:43
-- Serverversion: 10.4.17-MariaDB
-- PHP-version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `omik_polititabletbo`
--

CREATE TABLE `omik_polititabletbo` (
  `id` int(11) NOT NULL,
  `law` text NOT NULL,
  `para` text NOT NULL,
  `offense` text NOT NULL,
  `price` int(11) NOT NULL,
  `clip` int(11) NOT NULL,
  `jail` int(11) DEFAULT 0,
  `disq` text NOT NULL,
  `info` text NOT NULL,
  `amount` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Data dump for tabellen `omik_polititabletbo`
--
--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `omik_polititabletbo`
--
ALTER TABLE `omik_polititabletbo`
  ADD PRIMARY KEY (`id`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `omik_polititabletbo`
--
ALTER TABLE `omik_polititabletbo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
