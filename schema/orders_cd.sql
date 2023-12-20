CREATE TABLE `orders_cd` (
    `order_id` INT NOT NULL AUTO_INCREMENT,
    `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` VARCHAR(10) NOT NULL,
    `product_quantity` INT NOT NULL,
    `product_price` DECIMAL(10, 2) NOT NULL,
    `ordered_date` DATETIME NOT NULL,
    `employee_id` INT NOT NULL,
    PRIMARY KEY (`order_id`),
    UNIQUE KEY `orders_cd_customer_id_unique` (`customer_id`),
    UNIQUE KEY `orders_cd_product_id_unique` (`product_id`),
    UNIQUE KEY `orders_cd_employee_id_unique` (`employee_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer_cd` (`customer_id`),
    FOREIGN KEY (`employee_id`) REFERENCES `employee_cd` (`employee_id`),
    FOREIGN KEY (`product_id`) REFERENCES `prod_inventory_cd` (`product_id`)
);