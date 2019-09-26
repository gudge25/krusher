DROP FUNCTION IF EXISTS fn_table_exists;
DELIMITER $$
CREATE FUNCTION fn_table_exists(
  $table  varchar(100)
) returns bool
BEGIN
  declare $result     bool default 0;
  declare $dbName     varchar(100);
  --
  set $dbName = DATABASE();
  --
  if exists (
    select 1
    from information_schema.tables
    where table_schema = $dbName
      and table_name = $table) then
    set $result = 1;
  end if;
  --
  return $result;
END $$
DELIMITER ;

set @exist = fn_column_exists('stProduct', 'uID');
set @query = IF(@exist = 1
,'UPDATE stProduct SET uID = UUID_SHORT() WHERE uID is NULL OR uID = 0;'
,'select "+221_62";');
