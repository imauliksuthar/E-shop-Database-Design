-- This query adds an index to the `delivery_cd` table using the `dispatched_id` column.
ALTER TABLE `delivery_cd`
ADD INDEX `idx_dispatched_id` USING BTREE (`dispatched_id`);