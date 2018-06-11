-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SGA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SGA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SGA` DEFAULT CHARACTER SET utf8 ;
USE `SGA` ;

-- -----------------------------------------------------
-- Table `SGA`.`EMPRESA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`EMPRESA` (
  `ID_EMPRESA` INT NOT NULL AUTO_INCREMENT,
  `NOME_EMPRESA` VARCHAR(200) NOT NULL,
  `CNPJ_EMPRESA` VARCHAR(45) NOT NULL,
  `INSCRICAO_MUNICIPAL` VARCHAR(45) NULL,
  `LICENSA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_EMPRESA`))
ENGINE = InnoDB
COMMENT = 'Empresas de descarte';


-- -----------------------------------------------------
-- Table `SGA`.`CONTRATO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`CONTRATO` (
  `ID_CONTRATO` INT NOT NULL AUTO_INCREMENT,
  `DATA_CONTRATO` DATE NOT NULL,
  `DATA_VENCIMENTO_CONTRATO` DATE NOT NULL,
  `EMPRESA_ID_EMPRESA` INT NOT NULL,
  PRIMARY KEY (`ID_CONTRATO`, `EMPRESA_ID_EMPRESA`),
  INDEX `fk_CONTRATO_EMPRESA1_idx` (`EMPRESA_ID_EMPRESA` ASC),
  CONSTRAINT `fk_CONTRATO_EMPRESA1`
    FOREIGN KEY (`EMPRESA_ID_EMPRESA`)
    REFERENCES `SGA`.`EMPRESA` (`ID_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`DOCUMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`DOCUMENTO` (
  `ID_DOCUMENTO` INT NOT NULL AUTO_INCREMENT,
  `TIPO_DOCUMENTO` VARCHAR(45) NOT NULL,
  `NOME_DOCUMENTO` VARCHAR(200) NOT NULL,
  `URL` VARCHAR(200) NULL,
  `CONTRATO_ID_CONTRATO` INT NOT NULL,
  PRIMARY KEY (`ID_DOCUMENTO`, `CONTRATO_ID_CONTRATO`),
  INDEX `fk_DOCUMENTO_CONTRATO1_idx` (`CONTRATO_ID_CONTRATO` ASC),
  CONSTRAINT `fk_DOCUMENTO_CONTRATO1`
    FOREIGN KEY (`CONTRATO_ID_CONTRATO`)
    REFERENCES `SGA`.`CONTRATO` (`ID_CONTRATO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`MATERIAL` (
  `CODIGO_MATERIAL` INT NOT NULL AUTO_INCREMENT,
  `NOME_MATERIAL` VARCHAR(45) NOT NULL,
  `TIPO_MATERIAL` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CODIGO_MATERIAL`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`RISCO_BIOLOGICO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`RISCO_BIOLOGICO` (
  `ID_RISCO_BIOLOGICO` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO_RISCO` VARCHAR(45) NOT NULL,
  `GRAU_CONTAMINACAO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_RISCO_BIOLOGICO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`RISCO_MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`RISCO_MATERIAL` (
  `ID_RISCO_MATERIAL` INT NOT NULL AUTO_INCREMENT,
  `MATERIAL_CODIGO_MATERIAL` INT NOT NULL,
  `RISCO_BIOLOGICO_ID_RISCO_BIOLOGICO` INT NOT NULL,
  PRIMARY KEY (`ID_RISCO_MATERIAL`, `MATERIAL_CODIGO_MATERIAL`, `RISCO_BIOLOGICO_ID_RISCO_BIOLOGICO`),
  INDEX `fk_RISCO_MATERIAL_MATERIAL1_idx` (`MATERIAL_CODIGO_MATERIAL` ASC),
  INDEX `fk_RISCO_MATERIAL_RISCO_BIOLOGICO1_idx` (`RISCO_BIOLOGICO_ID_RISCO_BIOLOGICO` ASC),
  CONSTRAINT `fk_RISCO_MATERIAL_MATERIAL1`
    FOREIGN KEY (`MATERIAL_CODIGO_MATERIAL`)
    REFERENCES `SGA`.`MATERIAL` (`CODIGO_MATERIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RISCO_MATERIAL_RISCO_BIOLOGICO1`
    FOREIGN KEY (`RISCO_BIOLOGICO_ID_RISCO_BIOLOGICO`)
    REFERENCES `SGA`.`RISCO_BIOLOGICO` (`ID_RISCO_BIOLOGICO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`LISTA_MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`LISTA_MATERIAL` (
  `ID_LISTA_MATERIAL` INT NOT NULL AUTO_INCREMENT,
  `PERIODO_GERACAO_INICIO` DATE NOT NULL,
  `PERIODO_GERACAO_FIM` DATE NOT NULL,
  PRIMARY KEY (`ID_LISTA_MATERIAL`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`UNIDADE_MEDIDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`UNIDADE_MEDIDA` (
  `ID_UNIDADE_MEDIDA` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_UNIDADE_MEDIDA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`ITEM_LISTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`ITEM_LISTA` (
  `ID_ITEM` INT NOT NULL AUTO_INCREMENT,
  `QUANTIDADE_ITEM` VARCHAR(45) NOT NULL,
  `UNIDADE_MEDIDA_ID_UNIDADE_MEDIDA` INT NOT NULL,
  `LISTA_MATERIAL_ID_LISTA_MATERIAL` INT NOT NULL,
  `MATERIAL_CODIGO_MATERIAL` INT NOT NULL,
  PRIMARY KEY (`ID_ITEM`, `UNIDADE_MEDIDA_ID_UNIDADE_MEDIDA`, `LISTA_MATERIAL_ID_LISTA_MATERIAL`, `MATERIAL_CODIGO_MATERIAL`),
  INDEX `fk_LISTA_ITEM_MATERIAL_UNIDADE_MEDIDA1_idx` (`UNIDADE_MEDIDA_ID_UNIDADE_MEDIDA` ASC),
  INDEX `fk_LISTA_ITEM_MATERIAL_LISTA_MATERIAL1_idx` (`LISTA_MATERIAL_ID_LISTA_MATERIAL` ASC),
  INDEX `fk_ITEM_LISTA_MATERIAL1_idx` (`MATERIAL_CODIGO_MATERIAL` ASC),
  CONSTRAINT `fk_LISTA_ITEM_MATERIAL_UNIDADE_MEDIDA1`
    FOREIGN KEY (`UNIDADE_MEDIDA_ID_UNIDADE_MEDIDA`)
    REFERENCES `SGA`.`UNIDADE_MEDIDA` (`ID_UNIDADE_MEDIDA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LISTA_ITEM_MATERIAL_LISTA_MATERIAL1`
    FOREIGN KEY (`LISTA_MATERIAL_ID_LISTA_MATERIAL`)
    REFERENCES `SGA`.`LISTA_MATERIAL` (`ID_LISTA_MATERIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_LISTA_MATERIAL1`
    FOREIGN KEY (`MATERIAL_CODIGO_MATERIAL`)
    REFERENCES `SGA`.`MATERIAL` (`CODIGO_MATERIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`DESCARTE_MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`DESCARTE_MATERIAL` (
  `ID_DESCARTE_MATERIAL` INT NOT NULL AUTO_INCREMENT,
  `DATA_DESCARTE` DATE NOT NULL,
  `LOCAL_DESCARTE` VARCHAR(45) NOT NULL,
  `DATA_COLETA` VARCHAR(45) NOT NULL,
  `VALOR_TRANSACAO` DOUBLE NOT NULL,
  `LISTA_MATERIAL_ID_LISTA_MATERIAL` INT NOT NULL,
  `EMPRESA_ID_EMPRESA` INT NOT NULL,
  PRIMARY KEY (`ID_DESCARTE_MATERIAL`, `LISTA_MATERIAL_ID_LISTA_MATERIAL`, `EMPRESA_ID_EMPRESA`),
  INDEX `fk_DESCARTE_MATERIAL_LISTA_MATERIAL1_idx` (`LISTA_MATERIAL_ID_LISTA_MATERIAL` ASC),
  INDEX `fk_DESCARTE_MATERIAL_EMPRESA1_idx` (`EMPRESA_ID_EMPRESA` ASC),
  CONSTRAINT `fk_DESCARTE_MATERIAL_LISTA_MATERIAL1`
    FOREIGN KEY (`LISTA_MATERIAL_ID_LISTA_MATERIAL`)
    REFERENCES `SGA`.`LISTA_MATERIAL` (`ID_LISTA_MATERIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DESCARTE_MATERIAL_EMPRESA1`
    FOREIGN KEY (`EMPRESA_ID_EMPRESA`)
    REFERENCES `SGA`.`EMPRESA` (`ID_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SGA`.`ITEM_DOCUMENTO_DESCARTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGA`.`ITEM_DOCUMENTO_DESCARTE` (
  `ID_DOCUMENTO_DESCARTE` INT NOT NULL AUTO_INCREMENT,
  `DOCUMENTO_ID_DOCUMENTO` INT NOT NULL,
  `DESCARTE_MATERIAL_ID_DESCARTE_MATERIAL` INT NOT NULL,
  PRIMARY KEY (`ID_DOCUMENTO_DESCARTE`),
  INDEX `fk_ITEM_DOCUMENTO_DESCARTE_DOCUMENTO1_idx` (`DOCUMENTO_ID_DOCUMENTO` ASC),
  INDEX `fk_ITEM_DOCUMENTO_DESCARTE_DESCARTE_MATERIAL1_idx` (`DESCARTE_MATERIAL_ID_DESCARTE_MATERIAL` ASC),
  CONSTRAINT `fk_ITEM_DOCUMENTO_DESCARTE_DOCUMENTO1`
    FOREIGN KEY (`DOCUMENTO_ID_DOCUMENTO`)
    REFERENCES `SGA`.`DOCUMENTO` (`ID_DOCUMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_DOCUMENTO_DESCARTE_DESCARTE_MATERIAL1`
    FOREIGN KEY (`DESCARTE_MATERIAL_ID_DESCARTE_MATERIAL`)
    REFERENCES `SGA`.`DESCARTE_MATERIAL` (`ID_DESCARTE_MATERIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;