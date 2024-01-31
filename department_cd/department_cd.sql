--department table--

CREATE TABLE IF NOT EXISTS `department_cd`(
    `deprt_id` VARCHAR(6) NOT NULL PRIMARY KEY,
    `department_name` VARCHAR(30) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--trigger

DELIMITER //

CREATE TRIGGER before_insert_department_cd 
BEFORE INSERT ON department_cd FOR EACH ROW 
BEGIN
    SET NEW.deprt_id = CONCAT('DEP', LPAD(
        COALESCE(
            (SELECT MAX(SUBSTRING(deprt_id, 4) + 1) 
             FROM department_cd), 
            1
        ),
        3, '0')
    );
END;

//

DELIMITER ;


--dummy data--
INSERT INTO
    `department_cd` (`department_name`)
VALUES
    ('Sales'),('Marketing'),('Deliveries'),('Accounting'),('Human Resources'),('Research and Development'),('Customer Support');