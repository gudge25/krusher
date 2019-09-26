DROP PROCEDURE IF EXISTS fm_DelFormType;
DELIMITER $$
CREATE PROCEDURE fm_DelFormType(
    $token        VARCHAR(100)
    , $tpID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_DelFormType');
  ELSE
    if ($tpID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    delete from fmFormType
    where tpID = $tpID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
