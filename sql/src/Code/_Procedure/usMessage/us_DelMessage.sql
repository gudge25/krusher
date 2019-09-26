DELIMITER $$
DROP PROCEDURE IF EXISTS us_DelMessage;
CREATE PROCEDURE us_DelMessage(
   $message_id  int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  delete from usMessage
  where message_id = $message_id;
END $$
DELIMITER ;
--
