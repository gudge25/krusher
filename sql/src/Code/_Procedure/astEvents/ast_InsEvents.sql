DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsEvents;
CREATE PROCEDURE ast_InsEvents(
    $token              VARCHAR(100)
    , $ccName            BIGINT
    , $SIP              VARCHAR(10)
    , $eventName        VARCHAR(10)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
    DECLARE $Created DATETIME;
  DECLARE $Aid          INT;
  DECLARE $dcID          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsEvents');
  ELSEIF($Aid = 0)THEN
    IF($eventName = 'Unhold') THEN
      UPDATE ast_events
        SET timeEnd = NOW(),
            spentTime =  TIMESTAMPDIFF(SECOND, timeStart, NOW())
        WHERE timeEnd IS NULL
          AND ccName = $ccName
          AND event = 'Hold';
      SELECT Created, dcID
             INTO $Created, $dcID
      FROM ccContact WHERE ccName = $ccName AND ccStatus = 7007 ORDER BY dcID DESC LIMIT 1;
    -- SELECT  $Created, $dcID;
      IF($Created IS NOT NULL) THEN
          UPDATE ccContact SET holdtime = (SELECT SUM(spentTime) FROM ast_events WHERE ccName = $ccName AND timeStart BETWEEN $Created AND NOW()) WHERE dcID = $dcID;
      END IF;
    ELSE
        INSERT IGNORE INTO ast_events (
            ccName,
            SIP,
            event

        )
        VALUES (
                   $ccName,
                   $SIP,
                   $eventName
               );

    END IF;
  END IF;
END $$
DELIMITER ;
--
