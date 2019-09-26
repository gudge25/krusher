DROP PROCEDURE IF EXISTS cc_GetDailyHour;
DELIMITER $$
CREATE PROCEDURE cc_GetDailyHour(
    $token          VARCHAR(100)
    , $DateFrom         DATETIME
    , $DateTo           DATETIME
    , $emIDs            TINYTEXT
    , $channels         TINYTEXT
    , $IsOut            BIT
    , $CallTypes        TINYTEXT
    , $ffIDs            TINYTEXT
    , $ContactStatuses  TINYTEXT
    , $coIDs            TINYTEXT
    , $clIDs            TINYTEXT
    , $ManagerIDs       TINYTEXT
    , $targets          TINYTEXT
)
BEGIN
    DECLARE $Aid          INT;
    DECLARE $sql          VARCHAR(10000);
    DECLARE $sqlWhereCode     VARCHAR(2000);
    DECLARE $sqlMaker     VARCHAR(100);
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
        call RAISE(77068, 'cc_GetDailyHour');
    ELSE
        CREATE TABLE IF NOT EXISTS __DailyReportHour ( `id` INT(11) NOT NULL AUTO_INCREMENT
            , Period                          DATE
            , hourPeriod                    VARCHAR(20)
            , CallsCount                    INT NULL DEFAULT '0'
            , ReceivedBefore20sec           INT NULL DEFAULT '0'
            , ReceivedBefore20secPercent    DECIMAL(14, 2) NULL DEFAULT '0'
            , ReceivedBefore30sec           INT NULL DEFAULT '0'
            , ReceivedBefore30secPercent    DECIMAL(14, 2) NULL DEFAULT '0'
            , ReceivedBefore60sec           INT NULL DEFAULT '0'
            , ReceivedBefore60secPercent    DECIMAL(14, 2) NULL DEFAULT '0'
            , ReceivedAfter60sec            INT NULL DEFAULT '0'
            , ReceivedAfter60secPercent     DECIMAL(14, 2) NULL DEFAULT '0'
            , ReceivedCalls                 INT NULL DEFAULT '0'
            , LostBefore20sec               INT NULL DEFAULT '0'
            , LostBefore20secPercent        DECIMAL(14, 2) NULL DEFAULT '0'
            , LostBefore30sec               INT NULL DEFAULT '0'
            , LostBefore30secPercent        DECIMAL(14, 2) NULL DEFAULT '0'
            , LostBefore60sec               INT NULL DEFAULT '0'
            , LostBefore60secPercent        DECIMAL(14, 2) NULL DEFAULT '0'
            , LostAfter60sec                INT NULL DEFAULT '0'
            , LostAfter60secPercent         DECIMAL(14, 2) NULL DEFAULT '0'
            , LostCalls                     INT NULL DEFAULT '0'
            , AHT                           DECIMAL(14, 2) NULL DEFAULT '0'
            , SL                            DECIMAL(14, 2) NULL DEFAULT '0'
            , LCR                           DECIMAL(14, 2) NULL DEFAULT '0'
            , ATT                           DECIMAL(14, 2) NULL DEFAULT '0'
            , Aid                           INT NULL DEFAULT '0'
            , Created                       DATETIME
            , PRIMARY KEY (`id`)
            , INDEX `Aid` (`Aid`)
        )ENGINE=MEMORY;
        SET $sqlWhereCode = 'WHERE ';
        SET $sql = CONCAT('INSERT INTO __DailyReportHour
                        SELECT NULL
                             , SUBSTR(Created, 1, 10)																																							Period
                             , CONCAT(HOUR(Created), ":00-", HOUR(Created)+1, ":00")																																									hourPeriod
                             , count(dcID)																																																											CallsCount
                             , SUM(CASE WHEN ((serviceLevel <= 20 OR serviceLevel IS NULL) AND ccStatus = 7001) THEN 1 ELSE 0 END)       																									ReceivedBefore20sec
                             , IF(count(dcID)>0, (round(((100/count(dcID))*(SUM(CASE WHEN ((serviceLevel <= 20 OR serviceLevel IS NULL) AND ccStatus = 7001) THEN 1 ELSE 0 END))), 2)), 0)																ReceivedBefore20secPercent
                             , SUM(CASE WHEN ((serviceLevel > 20 AND serviceLevel <= 30) AND ccStatus = 7001) THEN 1 ELSE 0 END)       																		ReceivedBefore30sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN ((serviceLevel > 20 AND serviceLevel <= 30) AND ccStatus = 7001) THEN 1 ELSE 0 END)), 2), 0)								ReceivedBefore30secPercent
                             , SUM(CASE WHEN ((serviceLevel > 30 AND serviceLevel <= 60) AND ccStatus = 7001) THEN 1 ELSE 0 END)       																		ReceivedBefore60sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN ((serviceLevel > 30 AND serviceLevel <= 60) AND ccStatus = 7001) THEN 1 ELSE 0 END)), 2), 0)								ReceivedBefore60secPercent
                             , SUM(CASE WHEN (serviceLevel > 60 AND ccStatus = 7001) THEN 1 ELSE 0 END)       																										ReceivedAfter60sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN (serviceLevel > 60 AND ccStatus = 7001) THEN 1 ELSE 0 END)), 2), 0)																ReceivedAfter60secPercent
                             , SUM(CASE WHEN (ccStatus = 7001) THEN 1 ELSE 0 END)   																																		ReceivedCalls
                            #потеряшьки
                             , SUM(CASE WHEN ((duration <= 20 OR duration IS NULL) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)       																		LostBefore20sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN ((duration <= 20 OR duration IS NULL) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)), 2), 0)								LostBefore20secPercent
                             , SUM(CASE WHEN ((duration > 20 AND duration <= 30) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)       										LostBefore30sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN ((duration > 20 AND duration <= 30) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)), 2), 0)	LostBefore30secPercent
                             , SUM(CASE WHEN ((duration > 30 AND duration <=60) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)       										LostBefore60sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN ((duration > 30 AND duration <= 60) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)), 2), 0)	LostBefore60secPercent
                             , SUM(CASE WHEN (duration > 60 AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)       																		LostAfter60sec
                             , IF(count(dcID)>0, round(((100/count(dcID))*SUM(CASE WHEN (duration > 60 AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)), 2), 0)									LostAfter60secPercent
                             , SUM(CASE WHEN (ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)   																											LostCalls
   , IF(SUM(CASE WHEN ccStatus IN (7001) THEN 1 ELSE 0 END) = 0, 0, (SUM(CASE WHEN (ccStatus IN (7001)) THEN duration ELSE 0 END)/SUM(CASE WHEN ccStatus IN (7001) THEN 1 ELSE 0 END)))		AHT
                             , IF(count(dcID) = 0 OR SUM(CASE WHEN (/*(duration <= 20 OR duration IS NULL) AND*/ ccStatus IN (7001)) THEN 1 ELSE 0 END) = 0, 0, round((((SUM(CASE WHEN ((serviceLevel <= 20 OR serviceLevel IS NULL) AND ccStatus IN (7001)) THEN 1 ELSE 0 END)*100)/(SUM(CASE WHEN (ccStatus = 7001) THEN 1 ELSE 0 END)+SUM(CASE WHEN ((duration > 5 OR duration IS NULL) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)))), 2))		SL
, IF(count(dcID) = 0 OR SUM(CASE WHEN ((duration > 5) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END) = 0, 0, round((((SUM(CASE WHEN ((duration < 5 OR serviceLevel IS NULL) AND ccStatus NOT IN (7001)) THEN 1 ELSE 0 END)*100)/(count(dcID)))), 2))		LCR
                             , IF(SUM(CASE WHEN ccStatus IN (7001) THEN 1 ELSE 0 END) = 0, 0, (Avg(CASE WHEN (ccStatus IN (7001)) THEN duration ELSE 0 END)))		ATT
                             , Aid
                             , Created
                            FROM ccContact ', CHAR(10));
        IF($DateFrom IS NOT NULL AND $DateTo IS NOT NULL)THEN
            SET $sql = CONCAT($sql, $sqlWhereCode, 'Created BETWEEN "', $DateFrom, '" AND "', $DateTo,'"', CHAR(10));
            SET $sqlWhereCode = ' AND ';
        ELSEIF($DateFrom IS NOT NULL)THEN
            SET $sql = CONCAT($sql, $sqlWhereCode, 'Created >= "', $DateFrom, '"', CHAR(10));
            SET $sqlWhereCode = ' AND ';
        ELSE
            SET $sql = CONCAT($sql, $sqlWhereCode, 'Created <= "', $DateTo, '"', CHAR(10));
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
                IF (LOCATE(',', $emIDs)>0) THEN
                    SET $sqlMaker = REPLACE($emIDs, ',true', ') OR emID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR emID != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'emID IN (', $sqlMaker);
                ELSE
                    IF $emIDs = 'true' THEN
                        SET $sqlMaker = 'emID = 0';
                    END IF;
                    IF $emIDs = 'false' THEN
                        SET $sqlMaker = 'emID != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'emID IN (', $emIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF($IsOut IS NOT NULL AND LENGTH($IsOut)>0)THEN
            IF($IsOut = TRUE)THEN
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'IsOut = TRUE', CHAR(10));
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'IsOut = FALSE', CHAR(10));
            END IF;
            SET $sqlWhereCode = ' AND ';
        ELSE
            SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'IsOut = FALSE', CHAR(10));
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($channels is NOT NULL) AND (length(TRIM($channels))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $channels)>0) OR (LOCATE('false', $channels)>0)) THEN
                IF (LOCATE(',', $channels)>0) THEN
                    SET $sqlMaker = REPLACE($channels, ',true', ') OR channel = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR channel != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'channel IN (', $sqlMaker);
                ELSE
                    IF $channels = 'true' THEN
                        SET $sqlMaker = 'clID = 0';
                    END IF;
                    IF $channels = 'false' THEN
                        SET $sqlMaker = 'clID != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'channel IN ("', REPLACE($channels, ',', '","'), '")');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($clIDs is NOT NULL) AND (length(TRIM($clIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $clIDs)>0) OR (LOCATE('false', $clIDs)>0)) THEN
                IF (LOCATE(',', $clIDs)>0) THEN
                    SET $sqlMaker = REPLACE($clIDs, ',true', ') OR clID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR clID != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'clID IN (', $sqlMaker);
                ELSE
                    IF $clIDs = 'true' THEN
                        SET $sqlMaker = 'clID = 0';
                    END IF;
                    IF $clIDs = 'false' THEN
                        SET $sqlMaker = 'clID != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'clID IN (', $clIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($ContactStatuses is NOT NULL) AND (length(TRIM($ContactStatuses))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $ContactStatuses)>0) OR (LOCATE('false', $ContactStatuses)>0)) THEN
                IF (LOCATE(',', $ContactStatuses)>0) THEN
                    SET $sqlMaker = REPLACE($ContactStatuses, ',true', ') OR ContactStatuses = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR clID != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'ContactStatuses IN (', $sqlMaker);
                ELSE
                    IF $ContactStatuses = 'true' THEN
                        SET $sqlMaker = 'ContactStatuses = 0';
                    END IF;
                    IF $ContactStatuses = 'false' THEN
                        SET $sqlMaker = 'ContactStatuses != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'ContactStatuses IN (', $ContactStatuses, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($CallTypes is NOT NULL) AND (length(TRIM($CallTypes))>0)) THEN
            SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'CallType IN (', $CallTypes, ')');
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($ffIDs is NOT NULL) AND (length(TRIM($ffIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $ffIDs)>0) OR (LOCATE('false', $ffIDs)>0)) THEN
                IF (LOCATE(',', $ffIDs)>0) THEN
                    SET $sqlMaker = REPLACE($ffIDs, ',true', ') OR ffID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ffID != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'ffID IN (', $sqlMaker);
                ELSE
                    IF $ffIDs = 'true' THEN
                        SET $sqlMaker = 'ffID = 0';
                    END IF;
                    IF $ffIDs = 'false' THEN
                        SET $sqlMaker = 'ffID != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'ffID IN (', $ffIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($coIDs is NOT NULL) AND (length(TRIM($coIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $coIDs)>0) OR (LOCATE('false', $coIDs)>0)) THEN
                IF (LOCATE(',', $coIDs)>0) THEN
                    SET $sqlMaker = REPLACE($coIDs, ',true', ') OR coID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR coID != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'coID IN (', $sqlMaker);
                ELSE
                    IF $coIDs = 'true' THEN
                        SET $sqlMaker = 'coID = 0';
                    END IF;
                    IF $coIDs = 'false' THEN
                        SET $sqlMaker = 'coID != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'coID IN (', $coIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($targets is NOT NULL) AND (length(TRIM($targets))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $targets)>0) OR (LOCATE('false', $targets)>0)) THEN
                IF (LOCATE(',', $targets)>0) THEN
                    SET $sqlMaker = REPLACE($targets, ',true', ') OR target = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR target != 0');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'target IN ("', $sqlMaker);
                ELSE
                    IF $emIDs = 'true' THEN
                        SET $sqlMaker = 'target = 0';
                    END IF;
                    IF $emIDs = 'false' THEN
                        SET $sqlMaker = 'target != 0';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'target IN ("', REPLACE($targets, ',', '","'), '")');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($ManagerIDs is NOT NULL) AND (length(TRIM($ManagerIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $ManagerIDs)>0) OR (LOCATE('false', $ManagerIDs)>0)) THEN
                IF (LOCATE(',', $ManagerIDs)>0) THEN
                    SET $sqlMaker = REPLACE($ManagerIDs, ',true', ') OR ManageID = 0)');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ManageID != 0)');
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'emID IN (SELECT emID FROM emEmploy WHERE ManageID IN (', $sqlMaker);
                ELSE
                    IF $ManagerIDs = 'true' THEN
                        SET $sqlMaker = 'emID IN (SELECT emID FROM emEmploy WHERE ManageID!= 0)';
                    END IF;
                    IF $ManagerIDs = 'false' THEN
                        SET $sqlMaker = 'emID IN (SELECT emID FROM emEmploy WHEREcc_GetDailyHour ManageID!= 0)';
                    END IF;
                    SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sql = CONCAT($sql, CHAR(10), $sqlWhereCode, 'emID IN (SELECT emID FROM emEmploy WHERE ManageID IN (', $ManagerIDs, ') OR emID IN (', $ManagerIDs, '))');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        SET $sql = CONCAT($sql, $sqlWhereCode, 'Aid =', $Aid, CHAR(10));
        SET $sql = CONCAT($sql, $sqlWhereCode, 'ccStatus NOT IN (7006, 7007)', CHAR(10));
        SET $sql = CONCAT($sql, $sqlWhereCode, 'isActive = TRUE ', CHAR(10));
        SET $sql = CONCAT($sql, 'GROUP BY Period, HOUR(Created)', CHAR(10), 'ORDER BY Created DESC;');
        SET @s = $sql;
        -- SELECT @s ;

        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        --
        (SELECT
             Period
              , hourPeriod
              , CallsCount
              , ReceivedBefore20sec
              , ReceivedBefore20secPercent
              , ReceivedBefore30sec
              , ReceivedBefore30secPercent
              , ReceivedBefore60sec
              , ReceivedBefore60secPercent
              , ReceivedAfter60sec
              , ReceivedAfter60secPercent
              , ReceivedCalls
              , LostBefore20sec
              , LostBefore20secPercent
              , LostBefore30sec
              , LostBefore30secPercent
              , LostBefore60sec
              , LostBefore60secPercent
              , LostAfter60sec
              , LostAfter60secPercent
              , LostCalls
              , SUBSTR(sec_to_time(AHT), 1, 8) AHT
              , SL
              , LCR
              , SUBSTR(sec_to_time(ATT), 1, 8) ATT
         FROM __DailyReportHour
         WHERE Aid = $Aid
         ORDER BY Created DESC);
        --
        SELECT
            sum(CallsCount)                     CallsCount
             , sum(ReceivedBefore20sec)          ReceivedBefore20sec
             , round((100/(sum(CallsCount)))*((sum(ReceivedBefore20sec))), 2)   ReceivedBefore20secPercent
             , sum(ReceivedBefore30sec)          ReceivedBefore30sec
             , round((100/(sum(CallsCount)))*((sum(ReceivedBefore30sec))), 2)   ReceivedBefore30secPercent
             , sum(ReceivedBefore60sec)          ReceivedBefore60sec
             , round((100/(sum(CallsCount)))*((sum(ReceivedBefore60sec))), 2)   ReceivedBefore60secPercent
             , sum(ReceivedAfter60sec)           ReceivedAfter60sec
             , round((100/(sum(CallsCount)))*((sum(ReceivedAfter60sec))), 2)   ReceivedAfter60secPercent
             , sum(ReceivedCalls)                ReceivedCalls
             , sum(LostBefore20sec)              LostBefore20sec
             , round((100/(sum(CallsCount)))*((sum(LostBefore20sec))), 2)   LostBefore20secPercent
             , sum(LostBefore30sec)              LostBefore30sec
             , round((100/(sum(CallsCount)))*((sum(LostBefore30sec))), 2)   LostBefore30secPercent
             , sum(LostBefore60sec)              LostBefore60sec
             , round((100/(sum(CallsCount)))*((sum(LostBefore60sec))), 2)   LostBefore60secPercent
             , sum(LostAfter60sec)               LostAfter60sec
             , round((100/(sum(CallsCount)))*((sum(LostAfter60sec))), 2)   LostAfter60secPercent
             , sum(LostCalls)                    LostCalls
             , SUBSTR(sec_to_time(SUM(AHT)/count(id)), 1, 8)                             AHT
             , round(AVG(SL), 2)                            SL
             , round(AVG(LCR), 2)                           LCR
             , SUBSTR(sec_to_time(avg(ATT)), 1, 8)                          ATT
        FROM __DailyReportHour
        WHERE Aid = $Aid
        ORDER BY Created DESC;
        --
        DELETE FROM __DailyReportHour WHERE Aid = $Aid;
    END IF;
END $$
DELIMITER ;
--
