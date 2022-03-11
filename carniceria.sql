/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : carniceria

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 11/03/2022 00:16:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categoria_producto
-- ----------------------------
DROP TABLE IF EXISTS `categoria_producto`;
CREATE TABLE `categoria_producto`  (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(70) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `descripcion` varchar(150) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `status` binary(1) NOT NULL,
  PRIMARY KEY (`idCategoria`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ciudad
-- ----------------------------
DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE `ciudad`  (
  `ciudad` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `idCiudad` int NOT NULL AUTO_INCREMENT,
  `idProvincia` int NULL DEFAULT NULL,
  PRIMARY KEY (`idCiudad`) USING BTREE,
  INDEX `provincia_provincia`(`idProvincia`) USING BTREE,
  CONSTRAINT `provincia_provincia` FOREIGN KEY (`idProvincia`) REFERENCES `provincia` (`idProvincia`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente`  (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `referencia` varchar(300) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `idCiudad` int NULL DEFAULT NULL,
  `telefono1` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `telefono2` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `correoElectronico` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `idPersona` int NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`) USING BTREE,
  INDEX `persona_persona`(`idPersona`) USING BTREE,
  INDEX `ciudad_ciudad`(`idCiudad`) USING BTREE,
  CONSTRAINT `ciudad_ciudad` FOREIGN KEY (`idCiudad`) REFERENCES `ciudad` (`idCiudad`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `persona_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detalle_producto
-- ----------------------------
DROP TABLE IF EXISTS `detalle_producto`;
CREATE TABLE `detalle_producto`  (
  `idDetalleProducto` int NOT NULL AUTO_INCREMENT,
  `tituloDetalle` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(10000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `urlImg` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `idProducto` int NULL DEFAULT NULL,
  PRIMARY KEY (`idDetalleProducto`) USING BTREE,
  INDEX `producto_producto`(`idProducto`) USING BTREE,
  CONSTRAINT `producto_producto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detalle_venta
-- ----------------------------
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE `detalle_venta`  (
  `idDetalleVenta` int NOT NULL AUTO_INCREMENT,
  `idVenta` int NULL DEFAULT NULL,
  `cantidad` int NULL DEFAULT NULL,
  `precio` double NULL DEFAULT NULL,
  `idPromocion` int NULL DEFAULT NULL,
  `idFormaPago` int NULL DEFAULT NULL,
  `subtotal` double NULL DEFAULT NULL,
  `costosAdicionales` double NULL DEFAULT NULL,
  `motivoCostosAdicional` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idDetalleVenta`) USING BTREE,
  INDEX `forma_pago`(`idFormaPago`) USING BTREE,
  INDEX `promocion_promocion`(`idPromocion`) USING BTREE,
  INDEX `venta_venta`(`idVenta`) USING BTREE,
  CONSTRAINT `forma_pago` FOREIGN KEY (`idFormaPago`) REFERENCES `forma_pago` (`idFormaPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `promocion_promocion` FOREIGN KEY (`idPromocion`) REFERENCES `promocion` (`idPromocion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `venta_venta` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for forma_pago
-- ----------------------------
DROP TABLE IF EXISTS `forma_pago`;
CREATE TABLE `forma_pago`  (
  `idFormaPago` int NOT NULL AUTO_INCREMENT,
  `tipoFormaPago` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `descripcion` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idFormaPago`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for impuesto
-- ----------------------------
DROP TABLE IF EXISTS `impuesto`;
CREATE TABLE `impuesto`  (
  `idImpuesto` int NOT NULL AUTO_INCREMENT,
  `porcentaje` float NOT NULL,
  `fechaExpiracion` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`idImpuesto`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `idMenu` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idMenu`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu_in_rol
-- ----------------------------
DROP TABLE IF EXISTS `menu_in_rol`;
CREATE TABLE `menu_in_rol`  (
  `idRol` int NOT NULL,
  `idMenu` int NOT NULL,
  PRIMARY KEY (`idRol`, `idMenu`) USING BTREE,
  INDEX `menu_menu`(`idMenu`) USING BTREE,
  CONSTRAINT `menu_menu` FOREIGN KEY (`idMenu`) REFERENCES `menu` (`idMenu`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rol_rol` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu_option
-- ----------------------------
DROP TABLE IF EXISTS `menu_option`;
CREATE TABLE `menu_option`  (
  `idMenu` int NOT NULL,
  `idOption` int NOT NULL,
  PRIMARY KEY (`idMenu`, `idOption`) USING BTREE,
  INDEX `opcion_opcion`(`idOption`) USING BTREE,
  CONSTRAINT `menuOpc_menuOpc` FOREIGN KEY (`idMenu`) REFERENCES `menu` (`idMenu`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `opcion_opcion` FOREIGN KEY (`idOption`) REFERENCES `opcion` (`idOpcion`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for opcion
-- ----------------------------
DROP TABLE IF EXISTS `opcion`;
CREATE TABLE `opcion`  (
  `idOpcion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idOpcion`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona`  (
  `idPersona` int NOT NULL AUTO_INCREMENT,
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `apellido` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `sexo` tinytext CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL,
  `cedula` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idPersona`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto`  (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `imgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `precio` float NULL DEFAULT NULL,
  `titulo` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `status` binary(1) NOT NULL,
  `idCategoria` int NOT NULL,
  `idPromocion` int NOT NULL,
  `idUnidad` int NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`idProducto`) USING BTREE,
  INDEX `unidad_unidad`(`idUnidad`) USING BTREE,
  INDEX `promo_promocion`(`idPromocion`) USING BTREE,
  INDEX `categoria_categoria`(`idCategoria`) USING BTREE,
  CONSTRAINT `categoria_categoria` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_producto` (`idCategoria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `promo_promocion` FOREIGN KEY (`idPromocion`) REFERENCES `promocion` (`idPromocion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `unidad_unidad` FOREIGN KEY (`idUnidad`) REFERENCES `unidad_medida` (`idUnidad`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for promocion
-- ----------------------------
DROP TABLE IF EXISTS `promocion`;
CREATE TABLE `promocion`  (
  `idPromocion` int NOT NULL AUTO_INCREMENT,
  `fechaExpiracion` datetime(0) NOT NULL,
  `tipoPromo` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `porcentajePromo` double(10, 0) NOT NULL,
  PRIMARY KEY (`idPromocion`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for provincia
-- ----------------------------
DROP TABLE IF EXISTS `provincia`;
CREATE TABLE `provincia`  (
  `provincia` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `idProvincia` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idProvincia`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `descripcion` varchar(60) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idRol`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for unidad_medida
-- ----------------------------
DROP TABLE IF EXISTS `unidad_medida`;
CREATE TABLE `unidad_medida`  (
  `idUnidad` int NOT NULL AUTO_INCREMENT,
  `unidad` varchar(5) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`idUnidad`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `idRol` int NULL DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `idPersona` int NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`) USING BTREE,
  INDEX `personaUSR_personaUSR`(`idPersona`) USING BTREE,
  INDEX `rolUSR_rolUSR`(`idRol`) USING BTREE,
  CONSTRAINT `personaUSR_personaUSR` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rolUSR_rolUSR` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta`  (
  `idVenta` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NULL DEFAULT NULL,
  `numFactura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `fecha` datetime(0) NULL DEFAULT NULL,
  `idImpuesto` int NULL DEFAULT NULL,
  `total` double NULL DEFAULT NULL,
  `status` binary(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idVenta`) USING BTREE,
  INDEX `cliente_cliente`(`idCliente`) USING BTREE,
  INDEX `impuesto_impuesto`(`idImpuesto`) USING BTREE,
  CONSTRAINT `cliente_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `impuesto_impuesto` FOREIGN KEY (`idImpuesto`) REFERENCES `impuesto` (`idImpuesto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
