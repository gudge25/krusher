DROP PROCEDURE IF EXISTS em_UpdEmployStatus;
DELIMITER $$
CREATE PROCEDURE em_UpdEmployStatus(
    $token              VARCHAR(100)
    , $emID               INT
    , $onlineStatus       INT(11)
    , $emIDEditor         INT(11)
    , $hostEditor         VARCHAR(50)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE   $Aid           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_UpdEmployStatus');
  ELSE
    --
    IF ($emID is NULL) THEN
      -- Параметр "ID сотрудника" должен иметь значение
      call RAISE(77007, NULL);
    END IF;
        --
      UPDATE emEmploy SET
        onlineStatus      = $onlineStatus
      WHERE emID = $emID AND Aid = $Aid;

    IF ($onlineStatus IS NOT NULL) THEN
      call em_IPInsEmployStatus($Aid, $emID, $onlineStatus, TRUE);
    END IF;
    --
    /*INSERT DUP_emEmploy SET
      OLD_HIID          = (SELECT HIID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , DUP_InsTime     = NOW()
      , DUP_action      = 'U'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = (SELECT HIID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , Aid             = $Aid
      , emID            = $emID
      , emName          = (SELECT emName FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , LoginName       = (SELECT LoginName FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , `Password`      = (SELECT `Password` FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , Token           = NULL
      , TokenExpiredDate= NULL
      , url             = (SELECT url FROM emClient WHERE id_client=$Aid)
      , uID             = (SELECT uID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , ManageID        = (SELECT ManageID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , roleID          = (SELECT roleID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , sipID           = (SELECT sipID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , sipName         = (SELECT sipName FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , Queue           = (SELECT Queue FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , CompanyID       = (SELECT CompanyID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , onlineStatus    = $onlineStatus
      , coID            = (SELECT coID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , isActive        = (SELECT isActive FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
    ;*/
  END IF;
END $$
DELIMITER ;
--
