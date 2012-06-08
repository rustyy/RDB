SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `rdbshop` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `rdbshop` ;

-- -----------------------------------------------------
-- Table `rdbshop`.`order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `customer_id` INT NOT NULL ,
  `date` DATETIME NOT NULL ,
  `payment_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `customer_id`, `payment_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`orderitem`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`orderitem` (
  `amount` VARCHAR(45) NULL DEFAULT '1' ,
  `product_id` INT NOT NULL ,
  `order_id` INT NOT NULL ,
  `session` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`product_id`) ,
  INDEX `fk_order_id` (`order_id` ASC) ,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id` )
    REFERENCES `rdbshop`.`order` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `price` INT NOT NULL ,
  `producer_name` VARCHAR(45) NOT NULL ,
  `details` VARCHAR(255) NULL ,
  `cat` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`, `producer_name`, `cat`) ,
  INDEX `fk_orderitem` (`id` ASC) ,
  CONSTRAINT `fk_orderitem`
    FOREIGN KEY (`id` )
    REFERENCES `rdbshop`.`orderitem` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `street` VARCHAR(255) NOT NULL ,
  `zip` INT NOT NULL ,
  `location` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_order` (`id` ASC) ,
  CONSTRAINT `fk_order`
    FOREIGN KEY (`id` )
    REFERENCES `rdbshop`.`order` (`customer_id` )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`category` (
  `name` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(255) NULL ,
  PRIMARY KEY (`name`) ,
  INDEX `fk_cat_name` (`name` ASC) ,
  CONSTRAINT `fk_cat_name`
    FOREIGN KEY (`name` )
    REFERENCES `rdbshop`.`product` (`cat` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`payment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `service` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_service` (`id` ASC) ,
  CONSTRAINT `fk_service`
    FOREIGN KEY (`id` )
    REFERENCES `rdbshop`.`order` (`payment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`producer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`producer` (
  `producer_name` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(255) NULL ,
  PRIMARY KEY (`producer_name`) ,
  INDEX `fk_producer_name` (`producer_name` ASC) ,
  CONSTRAINT `fk_producer_name`
    FOREIGN KEY (`producer_name` )
    REFERENCES `rdbshop`.`product` (`producer_name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
