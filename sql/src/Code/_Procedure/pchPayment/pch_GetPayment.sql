DELIMITER $$
DROP PROCEDURE IF EXISTS pch_GetPayment;
CREATE PROCEDURE pch_GetPayment(
    $token            VARCHAR(100)
    , $dcID           int           -- ID документа
    , $dcNo           varchar(35)   -- Номер документа
    , $dcDate         date          -- дата документа
    , $dcLink         int           -- ID документа основания
    , $dcComment      varchar(200)  -- комментарий
    , $dcSum          decimal(14,2) -- сумма документа
    , $dcStatus       int           -- статус документа
    , $clID           int           -- ID клиента
    , $emID           int           -- ID владельца
    , $isActive       BIT
    , $PayType        int
    , $PayMethod      int
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
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'pch_GetPayment');
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
      SET $field_ = '`Created`';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM pchPayment s
              INNER JOIN dcDoc d ON d.dcID = s.dcID
              INNER JOIN crmClient cl ON d.clID = cl.clID ';
    --
    SET $sql = '
            SELECT
              s.HIID                   HIID
              , d.dcID                   dcID
              , d.dcNo                   dcNo
              , d.dcDate                 dcDate
              , d.dcLink                 dcLink
              , d.dcComment              dcComment
              , d.dcSum                  dcSum
              , d.dcStatus               dcStatus
              , d.clID                   clID
              , cl.clName                clName
              , d.emID                   emID
              , CONVERT(d.uID,CHAR(20))  uID
              , d.Created                Created
              , d.CreatedBy              CreatedBy
              , d.Changed                Changed
              , d.ChangedBy               Changed
              , s.PayType                PayType
              , s.PayMethod              PayMethod
              , d.isActive
              , d.Created
            FROM pchPayment s
              INNER JOIN dcDoc d ON d.dcID = s.dcID
              INNER JOIN crmClient cl ON d.clID = cl.clID ';
    --
    IF $dcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcID = ', $dcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcNo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcNo = ', QUOTE($dcNo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcDate is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcDate = ', QUOTE($dcDate));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcLink is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcLink = ', $dcLink);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcComment is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcComment = ', QUOTE($dcComment));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcSum is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcSum = ', $dcSum);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcStatus = ', $dcStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $PayMethod is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.PayMethod = ', $PayMethod);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.Aid = ', $Aid);
    SET $sqlWhereCode = ' AND ';
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dctID = 6');
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY d.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
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
