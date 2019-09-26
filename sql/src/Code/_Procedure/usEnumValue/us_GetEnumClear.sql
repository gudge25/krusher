DELIMITER $$
DROP PROCEDURE IF EXISTS us_GetEnumClear;
CREATE PROCEDURE us_GetEnumClear(
    $Aid              INT(11)
    , $tvID           INT(11)
    , $tyID           INT(11)
    , $Name           VARCHAR(100)
    , $isActive       BIT
    , $sorting        VARCHAR(5)
    , $field          VARCHAR(50)
    , $offset         INT(11)
    , $limit          INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(1000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  SET $offset = IFNULL($offset, 0);
  SET $limit  = IFNULL($limit, 500);
  SET $limit = if($limit > 10000, 10000, $limit);
  SET $sqlWhereCode = 'WHERE ';
  SET $sqlWhere = '';
  IF($sorting IS NULL) THEN
    SET $sorting_ = 'ASC';
  ELSE
    SET $sorting_ = $sorting;
  END IF;
  IF($field IS NULL) THEN
    SET $field_ = 'tvID';
  ELSE
    SET $field_ = $field;
  END IF;
  SET $sqlCount = 'SELECT COUNT(*)    Qty FROM usEnumValue ';
  --
  SET $sql = 'SELECT
                  HIID
                  , tvID
                  , tyID
                  , Name
                  , isActive
                FROM usEnumValue ';
  --
  IF $tvID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'tvID = ', $tvID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $tyID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'tyID = ', $tyID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Aid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
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
  IF $Name is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Name = ', QUOTE($Name));
    SET $sqlWhereCode = ' AND ';
  END IF;
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
END $$
DELIMITER ;
--
