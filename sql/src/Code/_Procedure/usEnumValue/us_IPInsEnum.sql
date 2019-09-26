DELIMITER $$
DROP PROCEDURE IF EXISTS us_IPInsEnum;
CREATE PROCEDURE us_IPInsEnum(
    $Aid                INT(11)
    , $tvID             INT(11)
    , $tyID             INT(11)
    , $Name             VARCHAR(100)
    , $isActive         BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  INSERT IGNORE INTO usEnumValue (
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
END $$
DELIMITER ;
--
