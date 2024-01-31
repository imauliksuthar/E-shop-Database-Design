CREATE TABLE IF NOT EXISTS `shopping_cart_cd`(
    `cart_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `customer_id` VARCHAR(12) NOT NULL,
    `product_id` VARCHAR(20) NOT NULL,
    `product_quantity` INT NOT NULL,
    `product_price` DECIMAL(8, 2) NOT NULL,
    `checkout` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_cd`(`customer_id`),
    FOREIGN KEY (`product_id`) REFERENCES `prod_inventory_cd`(`product_id`)
);


CREATE INDEX shopping_cart_cd_index USING BTREE ON shopping_cart_cd (customer_id, product_id);

--trigger

DELIMITER //

CREATE TRIGGER before_insert_shopping_cart_cd
BEFORE INSERT ON shopping_cart_cd
FOR EACH ROW
BEGIN
    SET NEW.cart_id = CONCAT(
        'CRT',
        DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            (
                SELECT IFNULL(MAX(SUBSTRING(cart_id, 7)) + 1, 1)
                FROM shopping_cart_cd
                WHERE SUBSTRING(cart_id, 4, 4) = DATE_FORMAT(NOW(), '%y%m')
            ), 5, '0')
    );
END;

//

DELIMITER ;

--dummy data--

INSERT INTO `shopping_cart_cd` (`customer_id`, `product_id`, `product_quantity`, `product_price`, `checkout`)
VALUES
    ('C240100001', 'P240100001', 2, 40.00, FALSE),
    ('C240100001', 'P240100001', 1, 20.00, FALSE),
    ('C240100002', 'P240100005', 1, 20.00, FALSE),
    ('C240100003', 'P240100010', 3, 54.00, FALSE),
    ('C240100004', 'P240100014', 1, 20.00, FALSE);