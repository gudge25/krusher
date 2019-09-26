DELIMITER $$
DROP PROCEDURE IF EXISTS reg_DelLocation;
CREATE PROCEDURE reg_DelLocation(
    $token            VARCHAR(100)
    , $lID            int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_DelLocation');
    ELSE
    if ($lID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    delete from reg_cities
    where city_id = $lID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
