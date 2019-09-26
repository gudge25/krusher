DELIMITER $$
DROP PROCEDURE IF EXISTS sf_GetInvoiceItem;
CREATE PROCEDURE sf_GetInvoiceItem(
    $token            VARCHAR(100)
    , $dcID           int             -- ID документа
    , $iiID           int             -- PK
    , $OwnerID        int             -- главная позиция
    , $psID           int             -- ID материала
    , $iNo            smallint        -- номер позиции
    , $iName          varchar(1020)   -- наименование позиции
    , $iPrice         decimal(14,4)   --
    , $iQty           decimal(14,4)   -- количетсво
    , $iComments      varchar(255)    -- комментарии
    , $isActive       BIT
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
    call RAISE(77068, 'sf_GetInvoiceItem');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM sfInvoiceItem ';
    --
    SET $sql = '
            SELECT
              HIID
              , iiID
              , OwnerID
              , dcID
              , psID
              , iNo
              , iName
              , iQty
              , iComments
              , iPrice
              , isActive
              , Created
              , Changed
            FROM sfInvoiceItem ';
    --
    IF $dcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dcID = ', $dcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $iiID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'iiID = ', $iiID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $OwnerID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'OwnerID = ', $OwnerID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $psID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'psID = ', $psID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $iNo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'iNo = ', $iNo);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $iName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'iName = ', QUOTE($iName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $iPrice is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'iPrice = ', $iPrice);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $iQty is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'iQty = ', $iQty);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $iComments is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'iComments = ', QUOTE($iComments));
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
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
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
  END IF;
END $$
DELIMITER ;
--
