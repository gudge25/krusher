DROP PROCEDURE IF EXISTS fm_UpdQuestion;
DELIMITER $$
CREATE PROCEDURE fm_UpdQuestion(
    $token            VARCHAR(100)
    , $HIID           bigint        -- версия
    , $qID            int           --  'ID записи'
    , $qName          varchar(2000)  --  'вопрос'
    , $ParentID       int           --  'родитель'
    , $tpID           int
    , $isActive       bit           --
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_UpdQuestion');
  ELSE
    if $HIID is NULL then
      -- Параметр "Версия" должен иметь значение
      call RAISE(77034,NULL);
    end if;
    if $qID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    if not exists (
      select 1
      from fmQuestion
      where HIID = $HIID
        and qID = $qID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update fmQuestion set
      qName       = $qName
      , isActive  = $isActive
      , ParentID  = $ParentID
      , HIID      = fn_GetStamp()
      , tpID      = $tpID
    where qID = $qID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
