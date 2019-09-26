DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsEnum;
CREATE PROCEDURE us_InsEnum(
    $token              VARCHAR(100)
    , $tvID             INT(11)
    , $tyID             INT(11)
    , $Name             VARCHAR(100)
    , $isActive         BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_InsEnum');
  ELSE
    INSERT INTO usEnumValue (
      tvID
      , Aid
      , tyID
      , `Name`
      , isActive
      , HIID
    )
    VALUES (
      $tvID
      , $Aid
      , $tyID
      , $Name
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
