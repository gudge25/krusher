DROP PROCEDURE IF EXISTS crm_SetActualClient;
DELIMITER $$
CREATE PROCEDURE crm_SetActualClient(
    $token        VARCHAR(100)
    , $HIID       bigint
    , $clID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $isNotice     bit;
  declare $dbPrefix     varchar(10);
  declare $actualStatus int;
  declare $headPost     varchar(50);
  declare $ffID         int;
  declare $StatusName   varchar(100);
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_SetActualClient');
  ELSE
    select
       ffID
      ,ActualStatus
    into
       $ffID
      ,$actualStatus
    from crmClient
    where HIID = $HIID
      and clID = $clID
      AND Aid = $Aid;
    --
    if $ffID is NULL then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    if not exists (
      select 1
      from crmClientEx
      where isNotice = 1
        AND Aid = $Aid)
    then
      select
        headPost into $headPost
      from crmOrg o
      where o.clID = $clID
        AND o.Aid = $Aid;
      --
      if $headPost is NULL then
        -- Параметр "Должность" должен иметь значение
        call RAISE(77064,NULL);
      end if;
      --
      if not exists (
        select 1
        from usEnumValue
        where Name = $headPost
          and tyID in (1008, 1009)
          AND Aid = $Aid)
      then
        -- Должность "%s" не соответствует справочнику "Должностей"
         call RAISE(77063,$headPost);
      end if;
    end if;
    --
    -- если не статус "ДОЗВОН"
    if $actualStatus != 101101
      and exists (
        select 1
        from crmContact
        where ccType = 36
          and clID = $clID
          AND Aid = $Aid)
    then
      select
        Name into $StatusName
      from usEnumValue
      where tvID = $actualStatus AND Aid = $Aid;
      -- Для статуса "%s", поле "Телефон дозвона" должено быть пустым
      call RAISE(77065,$StatusName);
    end if;
    --
    update crmClient set
      isActual = 1
    where clID = $clID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
