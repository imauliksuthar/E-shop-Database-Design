CREATE TABLE `employee_cd` (
    `employee_id` INT UNSIGNED NULL AUTO_INCREMENT,
    `first_name` VARCHAR(50) NULL,
    `middle_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NULL,
    `deprt_id` INT NULL,
    `emp_level` INT NOT NULL,
    `email_id` VARCHAR(50) NULL,
    `date_of_birth` DATE NULL,
    `phone_number` VARCHAR(9) NULL,
    `start_date` DATE NULL,
    `end_date` DATE NULL,
    `salary` DECIMAL(8, 2) NULL,
    `created_at` DATETIME NULL,
    PRIMARY KEY (`employee_id`),
    UNIQUE KEY `employee_cd_deprt_id_unique` (`deprt_id`),
    FOREIGN KEY (`deprt_id`) REFERENCES `department_cd` (`deprt_id`)
);