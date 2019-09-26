DROP PROCEDURE IF EXISTS st_GetProduct;
DELIMITER $$
CREATE PROCEDURE st_GetProduct(
    $token          VARCHAR(100)
    , $psID         INT(11)
    , $psName       varchar(1020)
    , $psState      int
    , $psCode       varchar(25)
    , $msID         INT(11)
    , $pctID        int
    , $ParentID     INT
    , $bID          int
    , $isActive     bit
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
    call RAISE(77068, 'st_GetProduct');
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
    SET $sqlCount = 'SELECT count(*) Qty from stProduct p
              inner join usMeasure ms on ms.msID = p.msID
              left outer join stCategory c on c.pctID = p.pctID
              left outer join stBrand b on b.bID = p.bID';
    --
    SET $sql = '
            SELECT
              p.HIID                        HIID
              , p.psID                      psID
              , p.psName                    psName
              , p.psState                   psState
              , p.psCode                    psCode
              , p.msID                      msID
              , ms.msName                   msName
              , p.pctID                     pctID
              , c.pctName                   pctName
              , p.ParentID                  ParentID
              , b.bID                       bID
              , b.bName                     bName
              , p.Created                   Created
              , p.CreatedBy                 CreatedBy
              , p.Changed                   Changed
              , p.ChangedBy                  ChangedBy
              , CONVERT(p.uID,char(20))     uID
              , p.isActive
            from stProduct p
              inner join usMeasure ms on ms.msID = p.msID
              left outer join stCategory c on c.pctID = p.pctID
              left outer join stBrand b on b.bID = p.bID ';
    --
    IF $psID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.psID = ', $psID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ParentID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.ParentID = ', $ParentID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $psState is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.psState = ', $psState);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $msID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.msID = ', $msID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $pctID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.pctID = ', $pctID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $bID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.bID = ', $bID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $psName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.psName = ', QUOTE($psName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $psCode is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'p.psCode = ', QUOTE($psCode));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
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
