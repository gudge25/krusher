DROP PROCEDURE IF EXISTS cc_SetExportRecords;
DELIMITER $$
CREATE PROCEDURE cc_SetExportRecords(
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
    , $convertFormat    INT
    , $isActive         BIT
    , $sorting          VARCHAR(5)
    , $field            VARCHAR(50)
    , $offset           INT
    , $limit            INT
    , $emID             INT
)
BEGIN
  DECLARE $sql            VARCHAR(10000);
  DECLARE $sqlData        VARCHAR(10000);
  DECLARE $Aid            INT;
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_SetExportRecords');
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

    IF($DateFrom IS NULL OR LENGTH(TRIM($DateFrom)) = 0) THEN
        SET $sqlData = CONCAT(', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT(', "', $DateFrom, '"', CHAR(10));
    END IF;
    IF($DateTo IS NULL OR LENGTH(TRIM($DateTo)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $DateTo, '"', CHAR(10));
    END IF;
    IF($dcIDs IS NULL OR LENGTH(TRIM($dcIDs)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $dcIDs, '"', CHAR(10));
    END IF;
    IF($emIDs IS NULL OR LENGTH(TRIM($emIDs)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $emIDs, '"', CHAR(10));
    END IF;
    IF($dcStatuss IS NULL OR LENGTH(TRIM($dcStatuss)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $dcStatuss, '"', CHAR(10));
    END IF;
    IF($ffIDs IS NULL OR LENGTH(TRIM($ffIDs)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $ffIDs, '"', CHAR(10));
    END IF;
    IF($isMissed IS NULL OR LENGTH(TRIM($isMissed)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', ', IF($isMissed = 1, TRUE, FALSE), CHAR(10));
    END IF;
    IF($isUnique IS NULL OR LENGTH(TRIM($isUnique)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', ', IF($isUnique = 1, TRUE, FALSE), CHAR(10));
    END IF;
    IF($CallTypes IS NULL OR LENGTH(TRIM($CallTypes)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $CallTypes, '"', CHAR(10));
    END IF;
    IF($ccNames IS NULL OR LENGTH(TRIM($ccNames)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $ccNames, '"', CHAR(10));
    END IF;
    IF($channels IS NULL OR LENGTH(TRIM($channels)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $channels, '"', CHAR(10));
    END IF;
    IF($comparison IS NULL OR LENGTH(TRIM($comparison)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $comparison, '"', CHAR(10));
    END IF;
    IF($billsec IS NULL OR LENGTH(TRIM($billsec)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $billsec, '"', CHAR(10));
    END IF;
    IF($clIDs IS NULL OR LENGTH(TRIM($clIDs)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $clIDs, '"', CHAR(10));
    END IF;
    IF($IsOut IS NULL OR LENGTH(TRIM($IsOut)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', ', IF($IsOut = 1, TRUE, FALSE), CHAR(10));
    END IF;
    IF($id_autodials IS NULL OR LENGTH(TRIM($id_autodials)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $id_autodials, '"', CHAR(10));
    END IF;
    IF($id_scenarios IS NULL OR LENGTH(TRIM($id_scenarios)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $id_scenarios, '"', CHAR(10));
    END IF;
    IF($ManagerIDs IS NULL OR LENGTH(TRIM($ManagerIDs)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $ManagerIDs, '"', CHAR(10));
    END IF;
    IF($target IS NULL OR LENGTH(TRIM($target)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $target, '"', CHAR(10));
    END IF;
    IF($coIDs IS NULL OR LENGTH(TRIM($coIDs)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $coIDs, '"', CHAR(10));
    END IF;
    IF($destination IS NULL OR LENGTH(TRIM($destination)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $destination, '"', CHAR(10));
    END IF;
    IF($destdata IS NULL OR LENGTH(TRIM($destdata)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $destdata, '"', CHAR(10));
    END IF;
    IF($destdata2 IS NULL OR LENGTH(TRIM($destdata2)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $destdata2, '"', CHAR(10));
    END IF;
    IF($ContactStatuses IS NULL OR LENGTH(TRIM($ContactStatuses)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $ContactStatuses, '"', CHAR(10));
    END IF;
    IF($emID IS NULL OR LENGTH(TRIM($emID)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $emID, '"', CHAR(10));
    END IF;
    IF($convertFormat IS NULL OR LENGTH(TRIM($convertFormat)) = 0) THEN
        SET $sqlData = CONCAT($sqlData, ', NULL', CHAR(10));
    ELSE
        SET $sqlData = CONCAT($sqlData, ', "', $convertFormat, '"', CHAR(10));
    END IF;
    SET $sql = CONCAT('INSERT INTO ccContactRecords (Aid, DateFrom, DateTo, dcIDs, emIDs, dcStatuss, ffIDs, isMissed, isUnique, CallTypes, ccNames, channels, comparison, billsec, clIDs, IsOut, id_autodials, id_scenarios, ManageIDs, target, coIDs, destination, destdata, destdata2, ContactStatuses, emID, convertFormat)VALUES
                      (', $Aid,'
                        ' , $sqlData, '
            );');
    SET @s = $sql;
    /*select @s;*/

    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    SELECT LAST_INSERT_ID() ID;
  END IF;
END $$
DELIMITER ;
--
