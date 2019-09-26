DROP PROCEDURE IF EXISTS fm_GetFormItem;
DELIMITER $$
CREATE PROCEDURE fm_GetFormItem(
    $token            VARCHAR(100)
    , $fiID           int           -- 'ID записи'
    , $dcID           int           -- 'ID документа'
    , $qID            varchar(200)  -- 'ID вопроса '
    , $qName          varchar(200)  -- 'вопрос '
    , $qiID           int           -- 'ID вариант ответа'
    , $qiAnswer       varchar(100)  -- 'вариант ответа'
    , $qiComment      varchar(200)
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
    call RAISE(77068, 'fm_GetFormItem');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM fmFormItem';
    --
    SET $sql = '
            SELECT
              HIID
              , fiID
              , dcID
              , qID
              , qName
              , qiID
              , qiAnswer
              , qiComment
              , isActive
              , Created
              , Changed
            FROM fmFormItem ';
    --
    IF $dcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dcID = ', $dcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $fiID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'fiID = ', $fiID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $qID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'qID = ', QUOTE($qID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $qName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'qName = ', QUOTE($qName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $qiID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'qiID = ', $qiID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $qiAnswer is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'qiAnswer = ', QUOTE($qiAnswer));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $qiComment is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'qiComment = ', QUOTE($qiComment));
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
