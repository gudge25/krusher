DROP PROCEDURE IF EXISTS cc_UpdContact;
DELIMITER $$
CREATE PROCEDURE cc_UpdContact(
    $dcID               INT
    , $ccName           VARCHAR(50)
    , $ccID             INT
    , $IsOut            BIT
    , $disposition      VARCHAR(45)
    , $clID             INT
    , $SIP              VARCHAR(50)
    , $emID             INT
    , $LinkFile         VARCHAR(200)
    , $duration         INT
    , $billsec          INT
    , $holdtime         INT
    , $channel          VARCHAR(50)
    , $isAutocall       BIT
    , $CauseCode        INT
    , $CauseDesc        VARCHAR(200)
    , $CauseWho         INT
    , $CallType         INT
    , $id_autodial      INT
    , $id_scenario      INT
    , $ffID             INT
    , $target           VARCHAR(255)
    , $coID             INT
    , $destination      INT
    , $destdata         INT
    , $destdata2        VARCHAR(100)
    , $transferFrom     VARCHAR(250)
    , $transferTo       VARCHAR(250)
    , $Comment          VARCHAR(250)
    , $ContactStatus    INT
    , $isAsterisk       BIT
    , $isActive         BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $CurDate          DATETIME;
  DECLARE $dcStatus         INT;
  DECLARE $delclID          INT;
  DECLARE $trID             INT;
  DECLARE $next1            INT;
  DECLARE $next2            INT;
  DECLARE $IsOut2           INT;
  DECLARE $serviceLevel     INT;
  DECLARE $isAutocall2      INT;
  DECLARE $Aid              INT;
  DECLARE $cName            BIGINT;
  DECLARE $sql              VARCHAR(1000);
  IF($isAsterisk = TRUE)THEN
      SET $ccName = REPLACE($ccName, '+', '');
      SET $ccName = NULLIF(TRIM(LEADING '0' FROM LEFT($ccName, 50)), '');
      --
      SET $ccName = fn_GetNumberByString($ccName);
      SET $cName = CAST($ccName AS UNSIGNED);
      --
      IF(($disposition = 'UP')) THEN
        IF($SIP != $ccName) THEN
            If($dcID IS NOT NULL AND $dcID > 0)THEN
                UPDATE ccContact SET
                    ccStatus        = 7007
                    , upTime        = NOW()
                WHERE dcID = $dcID AND ccStatus = 7006;
            ELSE
                SELECT IsOut, Aid, dcID, isAutocall, ccStatus
                INTO $IsOut2, $Aid, $dcID, $isAutocall2, $dcStatus
                FROM ccContact
                WHERE ccName = $cName
                  AND ccStatus = 7006
                  AND Created > DATE_ADD(NOW(), INTERVAL -120 MINUTE)
                ORDER BY dcID DESC
                LIMIT 1;
                IF($dcStatus = 7006)THEN
                    SET $SIP = SUBSTRING_INDEX($SIP, '_', 1);
                    SELECT tvID INTO $dcStatus FROM usEnumValue WHERE `Name` = $disposition AND Aid = $Aid LIMIT 1;
                    --
                    IF($emID IS NULL)THEN
                        SET $emID = 0;
                    END IF;
                    --
                    IF(($dcID IS NOT NULL) && ($dcStatus IS NOT NULL) && ($emID IS NOT NULL)) THEN
                        call cc_InsContactStat($Aid, $ccName, $IsOut2, $disposition, $isAutocall2);
                        --
                        call imu_InsContact($dcID, $IsOut2, $ccName, $SIP, $disposition, $channel);
                        --
                        UPDATE ccContact SET
                            SIP             = IF($SIP IS NOT NULL, $SIP, NULL)
                                           , `channel`     = IF($channel IS NULL, '', $channel)
                                           , ccStatus      = IF($dcStatus IS NULL, '', $dcStatus)
                                           , emID          = IF($emID IS NULL, NULL, $emID)
                                           , upTime        = NOW()
                        WHERE dcID = $dcID AND ccStatus = 7006;
                    END IF;
                END IF;
            END IF;
          /*

          --
          */
        ELSE
            SELECT IsOut, Aid, dcID, isAutocall, ccStatus
                   INTO $IsOut2, $Aid, $dcID, $isAutocall2, $dcStatus
            FROM ccContact
            WHERE dcID = $dcID

            /*ccName = $cName
              AND ccStatus = 7006
              AND Created > DATE_ADD(NOW(), INTERVAL -120 MINUTE)
            ORDER BY dcID DESC*/
            LIMIT 1;
            IF($dcStatus = 7006)THEN
                -- SET $SIP = SUBSTRING_INDEX($SIP, '_', 1);
                SELECT tvID INTO $dcStatus FROM usEnumValue WHERE `Name` = $disposition AND Aid = $Aid LIMIT 1;
                --
                /*IF($emID IS NULL OR $emID = 0)THEN
                    SELECT emID
                           INTO $emID
                    FROM emEmploy
                    WHERE SipName = $SIP AND Aid = $Aid
                    LIMIT 1;
                END IF;
                IF($emID IS NULL)THEN*/
                    SET $emID = 0;
                -- END IF;
                --
                IF(($dcID IS NOT NULL) && ($dcStatus IS NOT NULL)) THEN
                    call cc_InsContactStat($Aid, $ccName, $IsOut2, $disposition, $isAutocall2);
                    --
                    -- call imu_InsContact($dcID, $IsOut2, $ccName, $SIP, $disposition, $channel);
                    --
                    UPDATE ccContact SET
                       /*  SIP             = IF($SIP IS NOT NULL, $SIP, NULL)
                           , */`channel`     = IF($channel IS NULL, '', $channel)
                           , ccStatus      = IF($dcStatus IS NULL, '', $dcStatus)
                           /*, emID          = IF($emID IS NULL, NULL, $emID)*/
                           , upTime        = NOW()
                    WHERE dcID = $dcID;
                END IF;
            END IF;
        END IF;
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
        --
        IF($dcID IS NOT NULL) THEN
          SELECT Aid
          INTO $Aid
          FROM dcDoc
          WHERE dcID IN ($dcID, -1*$dcID) LIMIT 1;
        ELSE
          SELECT Aid
          INTO $Aid
          FROM ccContact
          WHERE ccName LIKE CONCAT('%', $ccName) AND ccStatus IN (7006, 7007) AND Created > DATE_ADD(NOW(), INTERVAL -120 MINUTE)
          ORDER BY dcID DESC LIMIT 1;
        END IF;
        --
        SET $SIP = REPLACE($SIP, CONCAT('_', $Aid), '');
        --
        IF $ccID is NULL AND $clID is NULL THEN
          SELECT c.ccID, c.clID
          INTO $ccID, $clID
          FROM crmContact c
          WHERE c.ccName = $cName
            AND c.isActive = 1
                AND c.ffID IN (SELECT ffID FROM fsFile WHERE isActive = 1)
            AND c.Aid = $Aid
            AND c.ccType = 36
          LIMIT 1;
        ELSEIF $clID is NULL THEN
          SELECT c.clID
          INTO $clID
          FROM crmContact c
          WHERE c.ccName = $cName
            AND c.isActive = 1
                AND c.ffID IN (SELECT ffID FROM fsFile WHERE isActive = 1)
            AND c.Aid = $Aid
            AND c.ccType = 36
          LIMIT 1;
        ELSEIF $ccID is NULL THEN
          SELECT c.ccID
          INTO $ccID
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
          SELECT cl.ffID
          INTO $ffID
          FROM crmClient cl
            INNER JOIN crmContact c ON c.clID = cl.clID
          WHERE cl.clID = $clID AND ccType = 36 AND cl.Aid = $Aid
          LIMIT 1;
        END IF;
        --
        IF($emID IS NULL OR $emID = 0)THEN
          SELECT emID
                 INTO $emID
          FROM emEmploy
          WHERE SipName = $SIP AND Aid = $Aid
          LIMIT 1;
          IF($emID IS NULL)THEN
            SET $emID = 0;
          END IF;
        END IF;
        --
        SELECT tvID
        INTO $dcStatus
        FROM usEnumValue
        WHERE tyID = 7
          AND `Name` = $disposition
        LIMIT 1;
        --
        SET $CurDate = NOW();
        SET $clID    = IFNULL($clID, 0);
        SET $ffID    = IFNULL($ffID, 0);
        --
        IF ($dcID IS NULL) THEN
            SELECT dcID
            INTO $dcID
            FROM ccContact
            WHERE ccName = $ccName
                AND ccStatus IN (7006, 7007)
                AND isActive = TRUE
                AND Created > DATE_ADD(NOW(), INTERVAL -120 MINUTE)
            LIMIT 1;
        END IF;
        SET $duration = TIMESTAMPDIFF(SECOND, (SELECT Created FROM ccContact WHERE dcID = $dcID), NOW());
        IF((SELECT upTime FROM ccContact WHERE dcID = $dcID) IS NOT NULL) THEN
            SET $billsec = TIMESTAMPDIFF(SECOND, (SELECT upTime FROM ccContact WHERE dcID = $dcID), NOW());
            SET $serviceLevel = TIMESTAMPDIFF(SECOND, (SELECT Created FROM ccContact WHERE dcID = $dcID), (SELECT upTime FROM ccContact WHERE dcID = $dcID));
        ELSE
            IF($disposition = 'ANSWERED') THEN
                SET $billsec = $duration;
            ELSE
                SET $billsec = 0;
            END IF;

            SET $serviceLevel = TIMESTAMPDIFF(SECOND, (SELECT Created FROM ccContact WHERE dcID = $dcID), NOW());
        END IF;
        IF $channel is NOT NULL AND LENGTH(TRIM($channel))>0 THEN
            SELECT trID
            INTO $trID
            FROM ast_trunk
            WHERE trName = $channel AND Aid = $Aid
            LIMIT 1;
        END IF;
        --
        SET $sql = CONCAT('UPDATE ccContact SET ccStatus      = ', $dcStatus);
        IF($SIP IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', SIP = "', $SIP, '"');
        END IF;
        IF($LinkFile IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', LinkFile = "', $LinkFile, '"');
        END IF;
        IF($ccName IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', ccName = "', $ccName, '"');
        END IF;
        IF($channel IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', channel = "', $channel, '"');
        END IF;
        IF($trID IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', trID = "', $trID, '"');
        END IF;
        IF($CauseDesc IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', CauseDesc = "', $CauseDesc, '"');
        END IF;
        IF($target IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', target = "', $target, '"');
        END IF;
        IF($destdata2 IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', destdata2 = "', $destdata2, '"');
        END IF;
        IF($transferFrom IS NOT NULL AND LENGTH($transferFrom)>0) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', transferFrom = "', $transferFrom, '"');
        END IF;
        IF($transferTo IS NOT NULL AND LENGTH($transferTo)>0) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', transferTo = "', $transferTo, '"');
        END IF;
        IF($duration IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', duration = ', $duration);
        ELSE
          SET $sql = CONCAT($sql, CHAR(10), ', duration = 0');
        END IF;
        IF($serviceLevel IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', serviceLevel = ', $serviceLevel);
        ELSE
          SET $sql = CONCAT($sql, CHAR(10), ', serviceLevel = 0');
        END IF;
        IF($billsec IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', billsec = ', $billsec);
        ELSE
          SET $sql = CONCAT($sql, CHAR(10), ', billsec = 0');
        END IF;
        IF($CauseCode IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', CauseCode = ', $CauseCode);
        END IF;
        IF($CauseWho IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', CauseWho = ', $CauseWho);
        END IF;
        IF($CallType IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', CallType = ', $CallType);
        END IF;
        IF($disposition != 'ANSWERED' AND $disposition != 'RINGING') THEN
          SET $sql = CONCAT($sql, CHAR(10), ', IsMissed = TRUE');
        ELSE
          SET $sql = CONCAT($sql, CHAR(10), ', IsMissed = FALSE');
        END IF;
        IF($emID IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', emID = ', $emID);
        END IF;
        IF($id_autodial IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', id_autodial = ', $id_autodial);
        END IF;
        IF($clID IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', clID = ', $clID);
        END IF;
        IF($ffID IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', ffID = ', $ffID);
        END IF;
        IF($coID IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', coID = ', $coID);
        END IF;
        IF($destination IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', destination = ', $destination);
        END IF;
        IF($destdata IS NOT NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', destdata = ', $destdata);
        END IF;
        IF($isActive IS NULL) THEN
          SET $sql = CONCAT($sql, CHAR(10), ', isActive = TRUE');
        ELSE
          IF($isActive = TRUE) THEN
            SET $sql = CONCAT($sql, CHAR(10), ', isActive = 1');
          ELSE
            SET $sql = CONCAT($sql, CHAR(10), ', isActive = 0');
          END IF;
        END IF;
        SET $sql = CONCAT($sql, CHAR(10), 'WHERE dcID = ', $dcID, ';');
        --
        -- select $sql;
        CALL query_exec($sql);
        --
        UPDATE dcDoc SET
          dcStatus      = $dcStatus
          , clID        = $clID
          , emID          = IF($emID IS NULL, NULL, $emID)
        WHERE dcID = $dcID;
        --
        call cc_InsContactStat($Aid, $ccName, $IsOut, $disposition, $isAutocall);
        --
        IF ($disposition = 'ANSWERED') THEN
          UPDATE ccContact SET IsMissed = 0 WHERE ccName = $ccName AND Created > (NOW() - INTERVAL 7 DAY);
          /*IF ($clID < 0) THEN
            UPDATE ccContact SET ccID = (SELECT ParentID FROM crmClient WHERE clID = $clID LIMIT 1) WHERE ccID=$ccID;
            --
            call crm_IPDelClient($clID);
          ELSE
            SELECT clID
            INTO $delclID
            FROM crmContact
            WHERE clID<0
              AND ccName = $cName
            LIMIT 1;
            --
            IF ($delclID < 0) THEN
              call crm_IPDelClient($delclID);
            END IF;
          END IF;*/
        END IF;
        --
        /*IF ($disposition != 'RINGING') THEN
          IF ($disposition != 'ANSWERED' AND $IsOut = FALSE) THEN
            --
            IF abs($clID) > 0 THEN
              SELECT clID
              INTO $delclID
              FROM crmClient
              WHERE clID = -1*abs($clID);
              --
              IF $delclID = 0 OR $delclID IS NULL THEN
                INSERT INTO crmClient (HIID, clID, Aid, clName, IsPerson, IsActive, `Comment`, ParentID, ffID, CompanyID, CreatedBy, ChangedBy, uID, isActual, ActualStatus, `Position`, responsibleID)
                SELECT HIID, clID*-1, Aid, clName, IsPerson, IsActive, `Comment`, ParentID, -1, CompanyID, CreatedBy, ChangedBy, UUID_SHORT(), isActual, ActualStatus, `Position`, responsibleID
                FROM crmClient
                WHERE clID=abs($clID);
                --
                INSERT INTO crmContact (HIID, ccID, Aid, clID, ffID, ccName, ccType, isPrimary, isActive, ccStatus, ccComment, gmt, MCC, MNC, id_country, id_region, id_area, id_city, id_mobileProvider)
                        SELECT HIID, ccID*-1, Aid, clID*-1, -1, ccName, ccType, isPrimary, isActive, ccStatus, `ccComment`, gmt, MCC, MNC, id_country, id_region, id_area, id_city, id_mobileProvider
                        FROM crmContact
                WHERE clID=abs($clID);
                --
                call crm_IPInsClientStatus(-1*abs($clID), $Aid, $ffID);
                call crm_IPUpdateRegionByClient(-1*abs($clID));
                call crm_IPUpdStatus(-1*abs($clID));
                call crm_InsClientEx((SELECT Token FROM emEmploy WHERE Aid=$Aid AND Token IS NOT NULL AND emName!='system' LIMIT 1), -1*abs($clID), $CurDate, false, false, false, false, NULL, NULL, NULL, NULL, TRUE);
              END IF;
              --
            ELSE
              SELECT count(*)
              INTO $delclID
              FROM crmContact
              WHERE ccName LIKE CONCAT('%', $ccName)
                AND ccType=36
                AND clID<0;
              --
              IF($delclID = 0 OR $delclID IS NULL) THEN
                SET $next1 = us_GetNextSequence('clID');
                --
                        INSERT INTO crmClient (HIID, clID, Aid, clName, IsPerson, IsActive, `Comment`, ParentID, ffID, CompanyID, CreatedBy, ChangedBy, uID, isActual, ActualStatus, `Position`, responsibleID)
                SELECT HIID, ($next1*-1), Aid, clName, IsPerson, IsActive, `Comment`, 0, -1, CompanyID, CreatedBy, ChangedBy, UUID_SHORT(), isActual, ActualStatus, `Position`, responsibleID
                FROM crmClient
                WHERE clID=$clID;
                --
                SET $next2 = us_GetNextSequence('ccID');
                --
                INSERT INTO crmContact (HIID, ccID, Aid, clID, ffID, ccName, ccType, isPrimary, isActive, ccStatus, ccComment, gmt, MCC, MNC, id_country, id_region, id_area, id_city, id_mobileProvider)
                SELECT HIID, ($next2*-1), Aid, ($next1*-1), -1, ccName, ccType, isPrimary, isActive, ccStatus, `ccComment`, gmt, MCC, MNC, id_country, id_region, id_area, id_city, id_mobileProvider
                FROM crmContact
                WHERE clID=$clID;
                --
                call crm_IPInsClientStatus(($next1*-1), $Aid, $ffID);
                call crm_IPUpdateRegionByClient($next1*-1);
                call crm_IPUpdStatus($next1*-1);
                call crm_IPInsClientEx($Aid, ($next1*-1), $emID, $CurDate, false, false, false, false, NULL, NULL, NULL, NULL, TRUE);
                --
                UPDATE crmContact
                  SET ccName = $ccName,
                      ccType = 36,
                      isPrimary = 1,
                      isActive = 1,
                      ccStatus = 1,
                      `ccComment` = 'Помоги мне. Меня проигнорили'
                WHERE clID = ($next1*-1);
              END IF;
            END IF;
          END IF;
        END IF;*/
        --
        call crm_IPUpdStatus($clID);
        --
        UPDATE crmClient
        SET responsibleID = $emID
        WHERE clID = $clID AND
          responsibleID IS NULL;
        --
        IF ($disposition != 'RINGING' AND $disposition != 'UP') THEN
          UPDATE crmClientEx SET
            isDial = 0
          WHERE clID = $clID
            AND isDial = 1;
        END IF;
        --
        call imu_InsContact($dcID, $IsOut, $ccName, $SIP, $disposition, $channel);
      END IF;
  ELSE
    IF($dcID IS NULL)THEN
      SELECT dcID
          INTO $dcID
        FROM ccContact
        WHERE ccName = $ccName
        ORDER BY dcID DESC
        LIMIT 1;
     END IF;
        UPDATE ccContact SET Comment = $Comment, ContactStatus = $ContactStatus WHERE dcID = $dcID;
  END IF;
END $$
DELIMITER ;
--
