-- This query adds an index to the `delivery_cd` table using the `delivery_status_cd` column.
ALTER TABLE `delivery_cd`
ADD INDEX idx_delivery_status_kwd ON delivery_status_cd (delivery_status_kwd);