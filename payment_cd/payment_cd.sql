CREATE TABLE IF NOT EXISTS `payment_cd`(
    `payment_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `name_on_card` VARCHAR(50) NOT NULL,
    `card_number` VARCHAR(16) NOT NULL,
    `card_type` VARCHAR(50) NOT NULL,
    `expiry_month` INT NOT NULL,
    `expiry_year` INT NOT NULL,
    `cvv` VARCHAR(3) NOT NULL,
    `amount` DECIMAL(8, 2) NOT NULL,
    `iscompleted` BOOLEAN NOT NULL,
    `isrefund` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--trigger--

DELIMITER //

CREATE TRIGGER before_insert_payment_cd
BEFORE INSERT ON payment_cd
FOR EACH ROW
BEGIN
    DECLARE next_payment_id INT;
    
    SELECT IFNULL(MAX(SUBSTRING(payment_id, 9, 5)), 0) + 1 INTO next_payment_id
    FROM payment_cd
    WHERE SUBSTRING(payment_id, 4, 4) = DATE_FORMAT(NEW.created_at, '%y%m');

    SET NEW.payment_id = CONCAT('PMT', DATE_FORMAT(NEW.created_at, '%y%m'), LPAD(next_payment_id, 5, '0'));
END;

//

DELIMITER ;

--dummy data--

INSERT INTO `payment_cd` (`name_on_card`, `card_number`, `card_type`, `expiry_month`, `expiry_year`, `cvv`, `amount`, `iscompleted`, `isrefund`)
VALUES
    ('John A. Doe', '1234567812345678', 'Visa', 12, 2025, '123', 50.00, true, false),
    ('Jane M. Smith', '9876543210987654', 'MasterCard', 10, 2024, '456', 75.99, true, false),
    ('Alice Johnson', '1111222233334444', 'American Express', 8, 2023, '789', 30.50, true, false),
    ('Bob B. Miller', '5555666677778888', 'Discover', 5, 2022, '321', 100.75, true, false),
    ('Eva Brown', '4444333322221111', 'Visa', 6, 2023, '555', 45.20, true, false),
    ('John A. Doe', '9876123412345678', 'MasterCard', 9, 2024, '987', 65.80, true, false),
    ('Alice Johnson', '8765987654321098', 'American Express', 11, 2022, '234', 85.50, true, false),
    ('Bob B. Miller', '3333444455556666', 'Discover', 3, 2025, '678', 120.00, true, false),
    ('Eva Brown', '1111222233344444', 'Visa', 7, 2023, '456', 25.30, true, false),
    ('Jane M. Smith', '9999888877776666', 'MasterCard', 2, 2022, '890', 95.25, true, false);
