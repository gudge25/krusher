DROP PROCEDURE IF EXISTS em_UpdEmploy;
DELIMITER $$
CREATE PROCEDURE em_UpdEmploy(
    $HIID                 BIGINT
    , $token              VARCHAR(100)
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
    , $emIDEditor         INT(11)
    , $hostEditor         VARCHAR(50)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE   $newHIID        BIGINT;
  DECLARE   $OLD_LoginName VARCHAR(30);
  DECLARE   $OLD_HIID      BIGINT;
  DECLARE   $Aid           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_UpdEmploy');
  ELSE
    SET $LoginName = NULLIF(TRIM($LoginName), '');
    SET $emName = NULLIF(TRIM($emName), '');
    --
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
    END IF;
    IF ($emName is NULL) THEN
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    END IF;
    IF ($LoginName is NULL) THEN
      -- Параметр "Логин" должен иметь значение
      call RAISE(77024, NULL);
    END IF;
    IF ($emID = 0) THEN
      -- Запрещено изменять пользователя [Not Defined]
      call RAISE(77030, NULL);
    END IF;
    --
    SET $Password = NULLIF(TRIM($Password), '');
    IF (($Password is NOT NULL) AND (LENGTH($Password) < 12)) THEN
      -- Параметр "Пароль" должен иметь значение
      call RAISE(77025, NULL);
    END IF;
    --
    SELECT LoginName, HIID
    INTO $OLD_LoginName, $OLD_HIID
    FROM emEmploy
    WHERE emID = $emID;
    --
    IF $HIID != IFNULL($OLD_HIID, -999)THEN
      -- Запись была изменена или удалена другим пользователем. Обновите данные без сохранения и выполните действия еще раз
      call RAISE(77003, NULL);
    END IF;
    --
    IF ($roleID is NULL) THEN
      -- Параметр "Роль" должен иметь значение
      call RAISE(77029, NULL);
    END IF;
    --
    SET $Queue = NULLIF(TRIM($Queue), '');
    SET $sipName = NULLIF(TRIM($sipName), '');
    SET $newHIID = fn_GetStamp();
    --
    IF ($Password is NULL) THEN
      UPDATE emEmploy SET
        HIID                = $newHIID
        , emName            = $emName
        , IsActive          = $isActive
        , ManageID          = $ManageID
        , LoginName         = $LoginName
        , sipName           = $sipName
        , Queue             = $Queue
        , sipID             = $sipID
        , companyID         = $companyID
        , onlineStatus      = $onlineStatus
        , coID              = $coID
        , pauseDelay        = $pauseDelay
      WHERE emID = $emID AND Aid = $Aid;
    ELSE
      UPDATE emEmploy SET
        HIID                = $newHIID
        , emName            = $emName
        , IsActive          = $isActive
        , ManageID          = $ManageID
        , LoginName         = $LoginName
        , `Password`        = PASSWORD($Password)
        , sipName           = $sipName
        , Queue             = $Queue
        , TokenExpiredDate  = NOW()
        , sipID             = $sipID
        , companyID         = $companyID
        , onlineStatus      = $onlineStatus
        , coID              = $coID
        , pauseDelay        = $pauseDelay
      WHERE emID = $emID AND Aid = $Aid;
    END IF;
    --
    IF($roleID IS NOT NULL) THEN
      UPDATE emEmploy SET
        roleID            = $roleID
      WHERE emID = $emID AND Aid = $Aid;
    END IF;
    --
    update ast_sippeers set
      isActive = $isActive
    where sipID = $sipID AND Aid = $Aid;
    --
    IF ($onlineStatus IS NOT NULL) THEN
      call em_IPInsEmployStatus($Aid, $emID, $onlineStatus, TRUE);
    END IF;
    --
    INSERT DUP_emEmploy SET
      OLD_HIID          = $HIID
      , DUP_InsTime     = NOW()
      , DUP_action      = 'U'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = $newHIID
      , Aid             = $Aid
      , emID            = $emID
      , emName          = $emName
      , LoginName       = $LoginName
      , `Password`      = PASSWORD($Password)
      , Token           = NULL
      , TokenExpiredDate= NULL
      , url             = (SELECT url FROM emClient WHERE id_client=$Aid)
      , uID             = (SELECT uID FROM emEmploy WHERE emID = $emID AND Aid = $Aid LIMIT 1)
      , ManageID        = $ManageID
      , roleID          = $roleID
      , sipID           = $sipID
      , sipName         = $sipName
      , Queue           = $Queue
      , CompanyID       = $CompanyID
      , onlineStatus    = $onlineStatus
      , coID            = $coID
      , isActive        = $isActive
      , pauseDelay      = $pauseDelay
    ;
  END IF;
END $$
DELIMITER ;
--
