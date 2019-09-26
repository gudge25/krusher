DELIMITER $$
DROP PROCEDURE IF EXISTS reg_GetCountryClear;
CREATE PROCEDURE reg_GetCountryClear(
    $Aid              VARCHAR(100)
    , $cID            INT(11)
    , $cName          VARCHAR(250)
    , $langID         INT
    , $LenNumber1     INT
    , $LenNumber2     INT
    , $isActive       bit
    , $sorting        VARCHAR(5)
    , $field          VARCHAR(50)
    , $offset         INT(11)
    , $limit          INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $language       VARCHAR(2);
  SET $offset = IFNULL($offset, 0);
  SET $limit = IFNULL($limit, 100);
  SET $limit = if($limit > 10000, 10000, $limit);
  SET $sqlWhereCode = 'WHERE ';
  SET $sqlWhere = '';
  SET $language = fn_GetLanguage($Aid, $langID);
  --
  IF($sorting IS NULL) THEN
    SET $sorting_ = 'ASC';
  ELSE
    SET $sorting_ = $sorting;
  END IF;
  IF($field IS NULL) THEN
    SET $field_ = CONCAT('title_', $language);
  ELSE
    SET $field_ = $field;
  END IF;
  --
  SET $sqlCount = 'SELECT count(*) Qty FROM reg_countries ';
  --
  SET $sql = CONCAT('
          SELECT
            HIID
            , country_id cID
            , title_', $language, ' cName
            , LenNumber1
            , LenNumber2
            , isActive
          FROM reg_countries ');
  --
  IF $cID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'country_id = ', $cID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $cName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'title_', $language, ' LIKE ', QUOTE(CONCAT($cName, '%')));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $LenNumber1 is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'LenNumber1 = ', $LenNumber1);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $LenNumber2 is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'LenNumber2 = ', $LenNumber2);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Aid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid  IN (0, ', $Aid, ')');
    SET $sqlWhereCode = ' AND ';
  ELSE
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid  IN (0)');
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
