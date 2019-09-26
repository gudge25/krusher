DELIMITER $$
DROP PROCEDURE IF EXISTS us_GetMessage;
CREATE PROCEDURE us_GetMessage(
   $message_id  int
) BEGIN
  --
  select
    text
  from usMessage
  where message_id = $message_id;
END $$
DELIMITER ;
--
