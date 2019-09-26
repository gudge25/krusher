DROP PROCEDURE IF EXISTS dc_GetDocTemplate;
DELIMITER $$
CREATE PROCEDURE dc_GetDocTemplate(
    $token              VARCHAR(100)
    , $dtID             int
    , $dtName           varchar(100)
    , $dcTypeID         tinyint(4)
    , $dtTemplate       text
    , $isDefault        bit
    , $isActive         bit
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
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_GetDocTemplate');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM dcDocTemplate';
    --
    SET $sql = '
            SELECT
              HIID
              , dtID
              , dtName
              , dcTypeID
              , dtTemplate
              , isDefault
              , isActive
              , Created
              , Changed
            FROM dcDocTemplate ';
    --
    IF $dtID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtID = ', $dtID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcTypeID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dcTypeID = ', $dcTypeID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isDefault is NOT NULL THEN
      IF $isDefault = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isDefault = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isDefault = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtName = ', QUOTE($dtName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtTemplate is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtTemplate = ', QUOTE($dtTemplate));
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
