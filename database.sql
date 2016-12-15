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
##  CREATE Actor Procedure
--
--  Parameters:
--    name:       VARCHAR(60)
--    biography:  LONGTEXT
--
--  Example Usage:
--    actor_create('Mads Mikkelsen', 'This could be a biography.');

DROP PROCEDURE IF EXISTS actor_create;

DELIMITER //

CREATE PROCEDURE actor_create(IN inName VARCHAR(60), IN inBiography LONGTEXT)
  BEGIN
    INSERT INTO Actor (name, biography) VALUES (inName, inBiography);
  END

//

DELIMITER ;


##  DELETE Actor Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    actor_delete(1);

DROP PROCEDURE IF EXISTS actor_delete;

DELIMITER //

CREATE PROCEDURE actor_delete(IN inId INT)
  BEGIN
    DELETE FROM Actor WHERE Actor.id = inId;
  END

//

DELIMITER ;


##  READ Actor Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    actor_read(NULL); // Returns all actors
--    actor_read(1); // Returns actor with ID = 1

DROP PROCEDURE IF EXISTS actor_read;

DELIMITER //

CREATE PROCEDURE actor_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Actor.id   AS 'ID',
        Actor.name AS 'Actor Name',
        Actor.biography AS 'Actor Biography'
      FROM Actor
      WHERE 1;
    ELSE
      SELECT
        Actor.id   AS 'ID',
        Actor.name AS 'Actor Name',
        Actor.biography AS 'Actor Biography'
      FROM Actor
      WHERE Actor.id = inId;
    END IF;
  END

//

DELIMITER ;


##  UPDATE Actor Procedure
--
--  Parameters:
--    id: INT
--    name:       VARCHAR(60)
--    biography:  LONGTEXT
--
--  Example Usage:
--    actor_update(1, 'Matt Damon', 'The one true martian.');

DROP PROCEDURE IF EXISTS actor_update;

DELIMITER //

CREATE PROCEDURE actor_update(IN inId INT, IN inName VARCHAR(60), inBiography LONGTEXT)
  BEGIN
    UPDATE Actor
    SET
      Actor.name      = inName,
      Actor.biography = inBiography
    WHERE Actor.id = inId;
  END

//

DELIMITER ;


##  CREATE Rate Procedure
--
--  Parameters:
--    rate: FLOAT
--
--  Example Usage:
--    rate_create(7.50);

DROP PROCEDURE IF EXISTS rate_create;

DELIMITER //

CREATE PROCEDURE rate_create(IN inRate FLOAT)
  BEGIN
    INSERT INTO Rate (rate) VALUES (inRate);
  END

//

DELIMITER ;


##  DELETE Rate Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    rate_delete(1);

DROP PROCEDURE IF EXISTS rate_delete;

DELIMITER //

CREATE PROCEDURE rate_delete(IN inId INT)
  BEGIN
    DELETE FROM Rate WHERE Rate.id = inId;
  END

//

DELIMITER ;


##  READ Rate Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    rate_read(NULL); // Returns all rates
--    rate_read(1); // Returns rate with ID = 1

DROP PROCEDURE IF EXISTS rate_read;

DELIMITER //

CREATE PROCEDURE rate_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Rate.id   AS 'ID',
        Rate.rate AS 'Daily Rate'
      FROM Rate
      WHERE 1;
    ELSE
      SELECT
        Rate.id   AS 'ID',
        Rate.rate AS 'Daily Rate'
      FROM Rate
      WHERE Rate.id = inId;
    END IF;
  END

//

DELIMITER ;


##  UPDATE Rate Procedure
--
--  Parameters:
--    id: INT
--    rate: FLOAT
--
--  Example Usage:
--    rate_update(1, 5.50);

DROP PROCEDURE IF EXISTS rate_update;

DELIMITER //

CREATE PROCEDURE rate_update(IN inId INT, IN inRate FLOAT)
  BEGIN
    UPDATE Rate
    SET Rate.rate = inRate
    WHERE Rate.id = inId;
  END

//

DELIMITER ;


##  CREATE Studio Procedure
--
--  Parameters:
--    name: VARCHAR(45)
--
--  Example Usage:
--    studio_create('Paramount Pictures');

DROP PROCEDURE IF EXISTS studio_create;

DELIMITER //

CREATE PROCEDURE studio_create(IN inName VARCHAR(45))
  BEGIN
    INSERT INTO Studio (name) VALUES (inName);
  END

//

DELIMITER ;


##  DELETE Studio Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    studio_delete(1);

DROP PROCEDURE IF EXISTS studio_delete;

DELIMITER //

CREATE PROCEDURE studio_delete(IN inId INT)
  BEGIN
    DELETE FROM Studio WHERE Studio.id = inId;
  END

//

DELIMITER ;


##  READ Studio Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    studio_read(NULL); // Returns all studios
--    studio_read(1); // Returns studio with ID = 1

DROP PROCEDURE IF EXISTS studio_read;

DELIMITER //

CREATE PROCEDURE studio_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Studio.id   AS 'ID',
        Studio.name AS 'Studio Name'
      FROM Studio
      WHERE 1;
    ELSE
      SELECT
        Studio.id   AS 'ID',
        Studio.name AS 'Studio Name'
      FROM Studio
      WHERE Studio.id = inId;
    END IF;
  END

//

DELIMITER ;


##  UPDATE Studio Procedure
--
--  Parameters:
--    id:   INT
--    name: VARCHAR(45)
--
--  Example Usage:
--    studio_update(1, 'Twentieth Century Fox');

DROP PROCEDURE IF EXISTS studio_update;

DELIMITER //

CREATE PROCEDURE studio_update(IN inId INT, IN inName VARCHAR(45))
  BEGIN
    UPDATE Studio
    SET Studio.name = inName
    WHERE Studio.id = inId;
  END

//

DELIMITER ;


##  CREATE Supplier Procedure
--
--  Parameters:
--    name: VARCHAR(100)
--
--  Example Usage:
--    supplier_create('Amazon');

DROP PROCEDURE IF EXISTS supplier_create;

DELIMITER //

CREATE PROCEDURE supplier_create(IN inName VARCHAR(100))
  BEGIN
    INSERT INTO Supplier (name) VALUES (inName);
  END

//

DELIMITER ;

##  DELETE Supplier Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    supplier_delete(1);

DROP PROCEDURE IF EXISTS supplier_delete;

DELIMITER //

CREATE PROCEDURE supplier_delete(IN inId INT)
  BEGIN
    DELETE FROM Supplier WHERE Supplier.id = inId;
  END

//

DELIMITER ;

##  READ Supplier Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    supplier_delete(NULL); // Returns all suppliers
--    supplier_delete(1); // Returns supplier with ID = 1

DROP PROCEDURE IF EXISTS supplier_read;

DELIMITER //

CREATE PROCEDURE supplier_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Supplier.id   AS 'ID',
        Supplier.name AS 'Supplier Name'
      FROM Supplier
      WHERE 1;
    ELSE
      SELECT
        Supplier.id   AS 'ID',
        Supplier.name AS 'Supplier Name'
      FROM Supplier
      WHERE Supplier.id = inId;
    END IF;
  END

//

DELIMITER ;

##  UPDATE Supplier Procedure
--
--  Parameters:
--    id:   INT
--    name: VARCHAR(100)
--
--  Example Usage:
--    supplier_update(1, 'Amazon');

DROP PROCEDURE IF EXISTS supplier_update;

DELIMITER //

CREATE PROCEDURE supplier_update(IN inId INT, IN inName VARCHAR(100))
  BEGIN
    UPDATE Supplier
    SET Supplier.name = inName
    WHERE Supplier.id = inId;
  END

//

DELIMITER ;

