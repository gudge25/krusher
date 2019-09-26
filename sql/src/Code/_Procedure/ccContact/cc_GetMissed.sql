DROP PROCEDURE IF EXISTS cc_GetMissed;
DELIMITER $$
CREATE PROCEDURE cc_GetMissed(
    $token              VARCHAR(100)
    , $DateFrom         DATETIME
    , $IsOut            BIT
    , $coIDs            TINYTEXT
    , $emIDs            TINYTEXT
    , $ManagerIDs       TINYTEXT
)
BEGIN
    DECLARE $sql            VARCHAR(8000);
    DECLARE $Aid            INT;
    DECLARE $sqlWhereCode   VARCHAR(10);
    DECLARE $sqlWhere       VARCHAR(8000);
    DECLARE $sqlOrder       VARCHAR(8000);
    DECLARE $sqlMaker       VARCHAR(1000);
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
        call RAISE(77068, 'cc_GetMissed');
    ELSE
        IF($DateFrom IS NULL) THEN
            SET $DateFrom = date_sub(NOW(),INTERVAL -1 WEEK) ;
        END IF;
        SET $sql = CONCAT('SELECT count(*) missed
                          FROM (
                            SELECT ccName, count(*) FROM ccContact
                            WHERE IsMissed = TRUE AND Created>"', $DateFrom, '" AND Aid = ', $Aid, ' AND CallType != 101320');
        SET $sqlWhere = '';
        SET $sqlWhereCode = ' AND ';
        SET $sqlOrder = '';
        IF (($DateFrom is NOT NULL) AND (length(TRIM($DateFrom))>0)) THEN
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Created>"', $DateFrom, '"');
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
        IF (($coIDs is NOT NULL) AND (length(TRIM($coIDs))>0)) THEN
            SET $sqlMaker = '';
            IF ((LOCATE('true', $coIDs)>0) OR (LOCATE('false', $coIDs)>0)) THEN
                IF (LOCATE(',', $coIDs)>0) THEN
                    SET $sqlMaker = REPLACE($emIDs, ',true', ') OR coID = 0');
                    SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR coID != 0');
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'coID IN (', $sqlMaker);
                ELSE
                    IF $emIDs = 'true' THEN
                        SET $sqlMaker = 'coID = 0';
                    END IF;
                    IF $emIDs = 'false' THEN
                        SET $sqlMaker = 'coID != 0';
                    END IF;
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
                END IF;
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'coID IN (', $coIDs, ')');
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
        IF $IsOut is NOT NULL THEN
            IF $IsOut = TRUE THEN
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsOut = TRUE');
            ELSE
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsOut = FALSE');
            END IF;
            SET $sqlWhereCode = ' AND ';
        END IF;
        SET $sql = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY ccName) a;');
        SET @s = $sql;
        -- select @s;
        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$
DELIMITER ;
--
