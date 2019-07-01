-- MySQL Script generated by MySQL Workbench
-- Thu Jun 27 09:54:39 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema workTogether
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema workTogether
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `workTogether` DEFAULT CHARACTER SET utf8 ;
USE `workTogether` ;

-- -----------------------------------------------------
-- Table `workTogether`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`users` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`users` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(70) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `tipousuario` VARCHAR(45) NOT NULL,
  `celular` INT NOT NULL,
  PRIMARY KEY (`idusuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`categoria` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`detalleproyecto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`detalleproyecto` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`detalleproyecto` (
  `iddetalleproyecto` INT NOT NULL AUTO_INCREMENT,
  `nombreproyecto` TINYTEXT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `alcance` TINYTEXT NOT NULL,
  `fechacreacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iddetalleproyecto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`proyectos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`proyectos` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`proyectos` (
  `idproyectos` INT NOT NULL AUTO_INCREMENT,
  `users_idusuarios` INT NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  `detalleproyecto_iddetalleproyecto` INT NOT NULL,
  PRIMARY KEY (`idproyectos`, `users_idusuarios`, `categoria_idcategoria`, `detalleproyecto_iddetalleproyecto`),
  INDEX `fk_proyectos_users_idx` (`users_idusuarios` ASC) ,
  INDEX `fk_proyectos_categoria1_idx` (`categoria_idcategoria` ASC) ,
  INDEX `fk_proyectos_detalleproyecto1_idx` (`detalleproyecto_iddetalleproyecto` ASC) ,
  CONSTRAINT `fk_proyectos_users`
    FOREIGN KEY (`users_idusuarios`)
    REFERENCES `workTogether`.`users` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyectos_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `workTogether`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyectos_detalleproyecto1`
    FOREIGN KEY (`detalleproyecto_iddetalleproyecto`)
    REFERENCES `workTogether`.`detalleproyecto` (`iddetalleproyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`detallepublicacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`detallepublicacion` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`detallepublicacion` (
  `iddetallepublicacion` INT NOT NULL AUTO_INCREMENT,
  `ver` VARCHAR(45) NOT NULL,
  `resumen` TINYTEXT NOT NULL,
  `fechapublicacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iddetallepublicacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`publicaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`publicaciones` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`publicaciones` (
  `idpublicaciones` INT NOT NULL AUTO_INCREMENT,
  `proyectos_idproyectos` INT NOT NULL,
  `proyectos_users_idusuarios` INT NOT NULL,
  `detallepublicacion_iddetallepublicacion` INT NOT NULL,
  PRIMARY KEY (`idpublicaciones`, `proyectos_idproyectos`, `proyectos_users_idusuarios`, `detallepublicacion_iddetallepublicacion`),
  INDEX `fk_publicaciones_proyectos1_idx` (`proyectos_idproyectos` ASC, `proyectos_users_idusuarios` ASC) ,
  INDEX `fk_publicaciones_detallepublicacion1_idx` (`detallepublicacion_iddetallepublicacion` ASC) ,
  CONSTRAINT `fk_publicaciones_proyectos1`
    FOREIGN KEY (`proyectos_idproyectos` , `proyectos_users_idusuarios`)
    REFERENCES `workTogether`.`proyectos` (`idproyectos` , `users_idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicaciones_detallepublicacion1`
    FOREIGN KEY (`detallepublicacion_iddetallepublicacion`)
    REFERENCES `workTogether`.`detallepublicacion` (`iddetallepublicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`documentacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`documentacion` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`documentacion` (
  `iddocumentacion` INT NOT NULL AUTO_INCREMENT,
  `contenido` TEXT NOT NULL,
  `publicaciones_idpublicaciones` INT NOT NULL,
  `publicaciones_proyectos_idproyectos` INT NOT NULL,
  `publicaciones_proyectos_users_idusuarios` INT NOT NULL,
  PRIMARY KEY (`iddocumentacion`, `publicaciones_idpublicaciones`, `publicaciones_proyectos_idproyectos`, `publicaciones_proyectos_users_idusuarios`),
  INDEX `fk_documentacion_publicaciones1_idx` (`publicaciones_idpublicaciones` ASC, `publicaciones_proyectos_idproyectos` ASC, `publicaciones_proyectos_users_idusuarios` ASC) ,
  CONSTRAINT `fk_documentacion_publicaciones1`
    FOREIGN KEY (`publicaciones_idpublicaciones` , `publicaciones_proyectos_idproyectos` , `publicaciones_proyectos_users_idusuarios`)
    REFERENCES `workTogether`.`publicaciones` (`idpublicaciones` , `proyectos_idproyectos` , `proyectos_users_idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`imagen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`imagen` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`imagen` (
  `idimagen` INT NOT NULL AUTO_INCREMENT,
  `imagenurl` TINYTEXT NOT NULL,
  `iddocumentacion` INT NOT NULL,
  PRIMARY KEY (`idimagen`),
  INDEX `documentacion_iddocumentacion_idx` (`iddocumentacion` ASC) ,
  CONSTRAINT `documentacion_iddocumentacion`
    FOREIGN KEY (`iddocumentacion`)
    REFERENCES `workTogether`.`documentacion` (`iddocumentacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`comentarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`comentarios` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`comentarios` (
  `idcomentarios` INT NOT NULL AUTO_INCREMENT,
  `urlcomentario` TINYTEXT NOT NULL,
  `iddocumentacion` INT NOT NULL,
  PRIMARY KEY (`idcomentarios`),
  INDEX `documentacion_iddocuemntacion_idx` (`iddocumentacion` ASC) ,
  CONSTRAINT `documentacion_iddocuemntacion`
    FOREIGN KEY (`iddocumentacion`)
    REFERENCES `workTogether`.`documentacion` (`iddocumentacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `workTogether`.`reportes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workTogether`.`reportes` ;

CREATE TABLE IF NOT EXISTS `workTogether`.`reportes` (
  `idreportes` INT NOT NULL AUTO_INCREMENT,
  `reporte` TINYTEXT NOT NULL,
  `proyectos_idproyectos` INT NOT NULL,
  `proyectos_users_idusuarios` INT NOT NULL,
  `proyectos_categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`idreportes`, `proyectos_idproyectos`, `proyectos_users_idusuarios`, `proyectos_categoria_idcategoria`),
  INDEX `fk_reportes_proyectos1_idx` (`proyectos_idproyectos` ASC, `proyectos_users_idusuarios` ASC, `proyectos_categoria_idcategoria` ASC) ,
  CONSTRAINT `fk_reportes_proyectos1`
    FOREIGN KEY (`proyectos_idproyectos` , `proyectos_users_idusuarios` , `proyectos_categoria_idcategoria`)
    REFERENCES `workTogether`.`proyectos` (`idproyectos` , `users_idusuarios` , `categoria_idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
