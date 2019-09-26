DELIMITER $$
DROP PROCEDURE IF EXISTS em_Auth;
CREATE PROCEDURE em_Auth(
    $LoginName    VARCHAR(50)
    , $Password   VARCHAR(100)
    , $url        VARCHAR(200)
)
BEGIN
  DECLARE $emPassword   VARCHAR(100);
  DECLARE $emID         INT;
  DECLARE $Aid          INT;
  DECLARE $clientCount  INT;
  DECLARE $idCurrency   INT;
  DECLARE $hostingType  INT;
  DECLARE $phone        BIGINT;
  DECLARE $isActive     BIT;
  DECLARE $CisActive    BIT;
  DECLARE $Token        VARCHAR(100);
  DECLARE $clientName   VARCHAR(255);
  DECLARE $logoUrl      VARCHAR(255);
  DECLARE $emailInfo    VARCHAR(255);
  --
  SET $Password = PASSWORD($password);
  SET $LoginName = LOWER($LoginName);
  --
  SELECT emID, isActive, IF(TokenExpiredDate>NOW(), Token, NULL), Aid
    INTO $emID, $isActive, $Token, $Aid
    FROM emEmploy
    WHERE LoginName = trim($LoginName)
          AND `Password` = trim($Password)
          AND ((url = SUBSTRING_INDEX($url, ':', 1)) OR (url = '127.0.0.1')) LIMIT 1;
  IF($emID IS NULL) THEN
    SELECT emID, isActive, IF(TokenExpiredDate>NOW(), Token, NULL), Aid
           INTO $emID, $isActive, $Token, $Aid
    FROM emEmploy
    WHERE LoginName = trim($LoginName)
      AND Password = trim($Password)
      AND ((url = SUBSTRING_INDEX($url, ':', 1)) OR (url = '127.0.0.1')) LIMIT 1;
  END IF;
  IF $isActive = 0 THEN
    -- Ошибка аутентификации. Логин %s заблокирован
    call RAISE(77061, $LoginName);
  END IF;
  --
  IF ($emID is NULL)THEN
    -- Ошибка аутентификации. не найден пользователь
    call RAISE(77019, NULL);
  END IF;
  --
  IF ($Token is NULL) THEN
    SET $Token = fn_GetToken();
    UPDATE emEmploy SET Token = $Token, TokenExpiredDate = DATE_ADD(NOW(), INTERVAL 1 MONTH) WHERE emID = $emID;
  END IF;
  --
  IF($Aid != 0) THEN
    SELECT phone, email_info, hosting_type, id_currency, client_count, logo_url, client_name, isActive
    INTO $phone, $emailInfo, $hostingType, $idCurrency, $clientCount, $logoUrl, $clientName, $CisActive
    FROM emClient
    WHERE id_client = $Aid LIMIT 1;
    --
    IF $CisActive = 0 THEN
      -- Ошибка аутентификации. Логин %s заблокирован
      call RAISE(77061, $LoginName);
    END IF;
  END IF;
  --
  SELECT
    $emID           emID
    , $LoginName    loginName
    , $Token        Token
    /*, $phone        phone
    , $emailInfo    email
    , $hostingType  hosting
    , $idСurrency   currency
    , $clientСount  clients
    , $logoUrl      logo
    , $clientName   clientName*/;
END $$
DELIMITER ;
--
