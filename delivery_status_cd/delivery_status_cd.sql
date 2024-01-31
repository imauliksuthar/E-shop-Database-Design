CREATE TABLE IF NOT EXISTS `delivery_status_cd`(
    `delivery_status_kwd` VARCHAR(10) NOT NULL PRIMARY KEY,
    `delivery_status_name` VARCHAR(20) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


--dummy data--

INSERT INTO `delivery_status_cd` (`delivery_status_kwd`, `delivery_status_name`)
VALUES
    ('PENDING', 'Pending'),
    ('PROCESS', 'Processing'),
    ('OUTDEL', 'Out for Delivery'),
    ('DELIVR', 'Delivered'),
    ('CANCEL', 'Cancelled');
