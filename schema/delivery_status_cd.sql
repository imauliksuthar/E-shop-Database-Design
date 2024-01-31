-- Create a table to store delivery status codes

CREATE TABLE `delivery_status_cd` (
    `delivery_status_kwd` VARCHAR(4) NOT NULL,
    `delivery_status_name` VARCHAR(10) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`delivery_status_kwd`)
);