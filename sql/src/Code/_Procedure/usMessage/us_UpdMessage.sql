DELIMITER $$
DROP PROCEDURE IF EXISTS us_UpdMessage;
CREATE PROCEDURE us_UpdMessage(
   $message_id  int
  ,$text        varchar(4096)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  update usMessage set
    text = $text
  where message_id = $message_id;
END $$
DELIMITER ;
--
