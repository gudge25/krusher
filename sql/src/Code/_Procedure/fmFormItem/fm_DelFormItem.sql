DROP PROCEDURE IF EXISTS fm_DelFormItem;
DELIMITER $$
CREATE PROCEDURE fm_DelFormItem(
    $token        VARCHAR(100)
    , $fiID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_DelFormItem');
  ELSE
    if ($fiID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from fmFormItem
    where fiID = $fiID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
