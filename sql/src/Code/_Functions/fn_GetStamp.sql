DROP FUNCTION IF EXISTS fn_GetStamp;
DELIMITER $$
CREATE FUNCTION fn_GetStamp()
RETURNS BIGINT
BEGIN
  declare $Result     bigint;
  --
  set $result = UNIX_TIMESTAMP(NOW()) * 1000000 + MICROSECOND(NOW(6));
  --
  RETURN $Result;
END $$
DELIMITER ;
--
