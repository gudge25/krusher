DELIMITER $$
DROP PROCEDURE IF EXISTS crm_BulkDelClient;
CREATE PROCEDURE crm_BulkDelClient(
    $token            VARCHAR(100)
    , $clIDs          VARCHAR(20000)
    , $emIDEditor     INT(11)
    , $hostEditor     VARCHAR(50)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $ffID           INT;
  DECLARE $n              INT;
  DECLARE $i              INT;
  DECLARE $delID          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_BulkDelClient');
  ELSE
    if $clIDs is NULL then
      -- 'Параметр ID клиента должен иметь значение';
      call raise(77004, NULL);
    end if;
    --
    if $clIDs = 0 then
      -- Запрещено изменять клиента [Not Defined]
      call RAISE(77040, NULL);
    end if;
    --
    CREATE TEMPORARY TABLE IF NOT EXISTS `tmpID` (
        ID                      int
        , Aid                   int          NOT NULL
        , INDEX `Aid` (`Aid`)
    )ENGINE=MEMORY;
    --
    DELETE FROM `tmpID` WHERE Aid = $Aid;
    --
    call sp_split($clIDs, ',', 'tmpID', $Aid);
    --
    /*SELECT ffID
    INTO $ffID
    FROM crmClient
    WHERE clID IN (REPLACE($clIDs, ",", "','")) LIMIT 1;
    SELECT $ffID;*/
    /*select * from tmpID;*/
    --
    SELECT count(*) s
    INTO $n
    FROM `tmpID`
    WHERE Aid = $Aid;
    --
    CREATE TEMPORARY TABLE IF NOT EXISTS `tmpffID` (
        `ffID` INT NOT NULL,
        `Aid` INT NULL,
        PRIMARY KEY (`ffID`),
        INDEX `Aid` (`Aid`)
    )ENGINE=MEMORY;
    --
    DELETE FROM `tmpffID` WHERE Aid = $Aid;
    --
    set $i = 0;
    while $i < $n do
      SELECT ID INTO $delID FROM `tmpID` WHERE Aid = $Aid LIMIT $i, 1;
      --
      INSERT IGNORE INTO `tmpffID`
      SELECT ffID, Aid
      FROM crmClient
      WHERE clID = $delID;
      --
      DELETE FROM ccContact WHERE clID = $delID AND Aid = $Aid;
      --
      DELETE FROM fmFormItem WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $delID) AND Aid = $Aid;
      --
      DELETE FROM fmForm WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $delID) AND Aid = $Aid;
      --
      DELETE FROM slDealItem WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $delID) AND Aid = $Aid;
      --
      DELETE FROM slDeal WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $delID) AND Aid = $Aid;
      --
      delete from dcDoc where clID = $delID AND Aid = $Aid;
      --
      delete from crmPerson where clID = $delID AND Aid = $Aid;
      --
      delete from crmContact where clID = $delID AND Aid = $Aid;
      --
      delete from crmStatus where clID = $delID AND Aid = $Aid;
      --
      delete from crmOrg where clID = $delID AND Aid = $Aid;
      --
      delete from crmClientEx where clID = $delID AND Aid = $Aid;
      --
      delete from crmTagList where clID = $delID AND Aid = $Aid;
      --
      delete from crmAddress where clID = $delID AND Aid = $Aid;
      --
      INSERT DUP_crmClient SET
        OLD_HIID          = (SELECT HIID FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , DUP_InsTime     = NOW()
        , DUP_action      = 'D'
        , DUP_HostName    = $hostEditor
        , DUP_AppName     = $emIDEditor
        , HIID            = NULL
        , clID            = $delID
        , Aid             = $Aid
        , clName          = (SELECT clName FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , IsPerson        = (SELECT IsPerson FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , Sex             = (SELECT Sex FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , Comment         = (SELECT Comment FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , ParentID        = (SELECT ParentID FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , ffID            = (SELECT ffID FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , CompanyID       = (SELECT CompanyID FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , uID             = (SELECT uID FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , isActual        = (SELECT isActual FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , ActualStatus    = (SELECT ActualStatus FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , IsActive        = (SELECT IsActive FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , responsibleID   = (SELECT responsibleID FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , Created         = (SELECT Created FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , Changed         = NOW()
        , CreatedBy       = (SELECT CreatedBy FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1)
        , ChangedBy       = $emIDEditor
        , `Position`      = (SELECT `Position` FROM crmClient WHERE clID = $delID AND Aid = $Aid LIMIT 1);
      --
      delete from crmClient where clID = $delID AND Aid = $Aid;
      --
      SET $i = $i + 1;
    end while;
    --
    SELECT count(*) s
    INTO $n
    FROM `tmpffID`
    WHERE Aid = $Aid;
    --
    set $i = 0;
    while $i < $n do
      SELECT ffID INTO $delID FROM `tmpffID` WHERE Aid = $Aid LIMIT $i, 1;
      --
      call fs_UpdFileStatus($token, $delID);
      --
      SET $i = $i + 1;
    end while;
    DELETE FROM `tmpID` WHERE Aid = $Aid;
    DELETE FROM `tmpffID` WHERE Aid = $Aid;
  END IF;
  --
END $$
DELIMITER ;
--
