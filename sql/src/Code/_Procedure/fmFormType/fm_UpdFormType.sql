DROP PROCEDURE IF EXISTS fm_UpdFormType;
DELIMITER $$
CREATE PROCEDURE fm_UpdFormType(
    $token        VARCHAR(100)
    , $HIID       bigint
    , $tpID       int
    , $tpName     varchar(50)
    , $ffID       int
    , $isActive   bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_UpdFormType');
  ELSE
    if $HIID is NULL then
      -- Параметр "Версия" должен иметь значение
      call RAISE(77034,NULL);
    end if;
    if $tpID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    if not exists (
      select 1
      from fmFormType
      where HIID = $HIID
        and tpID = $tpID AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update fmFormType set
       HIID     = fn_GetStamp()
      ,tpName   = $tpName
      ,isActive = IFNULL($isActive,0)
      ,ffID     = $ffID
      , isActive = $isActive
    where tpID  = $tpID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
