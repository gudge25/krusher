DELIMITER $$
DROP PROCEDURE IF EXISTS fs_UpdBase;
CREATE PROCEDURE fs_UpdBase (
    $token            VARCHAR(100)
    , $HIID           BIGINT
    , $dbID           int
    , $dbName         varchar(50)
    , $dbPrefix       varchar(10)
    , $activeTo       time
    , $isActive       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_UpdBase');
  ELSE
    set $dbName = NULLIF(TRIM($dbName),'');
    --
    if ($dbID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($dbName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    if not exists (
      select 1
      from fsBase
      where HIID = $HIID
        and dbID = $dbID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update fsBase set
       dbName   = $dbName
      ,dbPrefix = $dbPrefix
      ,isActive = IFNULL($isActive,0)
      ,activeTo = $activeTo
      , HIID        = fn_GetStamp()
    where dbID = $dbID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
