CREATE TABLE IF NOT EXISTS `orders_cd`(
    `order_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `customer_id` VARCHAR(12) NOT NULL,
    `product_id` VARCHAR(20) NOT NULL,
    `product_quantity` INT NOT NULL,
    `product_price` DECIMAL(10, 2) NOT NULL,
    `employee_id` VARCHAR(12) NOT NULL,
    `ordered_date` DATETIME NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_cd`(`customer_id`),
    FOREIGN KEY (`product_id`) REFERENCES `prod_inventory_cd`(`product_id`),
    FOREIGN KEY (`employee_id`) REFERENCES `employee_cd`(`employee_id`)
);

CREATE INDEX orders_cd_index USING BTREE ON orders_cd (customer_id, product_id,employee_id,ordered_date);

--trigger--

DELIMITER //
CREATE TRIGGER before_insert_orders_cd BEFORE INSERT ON orders_cd
FOR EACH ROW
BEGIN
    SET NEW.order_id = CONCAT(
        'O',
        DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            (   SELECT IFNULL(MAX(SUBSTRING(order_id, 7)) + 1, 1)
                FROM orders_cd
                WHERE SUBSTRING(order_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')
            ), 5, '0'));
END;
//
DELIMITER ;


--dummy data--

INSERT INTO `orders_cd` (`customer_id`, `product_id`, `product_quantity`, `product_price`, `employee_id`, `ordered_date`)
VALUES
    ('C240100001', 'P240100001', 2, 20.00, 'E240100003', '2024-01-06 12:00:00'),
    ('C240100001', 'P240100005', 1, 20.00, 'E240100017', '2024-01-06 12:30:00'),
    ('C240100002', 'P240100010', 3, 54.00, 'E240100010', '2024-01-06 13:00:00'),
    ('C240100002', 'P240100014', 1, 20.00, 'E240100017', '2024-01-06 13:30:00'),
    ('C240100003', 'P240100003', 2, 36.00, 'E240100010', '2024-01-06 14:00:00'),
    ('C240100003', 'P240100006', 1, 30.00, 'E240100017', '2024-01-06 14:30:00'),
    ('C240100004', 'P240100011', 2, 40.00, 'E240100010', '2024-01-06 15:00:00'),
    ('C240100004', 'P240100016', 1, 15.00, 'E240100024', '2024-01-06 15:30:00'),
    ('C240100005', 'P240100020', 3, 48.00, 'E240100017', '2024-01-06 16:00:00'),
    ('C240100005', 'P240100024', 1, 16.00, 'E240100024', '2024-01-06 16:30:00');