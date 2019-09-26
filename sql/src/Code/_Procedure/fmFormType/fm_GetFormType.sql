DROP PROCEDURE IF EXISTS fm_GetFormType;
DELIMITER $$
CREATE PROCEDURE fm_GetFormType(
    $token          VARCHAR(100)
    , $tpID         int
    , $tpName       varchar(50)
    , $ffID         int
    , $isActive     bit
    , $sorting      VARCHAR(5)
    , $field        VARCHAR(50)
    , $offset       INT(11)
    , $limit        INT(11)
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
    call RAISE(77068, 'fm_GetFormType');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit = IFNULL($limit, 100);
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
      SET $field_ = '`tpID`';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM fmFormType';
    --
    SET $sql = '
            SELECT
              HIID
              , tpID
              , tpName
              , isActive
              , ffID
              , isActive
              , Created
              , Changed
            FROM fmFormType ';
    --
    IF $tpID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'tpID = ', $tpID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ffID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ffID = ', $ffID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $tpName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'tpName = ', QUOTE($tpName));
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
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
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
