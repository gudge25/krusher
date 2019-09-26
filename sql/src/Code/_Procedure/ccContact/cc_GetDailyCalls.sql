DROP PROCEDURE IF EXISTS cc_GetDailyCalls;
DELIMITER $$
CREATE PROCEDURE cc_GetDailyCalls(
    $token              VARCHAR(100)
    , $DateFrom         DATETIME
    , $DateTo           DATETIME
    , $dcIDs            TINYTEXT
    , $emIDs            TINYTEXT
    , $dcStatuss        TINYTEXT
    , $ffIDs            TINYTEXT
    , $isMissed         BIT
    , $isUnique         BIT
    , $CallTypes        TINYTEXT
    , $ccNames          TINYTEXT      # фильт по номеру телефона
    , $channels         TINYTEXT      # фильтр по каналу
    , $comparison       VARCHAR(10)   # символ сравнения длительности разговора
    , $billsec          INT           # продолжительность разговора, которую необходимо сравнивать по показателю из предыдущего параметра
    , $clIDs            TINYTEXT      # фильтр по клиенту
    , $IsOut            BIT           # признак Входящий звонок или исходящий
    , $id_autodials     TINYTEXT
    , $id_scenarios     TINYTEXT
    , $ManagerIDs       TINYTEXT
    , $target           VARCHAR(255)
    , $coIDs            TINYTEXT
    , $destination      INT
    , $destdata         INT
    , $destdata2        VARCHAR(100)
    , $ContactStatuses  TINYTEXT
    , $isActive         BIT
    , $sorting          VARCHAR(5)
    , $field            VARCHAR(50)
    , $offset           INT
    , $limit            INT
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(10);
  DECLARE $sql            VARCHAR(8000);
  DECLARE $sqlRes         VARCHAR(8000);
  DECLARE $sqlRes2        VARCHAR(8000);
  DECLARE $sqlWhere       VARCHAR(8000);
  DECLARE $sqlOrder       VARCHAR(8000);
  DECLARE $sqlGroup       VARCHAR(8000);
  DECLARE $sqlCount       VARCHAR(1000);
  DECLARE $sqlMaker       VARCHAR(1000);
  DECLARE $Aid            INT;
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetDailyCalls');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $comparison = IFNULL($comparison, '=');
    SET $limit = IFNULL($limit, 1000);
    SET $limit = if($limit > 1000, 1000, $limit);
    IF($sorting IS NULL) THEN
      SET $sorting_ = 'DESC';
    ELSE
      SET $sorting_ = $sorting;
    END IF;
    IF($field IS NULL) THEN
      SET $field_ = 'Created';
    ELSE
      SET $field_ = $field;
    END IF;
    SET $sqlWhere = '';
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlOrder = '';
    SET $sqlGroup = '';
    SET $sqlCount = '
    SELECT
      c.IsOut IsOut,
      c.duration  qtyVoiceMin,
      c.duration  avgVoiceMin,
      c.serviceLevel  avgWaitMin,
      c.billsec   avgBillMin ';
    --
    SET $sql = CONCAT('
  SELECT
    c.Created                   Created
    , c.duration                duration
    , c.billsec                 billsec
    , c.serviceLevel            serviceLevel
    , c.ccName                  ccName
    , c.emID                    emID
    , IF(c.emID IS NOT NULL AND c.emID > 0, (SELECT emName FROM emEmploy WHERE emID = c.emID AND Aid = ', $Aid,' LIMIT 1), NULL) emName
    , c.ContactStatus                ContactStatus
    , IF(c.ContactStatus IS NOT NULL, (SELECT Name FROM usEnumValue WHERE tvID = c.ContactStatus AND Aid = ', $Aid, ' LIMIT 1), NULL)  ContactStatusName
    , c.Comment                     Comment
    , IF(c.clID IS NOT NULL, (SELECT adsName FROM crmAddress WHERE clID = c.clID AND Aid = ', $Aid, ' LIMIT 1), NULL) adsName
    , c.isActive                isActive
  FROM ccContact c ');
    --
    IF $DateFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT(CHAR(10), 'WHERE c.Created >= ', QUOTE($DateFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Created <= ', QUOTE($DateTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsOut is NOT NULL THEN
      IF $IsOut = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = TRUE');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = FALSE');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR c.emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.emID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'c.emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'c.emID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $emIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($dcIDs is NOT NULL) AND (length(TRIM($dcIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $dcIDs)>0) OR (LOCATE('false', $dcIDs)>0)) THEN
        IF (LOCATE(',', $dcIDs)>0) THEN
          SET $sqlMaker = REPLACE($dcIDs, ',true', ') OR c.dcID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.dcID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.dcID IN (', $sqlMaker);
        ELSE
          IF $dcIDs = 'true' THEN
            SET $sqlMaker = 'c.dcID = 0';
          END IF;
          IF $dcIDs = 'false' THEN
            SET $sqlMaker = 'c.dcID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.dcID IN (', $dcIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($coIDs is NOT NULL) AND (length(TRIM($coIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $coIDs)>0) OR (LOCATE('false', $coIDs)>0)) THEN
        IF (LOCATE(',', $coIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR c.coID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.coID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.coID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'c.coID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'c.coID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.coID IN (', $coIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ManagerIDs is NOT NULL) AND (length(TRIM($ManagerIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ManagerIDs)>0) OR (LOCATE('false', $ManagerIDs)>0)) THEN
        IF (LOCATE(',', $ManagerIDs)>0) THEN
          SET $sqlMaker = REPLACE($ManagerIDs, ',true', ') OR ManageID = 0)');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ManageID != 0)');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (SELECT emID FROM emEmploy WHERE ManageID IN (', $sqlMaker);
        ELSE
          IF $ManagerIDs = 'true' THEN
            SET $sqlMaker = 'c.emID IN (SELECT emID FROM emEmploy WHERE ManageID!= 0)';
          END IF;
          IF $ManagerIDs = 'false' THEN
            SET $sqlMaker = 'c.emID IN (SELECT emID FROM emEmploy WHERE ManageID!= 0)';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (SELECT emID FROM emEmploy WHERE ManageID IN (', $ManagerIDs, ') OR emID IN (', $ManagerIDs, '))');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ffIDs is NOT NULL) AND (length(TRIM($ffIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ffIDs)>0) OR (LOCATE('false', $ffIDs)>0)) THEN
        IF (LOCATE(',', $ffIDs)>0) THEN
          SET $sqlMaker = REPLACE($ffIDs, ',true', ') OR c.ffID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.ffID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $sqlMaker);
        ELSE
          IF $ffIDs = 'true' THEN
            SET $sqlMaker = 'c.ffID = 0';
          END IF;
          IF $ffIDs = 'false' THEN
            SET $sqlMaker = 'c.ffID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $ffIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_autodials is NOT NULL) AND (length(TRIM($id_autodials))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_autodials)>0) OR (LOCATE('false', $id_autodials)>0)) THEN
        IF (LOCATE(',', $id_autodials)>0) THEN
          SET $sqlMaker = REPLACE($id_autodials, ',true', ') OR c.id_autodial = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_autodial != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $sqlMaker);
        ELSE
          IF $id_autodials = 'true' THEN
            SET $sqlMaker = 'c.id_autodial = 0';
          END IF;
          IF $id_autodials = 'false' THEN
            SET $sqlMaker = 'c.id_autodial != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $id_autodials, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_scenarios is NOT NULL) AND (length(TRIM($id_scenarios))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_scenarios)>0) OR (LOCATE('false', $id_scenarios)>0)) THEN
        IF (LOCATE(',', $id_scenarios)>0) THEN
          SET $sqlMaker = REPLACE($id_scenarios, ',true', ') OR c.id_scenario = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_scenario != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $sqlMaker);
        ELSE
          IF $id_scenarios = 'true' THEN
            SET $sqlMaker = 'c.id_scenario = 0';
          END IF;
          IF $id_scenarios = 'false' THEN
            SET $sqlMaker = 'c.id_scenario != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $id_scenarios, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($dcStatuss is NOT NULL) AND (length(TRIM($dcStatuss))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccStatus IN (', $dcStatuss, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($CallTypes is NOT NULL) AND (length(TRIM($CallTypes))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.CallType IN (', $CallTypes, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ccNames is NOT NULL) AND (length(TRIM($ccNames))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $ccNames)>0) THEN
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($channels is NOT NULL) AND (length(TRIM($channels))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $channels)>0) THEN
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($clIDs is NOT NULL) AND (length(TRIM($clIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $clIDs)>0) OR (LOCATE('false', $clIDs)>0)) THEN
        IF (LOCATE(',', $clIDs)>0) THEN
          SET $sqlMaker = REPLACE($clIDs, ',true', ') OR c.clID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.clID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $sqlMaker);
        ELSE
          IF $clIDs = 'true' THEN
            SET $sqlMaker = 'c.clID = 0';
          END IF;
          IF $clIDs = 'false' THEN
            SET $sqlMaker = 'c.clID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $clIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ContactStatuses is NOT NULL) AND (length(TRIM($ContactStatuses))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ContactStatuses)>0) OR (LOCATE('false', $ContactStatuses)>0)) THEN
        IF (LOCATE(',', $ContactStatuses)>0) THEN
          SET $sqlMaker = REPLACE($ContactStatuses, ',true', ') OR c.ContactStatuses = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.clID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ContactStatuses IN (', $sqlMaker);
        ELSE
          IF $ContactStatuses = 'true' THEN
            SET $sqlMaker = 'c.ContactStatuses = 0';
          END IF;
          IF $ContactStatuses = 'false' THEN
            SET $sqlMaker = 'c.ContactStatuses != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ContactStatuses IN (', $ContactStatuses, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isMissed = 1 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsMissed = TRUE');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $billsec is NOT NULL THEN
      IF $comparison = '=' THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec = ', $billsec);
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec ', $comparison, '=', $billsec);
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.destination = ', $destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.destdata = ', $destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.destdata2 = ', QUOTE($destdata));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $target is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.target = ', QUOTE($target));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Aid = ', $Aid, ' AND c.isActive = TRUE AND IsOut = FALSE AND ccStatus = 7001 AND c.CallType != 101320 AND c.SIP IS NOT NULL AND (c.destination IS NULL OR c.destination != 101412)');
    --
    IF $isMissed = 1 or $isUnique = 1 then
      SET $sqlGroup = CONCAT(CHAR(10), 'GROUP BY c.ccName');
    END IF;
    --
    /*SET $sqlOrder = CONCAT(CHAR(10), 'ORDER BY c.Created DESC ');*/
    --
    SET @s = CONCAT($sql, $sqlWhere, $sqlGroup, $sqlOrder);
    /*select @s;*/
    --
    SET $sqlRes2 = CONCAT('(', $sqlCount, ' FROM ccContact c ', $sqlWhere, $sqlGroup, ')');
    /*---------------------------------------------------------------------------------------------------------------------------------------------------*/
    SET $sqlWhere = '';
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlOrder = '';
    SET $sqlGroup = '';

    SET $sql = CONCAT('
  SELECT
    c.Created                   Created
    , c.duration                duration
    , c.billsec                 billsec
    , c.serviceLevel            serviceLevel
    , c.ccName                  ccName
    , c.emID                    emID
    , IF(c.emID IS NOT NULL AND c.emID > 0, (SELECT emName FROM emEmploy WHERE emID = c.emID AND Aid = ', $Aid,' LIMIT 1), NULL) emName
    , c.ContactStatus                ContactStatus
    , IF(c.ContactStatus IS NOT NULL, (SELECT Name FROM usEnumValue WHERE tvID = c.ContactStatus AND Aid = ', $Aid, ' LIMIT 1), NULL)  ContactStatusName
    , c.Comment                     Comment
    , IF(c.clID IS NOT NULL, (SELECT adsName FROM crmAddress WHERE clID = c.clID AND Aid = ', $Aid, ' LIMIT 1), NULL) adsName
    , c.isActive                isActive
  FROM ccContact c ');
    --
    IF $DateFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT(CHAR(10), 'WHERE c.Created >= ', QUOTE($DateFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Created <= ', QUOTE($DateTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsOut is NOT NULL THEN
      IF $IsOut = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = TRUE');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = FALSE');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR c.emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.emID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'c.emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'c.emID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $emIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($dcIDs is NOT NULL) AND (length(TRIM($dcIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $dcIDs)>0) OR (LOCATE('false', $dcIDs)>0)) THEN
        IF (LOCATE(',', $dcIDs)>0) THEN
          SET $sqlMaker = REPLACE($dcIDs, ',true', ') OR c.dcID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.dcID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.dcID IN (', $sqlMaker);
        ELSE
          IF $dcIDs = 'true' THEN
            SET $sqlMaker = 'c.dcID = 0';
          END IF;
          IF $dcIDs = 'false' THEN
            SET $sqlMaker = 'c.dcID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.dcID IN (', $dcIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($coIDs is NOT NULL) AND (length(TRIM($coIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $coIDs)>0) OR (LOCATE('false', $coIDs)>0)) THEN
        IF (LOCATE(',', $coIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR c.coID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.coID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.coID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'c.coID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'c.coID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.coID IN (', $coIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.destination = ', $destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.destdata = ', $destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.destdata2 = ', QUOTE($destdata));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ManagerIDs is NOT NULL) AND (length(TRIM($ManagerIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ManagerIDs)>0) OR (LOCATE('false', $ManagerIDs)>0)) THEN
        IF (LOCATE(',', $ManagerIDs)>0) THEN
          SET $sqlMaker = REPLACE($ManagerIDs, ',true', ') OR ManageID = 0)');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ManageID != 0)');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel IN (SELECT trName FROM ast_trunk WHERE ManageID IN (', $sqlMaker);
        ELSE
          IF $ManagerIDs = 'true' THEN
            SET $sqlMaker = 'c.channel IN (SELECT trName FROM ast_trunk WHERE ManageID = 0)';
          END IF;
          IF $ManagerIDs = 'false' THEN
            SET $sqlMaker = 'c.channel IN (SELECT trName FROM ast_trunk WHERE ManageID != 0)';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel IN (SELECT trName FROM ast_trunk WHERE ManageID IN (', $ManagerIDs, '))');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ffIDs is NOT NULL) AND (length(TRIM($ffIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ffIDs)>0) OR (LOCATE('false', $ffIDs)>0)) THEN
        IF (LOCATE(',', $ffIDs)>0) THEN
          SET $sqlMaker = REPLACE($ffIDs, ',true', ') OR c.ffID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.ffID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $sqlMaker);
        ELSE
          IF $ffIDs = 'true' THEN
            SET $sqlMaker = 'c.ffID = 0';
          END IF;
          IF $ffIDs = 'false' THEN
            SET $sqlMaker = 'c.ffID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $ffIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_autodials is NOT NULL) AND (length(TRIM($id_autodials))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_autodials)>0) OR (LOCATE('false', $id_autodials)>0)) THEN
        IF (LOCATE(',', $id_autodials)>0) THEN
          SET $sqlMaker = REPLACE($id_autodials, ',true', ') OR c.id_autodial = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_autodial != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $sqlMaker);
        ELSE
          IF $id_autodials = 'true' THEN
            SET $sqlMaker = 'c.id_autodial = 0';
          END IF;
          IF $id_autodials = 'false' THEN
            SET $sqlMaker = 'c.id_autodial != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $id_autodials, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_scenarios is NOT NULL) AND (length(TRIM($id_scenarios))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_scenarios)>0) OR (LOCATE('false', $id_scenarios)>0)) THEN
        IF (LOCATE(',', $id_scenarios)>0) THEN
          SET $sqlMaker = REPLACE($id_scenarios, ',true', ') OR c.id_scenario = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_scenario != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $sqlMaker);
        ELSE
          IF $id_scenarios = 'true' THEN
            SET $sqlMaker = 'c.id_scenario = 0';
          END IF;
          IF $id_scenarios = 'false' THEN
            SET $sqlMaker = 'c.id_scenario != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $id_scenarios, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($dcStatuss is NOT NULL) AND (length(TRIM($dcStatuss))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccStatus IN (', $dcStatuss, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($CallTypes is NOT NULL) AND (length(TRIM($CallTypes))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.CallType IN (', $CallTypes, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ccNames is NOT NULL) AND (length(TRIM($ccNames))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $ccNames)>0) THEN
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($channels is NOT NULL) AND (length(TRIM($channels))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $channels)>0) THEN
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($clIDs is NOT NULL) AND (length(TRIM($clIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $clIDs)>0) OR (LOCATE('false', $clIDs)>0)) THEN
        IF (LOCATE(',', $clIDs)>0) THEN
          SET $sqlMaker = REPLACE($clIDs, ',true', ') OR c.clID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.clID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $sqlMaker);
        ELSE
          IF $clIDs = 'true' THEN
            SET $sqlMaker = 'c.clID = 0';
          END IF;
          IF $clIDs = 'false' THEN
            SET $sqlMaker = 'c.clID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $clIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ContactStatuses is NOT NULL) AND (length(TRIM($ContactStatuses))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ContactStatuses)>0) OR (LOCATE('false', $ContactStatuses)>0)) THEN
        IF (LOCATE(',', $ContactStatuses)>0) THEN
          SET $sqlMaker = REPLACE($ContactStatuses, ',true', ') OR c.ContactStatuses = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.clID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ContactStatuses IN (', $sqlMaker);
        ELSE
          IF $ContactStatuses = 'true' THEN
            SET $sqlMaker = 'c.ContactStatuses = 0';
          END IF;
          IF $ContactStatuses = 'false' THEN
            SET $sqlMaker = 'c.ContactStatuses != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ContactStatuses IN (', $ContactStatuses, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isMissed = 1 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsMissed = TRUE');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $billsec is NOT NULL THEN
      IF $comparison = '=' THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec = ', $billsec);
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec ', $comparison, '=', $billsec);
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $target is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.target = ', QUOTE($target));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Aid = ', $Aid, ' AND IsOut = FALSE  AND c.isActive = TRUE AND ccStatus = 7001 AND c.CallType != 101320 AND c.SIP IS NULL AND (c.destination IS NULL OR c.destination != 101412)');
    --
    IF $isMissed = 1 or $isUnique = 1 then
      SET $sqlGroup = CONCAT(CHAR(10), 'GROUP BY c.ccName');
    END IF;
    --
    SET @s2 = CONCAT($sql, $sqlWhere, $sqlGroup, $sqlOrder);
    /*select @s2;*/
    --
    SET $sqlRes = CONCAT('SELECT *
                          FROM ((', @s, ') UNION ALL (', @s2, '))a
                          ', 'ORDER BY a.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
    SET @s3 = $sqlRes;

    PREPARE stmt FROM @s3;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $sqlRes2 = CONCAT($sqlRes2, 'UNION ALL (', $sqlCount,  ' FROM ccContact c ', $sqlWhere, $sqlGroup, ')');
    /*select @s3;
    select $sqlRes2;*/
    IF $isMissed = 1 or $isUnique = 1 then
      SET @s = CONCAT("SELECT count(IsOut) Qty
                              , sec_to_time(Sum(
                                IF(avgBillMin=0 AND IsOut=1, 0,
                                  IF(IsOut=0 AND avgWaitMin=0, 0, qtyVoiceMin
                                    )
                                  )
                                )) qtyVoiceMin
                                , SUBSTR(sec_to_time(Avg(avgVoiceMin)), 1,8) avgVoiceMin
                              , SUBSTR(sec_to_time(Avg(avgWaitMin)), 1,8) avgWaitMin
                              , SUBSTR(sec_to_time(Avg(avgBillMin)), 1,8) avgBillMin
                      FROM (", $sqlRes2, ") dd");
    ELSE
      SET @s = CONCAT("SELECT count(IsOut) Qty
                              , sec_to_time(Sum(
                                IF(avgBillMin=0 AND IsOut=1, 0,
                                  IF(IsOut=0 AND avgWaitMin=0, 0, qtyVoiceMin
                                    )
                                  )
                                )) qtyVoiceMin
                                , SUBSTR(sec_to_time(Avg(avgVoiceMin)), 1,8) avgVoiceMin
                              , SUBSTR(sec_to_time(Avg(avgWaitMin)), 1,8) avgWaitMin
                              , SUBSTR(sec_to_time(Avg(avgBillMin)), 1,8) avgBillMin
                      FROM (", $sqlRes2, ") aa");
    END IF;

    /*select @s;*/

    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
