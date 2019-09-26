DROP PROCEDURE IF EXISTS cc_GetExportDailyStatuses;
DELIMITER $$
CREATE PROCEDURE cc_GetExportDailyStatuses(
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
  DECLARE $diff         INT;
  DECLARE $i            INT;
  DECLARE $j            INT;
  DECLARE $sql          VARCHAR(20000);
  DECLARE $sqlBegin     VARCHAR(200);
  DECLARE $sqlName      VARCHAR(200);
  DECLARE $sqlID        INT;
  DECLARE $sqlWhereCode VARCHAR(10);
  DECLARE $sqlWhere     VARCHAR(5000);
  DECLARE $sqlMaker     VARCHAR(100);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetExportDailyStatuses');
  ELSE
    SET $diff = datediff($DateTo, $DateFrom);

    if($diff>=0) THEN
        DROP TABLE IF EXISTS __StatusExportReport;
        SET $sql = 'CREATE TABLE __StatusExportReport (`Aid` INT(10) UNSIGNED NOT NULL DEFAULT "0"';
        SET $sql = CONCAT($sql, CHAR(10), ', `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT ');
        SET $sql = CONCAT($sql, CHAR(10), ', `status`   VARCHAR(100) NOT NULL');
        SET $i = 0;
        while $i <= $diff do
            SET $sql = CONCAT($sql, CHAR(10), ', count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), '  int NULL DEFAULT "0"');
            SET $sql = CONCAT($sql, CHAR(10), ', percent_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' decimal(14,2) NULL DEFAULT "0"');
            set $i = $i + 1;
        end while;
        SET $sql = CONCAT($sql, CHAR(10), ', PRIMARY KEY (`id`)');
        SET $sql = CONCAT($sql, CHAR(10), ', INDEX `Aid` (`Aid`)');
        SET $sql = CONCAT($sql, CHAR(10), ' )
                COMMENT="Report for statuses"
                COLLATE="utf8_general_ci"
                ENGINE=MyISAM;');
        SET @s = $sql;
        --        SELECT @s;
        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        SET $sqlWhereCode = ' ';
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
                SET $sqlWhere = CONCAT($sql, CHAR(10), $sqlWhereCode, 'emID IN (', $emIDs, ')');
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

        SET $sqlBegin = 'INSERT IGNORE INTO __StatusExportReport (`status`';
        SET $i = 0;
        while $i <= $diff do
            SET $sqlBegin = CONCAT($sqlBegin, CHAR(10), ', count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
            SET $sqlBegin = CONCAT($sqlBegin, CHAR(10), ', percent_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
            set $i = $i + 1;
        end while;
        SET $sqlBegin = CONCAT($sqlBegin, CHAR(10), ', Aid)');
        SET $i = 0;
        SET $sql = '';
        SET $sql = CONCAT($sqlBegin, CHAR(10), 'SELECT "Поступило" `status`');
        SET $i = 0;
            while $i <= $diff do
                SET $sql = CONCAT($sql, CHAR(10), ', (SELECT count(dcID) FROM ccContact WHERE IsOut = FALSE AND isActive = TRUE AND Aid = ', $Aid, ' AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 23:59:59" AND ', $sqlWhere, ') count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
                SET $sql = CONCAT($sql, CHAR(10), ', 100 percent_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
                set $i = $i + 1;
            end while;
        SET $sql = CONCAT($sql, CHAR(10), ', ', $Aid, ';');
        SET @s = $sql;
        -- select @s;
        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        --
        SET $sql = CONCAT($sqlBegin, CHAR(10), 'SELECT "Принято" `status`');
        SET $i = 0;
            while $i <= $diff do
                SET $sql = CONCAT($sql, CHAR(10), ', (SELECT count(dcID) FROM ccContact WHERE IsOut = FALSE AND isActive = TRUE AND Aid = ', $Aid, ' AND ccStatus IN (7001) AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 23:59:59" AND ', $sqlWhere, ') count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
                SET $sql = CONCAT($sql, CHAR(10), ', IF((SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило")=0 OR (SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило") IS NULL, 0, (100/(SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило"))*(SELECT count(dcID) FROM ccContact WHERE Aid = ', $Aid, ' AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 23:59:59" AND ccStatus IN (7001) AND IsOut = FALSE AND isActive = TRUE AND ', $sqlWhere, ')) percent_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
                set $i = $i + 1;
            end while;
        SET $sql = CONCAT($sql, CHAR(10), ', ', $Aid, ';');
        SET @s = $sql;
        -- select $sql;
        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        --
        SET $sql = CONCAT($sqlBegin, CHAR(10), 'SELECT "Пропущенно" `status`');
        SET $i = 0;
            while $i <= $diff do
                SET $sql = CONCAT($sql, CHAR(10), ', (SELECT count(dcID) FROM ccContact WHERE IsOut = FALSE AND isActive = TRUE AND Aid = ', $Aid, ' AND ccStatus NOT IN (7001) AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 23:59:59" AND ', $sqlWhere, ') count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
                SET $sql = CONCAT($sql, CHAR(10), ', IF((SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило")=0 OR (SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило") IS NULL, 0, (100/(SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило"))*(SELECT count(dcID) FROM ccContact WHERE Aid = ', $Aid, ' AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y-%m-%d'), ' 23:59:59" AND ccStatus NOT IN (7001) AND IsOut = FALSE AND isActive = TRUE AND ', $sqlWhere, ')) percent_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $i DAY), '%Y%m%d'));
                set $i = $i + 1;
            end while;
        SET $sql = CONCAT($sql, CHAR(10), ', ', $Aid, ';');
        SET @s = $sql;
        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SELECT `Name`, tvID
               INTO $sqlName, $sqlID
        FROM usEnumValue
        WHERE tyID = 1036
          AND Aid = $Aid
          AND isActive = TRUE
        ORDER BY tvID
        LIMIT 1;
        IF($sqlName IS NOT NULL)THEN
            while $sqlName IS NOT NULL AND LENGTH($sqlName)>0 DO
                SET $sql = CONCAT($sqlBegin, CHAR(10), 'SELECT "', $sqlName, '" `status`');
                SET $j = 0;
                    while $j <= $diff do
                        SET $sql = CONCAT($sql, CHAR(10), ', (SELECT count(dcID) FROM ccContact WHERE IsOut = FALSE AND isActive = TRUE AND Aid = ', $Aid, ' AND ContactStatus = ', $sqlID, ' AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y-%m-%d'), ' 23:59:59" AND ', $sqlWhere, ') count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y%m%d'));
                        SET $sql = CONCAT($sql, CHAR(10), ', IF((SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило")=0 OR (SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило") IS NULL, 0, (100/(SELECT count_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y%m%d'), ' FROM __StatusExportReport WHERE Aid=', $Aid, ' AND `status`="Поступило"))*(SELECT count(dcID) FROM ccContact WHERE Aid = ', $Aid, ' AND Created BETWEEN "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y-%m-%d'), ' 00:00:00" AND "', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y-%m-%d'), ' 23:59:59"  AND IsOut = FALSE AND isActive = TRUE AND ContactStatus = ', $sqlID, ' AND ', $sqlWhere, ')) percent_', DATE_FORMAT(DATE_ADD($DateFrom, INTERVAL $j DAY), '%Y%m%d'));
                        set $j = $j + 1;
                    end while;
                SET $sql = CONCAT($sql, CHAR(10), ', ', $Aid, ';');
                SET @s = $sql;
                PREPARE stmt FROM @s;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET $sqlName = '';
                SET $sql = '';
                SELECT `Name`, tvID
                       INTO $sqlName, $sqlID
                FROM usEnumValue
                WHERE tyID = 1036
                  AND Aid = $Aid
                  AND tvID > $sqlID
                  AND isActive = TRUE
                ORDER BY tvID
                LIMIT 1;
            end while;
        END IF;
        ALTER TABLE `__StatusExportReport`
            DROP COLUMN `Aid`;
        select * FROM __StatusExportReport;
    END IF;

    DROP TABLE __StatusExportReport;
  END IF;
END $$
DELIMITER ;
--
