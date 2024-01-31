/*This SQL code is creating two new indexes for the customer_cd table.*/

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

-- Create an index named `customer_cd_first_name_index` on the `customer_cd` table using the BTREE algorithm for the `first_name` column.
ALTER TABLE `customer_cd`
ADD INDEX `customer_cd_first_name_index` USING BTREE ON `customer_cd` (`first_name`);

-- Create an index named `customer_cd_last_name_index` on the `customer_cd` table using the BTREE algorithm for the `last_name` column.
ALTER TABLE `customer_cd`
ADD INDEX `customer_cd_last_name_index` USING BTREE ON `customer_cd` (`last_name`);