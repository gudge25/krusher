DELIMITER $$
DROP FUNCTION IF EXISTS fn_GetHostName;
CREATE FUNCTION fn_GetHostName()
RETURNS VARCHAR(30)
BEGIN
  declare $HostName varchar(128);
  declare $user     varchar(100);
  --
  set $user     = USER();
  set $HostName = RIGHT($user, LENGTH($user) - LENGTH(SUBSTRING_INDEX($user,'@', 1))-1);
  --
  RETURN $HostName;
END $$
DELIMITER ;
--
