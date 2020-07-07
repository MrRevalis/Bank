-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 07 Lip 2020, 17:52
-- Wersja serwera: 10.4.11-MariaDB
-- Wersja PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `bank`
--
CREATE DATABASE IF NOT EXISTS `bank` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bank`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `historialogowan`
--

DROP TABLE IF EXISTS `historialogowan`;
CREATE TABLE `historialogowan` (
  `idHistoriaLogowan` int(10) UNSIGNED NOT NULL,
  `WlascicielPesel` bigint(11) NOT NULL,
  `DataLogowania` date NOT NULL,
  `GodzinaLogowania` time NOT NULL,
  `AdresIP` varchar(15) NOT NULL,
  `CzyPoprawne` enum('Tak','Nie') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kartaoperacje`
--

DROP TABLE IF EXISTS `kartaoperacje`;
CREATE TABLE `kartaoperacje` (
  `idOperacji` int(10) UNSIGNED NOT NULL,
  `KartaPlatniczaNumerKarty` varchar(16) NOT NULL,
  `Typ` enum('wplata','wyplata') NOT NULL,
  `Wartosc` decimal(10,2) NOT NULL,
  `CzasOperacji` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kartaplatnicza`
--

DROP TABLE IF EXISTS `kartaplatnicza`;
CREATE TABLE `kartaplatnicza` (
  `NumerKarty` varchar(16) NOT NULL,
  `NumerKonta` varchar(26) NOT NULL,
  `DataWaznosci` date NOT NULL,
  `LimitPlatnosci` decimal(10,2) NOT NULL,
  `Pin` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `konto`
--

DROP TABLE IF EXISTS `konto`;
CREATE TABLE `konto` (
  `NumerKonta` varchar(26) NOT NULL,
  `WlascicielPesel` bigint(11) NOT NULL,
  `TypKonta` enum('Zwykle','Mlodziezowe','Kredytowe') NOT NULL,
  `Saldo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kredyt`
--

DROP TABLE IF EXISTS `kredyt`;
CREATE TABLE `kredyt` (
  `NumerKredytu` int(10) UNSIGNED NOT NULL,
  `WlascicielPesel` bigint(11) NOT NULL,
  `Wartosc` decimal(10,2) NOT NULL,
  `NumerKonta` varchar(26) NOT NULL,
  `DataSplaty` date NOT NULL,
  `Oprocentowanie` decimal(10,2) NOT NULL,
  `Rata` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przelew`
--

DROP TABLE IF EXISTS `przelew`;
CREATE TABLE `przelew` (
  `IDPrzelew` int(10) UNSIGNED NOT NULL,
  `NumerNadawcy` varchar(26) NOT NULL,
  `NumerOdbiorcy` varchar(26) NOT NULL,
  `Wartosc` decimal(10,2) NOT NULL,
  `CzasOperacji` datetime NOT NULL,
  `Tytul` varchar(20) NOT NULL,
  `Opis` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wlasciciel`
--

DROP TABLE IF EXISTS `wlasciciel`;
CREATE TABLE `wlasciciel` (
  `Pesel` bigint(11) NOT NULL,
  `Imie` varchar(20) NOT NULL,
  `Nazwisko` varchar(20) NOT NULL,
  `DataUrodzenia` date NOT NULL,
  `Miasto` varchar(30) NOT NULL,
  `Adres` varchar(30) NOT NULL,
  `Telefon` int(10) UNSIGNED NOT NULL,
  `Login` varchar(20) NOT NULL,
  `Haslo` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `historialogowan`
--
ALTER TABLE `historialogowan`
  ADD PRIMARY KEY (`idHistoriaLogowan`),
  ADD KEY `HistoriaLogowan_FKIndex1` (`WlascicielPesel`);

--
-- Indeksy dla tabeli `kartaoperacje`
--
ALTER TABLE `kartaoperacje`
  ADD PRIMARY KEY (`idOperacji`),
  ADD KEY `KartaOperacje_FKIndex1` (`KartaPlatniczaNumerKarty`);

--
-- Indeksy dla tabeli `kartaplatnicza`
--
ALTER TABLE `kartaplatnicza`
  ADD PRIMARY KEY (`NumerKarty`),
  ADD KEY `KartaPlatnicza_FKIndex1` (`NumerKonta`);

--
-- Indeksy dla tabeli `konto`
--
ALTER TABLE `konto`
  ADD PRIMARY KEY (`NumerKonta`),
  ADD KEY `konto_ibfk_1` (`WlascicielPesel`);

--
-- Indeksy dla tabeli `kredyt`
--
ALTER TABLE `kredyt`
  ADD PRIMARY KEY (`NumerKredytu`),
  ADD KEY `Kredyt_FKIndex1` (`WlascicielPesel`);

--
-- Indeksy dla tabeli `przelew`
--
ALTER TABLE `przelew`
  ADD PRIMARY KEY (`IDPrzelew`),
  ADD KEY `FK_Transfer_NrOdbiorcy` (`NumerOdbiorcy`),
  ADD KEY `FK_Transfer_NrNadawcy` (`NumerNadawcy`);

--
-- Indeksy dla tabeli `wlasciciel`
--
ALTER TABLE `wlasciciel`
  ADD PRIMARY KEY (`Pesel`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `historialogowan`
--
ALTER TABLE `historialogowan`
  MODIFY `idHistoriaLogowan` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `kartaoperacje`
--
ALTER TABLE `kartaoperacje`
  MODIFY `idOperacji` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `kredyt`
--
ALTER TABLE `kredyt`
  MODIFY `NumerKredytu` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `przelew`
--
ALTER TABLE `przelew`
  MODIFY `IDPrzelew` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `historialogowan`
--
ALTER TABLE `historialogowan`
  ADD CONSTRAINT `historialogowan_ibfk_1` FOREIGN KEY (`WlascicielPesel`) REFERENCES `wlasciciel` (`Pesel`) ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `kartaoperacje`
--
ALTER TABLE `kartaoperacje`
  ADD CONSTRAINT `kartaoperacje_ibfk_1` FOREIGN KEY (`KartaPlatniczaNumerKarty`) REFERENCES `kartaplatnicza` (`NumerKarty`) ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `kartaplatnicza`
--
ALTER TABLE `kartaplatnicza`
  ADD CONSTRAINT `kartaplatnicza_ibfk_1` FOREIGN KEY (`NumerKonta`) REFERENCES `konto` (`NumerKonta`) ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `konto`
--
ALTER TABLE `konto`
  ADD CONSTRAINT `konto_ibfk_1` FOREIGN KEY (`WlascicielPesel`) REFERENCES `wlasciciel` (`Pesel`) ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `kredyt`
--
ALTER TABLE `kredyt`
  ADD CONSTRAINT `kredyt_ibfk_1` FOREIGN KEY (`WlascicielPesel`) REFERENCES `wlasciciel` (`Pesel`) ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `przelew`
--
ALTER TABLE `przelew`
  ADD CONSTRAINT `FK_Transfer_NrNadawcy` FOREIGN KEY (`NumerNadawcy`) REFERENCES `konto` (`NumerKonta`),
  ADD CONSTRAINT `FK_Transfer_NrOdbiorcy` FOREIGN KEY (`NumerOdbiorcy`) REFERENCES `konto` (`NumerKonta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
