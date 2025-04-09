SELECT S.name AS my_schema, O.name AS my_table
FROM sys.schemas S
INNER JOIN sys.objects O
ON S.schema_id = O.schema_id
WHERE O.type = 'U'