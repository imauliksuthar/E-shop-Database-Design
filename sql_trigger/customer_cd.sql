-- This trigger is executed before inserting a new row into the `customer_cd` table
-- It generates a unique `customer_id` for each new row based on the `created_at` value

-- Create the trigger `customer_cd_before_insert`
CREATE TRIGGER `customer_cd_before_insert` BEFORE INSERT ON `customer_cd`
FOR EACH ROW
BEGIN
    -- Set the `customer_id` of the new row by concatenating 'C', the year and month of `created_at`,
    -- and a padded sequence number
    SET NEW.customer_id = CONCAT(
        'C',
        DATE_FORMAT(NEW.created_at, '%y%m'), 
        LPAD(
            (
                SELECT IFNULL(
                    MAX(CAST(SUBSTRING(`customer_id`, 4) AS UNSIGNED)), 0
                ) + 1 
                FROM `customer_cd` 
                WHERE SUBSTRING(`customer_id`, 2, 4) = DATE_FORMAT(NEW.created_at, '%ym')
            ),
            5,
            '0'
        )
    );
END;

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Trigger for inserting a new row in the customer_cd table
CREATE TRIGGER customer_cd_before_insert
BEFORE INSERT ON customer_cd
FOR EACH ROW
BEGIN
    -- Set the last_activity column to the current timestamp
    SET NEW.last_activity = CURRENT_TIMESTAMP;
END;

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Trigger for updating an existing row in the customer_cd table
CREATE TRIGGER customer_cd_before_update
BEFORE UPDATE ON customer_cd
FOR EACH ROW
BEGIN
    -- Set the last_activity column to the current timestamp
    SET NEW.last_activity = CURRENT_TIMESTAMP;
END;