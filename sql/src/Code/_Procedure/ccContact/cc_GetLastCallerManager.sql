DELIMITER $$
DROP PROCEDURE IF EXISTS cc_GetLastCallerManager;
CREATE PROCEDURE cc_GetLastCallerManager(
    $token          VARCHAR(100)
    , $callerID     BIGINT
    , $type         INT
    , $AidF         INT
)
BEGIN
  DECLARE $Aid          INT;
  DECLARE $SipName      VARCHAR(50);
  DECLARE $emName       VARCHAR(200);
  DECLARE $clName       VARCHAR(200);
  DECLARE $emID         INT;
  DECLARE $clID         INT;
  DECLARE $ID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetLastCallerManager');
  ELSEIF($Aid = 0) THEN
    IF($type = 101401) THEN /*Queue*/
      SELECT clID, destdata
      INTO $clID, $ID
      FROM ccContact
      WHERE ccStatus = 7001
        AND ccName = $callerID
        AND destination = $type
        AND Aid = $AidF
      ORDER BY dcID DESC
      LIMIT 1;
      --
      IF($ID IS NOT NULL) THEN
        SELECT queID, `name` queName, (SELECT clID FROM crmClient WHERE clID = $clID LIMIT 1) clID, (SELECT clName FROM crmClient WHERE clID = $clID LIMIT 1) clName
        FROM ast_queues
        WHERE queID = $ID AND Aid = $AidF
        LIMIT 1;
      END IF;
    ELSE /*extension*/
      SELECT clID
      INTO $clID
      FROM crmContact
      WHERE ccType = 36
        AND ccName = $callerID
        AND Aid = $AidF
        AND ffID IN (SELECT ffID FROM fsFile WHERE isActive = 1)
      ORDER BY isActive DESC
      LIMIT 1;
      --
      IF($clID IS NULL)THEN /*если нет такого контакта*/
        SELECT clID, emID, SIP
        INTO $clID, $ID, $SipName
        FROM ccContact
        WHERE ccStatus = 7001
          AND ccName = $callerID
          AND emID > 0
          AND Aid = $AidF
        ORDER BY dcID DESC
        LIMIT 1;
        --
        IF($ID IS NOT NULL AND $ID > 0)THEN
          SELECT $SipName SIP, emID, emName, (SELECT clID FROM crmClient WHERE clID = $clID LIMIT 1) clID, (SELECT clName FROM crmClient WHERE clID = $clID LIMIT 1) clName
          FROM emEmploy
          WHERE emID = $ID AND Aid = $AidF AND isActive = TRUE
          LIMIT 1;
        END IF;
      ELSE /*если есть контакт*/
        SELECT responsibleID
        INTO $emID
        FROM crmClient
        WHERE clID = $clID
          AND Aid = $AidF
        LIMIT 1;
        --
        IF($emID IS NULL)THEN /*если нет ответственного*/
          SELECT clID, emID, SIP
          INTO $clID, $ID, $SipName
          FROM ccContact
          WHERE ccStatus = 7001
            AND ccName = $callerID
            AND emID > 0
            AND Aid = $AidF
          ORDER BY dcID DESC
          LIMIT 1;
          --
          IF($ID IS NOT NULL AND $ID > 0)THEN
            SELECT $SipName SIP, emID, emName, (SELECT clID FROM crmClient WHERE clID = $clID LIMIT 1) clID, (SELECT clName FROM crmClient WHERE clID = $clID LIMIT 1) clName
            FROM emEmploy
            WHERE emID = $ID AND Aid = $AidF AND isActive = TRUE
            LIMIT 1;
          END IF;
        ELSE
          SELECT sipName SIP, emID, emName, (SELECT clID FROM crmClient WHERE clID = $clID LIMIT 1) clID, (SELECT clName FROM crmClient WHERE clID = $clID LIMIT 1) clName
          FROM emEmploy
          WHERE emID = $emID AND Aid = $AidF AND isActive = TRUE
          LIMIT 1;
        END IF;
      END IF;
    END IF;
  END IF;
END $$
DELIMITER ;
--
