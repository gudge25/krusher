DROP PROCEDURE IF EXISTS fs_ClearDelFile;
DELIMITER $$
CREATE PROCEDURE fs_ClearDelFile(
    $token            VARCHAR(100)
    , $ffID           int
    , $emIDEditor     INT(11)
    , $hostEditor     VARCHAR(50)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_ClearDelFile');
  ELSE
    if $ffID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    if $ffID = 0 then
      -- Запрещено удалять базу клиентов [Default]
      call RAISE(77041, NULL);
    end if;
    --
    DELETE FROM slDealItem WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
    --
    DELETE FROM slDeal WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
    --
    DELETE FROM ccContact WHERE ffID = $ffID AND Aid = $Aid;
    --
    DELETE FROM fmFormItem WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
    --
    DELETE FROM fmForm WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
    --
    DELETE FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID;
    --
    DELETE FROM crmContact WHERE Aid = $Aid AND ffID = $ffID;
    --
    DELETE FROM crmAddress WHERE Aid = $Aid AND clID IN (SELECT clID FROM crmClient WHERE Aid = $Aid AND ffID = $ffID);
    --
    DELETE FROM crmStatus WHERE Aid = $Aid AND ffID = $ffID;
    --
    DELETE FROM crmTagList WHERE Aid = $Aid AND clID IN (SELECT clID FROM crmClient WHERE Aid = $Aid AND ffID = $ffID);
    --
    DELETE FROM crmClientEx WHERE Aid = $Aid AND ffID = $ffID;
    --
    DELETE FROM crmOrg WHERE Aid = $Aid AND clID IN (SELECT clID FROM crmClient WHERE Aid = $Aid AND ffID = $ffID);
    --
    INSERT DUP_crmClient (
        OLD_HIID
        , DUP_InsTime
        , DUP_action
        , DUP_HostName
        , DUP_AppName
        , HIID
        , clID
        , Aid
        , clName
        , IsPerson
        , Sex
        , Comment
        , ParentID
        , ffID
        , CompanyID
        , uID
        , isActual
        , ActualStatus
        , IsActive
        , responsibleID
        , Created
        , Changed
        , CreatedBy
        , ChangedBy
        , `Position`)
    SELECT HIID
        , NOW()
        , 'D'
        , $hostEditor
        , $emIDEditor
        , NULL
        , clID
        , Aid
        , clName
        , IsPerson
        , Sex
        , Comment
        , ParentID
        , ffID
        , CompanyID
        , uID
        , isActual
        , ActualStatus
        , IsActive
        , responsibleID
        , Created
        , NOW()
        , CreatedBy
        , $emIDEditor
        , `Position`
    FROM crmClient WHERE ffID = $ffID AND Aid = $Aid;
    --
    DELETE FROM crmClient WHERE ffID = $ffID AND Aid = $Aid;
    --
    UPDATE fmFormType SET
      ffID = NULL
    WHERE ffID = $ffID AND Aid = $Aid;
    --
    #DELETE FROM fsFile WHERE ffID = $ffID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
