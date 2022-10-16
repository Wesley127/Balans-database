-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 16 okt 2022 om 10:58
-- Serverversie: 10.4.22-MariaDB
-- PHP-versie: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `balans`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `activiteit`
--

CREATE TABLE `activiteit` (
  `id` int(11) NOT NULL,
  `duur` int(11) NOT NULL,
  `beschrijving` text NOT NULL,
  `categorie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `agenda`
--

CREATE TABLE `agenda` (
  `id` int(11) NOT NULL,
  `begin_tijd` time NOT NULL,
  `eind_tijd` time NOT NULL,
  `datum` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) NOT NULL,
  `activiteit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `naam` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `notitie_client`
--

CREATE TABLE `notitie_client` (
  `id` int(11) NOT NULL,
  `user_id` int(1) NOT NULL,
  `notitie` text NOT NULL,
  `datum` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `notitie_therapeut`
--

CREATE TABLE `notitie_therapeut` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `therapeut_id` int(11) NOT NULL,
  `notitie` text NOT NULL,
  `datum` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `uitnodiging`
--

CREATE TABLE `uitnodiging` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `therapeut_id` int(11) NOT NULL,
  `status` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `wachtwoord` varchar(266) NOT NULL,
  `voornaam` varchar(40) NOT NULL,
  `tussenvoegsel` varchar(40) NOT NULL,
  `achternaam` varchar(40) NOT NULL,
  `user_role` varchar(20) NOT NULL,
  `max_punten` int(11) NOT NULL,
  `dag_starttijd` time NOT NULL,
  `dag_eindtijd` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `wachtwoord_vergeten`
--

CREATE TABLE `wachtwoord_vergeten` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `activiteit`
--
ALTER TABLE `activiteit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Relatie met categorie tabel` (`categorie_id`);

--
-- Indexen voor tabel `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Relatie met user tabel` (`user_id`),
  ADD KEY `Relatie met activiteit tabel` (`activiteit_id`);

--
-- Indexen voor tabel `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `notitie_client`
--
ALTER TABLE `notitie_client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Een relatie met user tabel` (`user_id`);

--
-- Indexen voor tabel `notitie_therapeut`
--
ALTER TABLE `notitie_therapeut`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Een relatie met user tabel.` (`client_id`),
  ADD KEY `Een relatie met de user tabel.` (`therapeut_id`);

--
-- Indexen voor tabel `uitnodiging`
--
ALTER TABLE `uitnodiging`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Relatie met de user tabel.` (`client_id`),
  ADD KEY `Relatie met user tabel.` (`therapeut_id`);

--
-- Indexen voor tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `wachtwoord_vergeten`
--
ALTER TABLE `wachtwoord_vergeten`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Relatie met de user tabel` (`user_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `activiteit`
--
ALTER TABLE `activiteit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `notitie_client`
--
ALTER TABLE `notitie_client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `notitie_therapeut`
--
ALTER TABLE `notitie_therapeut`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `uitnodiging`
--
ALTER TABLE `uitnodiging`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `wachtwoord_vergeten`
--
ALTER TABLE `wachtwoord_vergeten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `activiteit`
--
ALTER TABLE `activiteit`
  ADD CONSTRAINT `Relatie met categorie tabel` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `Relatie met activiteit tabel` FOREIGN KEY (`activiteit_id`) REFERENCES `activiteit` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Relatie met user tabel` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `notitie_client`
--
ALTER TABLE `notitie_client`
  ADD CONSTRAINT `Een relatie met user tabel` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `notitie_therapeut`
--
ALTER TABLE `notitie_therapeut`
  ADD CONSTRAINT `Een relatie met de user tabel.` FOREIGN KEY (`therapeut_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Een relatie met user tabel.` FOREIGN KEY (`client_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `uitnodiging`
--
ALTER TABLE `uitnodiging`
  ADD CONSTRAINT `Relatie met de user tabel.` FOREIGN KEY (`client_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Relatie met user tabel.` FOREIGN KEY (`therapeut_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `wachtwoord_vergeten`
--
ALTER TABLE `wachtwoord_vergeten`
  ADD CONSTRAINT `Relatie met de user tabel` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
