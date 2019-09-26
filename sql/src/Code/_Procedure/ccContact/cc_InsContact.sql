DROP PROCEDURE IF EXISTS cc_InsContact;
DELIMITER $$
CREATE PROCEDURE cc_InsContact(
    $Aid            INT
    , $dcID         INT
    , $ccName       VARCHAR(50)
    , $ccID         INT
    , $IsOut        BIT
    , $disposition  VARCHAR(45)
    , $clID         INT
    , $SIP          VARCHAR(50)
    , $emID         INT
    , $LinkFile     VARCHAR(200)
    , $duration     INT
    , $billsec      INT
    , $holdtime     INT
    , $channel      VARCHAR(50)
    , $isAutocall   BIT
    , $CauseCode    INT
    , $CauseDesc    VARCHAR(200)
    , $CauseWho     INT
    , $CallType     INT
    , $id_autodial  INT
    , $id_scenario  INT
    , $ffID         INT
    , $target       VARCHAR(255)
    , $coID         INT
    , $destination  INT
    , $destdata     INT
    , $destdata2    VARCHAR(100)
    , $transferFrom VARCHAR(250)
    , $transferTo   VARCHAR(250)
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $CurDate          DATETIME;
  DECLARE $dcStatus         INT;
  DECLARE $ffID2            INT;
  DECLARE $sql              VARCHAR(1000);
  DECLARE $sql1             VARCHAR(1000);
  DECLARE $sql2             VARCHAR(1000);
  DECLARE $delclID          INT;
  DECLARE $next1            INT;
  DECLARE $next2            INT;
  DECLARE $IsOut2           INT;
  DECLARE $isAutocall2      INT;
  DECLARE $cName            BIGINT;
  --
  IF ($Aid < 1) THEN
    call RAISE(77068, 'cc_InsContact');
  ELSE
    SET $IsOut = IFNULL($IsOut, 0);
    SET $delclID = IFNULL($delclID, 0);
    SET $next1 = IFNULL($next1, 0);
    SET $next2 = IFNULL($next2, 0);
    SET $SIP = NULLIF(TRIM($SIP), 'NULL');
    SET $isAutocall = NULLIF($isAutocall, 0);
    SET $IsOut2 = IF($IsOut = TRUE, 1, 0);
    SET $isAutocall2 = IF($isAutocall = TRUE, 1, 0);
    SET $id_autodial = IFNULL($id_autodial, 0);
    SET $id_scenario = IFNULL($id_scenario, 0);
    SET $SIP = REPLACE($SIP, CONCAT('_', $Aid), '');
    --
    IF $dcID = 0 or $dcID is NULL THEN
      SET $dcID = NEXTVAL(dcID);
    END IF;
    --
    SET $ccName = fn_GetNumberByString($ccName);
    SET $cName = CAST($ccName AS UNSIGNED);
    --
    IF((SELECT COUNT(1) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'AutoCall_data_procedure') > 0)THEN
        DELETE FROM AutoCall_data_procedure WHERE ffID = $ffID AND clID = $clID AND Aid = $Aid;
        DELETE FROM AutoCall_data_procedure WHERE ccName = $cName AND Aid = $Aid;
    END IF;
    --
    IF $ccID is NULL AND $clID is NULL THEN
      SELECT c.ccID, c.clID, ffID
      INTO $ccID, $clID, $ffID2
      FROM crmContact c
      WHERE c.ccName = $cName
        AND c.isActive = 1
        AND c.ffID IN (SELECT ffID FROM fsFile WHERE isActive = 1)
        AND c.Aid = $Aid
        AND c.ccType = 36
      LIMIT 1;
    ELSEIF $clID is NULL THEN
      SELECT c.clID, ffID
      INTO $clID, $ffID2
      FROM crmContact c
      WHERE c.ccName = $cName
        AND c.isActive = 1
        AND c.ffID IN (SELECT ffID FROM fsFile WHERE isActive = 1)
        AND c.Aid = $Aid
        AND c.ccType = 36
      LIMIT 1;
    ELSEIF $ccID is NULL THEN
      SELECT c.ccID, ffID
      INTO $ccID, $ffID2
      FROM crmContact c
      WHERE c.ccName = $cName
        AND c.isActive = 1
        AND c.ffID IN (SELECT ffID FROM fsFile WHERE isActive = 1)
        AND c.Aid = $Aid
        AND c.ccType = 36
      LIMIT 1;
    END IF;
    --
    IF $ffID is NULL THEN
      IF $ffID2 IS NOT NULL THEN
        SET $ffID = $ffID2;
      ELSE
        SELECT cl.ffID
        INTO $ffID
        FROM crmClient cl
          INNER JOIN crmContact c ON c.clID = cl.clID
        WHERE cl.clID = $clID AND ccType = 36
        LIMIT 1;
      END IF;
    END IF;
    --
    IF($emID IS NULL OR $emID = 0) THEN
      SELECT emID
             INTO $emID
      FROM emEmploy
      WHERE SipName = $SIP AND Aid = $Aid
      LIMIT 1;
    END IF;
    --
    SELECT tvID
    INTO $dcStatus
    FROM usEnumValue
    WHERE tyID = 7
      AND `Name` = $disposition
      AND Aid = $Aid
    LIMIT 1;
    --
    SET $CurDate = NOW();
    SET $clID    = IFNULL($clID, 0);
    SET $ffID    = IFNULL($ffID, 0);
    --
    IF($emID IS NULL) THEN
      SET $emID = 0;
    END IF;
    --
    call dc_IPInsDoc($Aid, $dcID, 1, NULL, 0, $CurDate, NULL, NULL, NULL, $dcStatus, $clID, $emID, 0, $isActive);
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
      , ', $IsOut2, '
      , "', $ccName,'"');
    IF($ccID IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', ccID');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $ccID);
    END IF;
    IF($SIP IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', SIP');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $SIP, '"');
    END IF;
    IF($LinkFile IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', LinkFile');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $LinkFile, '"');
    END IF;
    IF($CauseDesc IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', CauseDesc');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $CauseDesc, '"');
    END IF;
    IF($channel IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', channel');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $channel, '"');
    END IF;
    IF($target IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', target');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $target, '"');
    END IF;
    IF($duration IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', duration');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $duration);
    END IF;
    IF($billsec IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', billsec');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $billsec);
    END IF;
    IF($holdtime IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', holdtime');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $holdtime);
    END IF;
    IF($isAutocall2 IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', isAutocall');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $isAutocall2);
    END IF;
    IF($CauseCode IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', CauseCode');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $CauseCode);
    END IF;
    IF($CauseWho IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', CauseWho');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $CauseWho);
    END IF;
    IF($CallType IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', CallType');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $CallType);
    END IF;
    IF($disposition != 'ANSWERED' AND $disposition != 'RINGING') THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', IsMissed');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', TRUE');
    ELSE
      SET $sql1 = CONCAT($sql1, CHAR(10), ', IsMissed');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', FALSE');
    END IF;
    IF($dcStatus IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', ccStatus');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $dcStatus);
    END IF;
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
    IF($id_autodial IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', id_autodial');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $id_autodial);
    END IF;
    IF($id_scenario IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', id_scenario');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $id_scenario);
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
    IF($coID IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', coID');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $coID);
    END IF;
    IF($destination IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', destination');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $destination);
    END IF;
    IF($destdata IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', destdata');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', ', $destdata);
    END IF;
    IF($destdata2 IS NOT NULL) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', destdata2');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $destdata2, '"');
    END IF;
    IF($transferFrom IS NOT NULL AND LENGTH($transferFrom)>0) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', transferFrom');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $transferFrom, '"');
    END IF;
    IF($transferTo IS NOT NULL AND LENGTH($transferTo)>0) THEN
      SET $sql1 = CONCAT($sql1, CHAR(10), ', transferTo');
      SET $sql2 = CONCAT($sql2, CHAR(10), ', "', $transferTo, '"');
    END IF;
    --
    SET $sql = CONCAT('INSERT ccContact (', $sql1, ') VALUES (', $sql2, ');');
    /*SELECT $sql;*/
    CALL query_exec($sql);
    --
    IF ($disposition != 'RINGING' AND $disposition != 'UP') THEN
      UPDATE crmClientEx SET
        isDial = 0
      WHERE clID = $clID
        AND isDial = 1;
    ELSE
        UPDATE crmClientEx SET
            isDial = 1
        WHERE clID = $clID
          AND isDial = 0;
    END IF;
    --
    call cc_InsContactStat($Aid, $ccName, $IsOut, $disposition, $isAutocall);
    --
    call ast_IncCalles($Aid, $id_autodial);
    --
    call imu_InsContact($dcID, $IsOut, $ccName, $SIP, $disposition, $channel);
    --
  END IF;
END $$
DELIMITER ;
--
