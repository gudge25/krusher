DELIMITER $$
DROP PROCEDURE IF EXISTS reg_GetLocation;
CREATE PROCEDURE reg_GetLocation(
    $token            VARCHAR(100)
    , $lID            INT
    , $lName          VARCHAR(150)
    , $cID            INT
    , $rgID           INT
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
    call RAISE(77068, 'reg_GetLocation');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit = IFNULL($limit, 10);
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
    SET $sqlCount = 'SELECT count(*) Qty FROM reg_cities l
              INNER JOIN reg_regions r ON l.region_id = r.region_id
              INNER JOIN reg_countries c ON c.country_id = l.country_id ';
    --
    SET $sql = CONCAT('
            SELECT l.HIID HIID
                  , city_id lID
                  , l.title_', $language, ' lName
                  , l.country_id cID
                  , c.title_', $language, '  cName
                  , l.region_id rgID
                  , r.title_', $language, ' rgName
                  , city_id aID
                  , l.area_', $language, ' aName
						      , l.isActive
              FROM reg_cities l
              INNER JOIN reg_regions r ON l.region_id = r.region_id
              INNER JOIN reg_countries c ON c.country_id = l.country_id');
    --
    IF $cID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.country_id  = ', $cID);
      SET $sqlWhereCode = ' AND ';
      IF $rgID is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.region_id  = ', $rgID);
        IF $lID is NOT NULL THEN
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.city_id  = ', $lID);
        END IF;
        IF $lName is NOT NULL THEN
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.title_', $language, ' LIKE  ', QUOTE(CONCAT($lName, '%')));
        END IF;
      ELSE
        call RAISE(77070, 'rgID');
      END IF;
      IF $isActive is NOT NULL THEN
        IF $isActive = TRUE THEN
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.isActive = 1');
        ELSE
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.isActive = 0');
        END IF;
        SET $sqlWhereCode = ' AND ';
      END IF;
      --
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.Aid  IN (0, ', $Aid, ')');
      --
      SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY l.title_', $language, CHAR(10), 'ORDER BY l.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
      PREPARE stmt FROM @s;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      --
      SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
      PREPARE stmt FROM @s;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    ELSEIF($lID is NOT NULL) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.city_id  = ', $lID);
      SET $sqlWhereCode = ' AND ';
      IF $lName is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.title_', $language, ' LIKE  ', QUOTE(CONCAT($lName, '%')));
      END IF;
      IF $isActive is NOT NULL THEN
        IF $isActive = TRUE THEN
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.isActive = 1');
        ELSE
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.isActive = 0');
        END IF;
        SET $sqlWhereCode = ' AND ';
      END IF;
      --
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'l.Aid  IN (0, ', $Aid, ')');
      --
      SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY l.title_', $language, CHAR(10), 'ORDER BY l.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
      PREPARE stmt FROM @s;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      --
      SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
      PREPARE stmt FROM @s;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    ELSE
      call RAISE(77070, 'lID');
    END IF;
  END IF;
END $$
DELIMITER ;
--
