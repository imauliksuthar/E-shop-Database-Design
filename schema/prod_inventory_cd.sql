CREATE TABLE `prod_inventory_cd` (
    `product_id` VARCHAR(10) NOT NULL,
    `product_title` VARCHAR(100) NOT NULL,
    `product_type` BIGINT NOT NULL,
    `prod_genre` VARCHAR(12) NOT NULL,
    `product_language` VARCHAR(20) NOT NULL,
    `prod_description` VARCHAR(200) NOT NULL,
    `prod_units` INT NOT NULL,
    `prod_price` BIGINT NOT NULL,
    `employee_id` INT NOT NULL,
    `cretaed_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL,
    PRIMARY KEY (`product_id`),
    UNIQUE KEY `prod_inventory_cd_employee_id_unique` (`employee_id`),
    FOREIGN KEY (`employee_id`) REFERENCES `employee_cd` (`employee_id`)
);