DROP PROCEDURE IF EXISTS fm_UpdFormItem;
DELIMITER $$
CREATE PROCEDURE fm_UpdFormItem(
    $token            VARCHAR(100)
    , $HIID           bigint        -- версия
    , $fiID           int           -- 'ID записи'
    , $dcID           int           -- 'ID документа'
    , $qID            varchar(200)  -- 'ID вопроса '
    , $qName          varchar(2000)  -- 'вопрос '
    , $qiID           int           -- 'ID вариант ответа'
    , $qiAnswer       varchar(100)  -- 'вариант ответа'
    , $qiComment      varchar(2000)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_UpdFormItem');
  ELSE
    if $HIID is NULL then
      -- Параметр "Версия" должен иметь значение
      call RAISE(77034,NULL);
    end if;
    if $fiID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    if not exists (
      select 1
      from fmFormItem
      where HIID = $HIID
        and fiID = $fiID AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update fmFormItem set
       HIID     =  fn_GetStamp()
      ,qiID     = $qiID
      ,qiAnswer = $qiAnswer
      ,qiComment = $qiComment
      , isActive = $isActive
    where fiID = $fiID
      and dcID = $dcID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
