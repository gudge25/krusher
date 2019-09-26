DELIMITER $$
DROP FUNCTION IF EXISTS fn_GetEmID;
CREATE FUNCTION fn_GetEmID()
returns int
BEGIN
  declare $emID       int default 0;
  declare $LoginName  char(16);
  --
  set $LoginName = SUBSTRING_INDEX(USER(),'@', 1);
  --
  select
    emID into $emID
  from emEmploy
  where LoginName = $LoginName;
  --
  return $emID;
END $$
DELIMITER ;
--
