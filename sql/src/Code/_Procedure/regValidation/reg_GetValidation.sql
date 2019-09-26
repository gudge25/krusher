DELIMITER $$
DROP PROCEDURE IF EXISTS reg_GetValidation;
CREATE PROCEDURE reg_GetValidation(
    $token            VARCHAR(100)
    , $vID            INT
    , $prefix         BIGINT
    , $prefixBegin    BIGINT
    , $prefixEnd      BIGINT
    , $MCC            INT
    , $MNC            INT
    , $cID            INT
    , $rgID           INT
    , $arID           INT
    , $lID            INT
    , $oID            INT
    , $gmt            INT
    , $langID         INT
    , $isActive       bit
    , $phone          BIGINT
    , $isGSM          BIT
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
  DECLARE $Aid            INT;
  DECLARE $cID2           INT;
  DECLARE $rgID2          INT;
  DECLARE $arID2          INT;
  DECLARE $lID2           INT;
  DECLARE $oID2           INT;
  DECLARE $language       VARCHAR(2);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_GetValidation');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit = IFNULL($limit, 50);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    SET $language = fn_GetLanguage($Aid, $langID);
    --
    IF($sorting IS NULL) THEN
      SET $sorting_ = 'DESC';
    ELSE
      SET $sorting_ = $sorting;
    END IF;
    IF($field IS NULL) THEN
      SET $field_ = '`prefix`';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM reg_validation ';
    --
    SET $sql = CONCAT('
            SELECT
                v.HIID HIID
                , v.id_validation vID
                , v.prefix
                , v.prefixBegin
                , v.prefixEnd
                , v.gmt
                , v.MCC
                , v.MNC
                , v.id_country    cID
                , IF(v.id_country IS NOT NULL, (SELECT title_', $language, ' FROM reg_countries WHERE country_id = v.id_country), NULL)  cName
                , v.id_region   rgID
                , IF(v.id_region IS NOT NULL, (SELECT title_', $language, ' FROM reg_regions WHERE country_id = v.id_country AND region_id=v.id_region), NULL)  rgName
                , v.id_area   aID
                , IF(v.id_area IS NOT NULL, (SELECT area_', $language, ' FROM reg_cities WHERE city_id = v.id_area AND region_id=v.id_region AND country_id = v.id_country), NULL)  aName
                , v.id_city     lID
                , IF(v.id_city IS NOT NULL, (SELECT title_', $language, ' FROM reg_cities WHERE city_id = v.id_city AND region_id=v.id_region AND country_id = v.id_country), NULL)  lName
                , v.id_mobileProvider     oID
                , IF(v.id_mobileProvider IS NOT NULL, (SELECT title FROM reg_operator WHERE id_operator = v.id_mobileProvider), NULL)  oName
                , v.isActive
                , IF(v.id_mobileProvider IS NULL, FALSE, TRUE) isGSM
              FROM reg_validation v ');
    --
    IF $phone is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'prefixBegin  <= ', $phone);
      SET $sqlWhereCode = ' AND ';
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'prefixEnd  >= ', $phone);
    END IF;
    IF $vID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_validation  = ', $vID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $prefix is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'prefix  = ', $prefix);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $prefixBegin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'prefixBegin  = ', $prefixBegin);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $prefixEnd is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'prefixEnd  = ', $prefixEnd);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $MCC is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'MCC  = ', $MCC);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $MNC is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'MNC  = ', $MNC);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $cID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_country  = ', $cID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $rgID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_region  = ', $rgID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $arID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_area  = ', $arID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $lID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_city  = ', $lID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $oID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_mobileProvider  = ', $oID);
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
    IF $isGSM is NOT NULL THEN
      IF $isGSM = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_mobileProvider IS NOT NULL');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_mobileProvider IS NULL');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid  IN (0, ', $Aid, ')');
    --
    IF $phone is NOT NULL THEN
      SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY prefix DESC', CHAR(10), 'LIMIT 1');
    ELSE
      SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
    END IF;
    --
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
