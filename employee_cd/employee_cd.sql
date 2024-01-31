
CREATE TABLE IF NOT EXISTS `employee_cd`(
    `employee_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `first_name` VARCHAR(50) NULL,
    `middle_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NULL,
    `deprt_id` VARCHAR(6) NULL,
    `emp_level` INT NOT NULL,
    `email_id` VARCHAR(50) NULL,
    `date_of_birth` DATE NULL,
    `phone_number` VARCHAR(9) NULL,
    `start_date` DATE NULL,
    `end_date` DATE NULL,
    `salary` DECIMAL(8, 2) NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`deprt_id`) REFERENCES `department_cd`(`deprt_id`)
);

--trigger--
DELIMITER //

CREATE TRIGGER before_insert_employee_cd BEFORE
INSERT ON employee_cd FOR EACH ROW
BEGIN
    SET NEW.employee_id = CONCAT(
        'E',
        DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            COALESCE(
                (SELECT IFNULL(MAX(SUBSTRING(employee_id, 7)) + 1, 1)
                 FROM employee_cd
                 WHERE SUBSTRING(employee_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')),
                1
            ),
            5,
            '0'
        )
    );
END;

//

DELIMITER ;


--Dummy Data--
INSERT INTO `employee_cd` (`first_name`,`middle_name`,`last_name`,`deprt_id`,`emp_level`,`email_id`,`date_of_birth`,`phone_number`,`start_date`,`end_date`,`salary`) 
VALUES
    ('John', 'A', 'Doe', 'DEP001', 1, 'john.doe@company.com', '1985-05-10', '123456789', '2022-01-01', NULL, 60000.00),
    ('Jane', 'M', 'Smith', 'DEP002', 2, 'jane.smith@company.com', '1990-08-22', '987654321', '2022-02-01', NULL, 75000.00),
    ('Bob', 'B', 'Miller', 'DEP003', 3, 'bob.miller@company.com', '1988-11-15', '111222333', '2022-03-01', NULL, 90000.00),
    ('Alice', 'C', 'Johnson', 'DEP004', 1, 'alice.johnson@company.com', '1992-03-05', '555888999', '2022-04-01', NULL, 80000.00),
    ('Eva', 'D', 'Brown', 'DEP005', 2, 'eva.brown@company.com', '1995-12-03', '333444555', '2022-05-01', NULL, 70000.00),
    ('Chris', 'E', 'Wilson', 'DEP006', 3, 'chris.wilson@company.com', '1987-06-18', '999111222', '2022-06-01', NULL, 85000.00),
    ('Sophia', 'F', 'Davis', 'DEP007', 1, 'sophia.davis@company.com', '1993-09-25', '777444888', '2022-07-01', NULL, 95000.00),
    ('Michael', 'G', 'Johnson', 'DEP001', 2, 'michael.johnson@company.com', '1991-02-20', '666333999', '2022-08-01', NULL, 70000.00),
    ('Emma', 'H', 'Taylor', 'DEP002', 3, 'emma.taylor@company.com', '1984-04-12', '222555777', '2022-09-01', NULL, 80000.00),
    ('Matthew', 'I', 'Anderson', 'DEP003', 1, 'matthew.anderson@company.com', '1989-07-07', '444777999', '2022-10-01', NULL, 90000.00),
    ('Olivia', 'J', 'Thomas', 'DEP004', 2, 'olivia.thomas@company.com', '1996-10-30', '555666777', '2022-11-01', NULL, 75000.00),
    ('Daniel', 'K', 'Harris', 'DEP005', 3, 'daniel.harris@company.com', '1986-12-15', '111444666', '2022-12-01', NULL, 85000.00),
    ('Ava', 'L', 'Brown', 'DEP006', 1, 'ava.brown@company.com', '1994-01-05', '333555777', '2023-01-01', NULL, 95000.00),
    ('Logan', 'M', 'Wilson', 'DEP007', 2, 'logan.wilson@company.com', '1997-04-18', '666999111', '2023-02-01', NULL, 70000.00),
    ('Mia', 'N', 'Evans', 'DEP001', 3, 'mia.evans@company.com', '1988-06-23', '888777555', '2023-03-01', NULL, 80000.00),
    ('James', 'O', 'Johnson', 'DEP002', 1, 'james.johnson@company.com', '1990-09-12', '222555888', '2023-04-01', NULL, 90000.00),
    ('Grace', 'P', 'Robinson', 'DEP003', 2, 'grace.robinson@company.com', '1985-11-30', '444666888', '2023-05-01', NULL, 75000.00),
    ('William', 'Q', 'Martin', 'DEP004', 3, 'william.martin@company.com', '1993-02-15', '555777999', '2023-06-01', NULL, 85000.00),
    ('Lily', 'R', 'Hill', 'DEP005', 1, 'lily.hill@company.com', '1987-04-08', '111333777', '2023-07-01', NULL, 95000.00),
    ('Henry', 'S', 'Cooper', 'DEP006', 2, 'henry.cooper@company.com', '1995-07-25', '333555777', '2023-08-01', NULL, 70000.00),
    ('Chloe', 'T', 'Rogers', 'DEP007', 3, 'chloe.rogers@company.com', '1989-10-20', '666888999', '2023-09-01', NULL, 80000.00),
    ('Noah', 'U', 'Carter', 'DEP001', 1, 'noah.carter@company.com', '1991-01-15', '888777555', '2023-10-01', NULL, 90000.00),
    ('Sophie', 'V', 'Ward', 'DEP002', 2, 'sophie.ward@company.com', '1996-04-28', '222555777', '2023-11-01', NULL, 75000.00),
    ('Ethan', 'W', 'Hayes', 'DEP003', 3, 'ethan.hayes@company.com', '1984-07-10', '444666888', '2023-12-01', NULL, 85000.00),
    ('Isabella', 'X', 'Stewart', 'DEP004', 1, 'isabella.stewart@company.com', '1992-09-25', '555777999', '2024-01-01', NULL, 95000.00),
    ('Mason', 'Y', 'Fisher', 'DEP005', 2, 'mason.fisher@company.com', '1997-12-08', '111333777', '2024-02-01', NULL, 70000.00),
    ('Aria', 'Z', 'Miller', 'DEP006', 3, 'aria.miller@company.com', '1986-02-20', '333555777', '2024-03-01', NULL, 80000.00),
    ('Liam', 'AA', 'Brown', 'DEP007', 1, 'liam.brown@company.com', '1994-05-05', '666888999', '2024-04-01', NULL, 90000.00),
    ('Lory', 'Z', 'Green', 'DEP001', 1, 'lorry.green@company.com', '1990-05-05', '666880999', '2024-01-01', NULL, 90000.00);
