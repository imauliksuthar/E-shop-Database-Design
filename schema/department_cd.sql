-- This table represents the departments in the company.

CREATE TABLE `department_cd` (
    `deprt_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `department_name` VARCHAR(30) NOT NULL,
    `department_head` INT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`deprt_id`),
    FOREIGN KEY (`department_head`) REFERENCES `employee_cd` (`employee_id`)
);