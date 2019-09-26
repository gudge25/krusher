DELIMITER $$
DROP PROCEDURE IF EXISTS fs_GetTemplateItem;
CREATE PROCEDURE fs_GetTemplateItem(
    $token            VARCHAR(100)
    , $ftID           int
    , $ftiID          int
    , $ftType         int
    , $ColNumber      varchar(200)
    , $ftDelim        varchar(12)
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
    call RAISE(77068, 'fs_GetTemplateItem');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM fsTemplateItem i
                    inner join fsTemplateItemCol c on c.ftiID = i.ftiID ';
    --
    SET $sql = 'select
                    i.HIID
                    , i.ftiID
                    , i.ftID
                    , i.ftType
                    , GROUP_CONCAT(c.ColNumber separator ",") as ColNumber
                    , i.ftDelim
                    , i.isActive
                  from fsTemplateItem i
                    inner join fsTemplateItemCol c on c.ftiID = i.ftiID ';
    --
    IF $ftID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.ftID = ', $ftID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ftiID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.ftiID = ', $ftiID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ftType is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.ftType = ', $ftType);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ColNumber is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ColNumber = ', QUOTE($ColNumber));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ftDelim is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.ftDelim = ', QUOTE($ftDelim));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY i.ftiID, i.ftID, i.ftType, i.ftDelim ORDER BY i.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
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
