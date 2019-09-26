DROP PROCEDURE IF EXISTS fm_DelQuestion;
DELIMITER $$
CREATE PROCEDURE fm_DelQuestion(
    $token        VARCHAR(100)
    , $qID        int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_DelQuestion');
  ELSE
    if ($qID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from fmQuestionItem
    where qID = $qID AND Aid = $Aid;
    --
    delete from fmQuestion
    where qID = $qID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
