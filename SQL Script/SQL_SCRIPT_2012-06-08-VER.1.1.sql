SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `rdbshop` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `rdbshop` ;

-- -----------------------------------------------------
-- Table `rdbshop`.`customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `street` VARCHAR(255) NOT NULL ,
  `zip` INT NOT NULL ,
  `location` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`customer_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`payment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`payment` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `service` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`payment_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`order` (
  `order_id` INT UNSIGNED NULL AUTO_INCREMENT ,
  `customer_id` INT UNSIGNED NULL ,
  `date` DATETIME NULL ,
  `payment_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`order_id`, `customer_id`, `payment_id`) ,
  INDEX `fk_customer_id` (`customer_id` ASC) ,
  INDEX `fk_payment_id` (`payment_id` ASC) ,
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`customer_id` )
    REFERENCES `rdbshop`.`customer` (`customer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_id`
    FOREIGN KEY (`payment_id` )
    REFERENCES `rdbshop`.`payment` (`payment_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`orderitem`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`orderitem` (
  `amount` VARCHAR(45) NULL DEFAULT '1' ,
  `product_id` INT UNSIGNED NULL ,
  `order_id` INT UNSIGNED NULL ,
  `session` VARCHAR(45) NULL ,
  PRIMARY KEY (`product_id`, `order_id`) ,
  INDEX `fk_order_id` (`order_id` ASC) ,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id` )
    REFERENCES `rdbshop`.`order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`producer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`producer` (
  `producer_name` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(255) NULL ,
  PRIMARY KEY (`producer_name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`category` (
  `category_name` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(255) NULL ,
  PRIMARY KEY (`category_name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rdbshop`.`product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rdbshop`.`product` (
  `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `price` INT NOT NULL ,
  `producer_name` VARCHAR(45) NOT NULL ,
  `details` VARCHAR(255) NULL ,
  `category_name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`product_id`, `producer_name`, `category_name`) ,
  INDEX `fk_orderitem` (`product_id` ASC) ,
  INDEX `fk_producer_name` (`producer_name` ASC) ,
  INDEX `fk_category` (`category_name` ASC) ,
  CONSTRAINT `fk_orderitem`
    FOREIGN KEY (`product_id` )
    REFERENCES `rdbshop`.`orderitem` (`product_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producer_name`
    FOREIGN KEY (`producer_name` )
    REFERENCES `rdbshop`.`producer` (`producer_name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category`
    FOREIGN KEY (`category_name` )
    REFERENCES `rdbshop`.`category` (`category_name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
