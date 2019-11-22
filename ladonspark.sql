-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 07-06-2018 a las 13:24:39
-- Versión del servidor: 10.1.32-MariaDB
-- Versión de PHP: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Create user
--

CREATE USER 'ladonspark'@'localhost' IDENTIFIED BY 'ladonspark';
GRANT ALL PRIVILEGES ON * . * TO 'ladonspark'@'localhost';
--
-- Base de datos: `ladonspark`
--
CREATE DATABASE IF NOT EXISTS `ladonspark` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ladonspark`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `algorithm`
--

CREATE TABLE `algorithm` (
  `id_alg` int(11) NOT NULL,
  `name_alg` varchar(250) NOT NULL,
  `url_alg` varchar(250) NOT NULL,
  `class` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parameter`
--

CREATE TABLE `parameter` (
  `id_par` int(11) NOT NULL,
  `name_par` varchar(250) NOT NULL,
  `type_par` varchar(250) NOT NULL,
  `id_alg_par` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `algorithm`
--
ALTER TABLE `algorithm`
  ADD PRIMARY KEY (`id_alg`);

--
-- Indices de la tabla `parameter`
--
ALTER TABLE `parameter`
  ADD PRIMARY KEY (`id_par`),
  ADD KEY `id_alg_par` (`id_alg_par`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `algorithm`
--
ALTER TABLE `algorithm`
  MODIFY `id_alg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `parameter`
--
ALTER TABLE `parameter`
  MODIFY `id_par` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `parameter`
--
ALTER TABLE `parameter`
  ADD CONSTRAINT `parameter_ibfk_1` FOREIGN KEY (`id_alg_par`) REFERENCES `algorithm` (`id_alg`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
