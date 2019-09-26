DELIMITER $$
DROP PROCEDURE IF EXISTS dc_GetDocByClient;
CREATE PROCEDURE dc_GetDocByClient(
    $token          VARCHAR(100)
    , $dcID         int
    , $dcNo         VARCHAR(35)
    , $dcLink       INT
    , $dcComment    VARCHAR(200)
    , $dcSum        DECIMAL(14,2)
    , $dcStatus     int
    , $clID         int
    , $emID         int
    , $ccName       VARCHAR(50)
    , $dctID        int
    , $dcDate       DATETIME
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
  DECLARE $sqlJoin        VARCHAR(2000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_GetDocByClient');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 100);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    set $dcNo = NULLIF(TRIM($dcNo),'');
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
    SET $sqlCount = 'SELECT count(*) Qty ';
    --
    SET $sql = 'SELECT
                  d.dcID          dcID
                  , t.dctID       dctID
                  , t.dctName     dctName
                  , d.dcDate      dcDate
                  , if(d.dctID = 4, ft.tpName, d.dcNo) dcNo
                  , d.emID        emID
                  , em.emName     emName
                  #, v.Name        dcStatusName
                  , d.dcStatus    dcStatus
                  , c.ccName      ccName ';
    --
    set $sqlJoin = 'FROM dcDoc d
            inner join dcType t on d.dctID = t.dctID
            left join emEmploy em on em.emID = d.emID
            #left join usEnumValue v on (v.tvID = d.dcStatus AND d.dcStatus>0 AND v.Aid = 3)
            left join fmForm f on f.dcID = d.dcID
            left join fmFormType ft on ft.tpID = f.tpID
            left join ccContact c on c.dcID = d.dcID';
    --
    IF $dcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcID = ', $dcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcNo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcNo = ', QUOTE($dcNo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcComment is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcComment = ', QUOTE($dcComment));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcStatus = ', $dcStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcLink is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcLink = ', $dcLink);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcSum is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcSum = ', $dcSum);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dctID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dctID = ', $dctID);
      IF $dctID = 4 THEN
        IF $dcNo is NOT NULL then
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'ft.tpName like ', QUOTE($dcNo));
        END IF;
      ELSE
        IF $dcNo is NOT NULL then
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcNo like ', QUOTE($dcNo));
        END IF;
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ccName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'c.ccName = ', QUOTE($ccName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcDate is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcDate = ', QUOTE($dcDate));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.Aid = ', $Aid, ' AND	d.dctID>1 #AND v.Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlJoin, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY d.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount, CHAR(10), $sqlJoin, CHAR(10), $sqlWhere);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
