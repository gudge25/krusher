DELIMITER $$
DROP PROCEDURE IF EXISTS reg_DelOperator;
CREATE PROCEDURE reg_DelOperator(
    $token            VARCHAR(100)
    , $oID            int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_DelOperator');
  ELSE
    if ($oID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    delete from reg_operator
    where id_operator = $oID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
