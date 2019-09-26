DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetMonitoring;
CREATE PROCEDURE ast_GetMonitoring(
    $token              VARCHAR(100)
    , $SIP              VARCHAR(30)
    , $startDate        DATETIME
    , $endDate          DATETIME
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetMonitoring');
  ELSE
    IF ($SIP IS NULL) THEN
      SELECT
        'full'                                      SIP,
        dev_state                                   eventName,
        concat(SUBSTR(start_time, 1, 14), '00:00')  hourer,
        IF(count(*)>0, 'On', 'Off')                 eventSwitch,
        count(*)                                    counter
      FROM ast_monitoring
      WHERE dev_state IN ('INUSE', 'NOT_INUSE', 'UNAVAILABLE')
        AND SIP IN (SELECT SipName FROM emEmploy)
        AND start_time BETWEEN $startDate AND $endDate AND Aid = $Aid
      GROUP BY dev_state, hourer
      ORDER BY ID ASC;
    ELSE
      SELECT
        SIP                                         SIP,
        dev_state                                   eventName,
        concat(SUBSTR(start_time, 1, 14), '00:00')  hourer,
        IF(count(*)>0, 'On', 'Off')                 eventSwitch,
        count(*)                                    counter
      FROM ast_monitoring
      WHERE dev_state IN ('INUSE', 'NOT_INUSE', 'UNAVAILABLE')
        AND SIP = $SIP
        AND start_time BETWEEN $startDate AND $endDate AND Aid = $Aid
      GROUP BY SIP, dev_state, hourer
      ORDER BY ID ASC;
    END IF;
  END IF;
END $$
DELIMITER ;
--
