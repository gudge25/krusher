DELIMITER $$
DROP PROCEDURE IF EXISTS us_DelEnum;
CREATE PROCEDURE us_DelEnum(
    $token            VARCHAR(100)
    , $tvID           INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_DelEnum');
  ELSE
    DELETE FROM usEnumValue
    WHERE tvID = $tvID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
