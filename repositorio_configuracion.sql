-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-05-2025 a las 04:34:47
-- Versión del servidor: 8.0.38
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `repositorio_configuracion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items_configuracion`
--

CREATE TABLE `items_configuracion` (
  `id` int NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` enum('codigo','documento','diseno') NOT NULL,
  `estado` enum('activo','en_revision','obsoleto') DEFAULT 'activo',
  `version_actual` int DEFAULT NULL,
  `id_autor` int DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `referencias_cruzadas`
--

CREATE TABLE `referencias_cruzadas` (
  `id` int NOT NULL,
  `id_origen` int NOT NULL,
  `id_destino` int NOT NULL,
  `descripcion` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `rol` enum('desarrollador','lider','administrador') DEFAULT 'desarrollador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `versiones`
--

CREATE TABLE `versiones` (
  `id` int NOT NULL,
  `id_item` int DEFAULT NULL,
  `numero_version` int NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `comentario` text,
  `hash_git` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `items_configuracion`
--
ALTER TABLE `items_configuracion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `referencias_cruzadas`
--
ALTER TABLE `referencias_cruzadas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_origen` (`id_origen`),
  ADD KEY `id_destino` (`id_destino`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `versiones`
--
ALTER TABLE `versiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_item` (`id_item`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `items_configuracion`
--
ALTER TABLE `items_configuracion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `referencias_cruzadas`
--
ALTER TABLE `referencias_cruzadas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `versiones`
--
ALTER TABLE `versiones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `referencias_cruzadas`
--
ALTER TABLE `referencias_cruzadas`
  ADD CONSTRAINT `referencias_cruzadas_ibfk_1` FOREIGN KEY (`id_origen`) REFERENCES `items_configuracion` (`id`),
  ADD CONSTRAINT `referencias_cruzadas_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `items_configuracion` (`id`);

--
-- Filtros para la tabla `versiones`
--
ALTER TABLE `versiones`
  ADD CONSTRAINT `versiones_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `items_configuracion` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
