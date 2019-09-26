DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetRecall;
CREATE PROCEDURE ast_GetRecall(
    $token                          VARCHAR(100)
    , $rcID                         INT(11)
    , $rcName                       VARCHAR(255)
    , $callerID                     VARCHAR(50)
    , $TimeBegin                    TIME
    , $TimeEnd                      TIME
    , $DaysCall                     VARCHAR(500)
    , $RecallCount                  INT(11)
    , $RecallAfterMin               INT(11)
    , $RecallCountPerDay            INT(11)
    , $RecallDaysCount              INT(11)
    , $RecallAfterPeriod            INT(11)
    , $AutoDial                     VARCHAR(100)
    , $IsCallToOtherClientNumbers   BIT
    , $IsCheckCallFromOther         BIT
    , $AllowPrefix                  TEXT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $target                       TEXT
    , $roID                         VARCHAR(250)
    , $isFirstClient                BIT
    , $isResponsible                BIT
    , $type                         VARCHAR(250)
    , $isActive                     BIT
    , $sorting                      VARCHAR(5)
    , $field                        VARCHAR(50)
    , $offset                       INT(11)
    , $limit                        INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetRecall');
  ELSEIF ($Aid = 0) THEN
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 100);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    --
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
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_recall s ';
    --
    SET $sql = 'SELECT
                  s.HIID
                  , s.rcID
                  , s.rcName
                  , s.callerID
                  , s.TimeBegin
                  , s.TimeEnd
                  , s.DaysCall
                  , s.RecallCount
                  , s.RecallAfterMin
                  , s.RecallCountPerDay
                  , s.RecallDaysCount
                  , s.RecallAfterPeriod
                  , s.AutoDial
                  , s.IsCallToOtherClientNumbers
                  , s.IsCheckCallFromOther
                  , s.AllowPrefix
                  , s.roID roIDs
                  , s.destination
                  , IF(s.destination IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID=s.destination AND Aid=s.Aid), NULL) destinationName
                  , s.destdata
                  , s.destdata2
                  , IF(s.destdata IS NOT NULL, IF(s.destination = 101409, (SELECT poolName FROM ast_pools WHERE poolID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101408, (SELECT context FROM ast_custom_destination WHERE cdID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101407, (SELECT record_name FROM ast_record WHERE record_id=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101406, (SELECT rcName FROM ast_recall WHERE rcID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101405, (SELECT ivr_name FROM ast_ivr_config WHERE id_ivr_config=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101403, (SELECT trName FROM ast_trunk WHERE trID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101402, (SELECT sipName FROM emEmploy WHERE emID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101401, (SELECT `name` FROM ast_queues WHERE queID=s.destdata AND Aid = s.Aid LIMIT 1), NULL)))))))), NULL)	 destdataName
                  , s.target
                  , s.isFirstClient
                  , s.isResponsible
                  , s.statusMessage
                  , s.type
                  , s.isActive
                  , s.Created
                  , s.Changed
                FROM ast_recall s ';
    --
    IF $rcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.rcID = ', $rcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $rcName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.rcName = ', QUOTE($rcName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callerID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.callerID = ', QUOTE($callerID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TimeBegin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.TimeBegin = ', QUOTE($TimeBegin));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TimeEnd is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.TimeEnd = ', QUOTE($TimeEnd));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DaysCall is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.DaysCall = ', QUOTE($DaysCall));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isFirstClient is NOT NULL THEN
      IF $isFirstClient = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isFirstClient = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isFirstClient = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsCallToOtherClientNumbers is NOT NULL THEN
      IF($IsCallToOtherClientNumbers = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCallToOtherClientNumbers = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCallToOtherClientNumbers = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsCheckCallFromOther is NOT NULL THEN
       IF($IsCheckCallFromOther = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCheckCallFromOther = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCheckCallFromOther = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isResponsible is NOT NULL THEN
       IF($isResponsible = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.isResponsible = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.isResponsible = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallCount is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallCount = ', $RecallCount);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallAfterMin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallAfterMin = ', $RecallAfterMin);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallCountPerDay is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallCountPerDay = ', $RecallCountPerDay);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallDaysCount is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallDaysCount = ', $RecallDaysCount);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $AllowPrefix is NOT NULL AND LENGTH($AllowPrefix)>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.AllowPrefix = ', QUOTE($AllowPrefix));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $type is NOT NULL AND LENGTH($type)>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.type = ', QUOTE($type));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $roID is NOT NULL AND LENGTH($roID)>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.roID = ', QUOTE($roID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.destination = ', $destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.destdata = ', $destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.destdata2 = ', QUOTE($destdata2));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $target is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.target = ', QUOTE($target));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallAfterPeriod is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallAfterPeriod = ', $RecallAfterPeriod);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $AutoDial is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.AutoDial = ', QUOTE($AutoDial));
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY s.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 100);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    --
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
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_recall s';
    --
    SET $sql = 'SELECT
                  s.HIID
                  , s.rcID
                  , s.rcName
                  , s.callerID
                  , s.TimeBegin
                  , s.TimeEnd
                  , s.DaysCall
                  , s.RecallCount
                  , s.RecallAfterMin
                  , s.RecallCountPerDay
                  , s.RecallDaysCount
                  , s.RecallAfterPeriod
                  , s.AutoDial
                  , s.IsCallToOtherClientNumbers
                  , s.IsCheckCallFromOther
                  , s.AllowPrefix
                  , s.roID roIDs
                  , s.destination
                  , IF(s.destination IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID=s.destination AND Aid=s.Aid), NULL) destinationName
                  , s.destdata
                  , IF(s.destdata IS NOT NULL, IF(s.destination = 101409, (SELECT poolName FROM ast_pools WHERE poolID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101408, (SELECT context FROM ast_custom_destination WHERE cdID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101407, (SELECT record_name FROM ast_record WHERE record_id=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101406, (SELECT rcName FROM ast_recall WHERE rcID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101405, (SELECT ivr_name FROM ast_ivr_config WHERE id_ivr_config=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101403, (SELECT trName FROM ast_trunk WHERE trID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101402, (SELECT sipName FROM emEmploy WHERE emID=s.destdata AND Aid = s.Aid LIMIT 1), IF(s.destination = 101401, (SELECT `name` FROM ast_queues WHERE queID=s.destdata AND Aid = s.Aid LIMIT 1), NULL)))))))), NULL)	 destdataName
                  , s.destdata2
                  , s.target
                  , s.isFirstClient
                  , s.isResponsible
                  , s.statusMessage
                  , s.type
                  , s.isActive
                  , s.Created
                  , s.Changed
                FROM ast_recall s ';
    --
    IF $rcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.rcID = ', $rcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $rcName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.rcName = ', QUOTE($rcName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $type is NOT NULL AND LENGTH($type)>0 THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.type = ', QUOTE($type));
        SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callerID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.callerID = ', QUOTE($callerID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TimeBegin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.TimeBegin = ', QUOTE($TimeBegin));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TimeEnd is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.TimeEnd = ', QUOTE($TimeEnd));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DaysCall is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.DaysCall = ', QUOTE($DaysCall));
      SET $sqlWhereCode = ' AND ';
    END IF;
     IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isFirstClient is NOT NULL THEN
      IF $isFirstClient = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isFirstClient = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isFirstClient = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsCallToOtherClientNumbers is NOT NULL THEN
      IF($IsCallToOtherClientNumbers = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCallToOtherClientNumbers = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCallToOtherClientNumbers = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsCheckCallFromOther is NOT NULL THEN
       IF($IsCheckCallFromOther = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCheckCallFromOther = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.IsCheckCallFromOther = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isResponsible is NOT NULL THEN
      IF($isResponsible = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.isResponsible = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.isResponsible = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallCount is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallCount = ', $RecallCount);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallAfterMin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallAfterMin = ', $RecallAfterMin);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallCountPerDay is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallCountPerDay = ', $RecallCountPerDay);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallDaysCount is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallDaysCount = ', $RecallDaysCount);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.destination = ', $destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.destdata = ', $destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.destdata2 = ', QUOTE($destdata2));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $target is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.target = ', QUOTE($target));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RecallAfterPeriod is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.RecallAfterPeriod = ', $RecallAfterPeriod);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $AutoDial is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.AutoDial = ', QUOTE($AutoDial));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $AllowPrefix is NOT NULL AND LENGTH($AllowPrefix) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.AllowPrefix = ', QUOTE($AllowPrefix));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $roID is NOT NULL AND LENGTH($roID) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.roID = ', QUOTE($roID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY s.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
