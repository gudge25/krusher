DELIMITER $$
DROP PROCEDURE IF EXISTS prc_DelEntity;
CREATE PROCEDURE prc_DelEntity(
   $pfxID        int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  if ($pfxID is NULL) then
    -- Параметр "ID записи" должен иметь значение
    call RAISE(77021,NULL);
  end if;
  --
  delete from prcEntity
  where pfxID = $pfxID;
END $$
DELIMITER ;
--
