DELIMITER $$
DROP PROCEDURE IF EXISTS reg_DelValidation;
CREATE PROCEDURE reg_DelValidation(
    $token            VARCHAR(100)
    , $vID            int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_DelValidation');
    ELSE
    if ($vID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
      delete from reg_validation
    where id_validation = $vID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
