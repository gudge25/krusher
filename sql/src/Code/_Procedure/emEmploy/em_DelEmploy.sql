DElIMITER $$
DROP PROCEDURE IF EXISTS em_DelEmploy;
CREATE PROCEDURE em_DelEmploy(
    $token       VARCHAR(100)
    , $emID      INT
    , $emIDEditor         INT(11)
    , $hostEditor         VARCHAR(50)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $LoginName VARCHAR(30);
  DECLARE $SipName    VARCHAR(50);
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_DelEmploy');
  ELSE
    IF ($emID = 0) THEN
      -- Запрещено удалять пользователя [Not Defined]
      call RAISE(77031, NULL);
    END IF;
    --
    SELECT
      LoginName
      , SipName
    INTO
      $LoginName
      , $SipName
    FROM emEmploy
    WHERE emID = $emID AND Aid = $Aid;
    --
    INSERT DUP_emEmploy SET
      OLD_HIID          = (SELECT HIID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , DUP_InsTime     = NOW()
      , DUP_action      = 'D'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = NULL
      , Aid             = $Aid
      , emID            = $emID
      , emName          = (SELECT emName FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , LoginName       = (SELECT LoginName FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , `Password`      = (SELECT `Password` FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , Token           = (SELECT Token FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , TokenExpiredDate= (SELECT TokenExpiredDate FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , url             = (SELECT url FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , ManageID        = (SELECT ManageID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , roleID          = (SELECT roleID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , sipID           = (SELECT sipID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , sipName         = (SELECT sipName FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , Queue           = (SELECT Queue FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , CompanyID       = (SELECT CompanyID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , onlineStatus    = (SELECT onlineStatus FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , isActive        = (SELECT isActive FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , uID             = (SELECT uID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , coID            = (SELECT coID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
    ;
    DELETE FROM emEmploy
    WHERE emID = $emID AND Aid = $Aid;
    --
    delete from ast_sippeers
    where emID = $emID AND Aid = $Aid;
    --
  END IF;
  --
END $$
DELIMITER ;
--
