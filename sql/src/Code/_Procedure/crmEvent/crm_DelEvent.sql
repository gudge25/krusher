DROP PROCEDURE IF EXISTS crm_DelEvent;
DELIMITER $$
CREATE PROCEDURE crm_DelEvent(
  $dcID int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  /*if $dcID is NULL then
    -- Параметр "ID документа" должен иметь значение
    call RAISE(77001,NULL);
  end if;
  --
  delete from crmEvent
  where dcID = $dcID;
  --
  call dc_IPDelDoc($Aid, $dcID);*/
END $$
DELIMITER ;
--
