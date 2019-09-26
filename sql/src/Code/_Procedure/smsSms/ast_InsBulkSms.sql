DROP PROCEDURE IF EXISTS ast_InsBulkSms;
DELIMITER $$
CREATE PROCEDURE ast_InsBulkSms(
    $token          VARCHAR(100)
    , $bulkID       INT
    , $originator   VARCHAR(15)
    , $ffID         INT
    , $text_sms     TEXT
    , $timeBegin    DATETIME
    , $emID         INT
    , $status       INT
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid         INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid < 1) THEN
    call RAISE(77068, 'ast_InsBulkSms');
  ELSE
    --
    IF $bulkID = 0 or $bulkID is NULL THEN
      SET $bulkID = NEXTVAL(bulkID);
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
    IF $text_sms IS NULL OR LENGTH(TRIM($text_sms)) = 0 THEN
        call RAISE(77076, 'text_sms');
    END IF;
    IF $ffID IS NULL OR LENGTH(TRIM($ffID)) = 0 THEN
        call RAISE(77076, 'ffID');
    END IF;
    --
    INSERT INTO cc_SmsBulk (HIID, bulkID, Aid, originator, ffID, text_sms, timeBegin, emID, status, isActive)VALUES
                       (fn_GetStamp(), $bulkID, $Aid, $originator, $ffID, $text_sms, $timeBegin, $emID, $status, $isActive);
    --
  END IF;
END $$
DELIMITER ;
--
