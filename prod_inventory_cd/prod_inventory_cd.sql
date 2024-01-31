CREATE TABLE IF NOT EXISTS `prod_inventory_cd`(
    `product_id` VARCHAR(20) NOT NULL PRIMARY KEY,
    `product_title` VARCHAR(100) NOT NULL,
    `prod_type_kwd` VARCHAR(11) NOT NULL,
    `prod_genre` VARCHAR(30) NOT NULL,
    `prod_language` VARCHAR(20) NOT NULL,
    `prod_description` VARCHAR(200) NOT NULL,
    `prod_units` INT NOT NULL,
    `prod_price` BIGINT NOT NULL,
    `employee_id` VARCHAR(12) NOT NULL,
    `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employee_cd`(`employee_id`),
    FOREIGN KEY (`prod_type_kwd`) REFERENCES `product_type_cd`(`prod_type_kwd`)
);

CREATE INDEX prod_inventory_cd_index USING BTREE ON prod_inventory_cd (prod_type_kwd, prod_genre);

--trigger--

DELIMITER //

CREATE TRIGGER before_insert_prod_inventory_cd BEFORE
INSERT ON prod_inventory_cd FOR EACH ROW
BEGIN
    SET NEW.product_id = CONCAT('P', DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            COALESCE(
                (SELECT IFNULL(MAX(SUBSTRING(product_id, 7)) + 1, 1)
                 FROM prod_inventory_cd
                 WHERE SUBSTRING(product_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')),
                1
            ),
            5, '0')
    );
END;

//

DELIMITER ;



--dummy data--
INSERT INTO `prod_inventory_cd` (`product_title`, `prod_type_kwd`, `prod_genre`, `prod_language`, `prod_description`, `prod_units`, `prod_price`, `employee_id`)
VALUES
    ('the Book1', 'BOO24000002', 'Fiction', 'English', 'A great fiction book', 50, 20, 'E240100003'),
    ('the Book2', 'BOO24000002', 'Mystery', 'English', 'An intriguing mystery book', 40, 25, 'E240100003'),
    ('Book3', 'BOO24000002', 'Thriller', 'English', 'A thrilling suspense novel', 60, 18, 'E240100010'),
    ('Book4', 'BOO24000002', 'Romance', 'English', 'A romantic novel', 45, 22, 'E240100010'),
    ('Book5', 'BOO24000002', 'Science Fiction', 'English', 'A mind-bending science fiction story', 55, 20, 'E240100017'),
    ('Book6', 'BOO24000002', 'Fantasy', 'English', 'A magical fantasy adventure', 30, 30, 'E240100017'),
    ('Book7', 'BOO24000002', 'Non-Fiction', 'English', 'An informative non-fiction book', 70, 15, 'E240100024'),
    ('Book8', 'BOO24000002', 'Fantasy', 'English', 'An enchanting fantasy novel', 25, 28, 'E240100024'),
    ('the Book9', 'BOO24000002', 'Mystery', 'English', 'A mysterious detective story', 35, 23, 'E240100024'),
    ('Book10', 'BOO24000002', 'Science Fiction', 'English', 'A futuristic sci-fi adventure', 40, 26, 'E240100013'),
    ('the Book11', 'BOO24000002', 'Romance', 'English', 'A heartwarming romantic tale', 30, 24, 'E240100013'),
    ('Book12', 'BOO24000002', 'Non-Fiction', 'English', 'A thought-provoking non-fiction book', 55, 20, 'E240100013'),
    ('Book13', 'BOO24000002', 'Biography', 'English', 'An inspiring biography', 45, 22, 'E240100009'),
    ('Book14', 'BOO24000002', 'History', 'English', 'A captivating historical account', 50, 19, 'E240100009'),
    ('the Book15', 'BOO24000002', 'Self-Help', 'English', 'A self-help guide to success', 65, 15, 'E240100009'),
    ('Book16', 'BOO24000002', 'Drama', 'English', 'A dramatic fiction novel', 28, 27, 'E240100019'),
    ('Book17', 'BOO24000002', 'Adventure', 'English', 'An adventurous journey story', 38, 21, 'E240100019');

INSERT INTO `prod_inventory_cd` (`product_title`, `prod_type_kwd`, `prod_genre`, `prod_language`, `prod_description`, `prod_units`, `prod_price`, `employee_id`)
VALUES
    ('Movie1', 'MOV24000003', 'Action', 'English', 'An action-packed movie', 100, 15, 'E240100003'),
    ('Movie2', 'MOV24000003', 'Drama', 'English', 'A dramatic film', 120, 12, 'E240100003'),
    ('Movie3', 'MOV24000003', 'Comedy', 'English', 'A hilarious comedy', 80, 18, 'E240100010'),
    ('Movie4', 'MOV24000003', 'Thriller', 'English', 'A suspenseful thriller', 90, 20, 'E240100010'),
    ('Movie5', 'MOV24000003', 'Science Fiction', 'English', 'A sci-fi adventure', 110, 22, 'E240100017'),
    ('Movie6', 'MOV24000003', 'Family', 'English', 'A family-friendly film', 85, 25, 'E240100017'),
    ('Movie7', 'MOV24000003', 'Documentary', 'English', 'An informative documentary', 60, 20, 'E240100017'),
    ('Movie8', 'MOV24000003', 'Romance', 'English', 'A romantic movie', 75, 18, 'E240100024'),
    ('Movie9', 'MOV24000003', 'Horror', 'English', 'A scary horror film', 70, 15, 'E240100024'),
    ('Movie10', 'MOV24000003', 'Animation', 'English', 'An animated movie', 50, 30, 'E240100024'),
    ('Movie11', 'MOV24000003', 'Action', 'English', 'A thrilling action film', 95, 18, 'E240100024'),
    ('Movie12', 'MOV24000003', 'Comedy', 'English', 'A laugh-out-loud comedy movie', 80, 22, 'E240100024'),
    ('Movie13', 'MOV24000003', 'Drama', 'English', 'An emotional drama film', 110, 20, 'E240100013'),
    ('Movie14', 'MOV24000003', 'Romance', 'English', 'A heartwarming romantic movie', 75, 25, 'E240100013'),
    ('Movie15', 'MOV24000003', 'Science Fiction', 'English', 'An out-of-this-world sci-fi movie', 105, 23, 'E240100013'),
    ('Movie16', 'MOV24000003', 'Family', 'English', 'A family-friendly animated film', 85, 28, 'E240100009'),
    ('Movie17', 'MOV24000003', 'Horror', 'English', 'A spine-chilling horror movie', 70, 15, 'E240100009'),
    ('Movie18', 'MOV24000003', 'Adventure', 'English', 'An adventurous quest film', 90, 20, 'E240100009'),
    ('Movie19', 'MOV24000003', 'Documentary', 'English', 'An insightful documentary film', 60, 18, 'E240100019'),
    ('Movie20', 'MOV24000003', 'Fantasy', 'English', 'A magical fantasy film', 50, 30, 'E240100019');

INSERT INTO `prod_inventory_cd` (`product_title`, `prod_type_kwd`, `prod_genre`, `prod_language`, `prod_description`, `prod_units`, `prod_price`, `employee_id`)
VALUES
    ('Music1', 'MUS24000001', 'Pop', 'English', 'A pop music album', 160, 12, 'E240100003'),
    ('Music2', 'MUS24000001', 'Rock', 'English', 'A rock music collection', 130, 14, 'E240100010'),
    ('Music3', 'MUS24000001', 'Hip Hop', 'English', 'A hip hop music compilation', 140, 16, 'E240100017'),
    ('Music4', 'MUS24000001', 'Jazz', 'English', 'A jazz music experience', 120, 18, 'E240100024'),
    ('Music5', 'MUS24000001', 'R&B', 'English', 'A soulful R&B album', 160, 12, 'E240100003'),
    ('Music6', 'MUS24000001', 'Classical', 'English', 'A classical music masterpiece', 130, 14, 'E240100010'),
    ('Music7', 'MUS24000001', 'Country', 'English', 'A country music collection', 140, 16, 'E240100017'),
    ('Music8', 'MUS24000001', 'Pop', 'English', 'A chart-topping pop album', 180, 14, 'E240100024'),
    ('Music9', 'MUS24000001', 'Rock', 'English', 'An energetic rock compilation', 150, 16, 'E240100013'),
    ('Music10', 'MUS24000001', 'Hip Hop', 'English', 'A hip hop mixtape', 160, 18, 'E240100013'),
    ('Music11', 'MUS24000001', 'Jazz', 'English', 'A smooth jazz collection', 140, 20, 'E240100009'),
    ('Music12', 'MUS24000001', 'R&B', 'English', 'A soulful R&B experience', 180, 14, 'E240100009'),
    ('Music13', 'MUS24000001', 'Classical', 'English', 'A classical symphony', 150, 16, 'E240100019'),
    ('Music14', 'MUS24000001', 'Country', 'English', 'A country music journey', 160, 18, 'E240100019'),
    ('Music15', 'MUS24000001', 'Electronic', 'English', 'An electronic music album', 130, 15, 'E240100019'),
    ('Music16', 'MUS24000001', 'Indie', 'English', 'An indie music compilation', 170, 12, 'E240100011'),
    ('Music17', 'MUS24000001', 'Reggae', 'English', 'A reggae music collection', 155, 17, 'E240100011');