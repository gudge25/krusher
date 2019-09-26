DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetPoolListClear;
CREATE PROCEDURE ast_GetPoolListClear(
    $Aid                            INT(11)
    , $plID                         INT(11)
    , $poolID                       INT(11)
    , $trID                         INT(11)
    , $percent                      INT(11)
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
    call RAISE(77068, 'ast_GetPoolListClear');
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
    SET $sql = '
            SELECT
              pl.HIID
              , pl.Aid
              , pl.plID
              , pl.poolID
              , pl.trID
              , IF(trID IS NOT NULL, (SELECT trName FROM ast_trunk WHERE trID = pl.trID), NULL) trName
              , IF(trID IS NOT NULL, (SELECT coID FROM ast_trunk WHERE trID = pl.trID), NULL) coID
              , pl.percent
              , pl.isActive
              , pl.Created
              , pl.Changed
            FROM ast_pool_list pl';
    --
    IF $poolID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pl.poolID = ', $poolID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $plID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pl.plID = ', $plID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $trID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pl.trID = ', $trID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $percent is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pl.percent = ', $percent);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Aid is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pl.Aid = ', $Aid);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'pl.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'pl.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, ' pl.trID IN (SELECT trID FROM ast_trunk WHERE isActive=TRUE AND Aid = pl.Aid) AND pl.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY pl.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    /*SELECT @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
