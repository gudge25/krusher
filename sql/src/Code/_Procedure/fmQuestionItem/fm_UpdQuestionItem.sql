DROP PROCEDURE IF EXISTS fm_UpdQuestionItem;
DELIMITER $$
CREATE PROCEDURE fm_UpdQuestionItem(
    $token            VARCHAR(100)
    , $HIID           bigint        -- версия
    , $qiID           int           -- 'ID вариант ответа'
    , $qID            int  -- 'ID вопроса'
    , $qiAnswer       varchar(100)  -- 'вариант ответа'
    , $isActive       bit           --
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_UpdQuestionItem');
  ELSE
    if $HIID is NULL then
      -- Параметр "Версия" должен иметь значение
      call RAISE(77034,NULL);
    end if;
    if $qiID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    if not exists (
      select 1
      from fmQuestionItem
      where HIID = $HIID
        and qiID = $qiID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update fmQuestionItem set
       HIID     = fn_GetStamp()
      ,qiAnswer = $qiAnswer
      ,isActive = $isActive
    where qiID = $qiID
      and qID = $qID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
