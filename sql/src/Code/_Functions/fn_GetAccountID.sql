DROP FUNCTION IF EXISTS fn_GetAccountID;
DELIMITER $$
CREATE FUNCTION fn_GetAccountID(
    $token             VARCHAR(100)
)
RETURNS INT
BEGIN
  DECLARE $Aid   INT;
  SET $token = NULLIF(TRIM($token), NULL);
  SET $Aid = -999;
  --
  IF ($token IS NOT NULL) THEN
    SELECT Aid INTO $Aid FROM emEmploy WHERE Token = $token AND TokenExpiredDate > NOW();
  END IF;
  --
  RETURN $Aid;
END $$
DELIMITER ;
--
