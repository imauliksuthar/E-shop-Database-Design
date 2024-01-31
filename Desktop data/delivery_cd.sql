
CREATE TABLE IF NOT EXISTS `delivery_cd`(
    `dispatched_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `tracking_number` VARCHAR(20) NOT NULL,
    `dispatched_date` DATETIME NOT NULL,
    `delivery_status_kwd` VARCHAR(10) NOT NULL,
    `delivered_date` DATETIME NOT NULL,
    `employee_id` VARCHAR(12) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employee_cd`(`employee_id`),
    FOREIGN KEY (`delivery_status_kwd`) REFERENCES `delivery_status_cd`(`delivery_status_kwd`)
);

--index
CREATE INDEX delivery_cd_index USING BTREE ON delivery_cd (delivery_status_kwd, employee_id);

--trigger

DELIMITER //
CREATE TRIGGER before_insert_delivery_cd
BEFORE INSERT ON delivery_cd
FOR EACH ROW
BEGIN
    DECLARE next_dispatched_id INT;
    
    SELECT IFNULL(MAX(SUBSTRING(dispatched_id, 9, 5)), 0) + 1 INTO next_dispatched_id
    FROM delivery_cd
    WHERE SUBSTRING(dispatched_id, 4, 4) = DATE_FORMAT(NEW.created_at, '%y%m');

    SET NEW.dispatched_id = CONCAT('PMT', DATE_FORMAT(NEW.created_at, '%y%m'), LPAD(next_dispatched_id, 5, '0'));
END;
//
DELIMITER ;

--dummy data--

INSERT INTO `delivery_cd` (`tracking_number`, `dispatched_date`, `delivery_status_kwd`, `delivered_date`, `employee_id`)
VALUES
    ('TN240100001', '2024-06-01 12:15:00', 'PENDING', '2024-06-01 13:30:00', 'E240100003'),
    ('TN240100002', '2024-06-01 12:45:00', 'DELIVR', '2024-06-01 14:30:00', 'E240100017'),
    ('TN240100003', '2024-06-01 13:15:00', 'PROCESS', '2024-06-01 14:45:00', 'E240100010'),
    ('TN240100004', '2024-06-01 13:45:00', 'DELIVR', '2024-06-01 15:15:00', 'E240100017'),
    ('TN240100005', '2024-06-01 14:15:00', 'OUTDEL', '2024-06-01 15:45:00', 'E240100010'),
    ('TN240100006', '2024-06-01 14:45:00', 'DELIVR', '2024-06-01 16:15:00', 'E240100017'),
    ('TN240100007', '2024-06-01 15:15:00', 'OUTDEL', '2024-06-01 16:45:00', 'E240100010'),
    ('TN240100008', '2024-06-01 15:45:00', 'CANCEL', '2024-06-01 17:15:00', 'E240100024'),
    ('TN240100009', '2024-06-01 16:15:00', 'PROCESS', '2024-06-01 17:45:00', 'E240100017'),
    ('TN240100010', '2024-06-01 16:45:00', 'CANCEL', '2024-06-01 18:15:00', 'E240100024');