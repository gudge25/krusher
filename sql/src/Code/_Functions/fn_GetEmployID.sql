DROP FUNCTION IF EXISTS fn_GetEmployID;
DELIMITER $$
CREATE FUNCTION fn_GetEmployID(
    $token             VARCHAR(100)
)
RETURNS INT
BEGIN
  DECLARE $emID  INT;
  SET $token = NULLIF(TRIM($token), NULL);
  SET $emID = -999;
  --
  IF ($token IS NOT NULL) THEN
    SELECT emID INTO $emID FROM emEmploy WHERE Token = $token AND TokenExpiredDate > NOW();
  END IF;
  --
  RETURN $emID;
END $$
DELIMITER ;
--
