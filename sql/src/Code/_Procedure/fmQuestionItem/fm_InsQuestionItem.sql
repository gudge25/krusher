DROP PROCEDURE IF EXISTS fm_InsQuestionItem;
DELIMITER $$
CREATE PROCEDURE fm_InsQuestionItem(
    $token            VARCHAR(100)
    , $qiID           int           -- 'ID вариант ответа'
    , $qID            int           -- 'ID вопроса'
    , $qiAnswer       varchar(100)  -- 'вариант ответа'
    , $isActive       bit           --
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_InsQuestionItem');
  ELSE
    if ($qiID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    insert fmQuestionItem (
       HIID
      ,qiID
      ,qID
      ,qiAnswer
      ,isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$qiID
      ,$qID
      ,$qiAnswer
      ,$isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
