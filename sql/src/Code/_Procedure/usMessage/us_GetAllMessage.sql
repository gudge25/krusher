DELIMITER $$
DROP PROCEDURE IF EXISTS us_GetAllMessages;
CREATE PROCEDURE us_GetAllMessages()
BEGIN
  select
     message_id
    ,text
  from usMessage;
END $$
--
