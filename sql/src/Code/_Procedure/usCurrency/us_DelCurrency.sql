DELIMITER $$
DROP PROCEDURE IF EXISTS us_DelCurrency;
CREATE PROCEDURE us_DelCurrency(
  $crID int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  if ($crID is NULL) then
    -- Параметр "ID записи" должен иметь значение
    call RAISE(77021,NULL);
  end if;
  --
  delete from usCurrency
  where crID = $crID;
END $$
DELIMITER ;
--
