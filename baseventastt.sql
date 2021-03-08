 -- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-03-2021 a las 15:01:01
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `baseventastt`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletecliente` (`ide` INT)  begin
delete from clientes where clieide=ide;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteproducto` (`ide` INT)  BEGIN
DELETE FROM productos WHERE prodide=ide;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteproveedor` (`ide` INT)  begin
delete from proveedores where provide=ide;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteusuario` (`ide` INT)  BEGIN
DELETE FROM acceso WHERE usuaide=ide;
DELETE FROM permisos WHERE usuaide=ide;
DELETE FROM usuarios WHERE usuaide=ide;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteventa` (`ide` INT)  begin
delete from ventas where ventide=ide;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertentrada` (IN `producto` INT, IN `cantidad` DOUBLE, `proveedor` INT)  BEGIN
INSERT into entrada (prodide, entrcantid, entrfecha, provide) VALUES (producto, cantidad, now(),proveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatepermiso` (`usua` INT, `sumo` INT, `valor` INT)  BEGIN
DECLARE total int;
SELECT COUNT(*) INTO total FROM permisos WHERE usuaide=usua AND sumoide=sumo;
IF total>0 THEN
UPDATE permisos SET permestado=valor WHERE usuaide=usua AND sumoide=sumo;
ELSE
INSERT INTO permisos (usuaide,sumoide,permestado) VALUES (usua, sumo, 1);
END IF;


END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `insertarticulo` (`prod` INT, `cantidad` INT, `cliente` INT) RETURNS VARCHAR(100) CHARSET utf8 BEGIN
declare response varchar(100);
declare precioprod double;
if prod=0 THEN
	set response = 'Debe indicar un producto';
else
		select prodprecio into precioprod from productos where prodide=prod;
		insert into ventas (menuide, ventprecio, factide, clieide, ventcantid, ventfecha)
		values (prod, precioprod, 0, cliente, cantidad, now());
		set response = '1';
end if;
	return response;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `insertcliente` (`nacion` CHAR(1), `cedula` INT, `razsoc` VARCHAR(100), `direcc` VARCHAR(255), `telefo` INT) RETURNS VARCHAR(100) CHARSET utf8 begin
declare total int;
declare repetido varchar(100);
select count(*) into total from clientes where clienacion=nacion and cliecedula=cedula;
if total>0 then
set repetido  = 'Cliente ya registrado';
else
insert into clientes (clienacion, cliecedula, clierazsoc, cliedirecc, clietelefo)
values (nacion, cedula, razsoc, direcc, telefo);
set repetido = '1';
end if;
return repetido;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `insertcliente2` (`nacion` CHAR(1), `cedula` INT, `razsoc` VARCHAR(100), `direcc` VARCHAR(255), `telefo` INT) RETURNS INT(11) begin
declare total int;
declare idecliente int;
declare ide int;
select count(*) into total from clientes where clienacion=nacion and cliecedula=cedula;
if total>0 then
select clieide into idecliente from clientes where clienacion=nacion and cliecedula=cedula;
set ide  = idecliente;
else
insert into clientes (clienacion, cliecedula, clierazsoc, cliedirecc, clietelefo)
values (nacion, cedula, razsoc, direcc, telefo);
set ide = LAST_INSERT_ID();
end if;
return ide;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `insertproducto` (`producto` VARCHAR(45), `medida` INT(11), `precio` DOUBLE, `stock` INT(11)) RETURNS VARCHAR(60) CHARSET utf8 BEGIN
DECLARE total int;
DECLARE repetido varchar(60);
SELECT COUNT(*) INTO total FROM productos WHERE proddescri=producto AND unmeide=medida;
IF total>0 THEN
SET repetido = 'Producto ya registrado con esa unidad de medida';
ELSE
INSERT INTO productos (proddescri, unmeide, prodprecio, prodstomin)
VALUES (producto, medida, precio, stock);
SET repetido = '1';
END IF;
RETURN repetido;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `insertproveedor` (`razon` VARCHAR(50), `rif` VARCHAR(15), `direccion` VARCHAR(255), `telefono` INT(11), `correo` VARCHAR(50)) RETURNS VARCHAR(100) CHARSET utf8 BEGIN
declare repetido varchar(100);
declare total int;
declare total2 int;
SELECT COUNT(*) into total from proveedores where provrazsoc=razon;
SELECT COUNT(*) into total2 from proveedores where provrif=rif;
if (total>0) then
set repetido = 'Nombre o razón social ya registrado';
elseif (total2>0) then
set repetido = 'RIF ya registrado';
else
insert into proveedores (provrazsoc,provrif,provdirecc,provtelefo,provcorreo)
values (razon, rif, direccion, telefono, correo);
set repetido = '1';
end if;
RETURN repetido;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `insertusuario` (`nombre` VARCHAR(45), `apelli` VARCHAR(45), `nacion` CHAR, `cedula` INT, `usuari` VARCHAR(45), `clave` VARCHAR(32)) RETURNS VARCHAR(45) CHARSET utf8 BEGIN
DECLARE total int;
DECLARE totalusu int;
DECLARE repetido VARCHAR(45);
SELECT COUNT(*) INTO total FROM usuario WHERE usuanacion=nacion AND usuacedula=cedula;
SELECT COUNT(*) INTO totalusu FROM acceso WHERE acceusuari=usuari;
IF total>0 THEN
SET repetido = 'C&eacute;dula de identidad ya registrada';
ELSEIF totalusu>0 THEN
SET repetido = 'Nombre de usuario ya registrado';
ELSE
INSERT INTO usuarios (usuanombre,usuaapelli,usuanacion,usuacedula)
VALUES (nombre, apelli, nacion, cedula);
INSERT INTO acceso (usuaide,acceusuari,acceclave,accesestado)
VALUES (last_insert_id(), usuari, clave, 1);
SET repetido = '1';
END IF;
RETURN repetido;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `stock` (`ide` INT) RETURNS DOUBLE BEGIN
declare entradas double;
declare salidas double;
/*declare salida2 double;*/
/*declare salidas double;*/
declare total double;
select sum(entrcantid) into entradas from entrada where prodide=ide;
select  sum(a.ventcantid) into salidas from ventas as a
where a.menuide=ide;
if salidas>0 then
	set total = entradas-salidas;
else
	set total = entradas;
end if;
return total;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalpagar` (`cliente` INT, `factura` INT) RETURNS DOUBLE BEGIN
declare suma double;
SELECT sum(ventprecio*ventcantid) into suma from ventas where clieide=cliente and factide=factura;
return suma;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updatecliente` (`nacion` CHAR(1), `cedula` INT, `razsoc` VARCHAR(100), `direcc` VARCHAR(255), `telefo` INT, `ide` INT) RETURNS VARCHAR(100) CHARSET utf8 begin
declare total int;
declare repetido varchar(100);
select count(*) into total from clientes where clienacion=nacion and cliecedula=cedula and clieide!=ide;
if total>0 then
set repetido = 'Cliente ya registrado';
else
update clientes set clienacion=nacion, cliecedula=cedula, clierazsoc=razsoc, cliedirecc=direcc, clietelefo=telefo
where clieide=ide;
set repetido = '1';
end if;
return repetido;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updateproducto` (`producto` VARCHAR(45), `medida` INT, `ide` INT, `precio` DOUBLE, `stock` INT(11)) RETURNS VARCHAR(60) CHARSET utf8 BEGIN
DECLARE total int;
DECLARE repetido varchar(60);
SELECT COUNT(*) INTO total FROM productos WHERE proddescri=producto  AND unmeide=medida AND prodide!=ide;
IF total>0 THEN
SET repetido = 'Producto ya registrado con esa unidad de medida';
ELSE
UPDATE productos SET proddescri=producto, unmeide=medida, prodprecio=precio, prodstomin=stock  WHERE prodide=ide;
SET repetido = '1';
END IF;
RETURN repetido;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updateproveedor` (`razon` VARCHAR(50), `rif` VARCHAR(15), `direccion` VARCHAR(255), `telefono` INT(11), `correo` VARCHAR(50), `ide` INT) RETURNS VARCHAR(100) CHARSET utf8 BEGIN
declare repetido varchar(100);
declare total int;
declare total2 int;
SELECT COUNT(*) into total from proveedores where provrazsoc=razon and provide!=ide;
SELECT COUNT(*) into total2 from proveedores where provrif=rif and provide!=ide;
if (total>0) then
set repetido = 'Nombre o razón social ya registrado';
elseif (total2>0) then
set repetido = 'RIF ya registrado';
else
update proveedores set provrazsoc=razon, provrif=rif, provdirecc=direccion, provtelefo=telefono, provcorreo=correo where provide=ide;
set repetido = '1';
end if;
RETURN repetido;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `updateusuario` (`nombre` VARCHAR(45), `apelli` VARCHAR(45), `nacion` CHAR, `cedula` INT, `usuari` VARCHAR(45), `clave` VARCHAR(32), `ide` INT) RETURNS VARCHAR(45) CHARSET utf8 BEGIN
DECLARE total int;
DECLARE totalusu int;
DECLARE repetido VARCHAR(45);
SELECT COUNT(*) INTO total FROM usuario WHERE usuanacion=nacion AND usuacedula=cedula AND usuaide!=ide;
SELECT COUNT(*) INTO totalusu FROM acceso WHERE acceusuari=usuari AND usuaide!=ide;
IF total>0 THEN
SET repetido = 'C&eacute;dula de identidad ya registrada';
ELSEIF totalusu>0 THEN
SET repetido = 'Nombre de usuario ya registrado';
ELSE
UPDATE usuarios SET usuanombre=nombre, usuaapelli=apelli, usuanacion=nacion,
usuacedula=cedula WHERE usuaide=ide;
UPDATE acceso SET acceusuari=usuari, acceclave=clave WHERE usuaide=ide;
SET repetido = '1';
END IF;
RETURN repetido;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acceso`
--

CREATE TABLE `acceso` (
  `acceide` int(11) NOT NULL,
  `usuaide` int(11) DEFAULT NULL,
  `acceusuari` varchar(45) DEFAULT NULL,
  `acceclave` varchar(32) DEFAULT NULL,
  `accesestado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `acceso`
--

INSERT INTO `acceso` (`acceide`, `usuaide`, `acceusuari`, `acceclave`, `accesestado`) VALUES
(2, 1, 'Tania', 'tania', 2),
(8, 1, 'admin', 'admin', 1),
(9, 2, 'administrador', 'administrador', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `clieide` int(11) NOT NULL,
  `clienacion` char(1) DEFAULT NULL,
  `cliecedula` int(11) DEFAULT NULL,
  `clierazsoc` varchar(100) DEFAULT NULL,
  `cliedirecc` varchar(255) DEFAULT NULL,
  `clietelefo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`clieide`, `clienacion`, `cliecedula`, `clierazsoc`, `cliedirecc`, `clietelefo`) VALUES
(1, 'V', 12345678, 'Cliente 1', 'Calle 2', 214748364),
(3, 'V', 17811174, 'Cliente 2', '', 0),
(4, 'V', 1233434, 'sdsdsdsd', 'aaaaaaaaaa', 232323),
(5, 'P', 70927563, 'Ninguna', 'jr.los ositos NÂ° 239', 323212),
(6, 'P', 70927561, 'juan soto', 'jr.los ositos NÂ° 232', 945231232),
(7, 'P', 80927561, 'pablo gomes', 'LT-04-ms A9', 94545323),
(8, 'P', 341245643, 'nnnnnnnnnnn', 'ninguna', 2147483647);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `empride` int(11) NOT NULL,
  `emprrazsoc` varchar(100) DEFAULT NULL,
  `emprrif` varchar(15) DEFAULT NULL,
  `emprlogo` varchar(255) DEFAULT NULL,
  `emprlema` varchar(70) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`empride`, `emprrazsoc`, `emprrif`, `emprlogo`, `emprlema`) VALUES
(1, 'TopiTop S.A.C', '20709275629', 'cabecera.png', 'Los mejores productos en un solo lugar...');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE `entrada` (
  `entride` int(11) NOT NULL,
  `prodide` int(11) DEFAULT NULL,
  `entrcantid` double DEFAULT NULL,
  `entrfecha` date DEFAULT NULL,
  `provide` int(11) DEFAULT NULL,
  `mapride` int(11) DEFAULT NULL,
  `entrcanmap` decimal(10,2) DEFAULT NULL COMMENT 'Cantidad de materia prima usada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `entrada`
--

INSERT INTO `entrada` (`entride`, `prodide`, `entrcantid`, `entrfecha`, `provide`, `mapride`, `entrcanmap`) VALUES
(1, 1, 20, '2021-01-13', NULL, NULL, NULL),
(10, 1, 2, '2021-01-14', 1, NULL, NULL),
(11, 4, 50, '2021-01-14', 1, NULL, NULL),
(12, 1, 23, '2021-01-14', 2, NULL, NULL),
(13, 1, 3, '2021-01-14', 1, NULL, NULL),
(14, 7, 20, '2021-01-14', 1, NULL, NULL),
(15, 1, 60, '2021-01-14', 1, NULL, NULL),
(16, 4, 60, '2021-01-14', 1, NULL, NULL),
(17, 5, 30, '2021-01-14', 1, NULL, NULL),
(18, 5, 30, '2021-01-14', 2, NULL, NULL),
(19, 6, 100, '2021-01-14', 2, NULL, NULL),
(20, 1, 90, '2021-01-14', 1, NULL, NULL),
(21, 1, 100, '2021-01-14', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `entradaproductos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `entradaproductos` (
`entrcantid` double
,`entrfecha` date
,`entride` int(11)
,`prodide` int(11)
,`proddescri` varchar(45)
,`unmedescri` varchar(45)
,`provrazsoc` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `factide` int(11) NOT NULL,
  `clieide` int(11) DEFAULT NULL,
  `facttotal` double DEFAULT NULL,
  `factsubtot` double DEFAULT NULL,
  `factiva` double DEFAULT NULL,
  `factfecha` date DEFAULT NULL,
  `usuaide` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`factide`, `clieide`, `facttotal`, `factsubtot`, `factiva`, `factfecha`, `usuaide`) VALUES
(1, 1, 4, 3, 3, '2020-07-23', 1),
(2, 3, 2, 343, 4, '2020-07-23', 1),
(3, 3, 33, 43, 3, '2020-07-23', 1),
(4, 1, 444, 43, 3, '2020-07-23', 1),
(5, 1, 4, 43, 3, '2020-07-23', 1),
(6, 3, 4, 3, 4, '2020-07-23', 1),
(7, 3, 140, 123.2, 16.8, '2020-07-23', 1),
(8, 1, 400, 352, 48, '2020-08-22', 1),
(9, 1, 3000, 2640, 360, '2020-08-22', 1),
(10, 1, 40, 35.2, 4.8, '2020-08-22', 1),
(11, 1, 20, 17.6, 2.4, '2020-08-22', 1),
(12, 1, 30, 26.4, 3.6, '2020-08-22', 1),
(13, 1, 60, 52.8, 7.2, '2020-11-27', 1),
(14, 1, 220, 193.6, 26.4, '2020-11-27', 1),
(15, 1, 320, 281.6, 38.4, '2020-11-27', 1),
(16, 3, 40, 35.2, 4.8, '2020-11-28', 1),
(17, 1, 440, 387.2, 52.8, '2020-11-28', 1),
(18, 3, 200, 176, 24, '2020-11-28', 2),
(19, 6, 10, 8.8, 1.2, '2020-11-28', 2),
(20, 4, 70, 61.6, 8.4, '2020-11-28', 1),
(21, 3, 310, 272.8, 37.2, '2020-11-29', 1),
(22, 8, 10, 8.8, 1.2, '2020-11-29', 1),
(23, 6, 20, 17.6, 2.4, '2020-11-29', 1),
(24, 3, 60, 52.8, 7.2, '2020-11-29', 1),
(25, 1, 10, 8.8, 1.2, '2020-11-29', 1),
(26, 3, 40, 35.2, 4.8, '2020-11-30', 1),
(27, 1, 20, 17.6, 2.4, '2020-12-21', 1),
(28, 1, 40, 35.2, 4.8, '2020-12-26', 1),
(29, 4, 200, 176, 24, '2020-12-26', 1),
(30, 3, 20, 17.6, 2.4, '2020-12-27', 1),
(31, 3, 60, 52.8, 7.2, '2020-10-13', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `listasubmodulos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `listasubmodulos` (
`sumoide` int(11)
,`sumodescri` varchar(45)
,`modudescri` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `moduide` int(11) NOT NULL,
  `modudescri` varchar(45) DEFAULT NULL,
  `moduvisibl` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`moduide`, `modudescri`, `moduvisibl`) VALUES
(1, 'Usuarios', 1),
(2, 'Personal', 0),
(3, 'Cargos', 0),
(4, 'Men&uacute;', 0),
(5, 'Productos', 1),
(6, 'Ventas', 1),
(7, 'Clientes', 1),
(8, 'Proveedores', 1),
(9, 'Empresa', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `opcionesmenu`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `opcionesmenu` (
`modudescri` varchar(45)
,`sumoide` int(11)
,`sumodescri` varchar(45)
,`sumourl` varchar(100)
,`sumoicono` varchar(45)
,`usuaide` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `permide` int(11) NOT NULL,
  `usuaide` int(11) DEFAULT NULL,
  `sumoide` int(11) DEFAULT NULL,
  `permestado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`permide`, `usuaide`, `sumoide`, `permestado`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 0),
(3, 1, 3, 0),
(4, 1, 4, 0),
(5, 1, 5, 1),
(6, 1, 6, 1),
(7, 1, 7, 1),
(8, 1, 8, 1),
(9, 1, 10, 1),
(10, 2, 5, 1),
(11, 2, 6, 1),
(12, 2, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `prodide` int(11) NOT NULL,
  `proddescri` varchar(45) DEFAULT NULL,
  `unmeide` int(45) DEFAULT NULL,
  `prodprecio` double DEFAULT NULL,
  `prodstomin` int(11) NOT NULL,
  `fecha_reg` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`prodide`, `proddescri`, `unmeide`, `prodprecio`, `prodstomin`, `fecha_reg`) VALUES
(1, 'Abrigo', 3, 20, 55, '2021-01-10'),
(4, 'Pantalones', 3, 10, 60, '2021-01-10'),
(5, 'Camisas', 3, 5, 20, '2021-01-10'),
(6, 'Poleras', 3, 20, 56, '2021-01-10'),
(7, 'jeans', 3, 40, 10, '2021-01-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `provide` int(11) NOT NULL,
  `provrazsoc` varchar(50) DEFAULT NULL,
  `provrif` varchar(15) DEFAULT NULL,
  `provdirecc` varchar(255) DEFAULT NULL,
  `provtelefo` int(11) DEFAULT NULL,
  `provcorreo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`provide`, `provrazsoc`, `provrif`, `provdirecc`, `provtelefo`, `provcorreo`) VALUES
(1, 'ADIDAS', '2045231002', 'asasas', 232323, 'aas@as.pe'),
(2, 'deitemar', '2045231001', 'barrancas', 1234567, 'sdsd@sd.com'),
(3, 'HYU NAN', '2045231009', 'ningunaXD', 56023545, 'nuynan@chiioo.pe'),
(4, 'ADIDAS1', '204523100', 'dadasdasd', 2147483647, 'aas@ass.pe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `submodulos`
--

CREATE TABLE `submodulos` (
  `sumoide` int(11) NOT NULL,
  `moduide` int(11) DEFAULT NULL,
  `sumodescri` varchar(45) DEFAULT NULL,
  `sumourl` varchar(100) DEFAULT NULL,
  `sumoicono` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `submodulos`
--

INSERT INTO `submodulos` (`sumoide`, `moduide`, `sumodescri`, `sumourl`, `sumoicono`) VALUES
(1, 1, 'Usuarios', 'usuarios/vst/admin', 'users'),
(2, 2, 'Personal', 'personal/vst/admin', 'users'),
(3, 3, 'Cargos', 'cargos/vst/admin', 'bars'),
(4, 4, 'Men&uacute;', 'menu/vst/admin', 'coffee'),
(5, 5, 'Productos', 'productos/vst/admin', 'cube'),
(6, 6, 'Ventas', 'ventas/vst/admin', 'shopping-cart'),
(7, 7, 'Clientes', 'clientes/vst/admin', 'bars'),
(8, 8, 'Proveedores', 'proveedores/vst/admin', 'cube'),
(10, 9, 'Empresa', 'empresa/vst/admin', 'industry');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidamedid`
--

CREATE TABLE `unidamedid` (
  `unmeide` int(11) NOT NULL,
  `unmedescri` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `unidamedid`
--

INSERT INTO `unidamedid` (`unmeide`, `unmedescri`) VALUES
(3, 'Unidad(es)');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `usuario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `usuario` (
`usuaide` int(11)
,`usuanombre` varchar(45)
,`usuaapelli` varchar(45)
,`usuanacion` char(1)
,`usuacedula` int(11)
,`acceusuari` varchar(45)
,`acceclave` varchar(32)
,`accesestado` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuaide` int(11) NOT NULL,
  `usuanombre` varchar(45) DEFAULT NULL,
  `usuaapelli` varchar(45) DEFAULT NULL,
  `usuanacion` char(1) DEFAULT NULL,
  `usuacedula` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuaide`, `usuanombre`, `usuaapelli`, `usuanacion`, `usuacedula`) VALUES
(1, 'Tania', 'Ticona Encinas', 'P', 74452312),
(2, 'Administrador', 'Administrador', 'P', 70927562);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `ventide` int(11) NOT NULL,
  `menuide` int(11) DEFAULT NULL COMMENT 'prodide',
  `proddescri` varchar(45) DEFAULT NULL,
  `ventprecio` double DEFAULT NULL,
  `factide` int(11) DEFAULT NULL,
  `clieide` int(11) DEFAULT NULL,
  `ventcantid` int(11) DEFAULT NULL,
  `ventfecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`ventide`, `menuide`, `proddescri`, `ventprecio`, `factide`, `clieide`, `ventcantid`, `ventfecha`) VALUES
(2, 5, 'Camisas', 5, 7, 3, 20, '2021-01-14'),
(3, 1, 'Abrigo', 20, 7, 3, 2, '2021-01-14'),
(11, 1, 'Abrigo', 20, 8, 1, 20, '2021-01-14'),
(12, 1, 'Abrigo', 20, 9, 1, 150, '2021-01-14'),
(13, 1, 'Abrigo', 20, 10, 1, 2, '2021-01-14'),
(14, 1, 'Abrigo', 20, 11, 1, 1, '2021-01-14'),
(15, 1, 'Abrigo', 20, 12, 1, 1, '2021-01-14'),
(16, 5, 'Camisas', 5, 12, 1, 2, '2021-01-14'),
(17, 1, 'Abrigo', 20, 13, 1, 3, '2021-01-14'),
(18, 4, 'Pantalones', 10, 14, 1, 22, '2021-01-14'),
(19, 1, 'Abrigo', 20, 15, 1, 4, '2021-01-14'),
(20, 1, 'Abrigo', 20, 15, 1, 6, '2021-01-14'),
(21, 1, 'Abrigo', 20, 15, 1, 6, '2021-01-14'),
(22, 4, 'Pantalones', 10, 20, 4, 2, '2021-01-14'),
(24, 4, 'Pantalones', 10, 16, 3, 4, '2021-01-14'),
(25, 6, 'Poleras', 20, 17, 1, 2, '2021-01-14'),
(26, 6, 'Poleras', 20, 17, 1, 20, '2021-01-14'),
(27, 6, 'Poleras', 20, 18, 3, 10, '2021-01-14'),
(28, 1, 'Abrigo', 20, 21, 3, 2, '2021-01-14'),
(29, 4, 'Pantalones', 10, 20, 4, 3, '2021-01-14'),
(30, 4, 'Pantalones', 10, 19, 6, 1, '2021-01-14'),
(31, 4, 'Pantalones', 10, 20, 4, 2, '2021-01-14'),
(32, 5, 'Camisas', 5, 21, 3, 6, '2021-01-14'),
(33, 7, 'Jeans', 40, 21, 3, 6, '2021-01-14'),
(34, 5, 'Camisas', 5, 22, 8, 2, '2021-01-14'),
(35, 4, 'Pantalones', 10, 23, 6, 2, '2015-11-29'),
(36, 1, 'Abrigo', 20, 24, 3, 3, '2015-11-29'),
(37, 5, 'Camisas', 5, 25, 1, 2, '2015-11-29'),
(38, 4, 'Pantalones', 10, 26, 3, 4, '2015-11-30'),
(39, 1, 'Abrigo', 20, 27, 1, 1, '2015-12-21'),
(40, 1, 'Abrigo', 20, 28, 1, 2, '2015-12-21'),
(41, 7, 'Jeans', 40, 29, 4, 5, '2015-12-26'),
(45, 6, NULL, 20, 30, 3, 1, '2015-12-27'),
(46, 1, NULL, 20, 31, 3, 2, '2020-10-13'),
(48, 4, NULL, 10, 31, 3, 2, '2020-10-13'),
(49, 4, NULL, 10, 0, 1, 12, '2020-10-14'),
(50, 1, NULL, 20, 0, 6, 1, '2020-10-14');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_productos` (
`prodide` int(11)
,`proddescri` varchar(45)
,`prodprecio` double
,`unmeide` int(45)
,`prodstomin` int(11)
,`unmedescri` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_ventas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_ventas` (
`ventide` int(11)
,`ventprecio` double
,`clieide` int(11)
,`factide` int(11)
,`ventcantid` int(11)
,`ventfecha` date
,`menuide` int(11)
,`proddescri` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `entradaproductos`
--
DROP TABLE IF EXISTS `entradaproductos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entradaproductos`  AS  select `a`.`entrcantid` AS `entrcantid`,`a`.`entrfecha` AS `entrfecha`,`a`.`entride` AS `entride`,`a`.`prodide` AS `prodide`,`b`.`proddescri` AS `proddescri`,`c`.`unmedescri` AS `unmedescri`,`d`.`provrazsoc` AS `provrazsoc` from (((`entrada` `a` join `productos` `b` on(`a`.`prodide` = `b`.`prodide`)) join `unidamedid` `c` on(`b`.`unmeide` = `c`.`unmeide`)) join `proveedores` `d` on(`a`.`provide` = `d`.`provide`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `listasubmodulos`
--
DROP TABLE IF EXISTS `listasubmodulos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listasubmodulos`  AS  select `a`.`sumoide` AS `sumoide`,`a`.`sumodescri` AS `sumodescri`,`b`.`modudescri` AS `modudescri` from (`submodulos` `a` join `modulos` `b` on(`a`.`moduide` = `b`.`moduide`)) where `b`.`moduvisibl` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `opcionesmenu`
--
DROP TABLE IF EXISTS `opcionesmenu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `opcionesmenu`  AS  select `c`.`modudescri` AS `modudescri`,`b`.`sumoide` AS `sumoide`,`b`.`sumodescri` AS `sumodescri`,`b`.`sumourl` AS `sumourl`,`b`.`sumoicono` AS `sumoicono`,`a`.`usuaide` AS `usuaide` from ((`permisos` `a` join `submodulos` `b` on(`a`.`sumoide` = `b`.`sumoide`)) join `modulos` `c` on(`b`.`moduide` = `c`.`moduide`)) where `a`.`permestado` = 1 and `c`.`moduvisibl` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `usuario`
--
DROP TABLE IF EXISTS `usuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usuario`  AS  select `a`.`usuaide` AS `usuaide`,`a`.`usuanombre` AS `usuanombre`,`a`.`usuaapelli` AS `usuaapelli`,`a`.`usuanacion` AS `usuanacion`,`a`.`usuacedula` AS `usuacedula`,`b`.`acceusuari` AS `acceusuari`,`b`.`acceclave` AS `acceclave`,`b`.`accesestado` AS `accesestado` from (`usuarios` `a` join `acceso` `b` on(`a`.`usuaide` = `b`.`usuaide`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_productos`
--
DROP TABLE IF EXISTS `vw_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_productos`  AS  select `a`.`prodide` AS `prodide`,`a`.`proddescri` AS `proddescri`,`a`.`prodprecio` AS `prodprecio`,`a`.`unmeide` AS `unmeide`,`a`.`prodstomin` AS `prodstomin`,`b`.`unmedescri` AS `unmedescri` from (`productos` `a` join `unidamedid` `b` on(`a`.`unmeide` = `b`.`unmeide`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_ventas`
--
DROP TABLE IF EXISTS `vw_ventas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_ventas`  AS  select `a`.`ventide` AS `ventide`,`a`.`ventprecio` AS `ventprecio`,`a`.`clieide` AS `clieide`,`a`.`factide` AS `factide`,`a`.`ventcantid` AS `ventcantid`,`a`.`ventfecha` AS `ventfecha`,`a`.`menuide` AS `menuide`,`b`.`proddescri` AS `proddescri` from (`ventas` `a` join `productos` `b` on(`a`.`menuide` = `b`.`prodide`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD PRIMARY KEY (`acceide`),
  ADD UNIQUE KEY `acceusuari_UNIQUE` (`acceusuari`) USING BTREE,
  ADD KEY `usuaide` (`usuaide`) USING BTREE;

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`clieide`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`empride`);

--
-- Indices de la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD PRIMARY KEY (`entride`),
  ADD KEY `prodide` (`prodide`) USING BTREE,
  ADD KEY `provide` (`provide`) USING BTREE,
  ADD KEY `mapride` (`mapride`) USING BTREE;

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`factide`),
  ADD KEY `clieide` (`clieide`) USING BTREE,
  ADD KEY `usuaide` (`usuaide`) USING BTREE;

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`moduide`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`permide`),
  ADD KEY `usuaide` (`usuaide`) USING BTREE,
  ADD KEY `sumoide` (`sumoide`) USING BTREE;

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`prodide`),
  ADD KEY `unmeide` (`unmeide`) USING BTREE;

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`provide`);

--
-- Indices de la tabla `submodulos`
--
ALTER TABLE `submodulos`
  ADD PRIMARY KEY (`sumoide`),
  ADD KEY `moduide` (`moduide`) USING BTREE;

--
-- Indices de la tabla `unidamedid`
--
ALTER TABLE `unidamedid`
  ADD PRIMARY KEY (`unmeide`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuaide`),
  ADD UNIQUE KEY `usuacedula_UNIQUE` (`usuacedula`) USING BTREE;

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`ventide`),
  ADD KEY `menuide` (`menuide`) USING BTREE,
  ADD KEY `factide` (`factide`) USING BTREE,
  ADD KEY `clieide` (`clieide`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acceso`
--
ALTER TABLE `acceso`
  MODIFY `acceide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `clieide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `empride` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `entrada`
--
ALTER TABLE `entrada`
  MODIFY `entride` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `factide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `moduide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `permide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `prodide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `provide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `submodulos`
--
ALTER TABLE `submodulos`
  MODIFY `sumoide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `unidamedid`
--
ALTER TABLE `unidamedid`
  MODIFY `unmeide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuaide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `ventide` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD CONSTRAINT `acceso_ibfk_1` FOREIGN KEY (`usuaide`) REFERENCES `usuarios` (`usuaide`);

--
-- Filtros para la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `entrada_ibfk_1` FOREIGN KEY (`prodide`) REFERENCES `productos` (`prodide`),
  ADD CONSTRAINT `entrada_ibfk_2` FOREIGN KEY (`provide`) REFERENCES `proveedores` (`provide`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`clieide`) REFERENCES `clientes` (`clieide`),
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`usuaide`) REFERENCES `usuarios` (`usuaide`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`usuaide`) REFERENCES `usuarios` (`usuaide`),
  ADD CONSTRAINT `permisos_ibfk_2` FOREIGN KEY (`sumoide`) REFERENCES `submodulos` (`sumoide`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`unmeide`) REFERENCES `unidamedid` (`unmeide`);

--
-- Filtros para la tabla `submodulos`
--
ALTER TABLE `submodulos`
  ADD CONSTRAINT `submodulos_ibfk_1` FOREIGN KEY (`moduide`) REFERENCES `modulos` (`moduide`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`menuide`) REFERENCES `productos` (`prodide`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`clieide`) REFERENCES `clientes` (`clieide`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
