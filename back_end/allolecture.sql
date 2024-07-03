-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 03 juil. 2024 à 16:42
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `allolecture`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

CREATE TABLE `articles` (
  `id_art` int(11) NOT NULL,
  `nom_art` varchar(50) NOT NULL,
  `createur_art` varchar(50) NOT NULL,
  `duree` varchar(50) NOT NULL,
  `date_crea` date NOT NULL,
  `id_cat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`id_art`, `nom_art`, `createur_art`, `duree`, `date_crea`, `id_cat`) VALUES
(2, 'Inception', 'Christopher Nolan', '2h23', '2013-07-15', 1),
(4, 'Interstellar', 'Christopher Nolan', '2h54', '0000-00-00', 1),
(10, 'Art1', 'Createur1', '10:30', '2024-01-01', 1),
(11, 'Art2', 'Createur2', '12:45', '2024-01-03', 2),
(12, 'Art3', 'Createur3', '15:20', '2024-01-05', 3),
(13, 'Art4', 'Createur4', '07:50', '2024-01-07', 4),
(14, 'Art5', 'Createur5', '09:00', '2024-01-09', 5),
(15, 'Art6', 'Createur1', '11:15', '2024-01-11', 1),
(16, 'Art7', 'Createur2', '13:35', '2024-01-13', 2),
(17, 'Art8', 'Createur3', '14:40', '2024-01-15', 3),
(18, 'Art9', 'Createur4', '08:55', '2024-01-17', 4),
(19, 'Art10', 'Createur5', '10:25', '2024-01-19', 5);

-- --------------------------------------------------------

--
-- Structure de la table `catégories`
--

CREATE TABLE `catégories` (
  `id_cat` int(11) NOT NULL,
  `nom_cat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `catégories`
--

INSERT INTO `catégories` (`id_cat`, `nom_cat`) VALUES
(1, 'Films'),
(2, 'Livres'),
(3, 'Mangas'),
(4, 'Séries'),
(5, 'Bandes dessinées');

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

CREATE TABLE `notes` (
  `id_note` int(11) NOT NULL,
  `note` int(11) NOT NULL,
  `id_art` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notes`
--

INSERT INTO `notes` (`id_note`, `note`, `id_art`) VALUES
(1, 5, 2),
(2, 3, 2),
(3, 4, 4),
(4, 2, 4),
(5, 5, 10),
(6, 1, 10),
(7, 3, 10),
(8, 4, 11),
(9, 2, 11),
(10, 5, 12),
(11, 1, 12),
(12, 4, 13),
(13, 2, 13),
(14, 5, 14),
(15, 3, 14),
(16, 4, 15),
(17, 2, 15),
(18, 5, 16),
(19, 1, 16),
(20, 3, 17),
(21, 4, 17),
(22, 2, 18),
(23, 5, 18),
(24, 1, 19),
(25, 3, 19);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id_art`),
  ADD KEY `id_cat` (`id_cat`);

--
-- Index pour la table `catégories`
--
ALTER TABLE `catégories`
  ADD PRIMARY KEY (`id_cat`);

--
-- Index pour la table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id_note`),
  ADD KEY `id_art` (`id_art`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `articles`
--
ALTER TABLE `articles`
  MODIFY `id_art` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `catégories`
--
ALTER TABLE `catégories`
  MODIFY `id_cat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `notes`
--
ALTER TABLE `notes`
  MODIFY `id_note` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `id_cat` FOREIGN KEY (`id_cat`) REFERENCES `catégories` (`id_cat`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `id_art` FOREIGN KEY (`id_art`) REFERENCES `articles` (`id_art`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
