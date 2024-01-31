-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `test` ;

-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `test` ;

-- -----------------------------------------------------
-- Table `test`.`customer_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`customer_cd` (
  `customer_id` VARCHAR(12) NOT NULL,
  `password` VARCHAR(12) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `email_id` VARCHAR(50) NOT NULL,
  `email_verified` TINYINT(1) NOT NULL DEFAULT '0',
  `phone_number` VARCHAR(50) NOT NULL,
  `ph_no_verified` TINYINT(1) NOT NULL DEFAULT '0',
  `gender` VARCHAR(6) NOT NULL,
  `house_no` VARCHAR(50) NOT NULL,
  `street_address` VARCHAR(50) NOT NULL,
  `street_address2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NOT NULL,
  `post_code` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `logged_in` TINYINT(1) NOT NULL DEFAULT '0',
  `otp_generated` VARCHAR(6) NOT NULL,
  `otp_generated_at` DATETIME NOT NULL,
  `is_otp_verified` TINYINT(1) NOT NULL,
  `last_activity` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `test`.`department_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`department_cd` (
  `deprt_id` VARCHAR(6) NOT NULL,
  `department_name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`deprt_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `test`.`employee_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`employee_cd` (
  `employee_id` VARCHAR(12) NOT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `middle_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `deprt_id` VARCHAR(6) NULL DEFAULT NULL,
  `emp_level` INT NOT NULL,
  `email_id` VARCHAR(50) NULL DEFAULT NULL,
  `date_of_birth` DATE NULL DEFAULT NULL,
  `phone_number` VARCHAR(9) NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `salary` DECIMAL(8,2) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `employee_cd_ibfk_1`
    FOREIGN KEY (`deprt_id`)
    REFERENCES `test`.`department_cd` (`deprt_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `deprt_id` ON `test`.`employee_cd` (`deprt_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`delivery_status_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`delivery_status_cd` (
  `delivery_status_kwd` VARCHAR(10) NOT NULL,
  `delivery_status_name` VARCHAR(20) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`delivery_status_kwd`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `delivery_status_cd_index` USING BTREE ON `test`.`delivery_status_cd` (`delivery_status_kwd`) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`delivery_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`delivery_cd` (
  `dispatched_id` INT NOT NULL,
  `tracking_number` VARCHAR(20) NOT NULL,
  `dispatched_date` TIMESTAMP NOT NULL,
  `delivery_status_kwd` VARCHAR(10) NOT NULL,
  `delivered_date` DATETIME NOT NULL,
  `employee_id` VARCHAR(12) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dispatched_id`),
  CONSTRAINT `delivery_cd_ibfk_1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `test`.`employee_cd` (`employee_id`),
  CONSTRAINT `delivery_cd_ibfk_2`
    FOREIGN KEY (`delivery_status_kwd`)
    REFERENCES `test`.`delivery_status_cd` (`delivery_status_kwd`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `employee_id` ON `test`.`delivery_cd` (`employee_id` ASC) VISIBLE;

CREATE INDEX `delivery_cd_index` USING BTREE ON `test`.`delivery_cd` (`delivery_status_kwd`, `employee_id`) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`product_type_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`product_type_cd` (
  `prod_type_kwd` VARCHAR(11) NOT NULL,
  `prod_type_name` VARCHAR(60) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `product_type_cd_index` USING BTREE ON `test`.`product_type_cd` (`prod_type_kwd`) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`prod_inventory_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`prod_inventory_cd` (
  `product_id` VARCHAR(20) NOT NULL,
  `product_title` VARCHAR(100) NOT NULL,
  `prod_type_kwd` VARCHAR(11) NOT NULL,
  `prod_genre` VARCHAR(30) NOT NULL,
  `prod_language` VARCHAR(20) NOT NULL,
  `prod_description` VARCHAR(200) NOT NULL,
  `prod_units` INT NOT NULL,
  `prod_price` BIGINT NOT NULL,
  `employee_id` VARCHAR(12) NOT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `prod_inventory_cd_ibfk_1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `test`.`employee_cd` (`employee_id`),
  CONSTRAINT `prod_inventory_cd_ibfk_2`
    FOREIGN KEY (`prod_type_kwd`)
    REFERENCES `test`.`product_type_cd` (`prod_type_kwd`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `employee_id` ON `test`.`prod_inventory_cd` (`employee_id` ASC) VISIBLE;

CREATE INDEX `prod_inventory_cd_index` USING BTREE ON `test`.`prod_inventory_cd` (`prod_type_kwd`, `prod_genre`) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`orders_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`orders_cd` (
  `order_id` VARCHAR(12) NOT NULL,
  `customer_id` VARCHAR(12) NOT NULL,
  `product_id` VARCHAR(20) NOT NULL,
  `product_quantity` INT NOT NULL,
  `product_price` DECIMAL(10,2) NOT NULL,
  `employee_id` VARCHAR(12) NOT NULL,
  `ordered_date` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `orders_cd_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `test`.`customer_cd` (`customer_id`),
  CONSTRAINT `orders_cd_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `test`.`prod_inventory_cd` (`product_id`),
  CONSTRAINT `orders_cd_ibfk_3`
    FOREIGN KEY (`employee_id`)
    REFERENCES `test`.`employee_cd` (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `product_id` ON `test`.`orders_cd` (`product_id` ASC) VISIBLE;

CREATE INDEX `employee_id` ON `test`.`orders_cd` (`employee_id` ASC) VISIBLE;

CREATE INDEX `orders_cd_index` USING BTREE ON `test`.`orders_cd` (`customer_id`, `product_id`, `employee_id`, `ordered_date`) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`payment_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`payment_cd` (
  `payment_id` VARCHAR(12) NOT NULL,
  `name_on_card` VARCHAR(50) NOT NULL,
  `card_number` VARCHAR(16) NOT NULL,
  `card_type` VARCHAR(50) NOT NULL,
  `expiry_month` INT NOT NULL,
  `expiry_year` INT NOT NULL,
  `cvv` VARCHAR(3) NOT NULL,
  `amount` DECIMAL(8,2) NOT NULL,
  `iscompleted` TINYINT(1) NOT NULL,
  `isrefund` TINYINT(1) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `test`.`invoice_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`invoice_cd` (
  `invoice_id` VARCHAR(12) NOT NULL,
  `order_id` VARCHAR(12) NOT NULL,
  `payment_id` VARCHAR(12) NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `dispatched_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `invoice_cd_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `test`.`orders_cd` (`order_id`),
  CONSTRAINT `invoice_cd_ibfk_2`
    FOREIGN KEY (`payment_id`)
    REFERENCES `test`.`payment_cd` (`payment_id`),
  CONSTRAINT `invoice_cd_ibfk_3`
    FOREIGN KEY (`dispatched_id`)
    REFERENCES `test`.`delivery_cd` (`dispatched_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `dispatched_id` ON `test`.`invoice_cd` (`dispatched_id` ASC) VISIBLE;

CREATE INDEX `invoice_cd_index` USING BTREE ON `test`.`invoice_cd` (`order_id`, `payment_id`, `dispatched_id`) VISIBLE;

CREATE INDEX `invoice_cd_ibfk_2` ON `test`.`invoice_cd` (`payment_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `test`.`shopping_cart_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`shopping_cart_cd` (
  `cart_id` VARCHAR(12) NOT NULL,
  `customer_id` VARCHAR(12) NOT NULL,
  `product_id` VARCHAR(20) NOT NULL,
  `product_quantity` INT NOT NULL,
  `product_price` DECIMAL(8,2) NOT NULL,
  `checkout` TINYINT(1) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  CONSTRAINT `shopping_cart_cd_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `test`.`customer_cd` (`customer_id`),
  CONSTRAINT `shopping_cart_cd_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `test`.`prod_inventory_cd` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `customer_id` ON `test`.`shopping_cart_cd` (`customer_id` ASC) VISIBLE;

CREATE INDEX `product_id` ON `test`.`shopping_cart_cd` (`product_id` ASC) VISIBLE;

USE `test`;

DELIMITER $$
USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_customer_cd`
BEFORE INSERT ON `test`.`customer_cd`
FOR EACH ROW
BEGIN
   SET NEW.customer_id = CONCAT('C', DATE_FORMAT(NOW(), '%y%m'), LPAD((SELECT IFNULL(MAX(SUBSTRING(customer_id, 7)) + 1, 1) FROM customer_cd WHERE SUBSTRING(customer_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')), 5, '0'));
END$$

USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_employee_cd`
BEFORE INSERT ON `test`.`employee_cd`
FOR EACH ROW
BEGIN
   SET NEW.employee_id = CONCAT('E', DATE_FORMAT(NOW(), '%y%m'), LPAD((SELECT IFNULL(MAX(SUBSTRING(employee_id, 7)) + 1, 1) FROM employee_cd WHERE SUBSTRING(employee_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')), 5, '0'));
END$$

USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_product_type_cd`
BEFORE INSERT ON `test`.`product_type_cd`
FOR EACH ROW
BEGIN
SET
    NEW.prod_type_kwd = CONCAT(
        SUBSTRING(NEW.prod_type_name, 1, 3),
        DATE_FORMAT(NOW(), '%y'),
        LPAD(
            (
                SELECT
                    IFNULL(MAX(SUBSTRING(prod_type_kwd, 7)) + 1, 1)
                FROM
                    product_type_cd
                WHERE
                    SUBSTRING(prod_type_kwd, 4, 2) = DATE_FORMAT(NOW(), '%y')
            ),
            6,
            '0'
        )
    );

END$$

USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_prod_inventory_cd`
BEFORE INSERT ON `test`.`prod_inventory_cd`
FOR EACH ROW
BEGIN
SET
    NEW.product_id = CONCAT(
        'P',
        DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            (
                SELECT
                    IFNULL(MAX(SUBSTRING(product_id, 7)) + 1, 1)
                FROM
                    prod_inventory_cd
                WHERE
                    SUBSTRING(product_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')
            ),
            5,
            '0'
        )
    );

END$$

USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_orders_cd`
BEFORE INSERT ON `test`.`orders_cd`
FOR EACH ROW
BEGIN
    SET NEW.order_id = CONCAT(
        'O',
        DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            (
                SELECT IFNULL(MAX(SUBSTRING(order_id, 7)) + 1, 1)
                FROM orders_cd
                WHERE SUBSTRING(order_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')
            ), 5, '0')
    );
END$$

USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_payment_cd`
BEFORE INSERT ON `test`.`payment_cd`
FOR EACH ROW
BEGIN
    DECLARE next_payment_id INT;
    
    SELECT IFNULL(MAX(SUBSTRING(payment_id, 9, 5)), 0) + 1 INTO next_payment_id
    FROM payment_cd
    WHERE SUBSTRING(payment_id, 4, 4) = DATE_FORMAT(NEW.created_at, '%y%m');

    SET NEW.payment_id = CONCAT('PMT', DATE_FORMAT(NEW.created_at, '%y%m'), LPAD(next_payment_id, 5, '0'));
END$$

USE `test`$$
CREATE
DEFINER=`admin`@`localhost`
TRIGGER `test`.`before_insert_invoice_cd`
BEFORE INSERT ON `test`.`invoice_cd`
FOR EACH ROW
BEGIN
    DECLARE next_invoice_id INT;
    
    SELECT IFNULL(MAX(SUBSTRING(invoice_id, 9, 5)), 0) + 1 INTO next_invoice_id
    FROM invoice_cd
    WHERE SUBSTRING(invoice_id, 4, 4) = DATE_FORMAT(NEW.created_at, '%y%m');

    SET NEW.invoice_id = CONCAT('INV', DATE_FORMAT(NEW.created_at, '%y%m'), LPAD(next_invoice_id, 5, '0'));
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
