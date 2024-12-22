-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-12-2024 a las 05:59:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lindavista`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ln_diccionario`
--

CREATE TABLE `ln_diccionario` (
  `id` int(11) NOT NULL,
  `palabra` varchar(50) NOT NULL,
  `categoria` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ln_diccionario`
--

INSERT INTO `ln_diccionario` (`id`, `palabra`, `categoria`) VALUES
(1, 'casa', 'tipo'),
(2, 'piso', 'tipo'),
(3, 'chalet', 'tipo'),
(4, 'Centro', 'zona'),
(5, 'Nervión', 'zona'),
(6, 'Triana', 'zona'),
(7, 'barato', 'atributo'),
(8, 'grande', 'atributo'),
(9, 'garaje', 'atributo'),
(10, 'o', 'zona_o'),
(12, 'metros', 'metros_mas'),
(13, 'barato', 'atributo'),
(14, 'garaje', 'garaje'),
(15, 'metros', 'metros_mas'),
(16, 'cuadrados', 'metros_mas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ln_patrones`
--

CREATE TABLE `ln_patrones` (
  `id` int(11) NOT NULL,
  `patron` varchar(255) NOT NULL,
  `consultasql` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ln_patrones`
--

INSERT INTO `ln_patrones` (`id`, `patron`, `consultasql`) VALUES
(1, 'busco tipo', 'SELECT * FROM viviendas WHERE tipo = \'%1\''),
(2, 'busco zona', 'SELECT * FROM viviendas WHERE zona = \'%1\''),
(3, 'busco tipo zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND zona = \'%2\''),
(4, 'busco tipo numero dormitorios zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND ndormitorios=\'%2\' AND zona = \'%3\''),
(5, 'tipo', 'SELECT * FROM viviendas WHERE tipo = \'%1\''),
(6, 'tipo zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND zona = \'%2\''),
(7, 'tipo atributo', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND precio < 100000'),
(8, 'tipo numero dormitorios zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND ndormitorios = \'%2\' AND zona = \'%3\''),
(9, 'tipo zona_o', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND (zona = \'%2\' OR zona = \'%3\')'),
(10, 'tipo dormitorios_mas zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND ndormitorios > %2 AND zona = \'%3\''),
(12, 'tipo atributo', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND precio < 100000'),
(13, 'tipo zona garaje', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND zona = \'%2\' AND garaje = 1'),
(14, 'tipo zona zona_o zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND (zona = \'%2\' OR zona = \'%3\')'),
(15, 'tipo dormitorios_mas zona', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND ndormitorios > %2 AND zona = \'%3\''),
(16, 'tipo metros_mas', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND metros_cuadrados > %2'),
(17, 'tipo metros_mas', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND metros_cuadrados > %2'),
(18, 'tipo numero metros_mas', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND metros_cuadrados > %2'),
(19, 'tipo zona zona_o', 'SELECT * FROM viviendas WHERE tipo = \'%1\' AND (zona = \'%2\' OR zona = \'%3\')');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viviendas`
--

CREATE TABLE `viviendas` (
  `id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `zona` varchar(50) NOT NULL,
  `ndormitorios` int(11) NOT NULL,
  `metros_cuadrados` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `garaje` tinyint(1) NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `viviendas`
--

INSERT INTO `viviendas` (`id`, `tipo`, `zona`, `ndormitorios`, `metros_cuadrados`, `precio`, `garaje`, `foto`) VALUES
(1, 'Casa', 'Centro', 4, 120, 150000.00, 1, 'fotos/casa1.jpg'),
(2, 'Piso', 'Nervión', 3, 90, 100000.00, 0, 'fotos/piso1.jpg'),
(3, 'Chalet', 'Aljarafe', 5, 200, 300000.00, 1, 'fotos/chalet1.jpg'),
(4, 'Casa', 'Centro', 3, 110, 130000.00, 1, 'fotos/casa2.jpg'),
(5, 'Piso', 'Triana', 2, 80, 85000.00, 0, 'fotos/piso2.jpg'),
(6, 'Piso', 'Centro', 3, 90, 95000.00, 0, 'fotos/piso3.jpg'),
(7, 'Piso', 'Nervión', 4, 125, 150000.00, 1, 'fotos/piso4.jpg'),
(8, 'Casa', 'Triana', 5, 200, 250000.00, 1, 'fotos/casa3.jpg'),
(9, 'Casa', 'Centro', 4, 180, 220000.00, 0, 'fotos/casa4.jpg'),
(10, 'Piso', 'Centro', 5, 80, 85000.00, 0, 'fotos/piso5.jpg'),
(11, 'Chalet', 'Nervión', 6, 300, 400000.00, 1, 'fotos/chalet2.jpg'),
(12, 'Chalet', 'Nervión', 3, 120, 120000.00, 1, 'fotos/chalet3.jpg'),
(13, 'Piso', 'Triana', 2, 75, 95000.00, 0, 'fotos/piso6.jpg'),
(14, 'Piso', 'Centro', 4, 130, 175000.00, 1, 'fotos/piso7.jpg'),
(15, 'Casa', 'Centro', 5, 210, 300000.00, 1, 'fotos/casa5.jpg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ln_diccionario`
--
ALTER TABLE `ln_diccionario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ln_patrones`
--
ALTER TABLE `ln_patrones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `viviendas`
--
ALTER TABLE `viviendas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ln_diccionario`
--
ALTER TABLE `ln_diccionario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `ln_patrones`
--
ALTER TABLE `ln_patrones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `viviendas`
--
ALTER TABLE `viviendas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
