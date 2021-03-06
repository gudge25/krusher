DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetCompanyClear;
CREATE PROCEDURE crm_GetCompanyClear(
    $coID                 INT(11)
    , $coName             VARCHAR(100)
    , $coDescription      VARCHAR(100)
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
  DECLARE $Aid            INT;
  --
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
  SET $sql = '
          SELECT
            HIID
            , coID
            , coName
            , coDescription
            , isActive
            , Created
            , Changed
          FROM crmCompany ';
  --
  IF $coID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coID = ', $coID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $coName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coName = ', QUOTE($coName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $coDescription is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coDescription = ', QUOTE($coDescription));
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
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
--
