DROP PROCEDURE IF EXISTS ast_InsSingleSms;
DELIMITER $$
CREATE PROCEDURE ast_InsSingleSms(
    $token          VARCHAR(100)
    , $dcID         INT
    , $emID         INT
    , $ccID         INT
    , $clID         INT
    , $ffID         INT
    , $originator   VARCHAR(15)
    , $ccName       BIGINT
    , $text_sms     TEXT
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid         INT;
  DECLARE $sql              VARCHAR(1000);
  DECLARE $sql1             VARCHAR(1000);
  DECLARE $sql2             VARCHAR(1000);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid < 1) THEN
    call RAISE(77068, 'ast_InsSingleSms');
  ELSE
    --
    IF $dcID = 0 or $dcID is NULL THEN
      SET $dcID = NEXTVAL(dcID);
      /*SET $dcID = us_GetNextSequence('dcID');*/
    END IF;
    --
    IF $originator IS NULL OR LENGTH(TRIM($originator)) = 0 THEN
        SELECT data1
        INTO $originator
        FROM mp_IntegrationInstall
        WHERE Aid = $Aid AND mpID = 1
        LIMIT 1;
        IF $originator IS NULL OR LENGTH(TRIM($originator)) = 0 THEN
            call RAISE(77076, 'originator');
        END IF;
    END IF;
    --
    IF $ccName IS NULL OR LENGTH(TRIM($ccName)) = 0 THEN
        call RAISE(77076, 'ccName');
    END IF;
    --
    IF $text_sms IS NULL OR LENGTH(TRIM($text_sms)) = 0 THEN
        call RAISE(77076, 'text_sms');
    END IF;
    --
    call dc_IPInsDoc($Aid, $dcID, 1, NULL, 0, NOW(), NULL, NULL, NULL, 7012, $clID, $emID, 0, $isActive);
    --
    SET $sql1 = 'HIID
      , uID
      , Aid
      , dcID
      , IsOut
      , ccName';
    SET $sql2 = CONCAT('fn_GetStamp()
      , UUID_SHORT()
      , ', $Aid, '
      , ', $dcID, '
      , TRUE
      , "', $ccName,'"');
    IF($ccID IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', ccID');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $ccID);
    END IF;
    SET $sql1 = CONCAT($sql1, CHAR(10), ', CallType');
    SET $sql2 = CONCAT($sql2, CHAR(10), ', 101312');
    SET $sql1 = CONCAT($sql1, CHAR(10), ', ccStatus');
    SET $sql2 = CONCAT($sql2, CHAR(10), ', 7012');
    IF($emID IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', emID');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $emID);
    END IF;
    IF($clID IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', clID');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', abs($clID));
    END IF;
    IF($ffID IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', ffID');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $ffID);
    END IF;
    IF($isActive IS NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', isActive');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', 1');
    ELSE
      IF($isActive = TRUE) THEN
        SET $sql1 = CONCAT($sql1, CHAR(10), ', isActive');
        SET $sql2 = CONCAT($sql2, CHAR(10), ', 1');
      ELSE
        SET $sql1 = CONCAT($sql1, CHAR(10), ', isActive');
        SET $sql2 = CONCAT($sql2, CHAR(10), ', 0');
      END IF;
    END IF;
    --
    SET $sql = CONCAT('INSERT ccContact (', $sql1, ') VALUES (', $sql2, ');');
    -- SELECT $sql;
    CALL query_exec($sql);
    --
    INSERT INTO cc_Sms (HIID, dcID, Aid, emID, timeSend, originator, phone, text_sms, priority, statusSms, IsOut, isActive)VALUES
                       (fn_GetStamp(), $dcID, $Aid, $emID, NOW(), $originator, $ccName, $text_sms, 10, 7012, TRUE, $isActive);
    --
  END IF;
END $$
DELIMITER ;
--
