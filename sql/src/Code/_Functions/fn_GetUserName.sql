DELIMITER $$
DROP FUNCTION IF EXISTS fn_GetUserName;
CREATE FUNCTION fn_GetUserName()
RETURNS VARCHAR(30)
BEGIN
  declare
    $UserName varchar(30);
  --
  set $UserName = SUBSTRING_INDEX(USER(),'@', 1);
  --
  RETURN $UserName;
END $$
DELIMITER ;
--
