-- This SQL statement is used to add an index to the `department_cd` table

ALTER TABLE `department_cd`
ADD INDEX `idx_deprt_id` USING BTREE (`deprt_id`);