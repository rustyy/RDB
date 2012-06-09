SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `rdbshop`.`product` DROP FOREIGN KEY `fk_orderitem` ;

ALTER TABLE `rdbshop`.`orderitem` DROP FOREIGN KEY `fk_order_id` ;

ALTER TABLE `rdbshop`.`product` 
DROP INDEX `fk_orderitem` ;

ALTER TABLE `rdbshop`.`orderitem` CHANGE COLUMN `amount` `amount` VARCHAR(45) NULL DEFAULT '1'  AFTER `order_id` , 
  ADD CONSTRAINT `fk_product_id`
  FOREIGN KEY (`product_id` )
  REFERENCES `rdbshop`.`product` (`product_id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, 
  ADD CONSTRAINT `fk_order_id`
  FOREIGN KEY (`order_id` )
  REFERENCES `rdbshop`.`order` (`order_id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, DROP PRIMARY KEY 
, ADD PRIMARY KEY (`order_id`, `product_id`) 
, ADD INDEX `fk_product_id` (`product_id` ASC) ;


-- -----------------------------------------------------
-- Placeholder table for view `rdbshop`.`list_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rdbshop`.`list_categories` (`category_name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `rdbshop`.`list_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rdbshop`.`list_customers` (`customer_id` INT, `firstname` INT, `lastname` INT, `street` INT, `zip` INT, `location` INT);

-- -----------------------------------------------------
-- Placeholder table for view `rdbshop`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rdbshop`.`view1` (`id` INT);


USE `rdbshop`;

-- -----------------------------------------------------
-- View `rdbshop`.`list_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rdbshop`.`list_categories`;
USE `rdbshop`;
CREATE  OR REPLACE VIEW `rdbshop`.`list_categories` AS SELECT category_name from category;
;


USE `rdbshop`;

-- -----------------------------------------------------
-- View `rdbshop`.`list_customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rdbshop`.`list_customers`;
USE `rdbshop`;
CREATE  OR REPLACE VIEW `rdbshop`.`list_customers` AS SELECT * FROM customer;
;


USE `rdbshop`;

-- -----------------------------------------------------
-- View `rdbshop`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rdbshop`.`view1`;
USE `rdbshop`;
;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
