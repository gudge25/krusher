DROP PROCEDURE IF EXISTS cc_GetExportDailyReport;
DELIMITER $$
CREATE PROCEDURE cc_GetExportDailyReport(
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
    , $step             INT /*0 - by hours, 1 - by days*/
)
BEGIN
    DECLARE $Aid          INT;
    DECLARE $sql          VARCHAR(10000);
    DECLARE $sqlWhereCode VARCHAR(10);
    DECLARE $sqlWhere     VARCHAR(5000);
    DECLARE $sqlMaker     VARCHAR(100);
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
        call RAISE(77068, 'cc_GetExportDailyReport');
    ELSE
        CREATE TABLE IF NOT EXISTS __DailyReport ( `id` INT(11) NOT NULL AUTO_INCREMENT
            , Period                        DATE
            , hourPeriod                    VARCHAR(20)
            , CallsCount                    INT NULL DEFAULT '0'
            , LostBefore5sec                INT NULL DEFAULT '0'
            , LostBefore5secPercent         DECIMAL(14, 2) NULL DEFAULT '0'
            , LostBefore30sec               INT NULL DEFAULT '0'
            , LostBefore30secPercent        DECIMAL(14, 2) NULL DEFAULT '0'
            , LostAfter30sec                INT NULL DEFAULT '0'
            , LostAfter30secPercent         DECIMAL(14, 2) NULL DEFAULT '0'
            , LostCalls                     INT NULL DEFAULT '0'
            , ReceivedCalls                 INT NULL DEFAULT '0'
            , ReceivedBefore20sec           INT NULL DEFAULT '0'
            , ReceivedBefore20secPercent    DECIMAL(14, 2) NULL DEFAULT '0'
            , ReceivedBefore30sec           INT NULL DEFAULT '0'
            , ReceivedBefore30secPercent    DECIMAL(14, 2) NULL DEFAULT '0'
            , ReceivedAfter30sec            INT NULL DEFAULT '0'
            , ReceivedAfter30secPercent     DECIMAL(14, 2) NULL DEFAULT '0'
            , SL                            DECIMAL(14, 2) NULL DEFAULT '0'
            , LCR                           DECIMAL(14, 2) NULL DEFAULT '0'
            , ATT                           DECIMAL(14, 2) NULL DEFAULT '0'
            , HT                            DECIMAL(14, 2) NULL DEFAULT '0'
            , AHT                           DECIMAL(14, 2) NULL DEFAULT '0'
            , Recalls                       INT NULL DEFAULT '0'
            , RLCR                          DECIMAL(14, 2) NULL DEFAULT '0'
            , Aid                           INT NULL DEFAULT '0'
            , Created                       DATETIME
            , PRIMARY KEY (`id`)
            , INDEX `Aid` (`Aid`)
        )ENGINE=MEMORY;
        SET $sqlWhereCode = 'WHERE ';
        SET $sqlWhere = ' ';
        IF($DateFrom IS NOT NULL AND $DateTo IS NOT NULL)THEN
            SET $sqlWhere = CONCAT($sqlWhere, $sqlWhereCode, 'Created BETWEEN "', $DateFrom, '" AND "', $DateTo,'"', CHAR(10));
            SET $sqlWhereCode = ' AND ';
        ELSEIF($DateFrom IS NOT NULL)THEN
            SET $sqlWhere = CONCAT($sqlWhere, $sqlWhereCode, 'Created >= "', $DateFrom, '"', CHAR(10));
            SET $sqlWhereCode = ' AND ';
        ELSE
            SET $sqlWhere = CONCAT($sqlWhere, $sqlWhereCode, 'Created <= "', $DateTo, '"', CHAR(10));
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
        IF($IsOut IS NOT NULL AND LENGTH($IsOut)>0)THEN
            IF($IsOut = TRUE)THEN
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsOut = TRUE', CHAR(10));
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsOut = FALSE', CHAR(10));
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($channels is NOT NULL) AND (length(TRIM($channels))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $channels)>0) OR (LOCATE('false', $channels)>0)) THEN
                IF (LOCATE(',', $channels)>0) THEN
                    SET $sqlMaker = REPLACE($channels, ',true', ') OR channel = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR channel != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'channel IN (', $sqlMaker);
                ELSE
                    IF $channels = 'true' THEN
                        SET $sqlMaker = 'clID = 0';
                    END IF;
                    IF $channels = 'false' THEN
                        SET $sqlMaker = 'clID != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'channel IN ("', REPLACE($channels, ',', '","'), '")');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($clIDs is NOT NULL) AND (length(TRIM($clIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $clIDs)>0) OR (LOCATE('false', $clIDs)>0)) THEN
                IF (LOCATE(',', $clIDs)>0) THEN
                    SET $sqlMaker = REPLACE($clIDs, ',true', ') OR clID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR clID != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'clID IN (', $sqlMaker);
                ELSE
                    IF $clIDs = 'true' THEN
                        SET $sqlMaker = 'clID = 0';
                    END IF;
                    IF $clIDs = 'false' THEN
                        SET $sqlMaker = 'clID != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'clID IN (', $clIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($ContactStatuses is NOT NULL) AND (length(TRIM($ContactStatuses))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $ContactStatuses)>0) OR (LOCATE('false', $ContactStatuses)>0)) THEN
                IF (LOCATE(',', $ContactStatuses)>0) THEN
                    SET $sqlMaker = REPLACE($ContactStatuses, ',true', ') OR ContactStatuses = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR clID != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ContactStatuses IN (', $sqlMaker);
                ELSE
                    IF $ContactStatuses = 'true' THEN
                        SET $sqlMaker = 'ContactStatuses = 0';
                    END IF;
                    IF $ContactStatuses = 'false' THEN
                        SET $sqlMaker = 'ContactStatuses != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ContactStatuses IN (', $ContactStatuses, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($CallTypes is NOT NULL) AND (length(TRIM($CallTypes))>0)) THEN
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'CallType IN (', $CallTypes, ')');
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($ffIDs is NOT NULL) AND (length(TRIM($ffIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $ffIDs)>0) OR (LOCATE('false', $ffIDs)>0)) THEN
                IF (LOCATE(',', $ffIDs)>0) THEN
                    SET $sqlMaker = REPLACE($ffIDs, ',true', ') OR ffID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ffID != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ffID IN (', $sqlMaker);
                ELSE
                    IF $ffIDs = 'true' THEN
                        SET $sqlMaker = 'ffID = 0';
                    END IF;
                    IF $ffIDs = 'false' THEN
                        SET $sqlMaker = 'ffID != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ffID IN (', $ffIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($coIDs is NOT NULL) AND (length(TRIM($coIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $coIDs)>0) OR (LOCATE('false', $coIDs)>0)) THEN
                IF (LOCATE(',', $coIDs)>0) THEN
                    SET $sqlMaker = REPLACE($coIDs, ',true', ') OR coID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR coID != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'coID IN (', $sqlMaker);
                ELSE
                    IF $coIDs = 'true' THEN
                        SET $sqlMaker = 'coID = 0';
                    END IF;
                    IF $coIDs = 'false' THEN
                        SET $sqlMaker = 'coID != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'coID IN (', $coIDs, ')');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($targets is NOT NULL) AND (length(TRIM($targets))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $targets)>0) OR (LOCATE('false', $targets)>0)) THEN
                IF (LOCATE(',', $targets)>0) THEN
                    SET $sqlMaker = REPLACE($targets, ',true', ') OR target = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR target != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'target IN ("', $sqlMaker);
                ELSE
                    IF $emIDs = 'true' THEN
                        SET $sqlMaker = 'target = 0';
                    END IF;
                    IF $emIDs = 'false' THEN
                        SET $sqlMaker = 'target != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'target IN ("', REPLACE($targets, ',', '","'), '")');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        IF (($ManagerIDs is NOT NULL) AND (length(TRIM($ManagerIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $ManagerIDs)>0) OR (LOCATE('false', $ManagerIDs)>0)) THEN
                IF (LOCATE(',', $ManagerIDs)>0) THEN
                    SET $sqlMaker = REPLACE($ManagerIDs, ',true', ') OR ManageID = 0)');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ManageID != 0)');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID IN (SELECT emID FROM emEmploy WHERE ManageID IN (', $sqlMaker);
                ELSE
                    IF $ManagerIDs = 'true' THEN
                        SET $sqlMaker = 'emID IN (SELECT emID FROM emEmploy WHERE ManageID!= 0)';
                    END IF;
                    IF $ManagerIDs = 'false' THEN
                        SET $sqlMaker = 'emID IN (SELECT emID FROM emEmploy WHERE ManageID!= 0)';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID IN (SELECT emID FROM emEmploy WHERE ManageID IN (', $ManagerIDs, ') OR emID IN (', $ManagerIDs, '))');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        SET $sqlWhere = CONCAT($sqlWhere, $sqlWhereCode, 'Aid =', $Aid, CHAR(10));
        SET $sqlWhere = CONCAT($sqlWhere, $sqlWhereCode, 'ccStatus NOT IN (7006, 7007)', CHAR(10));
        SET $sqlWhere = CONCAT($sqlWhere, $sqlWhereCode, 'isActive = TRUE ', CHAR(10));
        -- SET @s = $sqlWhere;
        -- SELECT @s ;
        SET $sql = CONCAT('INSERT INTO __DailyReport
                        SELECT NULL
                            , SUBSTR(Created, 1, 10)																																							Period
                            , ', IF($step = 0 OR $step IS NULL, 'CONCAT(HOUR(Created), ":00-", HOUR(Created)+1, ":00")', '"00:00:00"'),' 																																									hourPeriod
                            , SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)																																																											CallsCount
                            , SUM(CASE WHEN ((duration < 5 OR duration IS NULL) AND ccStatus NOT IN (7001) AND IsOut = FALSE ) THEN 1 ELSE 0 END)       																		LostBefore5sec
                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)>0, round(((100/SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END))*SUM(CASE WHEN ((duration < 5 OR duration IS NULL) AND ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)), 2), 0)								LostBefore5secPercent
                            , SUM(CASE WHEN ((duration >= 5 AND duration < 30) AND ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)       										LostBefore30sec
                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)>0, round(((100/SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END))*SUM(CASE WHEN ((duration >= 5 AND duration < 30) AND ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)), 2), 0)	LostBefore30secPercent
                            , SUM(CASE WHEN ((duration >= 30) AND ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)       										LostAfter30sec
                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)>0, round(((100/SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END))*SUM(CASE WHEN ((duration >= 30) AND ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)), 2), 0)	LostAfter30secPercent
                            , SUM(CASE WHEN (ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)   																											LostCalls
                            , SUM(CASE WHEN (ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END)   																																		ReceivedCalls

                            , SUM(CASE WHEN ((serviceLevel < 20 OR serviceLevel IS NULL) AND ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END)       																									ReceivedBefore20sec
                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)>0, (round(((100/SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END))*(SUM(CASE WHEN ((serviceLevel < 20 OR serviceLevel IS NULL) AND ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END))), 2)), 0)																ReceivedBefore20secPercent
                            , SUM(CASE WHEN ((serviceLevel >= 20 AND serviceLevel < 30) AND ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END)       																		ReceivedBefore30sec
                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)>0, round(((100/SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END))*SUM(CASE WHEN ((serviceLevel >= 20 AND serviceLevel < 30) AND ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END)), 2), 0)								ReceivedBefore30secPercent
                            , SUM(CASE WHEN (serviceLevel >= 30 AND ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END)       																										ReceivedAfter30sec

                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)>0, round(((100/SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END))*SUM(CASE WHEN (serviceLevel >= 30 AND ccStatus = 7001 AND IsOut = FALSE) THEN 1 ELSE 0 END)), 2), 0)																ReceivedAfter30secPercent
                            , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END) = 0 OR SUM(CASE WHEN (ccStatus IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END) = 0, 0, round((((SUM(CASE WHEN ((serviceLevel < 20 OR serviceLevel IS NULL) AND IsOut = FALSE AND ccStatus IN (7001)) THEN 1 ELSE 0 END)*100)/(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)-SUM(CASE WHEN ((duration < 5 OR duration IS NULL) AND ccStatus NOT IN (7001) AND IsOut = FALSE ) THEN 1 ELSE 0 END)))), 2))		SL
                                                        , IF(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END) = 0, 0, round(((((SUM(CASE WHEN (ccStatus NOT IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END)-SUM(CASE WHEN ((duration < 5 OR duration IS NULL) AND ccStatus NOT IN (7001) AND IsOut = FALSE ) THEN 1 ELSE 0 END))*100)/(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)))), 2))		LCR
                            , IF(SUM(CASE WHEN (ccStatus IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END) = 0, 0, (Avg(CASE WHEN (ccStatus IN (7001) AND IsOut = FALSE) THEN duration ELSE 0 END)))		ATT
                            , IF(SUM(CASE WHEN (holdtime IS NOT NULL AND holdtime>0) THEN 1 ELSE 0 END) = 0, 0, (SUM(CASE WHEN (holdtime IS NOT NULL AND holdtime>0) THEN holdtime ELSE 0 END)))		HT
                            , IF(SUM(CASE WHEN (ccStatus IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END) = 0, 0,
	                                        FLOOR((SUM(CASE WHEN (ccStatus IN (7001) AND IsOut = FALSE) THEN duration ELSE 0 END)/
	 		                                SUM(CASE WHEN (ccStatus IN (7001) AND IsOut = FALSE) THEN 1 ELSE 0 END))))		AHT
                            , SUM(CallType = 101321 AND isActive = TRUE)		L
                            , IF(SUM(CASE WHEN (IsOut = FALSE AND isActive = TRUE) THEN 1 ELSE 0 END) = 0, 0, round((((SUM(CallType = 101321)*100)/(SUM(CASE WHEN (IsOut = FALSE) THEN 1 ELSE 0 END)))), 2))		LCRr
                                , Aid
                            , Created
                        FROM ccContact ', CHAR(10), $sqlWhere, CHAR(10));
        IF($step = 0 OR $step IS NULL)THEN
            SET $sql = CONCAT($sql, 'GROUP BY Period, HOUR(Created)', CHAR(10), 'ORDER BY Created DESC;');
        ELSE
            SET $sql = CONCAT($sql, 'GROUP BY Period', CHAR(10), 'ORDER BY Created DESC;');
        END IF;

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
              , LostBefore5sec
              , LostBefore5secPercent
              , LostBefore30sec
              , LostBefore30secPercent
              , LostAfter30sec
              , LostAfter30secPercent
              , LostCalls
              , ReceivedCalls
              , ReceivedBefore20sec
              , ReceivedBefore20secPercent
              , ReceivedBefore30sec
              , ReceivedBefore30secPercent
              , ReceivedAfter30sec
              , ReceivedAfter30secPercent
              , SL
              , LCR
              , SUBSTR(sec_to_time(ATT), 1, 8) ATT
              , SUBSTR(sec_to_time(HT), 1, 8) HT
              , AHT AHT
              , SUBSTR(sec_to_time(AHT), 1, 8) AHT
              , Recalls
              , RLCR
         FROM __DailyReport
         WHERE Aid = $Aid
         ORDER BY Created DESC) UNION ALL
        --
        (SELECT
             NULL Period
              , NULL hourPeriod
              , sum(CallsCount)                     CallsCount
              , sum(LostBefore5sec)          LostBefore5sec
              , round((100/(sum(CallsCount)))*((sum(LostBefore5sec))), 2)   LostBefore5secPercent
              , sum(LostBefore30sec)          LostBefore30sec
              , round((100/(sum(CallsCount)))*((sum(LostBefore30sec))), 2)   LostBefore30secPercent
              , sum(LostAfter30sec)          LostAfter30sec
              , round((100/(sum(CallsCount)))*((sum(LostAfter30sec))), 2)   LostAfter30secPercent
              , sum(LostCalls)                    LostCalls
              , sum(ReceivedCalls)                ReceivedCalls
              , sum(ReceivedBefore20sec)              ReceivedBefore20sec
              , round(sum((1/CallsCount)*ReceivedBefore20sec), 2)       ReceivedBefore20secPercent
              , sum(ReceivedBefore30sec)              ReceivedBefore30sec
              , round((100/(sum(CallsCount)))*((sum(ReceivedBefore30sec))), 2)   ReceivedBefore30secPercent
              , sum(ReceivedAfter30sec)              ReceivedAfter30sec
              , round((100/(sum(CallsCount)))*((sum(ReceivedAfter30sec))), 2)   ReceivedAfter30secPercent
              , round((sum(ReceivedBefore20sec)*100)/(sum(CallsCount)-sum(LostBefore5sec)), 2)                            SL
              , round(((sum(LostCalls) - sum(LostBefore5sec))*100)/sum(CallsCount), 2)                           LCR
              , SUBSTR(sec_to_time(avg(ATT)), 1, 8)                          ATT
              , SUBSTR(sec_to_time(AVG(HT)), 1, 8)                          HT
              , SUM(AHT)                             AHT2
              , SUBSTR(sec_to_time(SUM(AHT)), 1, 8)                             AHT
              , sum(Recalls)              Recalls
              , round(AVG(RLCR), 2)                           RLCR
         FROM __DailyReport
         WHERE Aid = $Aid
         ORDER BY Created DESC);
        --
        DELETE FROM __DailyReport WHERE Aid = $Aid;
    END IF;
END $$
DELIMITER ;
--
