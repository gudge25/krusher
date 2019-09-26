DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsEnumValue;
CREATE PROCEDURE us_InsEnumValue(
   $tvID  INT
  ,$tyID  INT
  ,$Name  VARCHAR(100)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  INSERT IGNORE INTO usEnumValue (
    tvID
    , tyID
    , Name
  )
  VALUES (
    $tvID
    , $tyID
    , $Name
  );
END $$
DELIMITER ;
/*GRANT EXECUTE ON PROCEDURE us_InsEnumValue TO _dbo;*/
--
DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsMessage;
CREATE PROCEDURE us_InsMessage(
  $message_id   INT
  , $text       VARCHAR(4096)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  INSERT IGNORE INTO usMessage (
    message_id
    , text
  )
  VALUES (
    $message_id
    , $text
  );
END $$
DELIMITER ;
--
DROP PROCEDURE IF EXISTS query_exec;
DELIMITER $$
CREATE PROCEDURE query_exec(
    $query           VARCHAR(5000)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  SET @s = $query;
  PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
/*GRANT EXECUTE ON PROCEDURE query_exec TO _dbo;*/
--
/*call us_InsNewEnums();*/