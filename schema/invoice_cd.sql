CREATE TABLE `invoice_cd` (
    `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `invoice_id` INT NULL AUTO_INCREMENT,
    `payment_id` INT NOT NULL,
    `total_amount` DECIMAL(10, 2) NOT NULL,
    `created_at` DATETIME NOT NULL,
    `dispatched_id` INT NOT NULL,
    PRIMARY KEY (`order_id`),
    UNIQUE KEY `invoice_cd_payment_id_unique` (`payment_id`),
    UNIQUE KEY `invoice_cd_dispatched_id_unique` (`dispatched_id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders_cd` (`order_id`),
    FOREIGN KEY (`payment_id`) REFERENCES `payment_cd` (`payment_id`),
    FOREIGN KEY (`dispatched_id`) REFERENCES `delivery_cd` (`dispatched_id`)
);