SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema DVD_Store_Schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS DVD_Store;

-- -----------------------------------------------------
-- Schema DVD_Store_Schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS DVD_Store
  DEFAULT CHARACTER SET utf8;
USE DVD_Store;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Director`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Director` (
  `id`        INT         NOT NULL AUTO_INCREMENT,
  `name`      VARCHAR(60) NOT NULL,
  `biography` LONGTEXT    NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Genre`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Genre` (
  `id`   INT         NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Studio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Studio`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Studio` (
  `id`   INT         NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE`
  ON DVD_Store.`Studio` (`id` ASC);

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Classification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Classification`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Classification` (
  `id`          INT         NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Rate`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Rate` (
  `id`   INT   NOT NULL AUTO_INCREMENT,
  `rate` FLOAT NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Movie`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Movie` (
  `id`                VARCHAR(20)  NOT NULL,
  `title`             VARCHAR(150) NOT NULL,
  `dvd_count`         INT          NOT NULL,
  `short_description` VARCHAR(45)  NULL,
  `release_date`      DATETIME     NULL,
  `runtime`           INT          NULL,
  `director_id`       INT          NOT NULL,
  `genre_id`          INT          NULL,
  `label_id`          INT          NULL,
  `studio_id`         INT          NULL,
  `classification_id` INT          NOT NULL,
  `rate_id`           INT          NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Catalogue_director`
  FOREIGN KEY (`director_id`)
  REFERENCES DVD_Store.`Director` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Catalogue_genre`
  FOREIGN KEY (`genre_id`)
  REFERENCES DVD_Store.`Genre` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Catalogue_studio`
  FOREIGN KEY (`studio_id`)
  REFERENCES DVD_Store.`Studio` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Catalogue_classification`
  FOREIGN KEY (`classification_id`)
  REFERENCES DVD_Store.`Classification` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Catalogue_rate`
  FOREIGN KEY (`rate_id`)
  REFERENCES DVD_Store.`Rate` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX `FK_director_idx`
  ON DVD_Store.`Movie` (`director_id` ASC);

CREATE INDEX `FK_genre_idx`
  ON DVD_Store.`Movie` (`genre_id` ASC);

CREATE INDEX `FK_studio_idx`
  ON DVD_Store.`Movie` (`studio_id` ASC);

CREATE INDEX `FK_classification_idx`
  ON DVD_Store.`Movie` (`classification_id` ASC);

CREATE INDEX `FK_rate_idx`
  ON DVD_Store.`Movie` (`rate_id` ASC);

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Supplier`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Supplier` (
  `id`   INT          NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Stock Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Stock Item`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Stock Item` (
  `id`           INT         NOT NULL AUTO_INCREMENT,
  `catalog_id`   VARCHAR(20) NOT NULL,
  `supplier_id`  INT         NOT NULL,
  `date_aquired` DATETIME    NULL,
  `cost`         INT         NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Stock_catalogue`
  FOREIGN KEY (`catalog_id`)
  REFERENCES DVD_Store.`Movie` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Stock_supplier`
  FOREIGN KEY (`supplier_id`)
  REFERENCES DVD_Store.`Supplier` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX `FK_catalogue_idx`
  ON DVD_Store.`Stock Item` (`catalog_id` ASC);

CREATE INDEX `FK_supplier_idx`
  ON DVD_Store.`Stock Item` (`supplier_id` ASC);

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Member`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Member` (
  `id`          INT          NOT NULL,
  `first_name`  VARCHAR(60)  NOT NULL,
  `last_name`   VARCHAR(60)  NOT NULL,
  `address`     VARCHAR(100) NOT NULL,
  `phone`       VARCHAR(30)  NULL,
  `email`       VARCHAR(60)  NULL,
  `dob`         DATE         NULL,
  `max_rentals` INT          NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Rental`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Rental` (
  `id`          INT          NOT NULL AUTO_INCREMENT,
  `stock_id`    INT          NOT NULL,
  `member_id`   INT          NOT NULL,
  `issue_date`  DATETIME     NOT NULL,
  `return_date` DATETIME     NOT NULL,
  `notes`       VARCHAR(255) NOT NULL,
  `charge`      INT          NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Rental_stock`
  FOREIGN KEY (`stock_id`)
  REFERENCES DVD_Store.`Stock Item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Rental_member`
  FOREIGN KEY (`member_id`)
  REFERENCES DVD_Store.`Member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX `FK_stock_idx`
  ON DVD_Store.`Rental` (`stock_id` ASC);

CREATE INDEX `FK_member_idx`
  ON DVD_Store.`Rental` (`member_id` ASC);

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Reservation`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Reservation` (
  `id`             INT         NOT NULL AUTO_INCREMENT,
  `catalogue_id`   VARCHAR(45) NOT NULL,
  `member_id`      INT         NOT NULL,
  `date_requested` DATETIME    NOT NULL,
  `date_issued`    DATETIME    NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Reservation_catalogue`
  FOREIGN KEY (`catalogue_id`)
  REFERENCES DVD_Store.`Movie` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Reservation_member`
  FOREIGN KEY (`member_id`)
  REFERENCES DVD_Store.`Member` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX `FK_catalogue_idx`
  ON DVD_Store.`Reservation` (`catalogue_id` ASC);

CREATE INDEX `FK_member_idx`
  ON DVD_Store.`Reservation` (`member_id` ASC);

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Actor`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Actor` (
  `id`        INT         NOT NULL AUTO_INCREMENT,
  `name`      VARCHAR(60) NOT NULL,
  `biography` LONGTEXT    NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Review`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Review` (
  `id`           INT         NOT NULL AUTO_INCREMENT,
  `catalogue_id` VARCHAR(20) NOT NULL,
  `text`         LONGTEXT    NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Review_catalogue`
  FOREIGN KEY (`catalogue_id`)
  REFERENCES DVD_Store.`Movie` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX `FK_catalogue_idx`
  ON DVD_Store.`Review` (`catalogue_id` ASC);

-- -----------------------------------------------------
-- Table `DVD_Store_Schema`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS DVD_Store.`Role`;

CREATE TABLE IF NOT EXISTS DVD_Store.`Role` (
  `actor_id`     INT         NOT NULL,
  `catalogue_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`actor_id`, `catalogue_id`),
  CONSTRAINT `FK_Role_actor`
  FOREIGN KEY (`actor_id`)
  REFERENCES DVD_Store.`Actor` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Role_catalogue`
  FOREIGN KEY (`catalogue_id`)
  REFERENCES DVD_Store.`Movie` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX `FK_catalogue_idx`
  ON DVD_Store.`Role` (`catalogue_id` ASC);


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
