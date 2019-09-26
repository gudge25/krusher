DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdClient;
CREATE PROCEDURE crm_UpdClient(
    $HIID             bigint
    , $token          VARCHAR(100)
    , $clID           int
    , $clName         VARCHAR(200)
    , $IsPerson       bit
    , $Sex            INT(11)
    , $Comment        VARCHAR(200)
    , $ffID           int
    , $ParentID       int
    , $CompanyID      int
    , $isActual       BIT
    , $responsibleID  INT(11)
    , $ActualStatus   int
    , $Position       int
    , $IsActive       bit
    , $emIDEditor     INT(11)
    , $hostEditor     VARCHAR(50)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $emID       int;
  DECLARE $Aid        INT;
  DECLARE $newHIID    BIGINT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdClient');
  ELSE
    SET $emID = fn_GetEmployID($token);
    if $clID is NULL then
      -- Запрещено изменять клиента [Not Found]
      call RAISE(77040, NULL);
    end if;
    --
    if not exists (
      select 1
      from crmClient
      where HIID = $HIID
        and clID = $clID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    IF($IsPerson = FALSE AND $Sex IS NOT NULL)THEN
      SET $Sex = NULL;
    END IF;
    --
    SET $newHIID = fn_GetStamp();
    --
    UPDATE crmClient SET
      clName          = $clName
      , IsPerson      = IF($IsPerson = TRUE, 1, 0)
      , IsActive      = IF($IsActive = TRUE, 1, 0)
      , Comment       = IF($Comment IS NULL, NULL, $Comment)
      , ffID          = $ffID
      , ParentID      = IF($ParentID IS NULL, NULL, $ParentID)
      , CompanyID     = IF($CompanyID IS NULL, NULL, $CompanyID)
      , isActual      = IF($isActual = TRUE, 1, 0)
      , ChangedBy     = $emID
      , responsibleID = IF($responsibleID IS NULL, NULL, $responsibleID)
      , ActualStatus  = IF($ActualStatus IS NULL, NULL, $ActualStatus)
      , `Position`    = IF($Position IS NULL, NULL, $Position)
      , HIID          = $newHIID
      , Sex           = $Sex
      , `Changed`     = NOW()
    where clID = $clID AND Aid = $Aid;
    --
    UPDATE dcDoc SET ffID = $ffID WHERE clID = $clID AND Aid = $Aid;
    --
    UPDATE crmClientEx SET ffID = $ffID WHERE clID = $clID AND Aid = $Aid;
    --
    UPDATE crmContact SET ffID = $ffID WHERE clID = $clID AND Aid = $Aid;
    --
    UPDATE crmStatus SET ffID = $ffID WHERE clID = $clID AND Aid = $Aid;
    --
    INSERT DUP_crmClient SET
      OLD_HIID          = $HIID
      , DUP_InsTime     = NOW()
      , DUP_action      = 'U'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = $newHIID
      , clID            = $clID
      , Aid             = $Aid
      , clName          = $clName
      , IsPerson        = $IsPerson
      , Sex             = IF($Sex = TRUE, 1, 0)
      , Comment         = $Comment
      , ParentID        = $ParentID
      , ffID            = $ffID
      , CompanyID       = $CompanyID
      , uID             = (SELECT uID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , isActual        = IF($isActual = TRUE, 1, 0)
      , ActualStatus    = $ActualStatus
      , IsActive        = $IsActive
      , responsibleID   = $responsibleID
      , Created         = (SELECT Created FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , Changed         = NOW()
      , CreatedBy       = (SELECT CreatedBy FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , ChangedBy       = $emIDEditor
      , `Position`      = $Position;
  END IF;
END $$
DELIMITER ;
--
