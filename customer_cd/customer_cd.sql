CREATE TABLE IF NOT EXISTS `customer_cd`(
    `customer_id` VARCHAR(12) NOT NULL PRIMARY KEY,
    `password` VARCHAR(12) NOT NULL,
    `first_name` VARCHAR(50) NOT NULL,
    `middle_name` VARCHAR(50) NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `date_of_birth` DATE NOT NULL,
    `email_id` VARCHAR(50) NOT NULL,
    `email_verified` BOOLEAN NOT NULL DEFAULT false,
    `phone_number` VARCHAR(50) NOT NULL,
    `ph_no_verified` BOOLEAN NOT NULL DEFAULT false,
    `gender` VARCHAR(6) NOT NULL,
    `house_no` VARCHAR(50) NOT NULL,
    `street_address` VARCHAR(50) NOT NULL,
    `street_address2` VARCHAR(50) NULL,
    `city` VARCHAR(50) NOT NULL,
    `post_code` VARCHAR(50) NOT NULL,
    `country` VARCHAR(50) NOT NULL,
    `logged_in` BOOLEAN NOT NULL DEFAULT false,
    `otp_generated` VARCHAR(6) NOT NULL,
    `otp_generated_at` DATETIME NOT NULL,
    `is_otp_verified` BOOLEAN NOT NULL,
    `last_activity` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--index--
CREATE INDEX customer_cd_index USING BTREE ON customer_cd (first_name, last_name);

--trigger--
DELIMITER //

CREATE TRIGGER before_insert_customer_cd 
BEFORE INSERT ON customer_cd FOR EACH ROW 
BEGIN
    SET NEW.customer_id = CONCAT('C', DATE_FORMAT(NOW(), '%y%m'),
        LPAD(
            COALESCE(
                (SELECT MAX(SUBSTRING(customer_id, 7) + 1) 
                 FROM customer_cd 
                 WHERE SUBSTRING(customer_id, 2, 4) = DATE_FORMAT(NOW(), '%y%m')), 
                1
            ),
            5, '0')
    );
END;

//

DELIMITER ;


--Dummy Data--
INSERT INTO `customer_cd` (`password`, `first_name`, `middle_name`, `last_name`, `date_of_birth`, `email_id`, `email_verified`, `phone_number`, `ph_no_verified`, `gender`, `house_no`, `street_address`, `street_address2`, `city`, `post_code`, `country`, `logged_in`, `otp_generated`, `otp_generated_at`, `is_otp_verified`)
VALUES 
('pass123', 'John', 'A', 'Doe', '1990-01-15', 'john.doe@email.com', true, '1234567890', true, 'Male', '123', 'Main Street', 'Apt 45', 'Cityville', '12345', 'USA', true, '123456', '2024-01-06 12:30:00', true),
('password321', 'Jane', 'M', 'Smith', '1985-07-22', 'jane.smith@email.com', false, '9876543210', false, 'Female', '456', 'Broadway', NULL, 'Townsville', '54321', 'Canada', false, '654321', '2024-01-06 13:45:00', false),
('securepass', 'Alice', NULL, 'Johnson', '1992-03-05', 'alice.johnson@email.com', true, '5558889999', true, 'Female', '789', 'Oak Street', 'Apt 12', 'Villagetown', '98765', 'UK', true, '789012', '2024-01-06 14:15:00', true),
('secretword', 'Bob', 'B', 'Miller', '1988-09-10', 'bob.miller@email.com', false, '1112223333', true, 'Male', '101', 'Cedar Lane', NULL, 'Hamletsville', '56789', 'Australia', false, '987654', '2024-01-06 15:00:00', true),
('access123', 'Eva', NULL, 'Brown', '1995-12-03', 'eva.brown@email.com', true, '3334445555', false, 'Female', '202', 'Pine Avenue', 'Suite 8', 'Suburbia', '11223', 'New Zealand', false, '456789', '2024-01-06 16:20:00', false),
('pass456', 'Michael', 'J', 'Anderson', '1982-06-18', 'michael.anderson@email.com', true, '9998887777', true, 'Male', '222', 'Sunset Blvd', 'Apt 33', 'Cityscape', '67890', 'USA', true, '456789', '2024-01-07 09:30:00', true),
('key123', 'Emily', 'K', 'Johnson', '1998-04-25', 'emily.johnson@email.com', false, '4445556666', false, 'Female', '789', 'Meadow Lane', NULL, 'Greenville', '54321', 'Canada', false, '321654', '2024-01-07 10:45:00', false),
('secureword', 'Daniel', 'D', 'Williams', '1987-11-08', 'daniel.williams@email.com', true, '7778889999', true, 'Male', '303', 'Riverside Drive', 'Suite 5', 'Metropolis', '98765', 'UK', true, '987654', '2024-01-07 11:15:00', true),
('mypassword', 'Sophia', NULL, 'Brown', '1994-02-12', 'sophia.brown@email.com', false, '1113335555', true, 'Female', '404', 'Maple Street', 'Apt 21', 'Villageland', '56789', 'Australia', false, '456123', '2024-01-07 12:00:00', true),
('access456', 'Ryan', 'R', 'Miller', '1989-07-30', 'ryan.miller@email.com', true, '6667778888', false, 'Male', '505', 'Cypress Avenue', NULL, 'Hamlettown', '11223', 'New Zealand', false, '789012', '2024-01-07 13:20:00', false),
('open123', 'Olivia', NULL, 'Garcia', '1996-10-05', 'olivia.garcia@email.com', false, '3331112222', true, 'Female', '606', 'Chestnut Lane', 'Suite 12', 'Suburbville', '11223', 'New Zealand', false, '654321', '2024-01-07 14:45:00', false),
('letmein', 'Liam', 'L', 'White', '1991-12-20', 'liam.white@email.com', true, '9990001111', false, 'Male', '707', 'Birch Street', NULL, 'Countryside', '11223', 'New Zealand', false, '789456', '2024-01-07 15:15:00', false),
('password789', 'Ava', 'A', 'Taylor', '1997-03-15', 'ava.taylor@email.com', false, '2224446666', true, 'Female', '808', 'Palm Avenue', 'Apt 9', 'Townsville', '54321', 'Canada', false, '123789', '2024-01-07 16:00:00', true),
('letmeinnow', 'Noah', NULL, 'Martinez', '1986-08-28', 'noah.martinez@email.com', true, '7770001111', true, 'Male', '909', 'Willow Lane', 'Suite 3', 'Cityville', '12345', 'USA', true, '987123', '2024-01-07 17:20:00', true),
('mypassword123', 'Mia', NULL, 'Turner', '1993-05-02', 'mia.turner@email.com', false, '5556667777', false, 'Female', '1010', 'Sycamore Lane', 'Apt 15', 'Hometown', '67890', 'USA', false, '321789', '2024-01-07 18:45:00', false);
