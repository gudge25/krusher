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
