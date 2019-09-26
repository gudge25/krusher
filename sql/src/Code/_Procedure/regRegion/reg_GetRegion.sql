DELIMITER $$
DROP PROCEDURE IF EXISTS reg_GetRegion;
CREATE PROCEDURE reg_GetRegion(
    $token            VARCHAR(100)
    , $rgID           int
    , $rgName         VARCHAR(250)
    , $cID            int
    , $langID         INT
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
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_GetRegion');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit = IFNULL($limit, 50);
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
    SET $sqlCount = 'SELECT count(*) Qty FROM reg_regions r
        INNER JOIN reg_countries c ON c.country_id = r.country_id ';
    --
    SET $sql = CONCAT('
            SELECT r.HIID HIID
              , r.region_id rgID
              , r.title_', $language, ' rgName
              , c.country_id cID
              , c.title_', $language, ' cName
              , r.isActive
        FROM reg_regions r
        INNER JOIN reg_countries c ON c.country_id = r.country_id ');
    --
    IF $cID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.country_id  = ', $cID);
      SET $sqlWhereCode = ' AND ';
      IF $rgName is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'r.title_', $language, ' LIKE  ', QUOTE(CONCAT($rgName, '%')));
      END IF;
    END IF;
    IF $rgID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'r.region_id  = ', $rgID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'r.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'r.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'r.Aid  IN (0, ', $Aid, ')');
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY r.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
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
