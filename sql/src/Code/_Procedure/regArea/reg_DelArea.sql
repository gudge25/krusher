DELIMITER $$
DROP PROCEDURE IF EXISTS reg_DelArea;
CREATE PROCEDURE reg_DelArea(
    $token            VARCHAR(100)
    , $arID            int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_DelArea');
    ELSE
    if ($arID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    delete from reg_cities
    where city_id = $arID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
