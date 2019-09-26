DELIMITER $$
DROP PROCEDURE IF EXISTS us_GetCurrency;
CREATE PROCEDURE us_GetCurrency(
  $crID int
) BEGIN
  if ($crID is NULL) then
    -- Параметр "ID записи" должен иметь значение
    call RAISE(77021,NULL);
  end if;
  --
  select
     crID
    ,crName
    ,crFullName
  from usCurrency
  where crID = $crID;
END $$
DELIMITER ;
--
