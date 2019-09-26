DELIMITER $$
DROP PROCEDURE IF EXISTS reg_DelCountry;
CREATE PROCEDURE reg_DelCountry(
    $token            VARCHAR(100)
    , $cID           int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_DelCountry');
  ELSE
    if ($cID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    delete from reg_countries
    where country_id = $cID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
