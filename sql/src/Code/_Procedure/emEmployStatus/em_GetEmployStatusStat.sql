DROP PROCEDURE IF EXISTS em_GetEmployStatusStat;
DELIMITER $$
CREATE PROCEDURE em_GetEmployStatusStat(
    $token              VARCHAR(100)
    , $DateFrom         DATETIME
    , $DateTo           DATETIME
    , $emIDs            TINYTEXT
    , $onlineStatus     INT(11)
    , $sorting          VARCHAR(5)
    , $field            VARCHAR(50)
    , $offset           INT
    , $limit            INT
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid            INT;
  DECLARE $sqlMaker       VARCHAR(1000);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_GetEmployStatusStat');
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
      SET $field_ = 'dateSpent, emID';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    CREATE TEMPORARY TABLE IF NOT EXISTS _StatusStat (
      `id` INT(11) NOT NULL AUTO_INCREMENT
      , `Aid` INT(11) NOT NULL DEFAULT '0'
      , `dateSpent` DATE NOT NULL
      , `emID` INT(11) NOT NULL DEFAULT '0'
      , `Available` INT(11) NOT NULL DEFAULT '0'
      , `Unvailable` INT(11) NOT NULL DEFAULT '0'
      , `Pause` INT(11) NOT NULL DEFAULT '0'
      , `Dinner` INT(11) NOT NULL DEFAULT '0'
      , `Meeting` INT(11) NOT NULL DEFAULT '0'
      , `Other` INT(11) NOT NULL DEFAULT '0'
      , `Logout` INT(11) NOT NULL DEFAULT '0'
      , `Post_Processing` INT(11) NOT NULL DEFAULT '0'
      , `All_State` INT(11) NOT NULL DEFAULT '0'
      , PRIMARY KEY (id)
      , INDEX `Aid` (`Aid`)
      , INDEX `dateSpent` (`dateSpent`)
      , INDEX `emID` (`emID`)
      )ENGINE=MEMORY;
    --
    SET $sqlCount = CONCAT('SELECT count(*) Qty FROM _StatusStat WHERE Aid = ', $Aid);
    --
    SET $sql = CONCAT('INSERT INTO _StatusStat(Aid, dateSpent, emID, Available, Unvailable, Pause, Dinner, Meeting, Other, `Logout`, Post_Processing, All_State)
                        SELECT ', $Aid, ' Aid
                              , DATE_FORMAT(Created, "%Y-%m-%d") dateSpent
                              , emID
                              , SUM(CASE WHEN onlineStatus = 103501 THEN timeSpent ELSE 0 END) Available
                              , SUM(CASE WHEN onlineStatus = 103502 THEN timeSpent ELSE 0 END) Unvailable
                              , SUM(CASE WHEN onlineStatus = 103503 THEN timeSpent ELSE 0 END) Pause
                              , SUM(CASE WHEN onlineStatus = 103504 THEN timeSpent ELSE 0 END) Dinner
                              , SUM(CASE WHEN onlineStatus = 103505 THEN timeSpent ELSE 0 END) Meeting
                              , SUM(CASE WHEN onlineStatus = 103506 THEN timeSpent ELSE 0 END) Other
                              , SUM(CASE WHEN onlineStatus = 103507 THEN timeSpent ELSE 0 END) Logout
                              , SUM(CASE WHEN onlineStatus = 103508 THEN timeSpent ELSE 0 END) Post_Processing
                              , SUM(CASE WHEN onlineStatus IS NOT NULL THEN timeSpent ELSE 0 END) All_State
                        FROM emStatus
             ');
    --
    IF $DateFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT(CHAR(10), 'WHERE Created >= ', QUOTE($DateFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Created <= ', QUOTE($DateTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR emID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'emID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID IN (', $emIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $onlineStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'onlineStatus = ', $onlineStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    --
    UPDATE emStatus SET timeSpent = UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(Created) WHERE isCurrent = TRUE;
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY dateSpent, emID ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    -- SELECT @s;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT('SELECT dateSpent, emID, Available, Unvailable, Pause, Dinner, Meeting, Other, Logout, Post_Processing, All_State FROM _StatusStat WHERE Aid = ', $Aid,' ORDER BY id ASC;');
    -- SELECT @s;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount);
    -- SELECT @s;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    -- DELETE FROM _StatusStat WHERE Aid = $Aid;
      DROP TABLE _StatusStat;
  END IF;
END $$
DELIMITER ;
--
