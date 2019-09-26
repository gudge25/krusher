DELIMITER $$
DROP PROCEDURE IF EXISTS reg_GetArea;
CREATE PROCEDURE reg_GetArea(
    $token            VARCHAR(100)
    , $arID           INT
    , $aName          VARCHAR(150)
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
    call RAISE(77068, 'reg_GetArea');
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
      SET $field_ = CONCAT('area_', $language);
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM reg_cities ';
    --
    SET $sql = CONCAT('
            SELECT r.HIID HIID
                  , r.city_id aID
                  , r.area_', $language, ' aName
                  , r.country_id cID
                  , (SELECT title_', $language,' FROM reg_countries WHERE country_id = r.country_id) cName
                  , r.region_id rgID
                  , (SELECT title_', $language,' FROM reg_regions WHERE region_id = r.region_id) rgName
                  , r.isActive
              FROM reg_cities r');
    --
    IF $cID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'country_id  = ', $cID);
      SET $sqlWhereCode = ' AND ';
      IF $rgID is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'region_id  = ', $rgID);
        IF $arID is NOT NULL THEN
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'city_id  = ', $arID);
        END IF;
        IF $aName is NOT NULL THEN
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'area_', $language,' LIKE  ', QUOTE(CONCAT($aName, '%')));
        END IF;
      END IF;
    ELSEIF($arID is NOT NULL) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'city_id  = ', $arID);
      SET $sqlWhereCode = ' AND ';
      IF $aName is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'title_', $language, ' LIKE  ', QUOTE(CONCAT($aName, '%')));
      END IF;
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
    IF($arID IS NULL AND $aName IS NULL AND $cID IS NULL AND $rgID IS NULL) THEN
      call RAISE(77114, NULL);
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid IN (0, ', $Aid, ')');
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY area_', $language, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
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
