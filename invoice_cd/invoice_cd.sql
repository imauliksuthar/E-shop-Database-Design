CREATE TABLE IF NOT EXISTS `invoice_cd`(
    `invoice_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `order_id` VARCHAR(12) NOT NULL,
    `payment_id` VARCHAR(12) NOT NULL,
    `total_amount` DECIMAL(10, 2) NOT NULL,
    `dispatched_id` VARCHAR(12) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders_cd`(`order_id`),
    FOREIGN KEY (`payment_id`) REFERENCES `payment_cd`(`payment_id`),
    FOREIGN KEY (`dispatched_id`) REFERENCES `delivery_cd`(`dispatched_id`)
);

CREATE INDEX invoice_cd_index USING BTREE ON invoice_cd (order_id, payment_id,dispatched_id);

--trigger--

DELIMITER //

CREATE TRIGGER before_insert_invoice_cd
BEFORE INSERT ON invoice_cd
FOR EACH ROW
BEGIN
    DECLARE next_invoice_id INT;
    
    SELECT IFNULL(MAX(SUBSTRING(invoice_id, 9, 5)), 0) + 1 INTO next_invoice_id
    FROM invoice_cd
    WHERE SUBSTRING(invoice_id, 4, 4) = DATE_FORMAT(NEW.created_at, '%y%m');

    SET NEW.invoice_id = CONCAT('INV', DATE_FORMAT(NEW.created_at, '%y%m'), LPAD(next_invoice_id, 5, '0'));
END;

//

DELIMITER ;

--dummy data--
INSERT INTO `invoice_cd` (`order_id`, `payment_id`, `total_amount`, `dispatched_id`)
VALUES
    ('O240100001', 'PMT240100001', 40, 'DEL240100001'),
    ('O240100002', 'PMT240100002', 20, 'DEL240100002'),
    ('O240100003', 'PMT240100003', 162, 'DEL240100003'),
    ('O240100004', 'PMT240100004', 20, 'DEL240100004'),
    ('O240100005', 'PMT240100005', 72, 'DEL240100005'),
    ('O240100006', 'PMT240100006', 30, 'DEL240100006'),
    ('O240100007', 'PMT240100007', 80, 'DEL240100007'),
    ('O240100008', 'PMT240100008', 15, 'DEL240100008'),
    ('O240100009', 'PMT240100009', 144, 'DEL240100009'),
    ('O240100010', 'PMT240100010', 16, 'DEL240100010');

