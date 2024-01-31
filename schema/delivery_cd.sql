CREATE TABLE `delivery_cd` (
    `dispatched_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tracking_number` DATETIME NOT NULL,
    `dispatched_date` DATETIME NOT NULL,
    `delivery_status_kwd` VARCHAR(255) NOT NULL,
    `delivered_date` DATETIME NOT NULL,
    `employee_id` INT NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`dispatched_id`),
    UNIQUE KEY `delivery_cd_delivery_status_kwd_unique` (`delivery_status_kwd`),
    FOREIGN KEY (`employee_id`) REFERENCES `prod_inventory_cd` (`employee_id`),
    FOREIGN KEY (`delivery_status_kwd`) REFERENCES `delivery_status_cd` (`delivery_status_kwd`)
);