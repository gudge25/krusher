DROP PROCEDURE IF EXISTS imu_InsContact;
DELIMITER $$
CREATE PROCEDURE imu_InsContact(
  $dcID           INT
  , $IsOut        BIT
  , $ccName       VARCHAR(50)
  , $SIP          VARCHAR(50)
  , $disposition  VARCHAR(45)
  , $channel      VARCHAR(50)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
 /* SELECT $dcID, $ccName, $SIP, $disposition;*/
  IF (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'meduchet' AND table_name = 'fifo') THEN
    IF($disposition = 'RINGING') THEN
      INSERT INTO meduchet.fifo (`type`, src, dst, trunk, state, uniqueid, channel, source)
        VALUES(IF($IsOut = TRUE OR $IsOut = 1, 'OUT', 'IN'), $ccName, $SIP, $channel, 'RINGING', $dcID, $channel, 'krusher');
    ELSE
       UPDATE meduchet.fifo SET
         state = IF($disposition = 'UP', 'UP', 'HANGUP')
         /*, `type` = 'OUT'*/
         , dst = $SIP
       WHERE uniqueid = $dcID;
    END IF;
  END IF;
END $$
DELIMITER ;
--
