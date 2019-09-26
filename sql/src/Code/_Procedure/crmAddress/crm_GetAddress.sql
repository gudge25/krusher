DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetAddress;
CREATE PROCEDURE crm_GetAddress(
    $token          VARCHAR(100)
    , $adsID        INT
    , $adsName      VARCHAR(200)
    , $adtID        INT
    , $Postcode     VARCHAR(10)
    , $clID         INT
    , $pntID        INT
    , $Region       VARCHAR(100)
    , $RegionDesc   VARCHAR(200)
    , $isActive     BIT
    , $sorting      VARCHAR(5)
    , $field        VARCHAR(50)
    , $offset       INT
    , $limit        INT
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
    call RAISE(77068, 'crm_GetAddress');
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
      SET $field_ = 'Created';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM crmAddress';
    --
    SET $sql = '
            SELECT
              HIID
              , adsID
              , adsName
              , adtID
              , Postcode
              , clID
              , pntID
              , Region
              , RegionDesc
              , isActive
              , Created
              , Changed
            FROM crmAddress ';
    --
    IF $adsID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'adsID = ', $adsID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $adsName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'adsName = ', QUOTE($adsName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $adtID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'adtID = ', $adtID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Postcode is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Postcode = ', QUOTE($Postcode));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $pntID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pntID = ', $pntID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Region is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Region = ', QUOTE($Region));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RegionDesc is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'RegionDesc = ', QUOTE($RegionDesc));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 0');
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
