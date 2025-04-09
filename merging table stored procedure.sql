CREATE PROCEDURE sp_mfg_cus_merge_table
AS
BEGIN

IF CURSOR_STATUS('global', 'table_cursor') >= 0
BEGIN
    CLOSE table_cursor;
    DEALLOCATE table_cursor;
END

-- Counting total customer tables
-- DECLARE @table_count NVARCHAR(20)
-- SET @table_count = (
-- SELECT count(table_name)
-- FROM information_schema.tables
-- WHERE table_name LIKE '%cus_%');
-- SELECT @table_count AS my_table_count

DECLARE @merge_cus_tables NVARCHAR(MAX) = '';
DECLARE @table_name NVARCHAR(200);

DECLARE table_cursor CURSOR FOR
SELECT table_name
FROM information_schema.tables
WHERE table_name LIKE '%cus_%';  

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @table_name;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @merge_cus_tables += 'SELECT * FROM ' + QUOTENAME(@table_name) + ' UNION ALL ';
    FETCH NEXT FROM table_cursor INTO @table_name;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Removing last UNION ALL
SET @merge_cus_tables = LEFT(@merge_cus_tables, LEN(@merge_cus_tables) - 10);

-- Merging into final customer table
SET @merge_cus_tables = '
WITH AllCustomers AS (
    ' + @merge_cus_tables + '
),
Deduped AS (
    SELECT * FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY customer_code ORDER BY customer_code DESC) AS row_num
        FROM AllCustomers
    ) t WHERE row_num = 1
)
MERGE INTO mfg_cus AS final_cus
USING Deduped AS new_cus
ON final_cus.customer_code = new_cus.customer_code
WHEN NOT MATCHED BY TARGET THEN
    INSERT (first_name, last_name, email, country, is_current,start_date, end_date, customer_code)
    VALUES (new_cus.first_name, new_cus.last_name, new_cus.email, new_cus.country, 
	new_cus.is_current, new_cus.start_date, new_cus.end_date, new_cus.customer_code);
';

EXEC sp_executesql @merge_cus_tables;
END;

-- DROP PROCEDURE dbo.sp_mfg_cus_merge_table