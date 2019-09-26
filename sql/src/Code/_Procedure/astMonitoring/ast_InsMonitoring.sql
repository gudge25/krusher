DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsMonitoring;
CREATE PROCEDURE ast_InsMonitoring(
    $token              VARCHAR(100)
    , $SIP              VARCHAR(30)
    , $eventName        VARCHAR(30)
    , $dev_status       VARCHAR(30)
    , $dev_state        VARCHAR(30)
    , $pause            BIT
    , $address          VARCHAR(20)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsMonitoring');
  ELSE
    IF($dev_state = 'NOT_INUSE') THEN
      UPDATE ast_monitoring
        SET end_time = NOW(),
            spend_sec =  TIMESTAMPDIFF(SECOND, start_time, NOW())
        WHERE end_time IS NULL
          AND Aid = $Aid
          AND SIP = $SIP
          AND eventName = 'DeviceStateChange'
          AND dev_state = 'INUSE'
          AND end_time IS NULL;
    END IF;
    INSERT INTO ast_monitoring (
        Aid,
        SIP,
        eventName,
        dev_status,
        dev_state,
        pause,
        address
      )
      VALUES (
        $Aid,
        $SIP,
        $eventName,
        $dev_status,
        $dev_state,
        $pause,
        $address
      );
  END IF;
END $$
DELIMITER ;
--
