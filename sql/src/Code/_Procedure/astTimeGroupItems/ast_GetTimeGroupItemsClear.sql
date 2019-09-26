DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetTimeGroupItemsClear;
CREATE PROCEDURE ast_GetTimeGroupItemsClear(
    $Aid                            INT(11)
    , $tgiID                        INT(11)
    , $tgID                         INT(11)
    , $TimeStart                    TIME
    , $TimeFinish                   TIME
    , $DayNumStart                  INT(11)
    , $DayNumFinish                 INT(11)
    , $DayStart                     VARCHAR(10)
    , $DayFinish                    VARCHAR(10)
    , $MonthStart                   VARCHAR(10)
    , $MonthFinish                  VARCHAR(10)
    , $isActive                     BIT
    , $sorting                      VARCHAR(5)
    , $field                        VARCHAR(50)
    , $offset                       INT(11)
    , $limit                        INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);  
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetTimeGroupItemsClear');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_time_group_items ';
    --
    SET $sql = '
            SELECT
              HIID
              , Aid
              , tgiID
              , tgID
              , TimeStart
              , TimeFinish
              , DayNumStart
              , DayNumFinish
              , DayStart
              , DayFinish
              , MonthStart
              , MonthFinish
              , isActive
              , Created
              , Changed
            FROM ast_time_group_items ';
    --
    IF $tgiID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'tgiID = ', $tgiID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $tgID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'tgID = ', $tgID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TimeStart is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'TimeStart = ', QUOTE($TimeStart));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TimeFinish is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'TimeFinish = ', QUOTE($TimeFinish));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DayStart is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'DayStart = ', QUOTE($DayStart));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DayFinish is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'DayFinish = ', QUOTE($DayFinish));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DayNumStart is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'DayNumStart = ', QUOTE($DayNumStart));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DayNumFinish is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'DayNumFinish = ', QUOTE($DayNumFinish));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $MonthStart is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'MonthStart = ', QUOTE($MonthStart));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $MonthFinish is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'MonthFinish = ', QUOTE($MonthFinish));
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
    IF $Aid is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Aid = ', $Aid);
      SET $sqlWhereCode = ' AND ';
    END IF;
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
