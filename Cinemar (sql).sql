
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Schema Cinemar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cinemar` DEFAULT CHARACTER SET utf8 ;
USE `Cinemar` ;

-- Table `Cinemar`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Rol` (
  `idRol` INT NOT NULL ,
  `Rol` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;

-- Table `Cinemar`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Usuario` (
  `idUsuario` INT NOT NULL auto_increment,
  `Rol_idRol` INT NOT NULL,
  `Usuario` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `Correo` VARCHAR(45) NULL,
  `Dni` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `Frecuencia` TINYINT NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_Rol_idx` (`Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Rol`
    FOREIGN KEY (`Rol_idRol`)
    REFERENCES `Cinemar`.`Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `Cinemar`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Estado` (
  `idEstado` INT NOT NULL,
  `Estado` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB;

-- Table `Cinemar`.`tipoPago`
CREATE TABLE IF NOT EXISTS `Cinemar`.`tipoPago` (
  `idTipoPago` INT NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idTipoPago`))
ENGINE = InnoDB;

-- Table `Cinemar`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Reserva` (
  `idReserva` INT NOT NULL auto_increment,
  `Estado_idEstado` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `tipoPago_idTipoPago` INT NOT NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Reserva_Estado1_idx` (`Estado_idEstado` ASC) VISIBLE,
  INDEX `fk_Reserva_tipoPago1_idx` (`tipoPago_idTipoPago` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `Cinemar`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Estado1`
    FOREIGN KEY (`Estado_idEstado`)
    REFERENCES `Cinemar`.`Estado` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_tipoPago1`
    FOREIGN KEY (`tipoPago_idTipoPago`)
    REFERENCES `Cinemar`.`tipoPago` (`idTipoPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `Cinemar`.`TipoSala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`TipoSala` (
  `idTipoSala` INT NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  `Precio` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idTipoSala`))
ENGINE = InnoDB;

-- Table `Cinemar`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Sala` (
  `idSala` INT NOT NULL ,
  `TipoSala_idTipoSala` INT NOT NULL,
  `Capacidad` INT NULL,
  `Nro` INT NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idSala`),
  INDEX `fk_Sala_TipoSala1_idx` (`TipoSala_idTipoSala` ASC) VISIBLE,
  CONSTRAINT `fk_Sala_TipoSala1`
    FOREIGN KEY (`TipoSala_idTipoSala`)
    REFERENCES `Cinemar`.`TipoSala` (`idTipoSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `Cinemar`.`Butaca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Butaca` (
  `idButaca` INT NOT NULL,
  `Sala_idSala` INT NOT NULL,
  `Lugar` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idButaca`),
  INDEX `fk_Butaca_Sala1_idx` (`Sala_idSala` ASC) VISIBLE,
  CONSTRAINT `fk_Butaca_Sala1`
    FOREIGN KEY (`Sala_idSala`)
    REFERENCES `Cinemar`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `Cinemar`.`Reserva_Detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Reserva_Detalle` (
  `idReserva_Detalle` INT NOT NULL auto_increment,
  `Reserva_idReserva` INT NOT NULL,
  `Butaca_idButaca` INT NOT NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idReserva_Detalle`),
  INDEX `fk_Reserva_Detalle_Reserva1_idx` (`Reserva_idReserva` ASC) VISIBLE,
  INDEX `fk_Reserva_Detalle_Butaca1_idx` (`Butaca_idButaca` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Detalle_Reserva1`
    FOREIGN KEY (`Reserva_idReserva`)
    REFERENCES `Cinemar`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Detalle_Butaca1`
    FOREIGN KEY (`Butaca_idButaca`)
    REFERENCES `Cinemar`.`Butaca` (`idButaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `Cinemar`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Genero` (
  `idGenero` INT NOT NULL auto_increment,
  `Genero` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;

-- Table `Cinemar`.`Pelicula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Pelicula` (
  `idPelicula` INT NOT NULL auto_increment,
  `Genero_idGenero` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Duracion` VARCHAR(45) NULL,
  `atp` TINYINT NULL,
  `plus` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idPelicula`),
  INDEX `fk_Pelicula_Genero1_idx` (`Genero_idGenero` ASC) VISIBLE,
  CONSTRAINT `fk_Pelicula_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `Cinemar`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `Cinemar`.`Cartelera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cinemar`.`Cartelera` (
  `idCartelera` INT NOT NULL auto_increment,
  `Sala_idSala` INT NOT NULL,
  `Pelicula_idPelicula` INT NOT NULL,
  `Fecha` DATE NULL,
  `Hora` TIME NULL,
  `PrecioTotal` VARCHAR(45) NULL,
  `created_At` DATETIME NULL,
  `updated_At` DATETIME NULL,
  `deleted_At` DATETIME NULL,
  PRIMARY KEY (`idCartelera`),
  INDEX `fk_Cartelera_Sala1_idx` (`Sala_idSala` ASC) VISIBLE,
  INDEX `fk_Cartelera_Pelicula1_idx` (`Pelicula_idPelicula` ASC) VISIBLE,
  CONSTRAINT `fk_Cartelera_Sala1`
    FOREIGN KEY (`Sala_idSala`)
    REFERENCES `Cinemar`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cartelera_Pelicula1`
    FOREIGN KEY (`Pelicula_idPelicula`)
    REFERENCES `Cinemar`.`Pelicula` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



insert into cinemar.estado (idEstado,Estado) values
(1,'Activa'),
(2,'Cancelada');

insert into cinemar.usuario (Rol_idRol,Usuario,Nombre,Apellido,Correo,Dni,Password,Frecuencia,created_At) values
(1,'PabloFgr','Pablo','Gomez','gomez.pablo@gmail.com',43837604,'PabloFgr',1,'2022-01-10'),
(1,'Gercapo','German','Maurino','maurino.german@gmail.com',44176415,'Gercapo',1,'2022-01-10');

insert into cinemar.rol (idRol,Rol,created_At) values
(1,'Administrador','2022-01-01'),
(2,'Usuario Comun','2022-01-01');

insert into cinemar.tipopago (idTipoPago,Tipo) values
(1,'Efectivo'),
(2,'Debito'),
(3,'Credito');

insert into cinemar.reserva (Estado_idEstado,Usuario_idUsuario,tipoPago_idTipoPago,created_At) values
(1,2,3,'2022-06-10'),
(2,2,1,'2022-06-11'),
(1,2,2,'2022-06-12');

insert into cinemar.reserva_detalle (Reserva_idReserva,Butaca_idButaca) values
(1,'16'),
(2,'50'),
(3,'34');

insert into cinemar.butaca (idButaca,Sala_idSala,Lugar) values
(1,1,'A1'),(2,1,'A2'),(3,1,'A3'),(4,1,'A4'),(5,1,'A5'),(6,2,'A6'),(7,3,'A7'),(8,3,'A8'),(9,2,'A9'),
(10,2,'B1'),(11,2,'B2'),(12,2,'B3'),(13,2,'B4'),(14,3,'B5'),(15,2,'B6'),(16,3,'B7'),(17,3,'B8'),(18,1,'B9'),
(19,3,'C1'),(20,1,'C2'),(21,1,'C3'),(22,3,'C4'),(23,3,'C5'),(24,3,'C6'),(25,2,'C7'),(26,3,'C8'),(27,3,'C9'),
(28,1,'D1'),(29,3,'D2'),(30,3,'D3'),(31,3,'D4'),(32,1,'D5'),(33,1,'D6'),(34,1,'D7'),(35,2,'D8'),(36,1,'D9'),
(37,3,'E1'),(38,2,'E2'),(39,1,'E3'),(40,1,'E4'),(41,3,'E5'),(42,3,'E6'),(43,1,'E7'),(44,2,'E8'),(45,1,'E9'),
(46,2,'F1'),(47,2,'F2'),(48,3,'F3'),(49,2,'F4'),(50,1,'F5'),(51,3,'F6'),(52,1,'F7'),(53,2,'F8'),(54,3,'F9');


insert into cinemar.sala (idSala,TipoSala_idTipoSala,Capacidad,Nro) values
(1,2,54,1),
(2,2,54,2),
(3,1,54,3);

insert into cinemar.tiposala (idTipoSala,Tipo,Precio) values
(1,'2D',500),
(2,'3D',600);

insert into cinemar.cartelera (Sala_idSala,Pelicula_idPelicula,Fecha,Hora,PrecioTotal) values
(1,1,'2022-06-15','20:00',500),
(2,2,'2022-06-15','18:00',600),
(2,3,'2022-06-16','21:00',600);

insert into cinemar.pelicula (Genero_idGenero,Nombre,Duracion,atp,plus) values
(1,'Top Gun','120 min',1,'No'),
(2,'Toy Story','130 min',1,'Si'),
(3,'Harry Potter 1','140 min',0,'Si');

insert into cinemar.genero (Genero) values
('Accion'),
('Infantil'),
('Ciencia Ficción');

