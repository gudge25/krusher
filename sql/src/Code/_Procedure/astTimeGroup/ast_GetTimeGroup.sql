DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetTimeGroup;
CREATE PROCEDURE ast_GetTimeGroup(
    $token                          VARCHAR(100)
    , $tgID                         INT(11)
    , $tgName                       VARCHAR(50)
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $invalid_destination          INT(11)
    , $invalid_destdata             INT(11)
    , $invalid_destdata2            VARCHAR(100)
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
    call RAISE(77068, 'ast_GetTimeGroup');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_time_group ';
    --
    SET $sql = '
            SELECT
              HIID
              , tgID
              , tgName
              , destination
              , destdata
              , destdata2
              , invalid_destination
              , invalid_destdata
              , invalid_destdata2
              , isActive
              , Created
              , Changed
            FROM ast_time_group ';
    --
    IF $tgID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'tgID = ', $tgID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'destination = ', $destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'destdata = ', $destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'destdata2 = ', QUOTE($destdata));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $invalid_destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'invalid_destination = ', $invalid_destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $invalid_destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'invalid_destdata = ', $invalid_destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $invalid_destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'invalid_destdata2 = ', QUOTE($invalid_destdata));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $tgName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'tgName = ', QUOTE($tgName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
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
