DROP PROCEDURE IF EXISTS fm_DelForm;
DELIMITER $$
CREATE PROCEDURE fm_DelForm(
    $token        VARCHAR(100)
    , $dcID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_DelForm');
  ELSE
    if $dcID is NULL then
      -- Параметр "ID документа" должен иметь значение
      call RAISE(77001,NULL);
    end if;
    --
    delete from fmFormItem
    where dcID = $dcID AND Aid = $Aid;
    --
    delete from fmForm
    where dcID = $dcID AND Aid = $Aid;
    --
    call dc_IPDelDoc($Aid, $dcID);
  END IF;
END $$
DELIMITER ;
--
