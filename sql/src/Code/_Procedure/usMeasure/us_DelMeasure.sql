DROP PROCEDURE IF EXISTS us_DelMeasure;
DELIMITER $$
CREATE PROCEDURE us_DelMeasure(
    $token            VARCHAR(100)
    , $msID           int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_DelMeasure');
  ELSE
    if ($msID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from usMeasure
    where msID = $msID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
