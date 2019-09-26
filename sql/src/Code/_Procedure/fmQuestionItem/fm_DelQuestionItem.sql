DROP PROCEDURE IF EXISTS fm_DelQuestionItem;
DELIMITER $$
CREATE PROCEDURE fm_DelQuestionItem(
    $token        VARCHAR(100)
    , $qiID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_DelQuestionItem');
  ELSE
    if ($qiID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from fmQuestionItem
    where qiID = $qiID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
