CREATE TABLE `shopping_cart_cd` (
    `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` VARCHAR(10) NOT NULL,
    `product_quantity` INT NOT NULL,
    `product_price` BIGINT NOT NULL,
    `checkout` TINYINT(1) NOT NULL,
    `updated_at` BIGINT NOT NULL,
    PRIMARY KEY (`customer_id`),
    UNIQUE KEY `shopping_cart_cd_product_id_unique` (`product_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer_cd` (`customer_id`),
    FOREIGN KEY (`product_id`) REFERENCES `prod_inventory_cd` (`product_id`)
);
