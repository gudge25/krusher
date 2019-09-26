DROP FUNCTION IF EXISTS fn_column_exists;
DELIMITER $$
CREATE FUNCTION fn_column_exists(
   $table  varchar(100)
  ,$column varchar(100)
) returns bool
BEGIN
  declare $result     bool default 0;
  declare $dbName     varchar(100);
  --
  set $dbName = DATABASE();
  --
  if exists (
    select 1
    from information_schema.columns
    where table_schema = $dbName
      and table_name = $table
      and column_name = $column) then
    set $result = 1;
  end if;
  --
  return $result;
END $$
DELIMITER ;
--
