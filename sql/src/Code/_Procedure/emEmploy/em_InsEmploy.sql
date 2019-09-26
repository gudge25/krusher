DELIMITER $$
DROP PROCEDURE IF EXISTS em_InsEmploy;
CREATE PROCEDURE em_InsEmploy(
    $token                VARCHAR(100)
    , $emID               INT
    , $emName             VARCHAR(50)
    , $LoginName          VARCHAR(30)
    , $Password           VARCHAR(100)
    , $ManageID           INT
    , $roleID             INT
    , $sipName            VARCHAR(50)
    , $Queue              VARCHAR(128)
    , $sipID              INT(11)
    , $companyID          INT(11)
    , $onlineStatus       INT(11)
    , $coID               VARCHAR(50)
    , $pauseDelay         INT(11)
    , $isActive           BIT
    , $url                VARCHAR(250)
    , $emIDEditor         INT(11)
    , $hostEditor         VARCHAR(50)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid      INT;
  DECLARE $HIID     BIGINT;
  DECLARE $uID      BIGINT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_InsEmploy');
  ELSE
    SET $emName = NULLIF(TRIM($emName), '');
    SET $LoginName = NULLIF(TRIM($LoginName), '');
    IF($LoginName = 'root') THEN
      call RAISE(77067, NULL);
    END IF;
    IF($LoginName = 'system') THEN
      call RAISE(77067, NULL);
    END IF;
    --
    IF ($emID is NULL) THEN
      -- Параметр "ID сотрудника" должен иметь значение
      call RAISE(77007, NULL);
    end if;
    IF ($emName is NULL) THEN
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    END IF;
    IF ($LoginName is NULL) THEN
      -- Параметр "Логин" должен иметь значение
      call RAISE(77024, NULL);
    END IF;
    IF ($roleID is NULL) THEN
      -- Параметр "Роль" должен иметь значение
      call RAISE(77029, NULL);
    END IF;
    SET $Password = NULLIF(TRIM($Password), '');
    IF (($Password is NULL) or (LENGTH($Password) < 12)) THEN
      -- Параметр "Пароль" должен иметь значение
      call RAISE(77025, NULL);
    END IF;
    --
    if exists (
      SELECT 1
      FROM emEmploy
      WHERE LoginName = $LoginName AND Aid = $Aid) THEN
      -- Логин "%s", уже используется для другого сотрудника
      call RAISE(77026, $LoginName);
    END IF;
    --
    SET $Queue = NULLIF(TRIM($Queue), '');
    SET $url = NULLIF(TRIM($url), '');
    SET $sipName = NULLIF(TRIM($sipName), '');
    --
    IF ($isActive = TRUE) THEN
      SET $isActive = 1;
    ELSE
      SET $isActive = 0;
    END IF;
    --
    SET $HIID = fn_GetStamp();
    SET $uID = UUID_SHORT();
    INSERT INTO emEmploy (
      HIID
      , emID
      , Aid
      , SipAccount
      , emName
      , isActive
      , LoginName
      , `Password`
      , ManageID
      , sipName
      , Queue
      , url
      , roleID
      , sipID
      , companyID
      , onlineStatus
      , uID
      , coID
      , pauseDelay
    )
    VALUES (
      $HIID
      , $emID
      , $Aid
      , (100000+$emID)
      , $emName
      , $isActive
      , $LoginName
      , PASSWORD($Password)
      , $ManageID
      , $sipName
      , $Queue
      , IF($url IS NULL, (SELECT url FROM emClient WHERE id_client=$Aid), $url)
      , $roleID
      , $sipID
      , $companyID
      , $onlineStatus
      , $uID
      , $coID
      , IF($pauseDelay IS NULL, 60, $pauseDelay)
    );
    --
    IF ($onlineStatus IS NOT NULL) THEN
      call em_IPInsEmployStatus($Aid, $emID, $onlineStatus, TRUE);
    END IF;
    INSERT DUP_emEmploy SET
      OLD_HIID          = NULL
      , DUP_InsTime     = NOW()
      , DUP_action      = 'I'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = $HIID
      , Aid             = $Aid
      , emID            = $emID
      , emName          = $emName
      , LoginName       = $LoginName
      , `Password`      = PASSWORD($Password)
      , Token           = NULL
      , TokenExpiredDate= NULL
      , url             = IF($url IS NULL, (SELECT url FROM emClient WHERE id_client=$Aid), $url)
      , uID             = $uID
      , ManageID        = $ManageID
      , roleID          = $roleID
      , sipID           = $sipID
      , sipName         = $sipName
      , Queue           = $Queue
      , CompanyID       = $CompanyID
      , onlineStatus    = $onlineStatus
      , coID            = $coID
      , isActive        = $isActive
      , pauseDelay      = IF($pauseDelay IS NULL, 60, $pauseDelay)
      ;
  END IF;
END $$
DELIMITER ;
--
