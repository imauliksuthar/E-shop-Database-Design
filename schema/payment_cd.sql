CREATE TABLE `payment_cd` (
    `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name_on_card` VARCHAR(50) NOT NULL,
    `card_number` VARCHAR(16) NOT NULL,
    `card_type` VARCHAR(50) NOT NULL,
    `expiry_month` INT NOT NULL,
    `expiry_year` INT NOT NULL,
    `cvv` VARCHAR(3) NOT NULL,
    `amount` DECIMAL(8, 2) NOT NULL,
    `iscompleted` TINYINT(1) NOT NULL,
    `isrefund` TINYINT(1) NOT NULL,
    PRIMARY KEY (`payment_id`)
);