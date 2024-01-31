
CREATE TABLE IF NOT EXISTS `product_type_cd`(
    `prod_type_kwd` VARCHAR(11) NOT NULL PRIMARY KEY,
    `prod_type_name` VARCHAR(60) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--trigger--
DELIMITER //

CREATE TRIGGER before_insert_product_type_cd
BEFORE INSERT ON product_type_cd
FOR EACH ROW
BEGIN
    SET NEW.prod_type_kwd = CONCAT(
        SUBSTRING(NEW.prod_type_name, 1, 3),
        DATE_FORMAT(NOW(), '%y'),
        LPAD(
            (SELECT IFNULL(MAX(SUBSTRING(prod_type_kwd, 7)) + 1, 1) FROM product_type_cd WHERE SUBSTRING(prod_type_kwd, 4, 2) = DATE_FORMAT(NOW(), '%y')),
            6,
            '0'
        )
    );
END;

//

DELIMITER ;

--dummy data--
INSERT INTO
    `product_type_cd` (`prod_type_name`)
VALUES
    ('MusicRecords'),('Books'),('Movies'),('Games'),('Toys'),('Sports'),('Food');