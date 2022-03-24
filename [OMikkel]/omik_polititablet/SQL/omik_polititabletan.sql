-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 15. 03 2021 kl. 14:54:22
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
-- Struktur-dump for tabellen `omik_polititabletan`
--

CREATE TABLE `omik_polititabletan` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `name` text NOT NULL,
  `phone` text NOT NULL,
  `profileLogo` text NOT NULL DEFAULT 'https://i.imgur.com/DGW6ZHZ.png',
  `rank` text NOT NULL,
  `extraRank` text NOT NULL,
  `badgeNumber` text NOT NULL,
  `password` text NOT NULL,
  `ranks` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ranks`)),
  `certs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`certs`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Data dump for tabellen `omik_polititabletan`
--
--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `omik_polititabletan`
--
ALTER TABLE `omik_polititabletan`
  ADD PRIMARY KEY (`id`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `omik_polititabletan`
--
ALTER TABLE `omik_polititabletan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
