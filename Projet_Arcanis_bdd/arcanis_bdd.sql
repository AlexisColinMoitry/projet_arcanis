SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Project_Arcanis
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Project_Arcanis` ;
CREATE SCHEMA IF NOT EXISTS `Project_Arcanis` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Project_Arcanis` ;

-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Proprietaire` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(20) NULL,
  `Prenom` VARCHAR(20) NULL,
  `Adressse` VARCHAR(30) NULL,
  `Num SIRET` DECIMAL(10,0) NULL,
  `Telephone` VARCHAR(10) NULL,
  `Email` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Num SIRET_UNIQUE` (`Num SIRET` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Race`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Race` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Robe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Robe` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Couleur` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Elevage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Elevage` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Propriétaire_id` INT UNSIGNED NOT NULL,
  `Nom` VARCHAR(20) NULL,
  `Adresse` VARCHAR(30) NULL,
  PRIMARY KEY (`id`, `Propriétaire_id`),
  INDEX `fk_Elevage_Proprietaire1_idx` (`Propriétaire_id` ASC),
  CONSTRAINT `fk_Elevage_Proprietaire1`
    FOREIGN KEY (`Propriétaire_id`)
    REFERENCES `Project_Arcanis`.`Proprietaire` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Chien`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Chien` (
  `id` INT UNSIGNED NOT NULL,
  `Prenom` VARCHAR(20) NULL,
  `Date_naissance` DATE NULL,
  `Numero_puce` INT NULL,
  `Proprietaire_id` INT NOT NULL,
  `Robe_id` INT NOT NULL,
  `Race_id` INT NOT NULL,
  `Provenance` VARCHAR(30) NULL,
  `mere_id` INT NULL DEFAULT NULL,
  `pere_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `Proprietaire_id`, `Robe_id`, `Race_id`),
  INDEX `fk_TableChien_Race1_idx` (`Race_id` ASC),
  INDEX `fk_TableChien_Robe1_idx` (`Robe_id` ASC),
  INDEX `fk_TableChien_Proprietaire1_idx` (`Proprietaire_id` ASC),
  UNIQUE INDEX `Numero_puce_UNIQUE` (`Numero_puce` ASC),
  CONSTRAINT `fk_TableChien_Race1`
    FOREIGN KEY (`Race_id`)
    REFERENCES `Project_Arcanis`.`Race` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TableChien_Robe1`
    FOREIGN KEY (`Robe_id`)
    REFERENCES `Project_Arcanis`.`Robe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TableChien_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id`)
    REFERENCES `Project_Arcanis`.`Proprietaire` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Etat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Etat` (
  `Chien_id` INT UNSIGNED NOT NULL,
  `Genre` CHAR CHARACTER SET 'big5' COLLATE 'big5_chinese_ci' NOT NULL DEFAULT 'F',
  `Loof` TINYINT(1) NULL,
  `Disponible` TINYINT(1) NULL,
  `Archive` TINYINT(1) NULL,
  PRIMARY KEY (`Chien_id`),
  INDEX `fk_Etat_TableChien1_idx` (`Chien_id` ASC),
  CONSTRAINT `fk_Etat_TableChien1`
    FOREIGN KEY (`Chien_id`)
    REFERENCES `Project_Arcanis`.`Chien` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Portee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Portee` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Chien_id` INT UNSIGNED NOT NULL,
  `Date_portee` DATE NULL,
  `Nombre_chiots` TINYINT NULL,
  PRIMARY KEY (`id`, `Chien_id`),
  INDEX `fk_Portee_TableChien1_idx` (`Chien_id` ASC),
  CONSTRAINT `fk_Portee_TableChien1`
    FOREIGN KEY (`Chien_id`)
    REFERENCES `Project_Arcanis`.`Chien` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Collaborateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Collaborateur` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(20) NOT NULL,
  `Prenom` VARCHAR(20) NOT NULL,
  `Adresse` VARCHAR(30) NOT NULL,
  `Telephone` VARCHAR(10) NULL,
  `Emaill` VARCHAR(20) NULL,
  `Titre` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Facture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Facture` (
  `id_facture` INT NOT NULL,
  `Collaborateur_id` INT NOT NULL,
  `Proprietaire_id` INT NOT NULL,
  `Date_facture` DATE NULL,
  `Contenu` VARCHAR(225) NULL,
  PRIMARY KEY (`id_facture`, `Collaborateur_id`, `Proprietaire_id`),
  INDEX `fk_Collaborateur_has_Proprietaire_Proprietaire1_idx` (`Proprietaire_id` ASC),
  INDEX `fk_Collaborateur_has_Proprietaire_Collaborateur_idx` (`Collaborateur_id` ASC),
  CONSTRAINT `fk_Collaborateur_has_Proprietaire_Collaborateur`
    FOREIGN KEY (`Collaborateur_id`)
    REFERENCES `Project_Arcanis`.`Collaborateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Collaborateur_has_Proprietaire_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id`)
    REFERENCES `Project_Arcanis`.`Proprietaire` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Client` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(20) NOT NULL,
  `Prenom` VARCHAR(20) NOT NULL,
  `Adresse` VARCHAR(30) NOT NULL,
  `Telephone` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Vente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Vente` (
  `id` INT UNSIGNED NOT NULL,
  `Date_vente` DATE NULL,
  `Chien_id` INT NOT NULL,
  `Client_id` INT NOT NULL,
  `Proprietaire_id` INT NOT NULL,
  `Prix` INT UNSIGNED NULL,
  PRIMARY KEY (`id`, `Chien_id`, `Client_id`, `Proprietaire_id`),
  INDEX `fk_Vente_Chien1_idx` (`Chien_id` ASC),
  INDEX `fk_Vente_Client1_idx` (`Client_id` ASC),
  INDEX `fk_Vente_Proprietaire1_idx` (`Proprietaire_id` ASC),
  CONSTRAINT `fk_Vente_Chien1`
    FOREIGN KEY (`Chien_id`)
    REFERENCES `Project_Arcanis`.`Chien` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vente_Client1`
    FOREIGN KEY (`Client_id`)
    REFERENCES `Project_Arcanis`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vente_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id`)
    REFERENCES `Project_Arcanis`.`Proprietaire` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Soins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Soins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Chien_id` INT NOT NULL,
  `Type_soins` VARCHAR(20) NULL,
  `Date_intervention` DATE NULL,
  `Commentaires` VARCHAR(255) NULL,
  PRIMARY KEY (`id`, `Chien_id`),
  INDEX `fk_Soins_Chien1_idx` (`Chien_id` ASC),
  CONSTRAINT `fk_Soins_Chien1`
    FOREIGN KEY (`Chien_id`)
    REFERENCES `Project_Arcanis`.`Chien` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Saillie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Saillie` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Chien_id` INT UNSIGNED NOT NULL,
  `Date_saillie` DATE NULL,
  `Commentaire` VARCHAR(255) NULL,
  PRIMARY KEY (`id`, `Chien_id`),
  INDEX `fk_Saillie_Chien1_idx` (`Chien_id` ASC),
  CONSTRAINT `fk_Saillie_Chien1`
    FOREIGN KEY (`Chien_id`)
    REFERENCES `Project_Arcanis`.`Chien` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Historique`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Historique` (
  `id` INT UNSIGNED NOT NULL,
  `Genre` CHAR NULL,
  `Nom` VARCHAR(20) NULL,
  `Date_naissance` DATE NULL,
  `Numero_puce` INT NULL,
  `race_id` INT UNSIGNED NULL,
  `robe_id` INT UNSIGNED NULL,
  `Date_histo` DATETIME NOT NULL,
  `Evenement_histo` CHAR(6) NOT NULL,
  PRIMARY KEY (`id`, `Date_histo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Archive` (
  `id` INT UNSIGNED NOT NULL,
  `Genre` CHAR NULL,
  `Nom` VARCHAR(20) NULL,
  `Date_naissance` DATE NULL,
  `Numero_puce` INT NULL,
  `race_id` INT UNSIGNED NULL,
  `robe_id` INT UNSIGNED NULL,
  `mere_id` INT UNSIGNED NULL,
  `pere_id` INT NULL,
  `Date_archive` DATETIME NOT NULL,
  `Evenement_archiv` CHAR(5) NOT NULL,
  PRIMARY KEY (`id`, `Date_archive`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_Arcanis`.`Erreur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_Arcanis`.`Erreur` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Erreur` VARCHAR(225) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Erreur_UNIQUE` (`Erreur` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
