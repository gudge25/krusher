DROP PROCEDURE IF EXISTS ast_InsIncomingGoIP;
DELIMITER $$
CREATE PROCEDURE ast_InsIncomingGoIP(
    $name           VARCHAR(15)
    , $number       VARCHAR(15)
    , $content      VARCHAR(2000)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
    DECLARE $Aid          INT;
    DECLARE $dcID         INT;
    DECLARE $trName       VARCHAR(100);
    DECLARE $number2      VARCHAR(15);
    DECLARE $trID         INT;
    DECLARE $sql          VARCHAR(1000);
    DECLARE $sql1         VARCHAR(1000);
    DECLARE $sql2         VARCHAR(1000);
    --
    IF $name IS NULL OR LENGTH(TRIM($name)) = 0 THEN
        call RAISE(77076, 'name');
    END IF;
    --
    IF $number IS NULL OR LENGTH(TRIM($number)) = 0 THEN
        call RAISE(77076, 'number');
    END IF;
    --
    IF $content IS NULL OR LENGTH($content) = 0 THEN
        call RAISE(77076, 'content');
    END IF;
    --
    SET $dcID = NEXTVAL(dcID);
    SELECT trID, trName, Aid
    INTO $trID, $trName, $Aid
    FROM ast_trunk
    WHERE `trName` = CONCAT("t", $name) OR `trName` = CONCAT("GSM", $name) LIMIT 1;
    --
    SET $Aid = IFNULL($Aid, 0);
    --
    call dc_IPInsDoc($Aid, $dcID, 1, NULL, 0, NOW(), NULL, NULL, NULL, 7014, 0, 0, 0, TRUE);
    --
    IF(LOCATE('+', $number) = 1)THEN
        SET $number = RIGHT($number, LENGTH($number)-1);
    END IF;
    SET $number2 = $number;
    /*IF($number REGEXP '/^([0-9]{3,25})*$/i')THEN
        SET $number2 = $number;
    ELSE
        SET $number2 = TRIM($name);
    END IF;*/
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
      , FALSE
      , "', $number2,'"');
    SET $sql1 = CONCAT($sql1, CHAR(10), ', CallType');
    SET $sql2 = CONCAT($sql2, CHAR(10), ', 101312');
    SET $sql1 = CONCAT($sql1, CHAR(10), ', channel');
    SET $sql1 = CONCAT($sql1, CHAR(10), ', trID');
    IF($trName IS NOT NULL OR LENGTH(TRIM($trName))>0) THEN
        SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $trName,'"');
    ELSE
        SET $sql2 = CONCAT($sql2, CHAR(10), ', NULL');
    END IF;
    IF($trID IS NOT NULL OR LENGTH(TRIM($trID))>0) THEN
        SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $trID);
    ELSE
        SET $sql2 = CONCAT($sql2, CHAR(10), ', NULL');
    END IF;
    SET $sql1 = CONCAT($sql1, CHAR(10), ', ccStatus');
    SET $sql2 = CONCAT($sql2, CHAR(10), ', 7014');
    SET $sql1 = CONCAT($sql1, CHAR(10), ', isActive');
    SET $sql2 = CONCAT($sql2, CHAR(10), ', 1');
    --
    SET $sql = CONCAT('INSERT ccContact (', $sql1, ') VALUES (', $sql2, ');');
    -- SELECT $sql;
     CALL query_exec($sql);
    --
    INSERT INTO cc_Sms (HIID, dcID, Aid, emID, timeSend, originator, phone, text_sms, priority, statusSms, IsOut, isActive)VALUES
                        (fn_GetStamp(), $dcID, $Aid, NULL, NOW(), $number, $name, $content, 10, 7014, FALSE, TRUE);
    --
END $$
DELIMITER ;
--
