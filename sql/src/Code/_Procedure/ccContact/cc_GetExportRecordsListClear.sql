DELIMITER $$
DROP PROCEDURE IF EXISTS cc_GetExportRecordsListClear;
CREATE PROCEDURE cc_GetExportRecordsListClear(
    $DateFrom             DATETIME
    , $DateTo             DATETIME
    , $status             varchar(50)
    , $isActive           BIT
    , $sorting            VARCHAR(5)
    , $field              VARCHAR(50)
    , $offset             INT(11)
    , $limit              INT(11)
)
BEGIN
    DECLARE $sqlWhereCode   VARCHAR(100);
    DECLARE $sqlWhere       VARCHAR(5000);
    DECLARE $sqlCount       VARCHAR(500);
    DECLARE $sql            VARCHAR(5000);
    DECLARE $sorting_       VARCHAR(5);
    DECLARE $field_         VARCHAR(50);
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
    SET $sqlCount = 'SELECT count(*) Qty FROM ccContactRecords';
    --
    SET $sql = 'SELECT
                    idCR
                    , link
                    , statusReady
                    , DateFrom
                    , DateTo
                    , dcIDs
                    , emIDs
                    , dcStatuss
                    , ffIDs
                    , isMissed
                    , isUnique
                    , CallTypes
                    , channels
                    , ccNames
                    , comparison
                    , billsec
                    , clIDs
                    , IsOut
                    , id_autodials
                    , id_scenarios
                    , ManageIDs
                    , target
                    , coIDs
                    , destination
                    , destdata
                    , destdata2
                    , ContactStatuses
                    , convertFormat
                    , isActive
                    , Created
                    , Changed
                    , Aid
                FROM ccContactRecords ';
    --
    IF $DateFrom is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Created >= ', QUOTE($DateFrom));
        SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateTo is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Created <= ', QUOTE($DateTo));
        SET $sqlWhereCode = ' AND ';
    END IF;
    IF $status is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'statusReady = ', QUOTE($status));
        SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
        IF $IsActive = TRUE THEN
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 1');
        ELSE
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 0');
        END IF;
        SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10));
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    -- select @s;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
--
