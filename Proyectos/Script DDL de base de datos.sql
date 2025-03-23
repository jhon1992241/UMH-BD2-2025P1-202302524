# PROYECTO FORMULARIO DE HOTEL

-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto2` DEFAULT CHARACTER SET utf8;
USE `proyecto2`;

-- -----------------------------------------------------
-- Table `proyecto2`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pais`)
);

-- -----------------------------------------------------
-- Table `proyecto2`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `id_pais` INT NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  INDEX `fk_ciudad_pais1_idx` (`id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_pais1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `proyecto2`.`pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `proyecto2`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`domicilio` (
  `id_domicilio` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NULL,
  `id_ciudad` INT NOT NULL,
  PRIMARY KEY (`id_domicilio`),
  INDEX `fk_domicilio_ciudad1_idx` (`id_ciudad` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_ciudad1`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `proyecto2`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `proyecto2`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `organizacion` VARCHAR(45) NULL,
  `cargo` VARCHAR(45) NULL,
  `numPasaporte` VARCHAR(45) NULL,
  `fechaNacimiento` DATE NULL,
  `nacionalidad` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `id_domicilio` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_participante_domicilio1_idx` (`id_domicilio` ASC) VISIBLE,
  CONSTRAINT `fk_participante_domicilio1`
    FOREIGN KEY (`id_domicilio`)
    REFERENCES `proyecto2`.`domicilio` (`id_domicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `proyecto2`.`hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`hotel` (
  `id_hotel` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_hotel`)
);

-- -----------------------------------------------------
-- Table `proyecto2`.`tipoTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`tipoTarjeta` (
  `id_tipoTarjeta` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipoTarjeta`)
);

-- -----------------------------------------------------
-- Table `proyecto2`.`tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`tarjeta` (
  `id_tarjeta` INT NOT NULL AUTO_INCREMENT,
  `numTarjeta` VARCHAR(45) NULL,
  `fechaVencimiento` DATE NULL,
  `nombreTitular` VARCHAR(45) NULL,
  `id_cliente` INT NOT NULL,
  `id_tipoTarjeta` INT NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  INDEX `fk_tarjeta_participante1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_tarjeta_tipoTarjeta1_idx` (`id_tipoTarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_participante1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `proyecto2`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarjeta_tipoTarjeta1`
    FOREIGN KEY (`id_tipoTarjeta`)
    REFERENCES `proyecto2`.`tipoTarjeta` (`id_tipoTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `proyecto2`.`tipoHabitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`tipoHabitacion` (
  `id_tipoHabitacion` INT NOT NULL AUTO_INCREMENT,
  `tipoHabitacion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipoHabitacion`)
);

-- -----------------------------------------------------
-- Table `proyecto2`.`acomodacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`acomodacion` (
  `id_acomodacion` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_acomodacion`)
);

-- -----------------------------------------------------
-- Table `proyecto2`.`habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`habitacion` (
  `id_habitacion` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL NULL,
  `id_hotel` INT NOT NULL,
  `id_tipoHabitacion` INT NOT NULL,
  `id_acomodacion` INT NOT NULL,
  PRIMARY KEY (`id_habitacion`),
  INDEX `fk_Habitacion_hotel1_idx` (`id_hotel` ASC) VISIBLE,
  INDEX `fk_habitacion_tipoHabitacion1_idx` (`id_tipoHabitacion` ASC) VISIBLE,
  INDEX `fk_habitacion_acomodacion1_idx` (`id_acomodacion` ASC) VISIBLE,
  CONSTRAINT `fk_Habitacion_hotel1`
    FOREIGN KEY (`id_hotel`)
    REFERENCES `proyecto2`.`hotel` (`id_hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitacion_tipoHabitacion1`
    FOREIGN KEY (`id_tipoHabitacion`)
    REFERENCES `proyecto2`.`tipoHabitacion` (`id_tipoHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitacion_acomodacion1`
    FOREIGN KEY (`id_acomodacion`)
    REFERENCES `proyecto2`.`acomodacion` (`id_acomodacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `proyecto2`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`reserva` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `fechaArribo` DATE NULL,
  `fechaSalida` DATE NULL,
  `numNoches` INT NULL,
  `vueloArribo` DATE NULL,
  `vueloSalida` DATE NULL,
  `early_check_in` VARCHAR(45) NULL,
  `id_cliente` INT NOT NULL,
  `id_tarjeta` INT NOT NULL,
  `id_habitacion` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reserva_participante1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_reserva_tarjeta1_idx` (`id_tarjeta` ASC) VISIBLE,
  INDEX `fk_reserva_habitacion1_idx` (`id_habitacion` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_participante1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `proyecto2`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_tarjeta1`
    FOREIGN KEY (`id_tarjeta`)
    REFERENCES `proyecto2`.`tarjeta` (`id_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_habitacion1`
    FOREIGN KEY (`id_habitacion`)
    REFERENCES `proyecto2`.`habitacion` (`id_habitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `proyecto2`.`personaContacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`personaContacto` (
  `id_contacto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `id_hotel` INT NOT NULL,
  PRIMARY KEY (`id_contacto`),
  INDEX `fk_contacto_hotel_idx` (`id_hotel` ASC) VISIBLE,
  CONSTRAINT `fk_contacto_hotel`
    FOREIGN KEY (`id_hotel`)
    REFERENCES `proyecto2`.`hotel` (`id_hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
