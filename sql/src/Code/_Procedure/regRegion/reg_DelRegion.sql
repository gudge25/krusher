DELIMITER $$
DROP PROCEDURE IF EXISTS reg_DelRegion;
CREATE PROCEDURE reg_DelRegion(
    $token            VARCHAR(100)
    , $rgID          int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_DelRegion');
  ELSE
    if ($rgID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    delete from reg_regions
    where region_id = $rgID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
