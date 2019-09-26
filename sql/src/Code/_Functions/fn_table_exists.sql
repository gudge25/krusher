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
--
