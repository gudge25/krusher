DELIMITER $$
DROP PROCEDURE IF EXISTS RAISE;
CREATE PROCEDURE RAISE(
    $message_id     INT
    , $param        VARCHAR(100)
) BEGIN
  DECLARE $text VARCHAR(4096);
  --
  select text
         into $text
  from usMessage
  where message_id = $message_id;
  --
  if ($param is NOT NULL) then
    set $text = REPLACE($text, '%s', $param);
  end if;
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = $text; -- 'Параметр ID клиента должен иметь значение';
END $$
DELIMITER ;
--
