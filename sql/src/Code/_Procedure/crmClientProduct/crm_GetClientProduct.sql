DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetClientProduct;
CREATE PROCEDURE crm_GetClientProduct(
    $token          VARCHAR(100)
    , $cpID         int
    , $clID         int
    , $psID         int
    , $cpQty        decimal(14,4)
    , $cpPrice      decimal(14,2)
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
    call RAISE(77068, 'crm_GetClientProduct');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM crmClientProduct p
              inner join stProduct st on st.psID = p.psID ';
    --
    SET $sql = '
            select
              p.HIID        HIID
              , p.cpID      cpID
              , p.clID      clID
              , p.psID      psID
              , p.cpQty     cpQty
              , p.cpPrice   cpPrice
              , st.psName   psName
              , p.isActive  isActive
              , p.Created
              , p.Changed
            from crmClientProduct p
              inner join stProduct st on st.psID = p.psID ';
    --
    IF $cpID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.cpID = ', $cpID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $psID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.psID = ', $psID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $cpQty is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.cpQty = ', $cpQty);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $cpPrice is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.cpPrice = ', $cpPrice);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'p.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'p.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'p.Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY p.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
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
