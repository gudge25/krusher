DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsClient;
CREATE PROCEDURE crm_InsClient(
    $token            VARCHAR(100)
    , $clID           int
    , $clName         varchar(200)
    , $IsPerson       bit
    , $Sex            INT(11)
    , $Comment        varchar(200)
    , $ffID           int
    , $ParentID       int
    , $CompanyID      int
    , $isActual       BIT
    , $responsibleID  INT(11)
    , $ActualStatus   INT
    , $Position       int
    , $IsActive       bit
    , $emIDEditor     INT(11)
    , $hostEditor     VARCHAR(50)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  DECLARE $emID         INT;
  DECLARE $HIID         BIGINT;
  DECLARE $uID          BIGINT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsClient');
  ELSE
    --
    if ($clID is NULL) then
      -- Параметр "ID клинта" должен иметь значение
      call RAISE(77004,NULL);
    end if;
    --
    SET $emID = fn_GetEmployID($token);
    --
    IF(($IsPerson = FALSE) AND ($Sex IS NOT NULL))THEN
      SET $Sex = NULL;
    END IF;
    --
    SET $HIID = fn_GetStamp();
    SET $uID = UUID_SHORT();
    INSERT crmClient (
      clID
      , clName
      , IsPerson
      , IsActive
      , Comment
      , ffID
      , ParentID
      , CompanyID
      , Aid
      , CreatedBy
      , `Position`
      , HIID
      , isActual
      , responsibleID
      , ActualStatus
      , uID
      , Sex
    )
    VALUES (
      $clID
      , $clName
      , $IsPerson
      , $IsActive
      , $Comment
      , $ffID
      , $ParentID
      , $CompanyID
      , $Aid
      , $emID
      , $Position
      , $HIID
      , if($isActual = TRUE, 1, 0)
      , $responsibleID
      , $ActualStatus
      , $uID
      , $Sex
    );
    --
    call crm_InsClientEx($token, $clID, NULL, FALSE, FALSE, FALSE, FALSE, NULL, NULL, NULL, NULL, TRUE);
    call crm_IPInsClientStatus($clID, $Aid, $ffID);
    INSERT DUP_crmClient SET
      OLD_HIID          = NULL
      , DUP_InsTime     = NOW()
      , DUP_action      = 'I'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = $HIID
      , clID            = $clID
      , Aid             = $Aid
      , clName          = $clName
      , IsPerson        = $IsPerson
      , Sex             = IF($Sex = TRUE, 1, 0)
      , Comment         = $Comment
      , ParentID        = $ParentID
      , ffID            = $ffID
      , CompanyID       = $CompanyID
      , uID             = $uID
      , isActual        = if($isActual = TRUE, 1, 0)
      , ActualStatus    = $ActualStatus
      , Created         = NOW()
      , IsActive        = $IsActive
      , responsibleID   = $responsibleID
      , CreatedBy       = $emIDEditor
      , ChangedBy       = $emIDEditor
      , `Position`      = $Position;
  END IF;
END $$
DELIMITER ;
--
