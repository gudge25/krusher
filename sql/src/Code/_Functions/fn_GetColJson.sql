DELIMITER $$
DROP FUNCTION IF EXISTS fn_GetColJson;
CREATE FUNCTION fn_GetColJson(
    $tblName   varchar(50)
   ,$exclude   varchar(50)
) RETURNS varchar(2000)
BEGIN
  declare $sql varchar(2000);
--
select
  GROUP_CONCAT(CONCAT(COLUMN_NAME,' as ',COLUMN_NAME) separator ', ')
into
  $sql
from information_schema.COLUMNS
where TABLE_SCHEMA = DATABASE()
  and TABLE_NAME = $tblName
  -- and COLUMN_NAME != 'HIID'
  and (COLUMN_NAME != $exclude or $exclude is NULL);
--
-- set $sql = CONCAT('GROUP_CONCAT(CONCAT(''{'',', SUBSTRING($sql, 1 , LENGTH($sql)-5),',''}''))');
--
RETURN $sql;
END $$
DELIMITER ;
--
