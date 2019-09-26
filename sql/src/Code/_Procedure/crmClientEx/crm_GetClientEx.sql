DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetClientEx;
CREATE PROCEDURE crm_GetClientEx(
    $token          VARCHAR(100)
    , $clID         INT
    , $CallDate     DATETIME
    , $isNotice     BIT
    , $isRobocall   BIT
    , $isCallback   BIT
    , $isDial       BIT
    , $curID        INT
    , $langID       INT
    , $sum          DECIMAL(14,2)
    , $ttsText      LONGTEXT
    , $isActive     BIT
    , $sorting      VARCHAR(5)
    , $field        VARCHAR(50)
    , $offset       INT
    , $limit        INT
) COMMENT 'Получает расширеную шапку клиента'
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
    call RAISE(77068, 'crm_GetClientEx');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM crmClientEx';
    --
    SET $sql = '
            SELECT
              HIID
              , clID
              , CallDate
              , ChangedBy
              , isNotice
              , isRobocall
              , ActDate
              , timeZone
              , isCallback
              , isDial
              , curID
              , langID
              , `sum`
              , ttsText
              , isActive
              , Created
              , Changed
            FROM crmClientEx ';
    --
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $CallDate is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'CallDate = ', QUOTE($CallDate));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isNotice is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'isNotice = 1');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isRobocall is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'isRobocall = ', $isRobocall);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isCallback is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'isCallback = ', $isCallback);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isDial is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'isDial = ', $isDial);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $curID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'curID = ', $curID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $langID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'langID = ', $langID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $sum is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'sum = ', $sum);
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
