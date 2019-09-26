DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelClient;
CREATE PROCEDURE crm_DelClient(
    $token            VARCHAR(100)
    , $clID           INT
    , $customeDelete  BIT
    , $emIDEditor     INT(11)
    , $hostEditor     VARCHAR(50)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $ffID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelClient');
  ELSE
    if $clID is NULL then
      -- 'Параметр ID клиента должен иметь значение';
      call raise(77004, NULL);
    end if;
    --
    if $clID = 0 then
      -- Запрещено изменять клиента [Not Defined]
      call RAISE(77040, NULL);
    end if;
    --
    SELECT ffID
    INTO $ffID
    FROM crmClient
    WHERE clID = $clID;
    --
    IF ($customeDelete = TRUE) THEN
      DELETE FROM ccContact WHERE clID = $clID AND Aid = $Aid;
    ELSE
      UPDATE ccContact SET ccID=NULL, clID=NULL, ffID=NULL WHERE clID=$clID;
    END IF;
    --
    DELETE FROM fmFormItem WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $clID) AND Aid = $Aid;
    --
    DELETE FROM fmForm WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $clID) AND Aid = $Aid;
    --
    DELETE FROM slDealItem WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $clID) AND Aid = $Aid;
    --
    DELETE FROM slDeal WHERE dcID IN (SELECT dcID FROM dcDoc WHERE clID = $clID) AND Aid = $Aid;
    --
    delete from dcDoc where clID = $clID AND Aid = $Aid;
    --
    delete from crmPerson where clID = $clID AND Aid = $Aid;
    --
    delete from crmContact where clID = $clID AND Aid = $Aid;
    --
    delete from crmStatus where clID = $clID AND Aid = $Aid;
    --
    delete from crmOrg where clID = $clID AND Aid = $Aid;
    --
    delete from crmClientEx where clID = $clID AND Aid = $Aid;
    --
    delete from crmTagList where clID = $clID AND Aid = $Aid;
    --
    delete from crmAddress where clID = $clID AND Aid = $Aid;
    --
    INSERT DUP_crmClient SET
      OLD_HIID          = (SELECT HIID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , DUP_InsTime     = NOW()
      , DUP_action      = 'D'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = NULL
      , clID            = $clID
      , Aid             = $Aid
      , clName          = (SELECT clName FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , IsPerson        = (SELECT IsPerson FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , Sex             = (SELECT Sex FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , Comment         = (SELECT Comment FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , ParentID        = (SELECT ParentID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , ffID            = (SELECT ffID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , CompanyID       = (SELECT CompanyID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , uID             = (SELECT uID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , isActual        = (SELECT isActual FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , ActualStatus    = (SELECT ActualStatus FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , IsActive        = (SELECT IsActive FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , responsibleID   = (SELECT responsibleID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , Created         = (SELECT Created FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , Changed         = NOW()
      , CreatedBy       = (SELECT CreatedBy FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , ChangedBy       = $emIDEditor
      , `Position`      = (SELECT `Position` FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1);
    --
    delete from crmClient where clID = $clID AND Aid = $Aid;
    --
    call fs_UpdFileStatus($token, $ffID);
  END IF;
END $$
DELIMITER ;
--
