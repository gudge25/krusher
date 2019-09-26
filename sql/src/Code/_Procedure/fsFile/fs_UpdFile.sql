DELIMITER $$
DROP PROCEDURE IF EXISTS fs_UpdFile;
CREATE PROCEDURE fs_UpdFile(
    $token            VARCHAR(100)
    , $HIID         BIGINT
    , $ffID           int
    , $ffName         varchar(200)
    , $Priority       int
    , $dbID           int
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid      INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_UpdFile');
  ELSE
    if ($ffID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($ffName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    IF($Priority IS NULL) THEN
      SET $Priority = 0;
    END IF;
    --
    if not exists (
      select 1
      from fsFile
      where HIID = $HIID
        and ffID = $ffID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update fsFile set
      ffName        = $ffName
      , Priority    = $Priority
      , isActive    = IFNULL($isActive,0)
      , dbID        = $dbID
      , HIID        = fn_GetStamp()
    where ffID = $ffID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
