DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetAutodialProcess;
CREATE PROCEDURE ast_GetAutodialProcess(
    $token              VARCHAR(100)
    , $id_autodial      INT(11)
    , $process          INT(11)
    , $ffID             INT(11)
    , $id_scenario      INT(11)
    , $emID             INT(11)
    , $factor           INT(11)
    , $called           INT(11)
    , $targetCalls      INT(11)
    , $planDateBegin    DATETIME
    , $errorDescription VARCHAR(500)
    , $description      VARCHAR(500)
    , $isActive         BIT
    , $sorting          VARCHAR(5)
    , $field            VARCHAR(50)
    , $offset           INT(11)
    , $limit            INT(11)
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
  SET $offset = IFNULL($offset, 0);
  SET $limit  = IFNULL($limit, 100);
  SET $limit  = if($limit > 10000, 10000, $limit);
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
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetAutodialProcess');
  ELSEIF ($Aid = 0) THEN
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_autodial_process';
    --
    SET $sql = '
            SELECT
              HIID
              , Aid
              , id_autodial
              , `process`
              , ffID
              , id_scenario
              , emID
              , factor
              , called
              , targetCalls
              , planDateBegin
              , errorDescription
              , description
              , Created
              , Changed
            FROM ast_autodial_process ';
    --
    IF $id_autodial is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_autodial = ', $id_autodial);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $process is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, '`process` = ', $process);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $planDateBegin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, '`planDateBegin` < ', QUOTE($planDateBegin));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ffID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ffID = ', $ffID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $id_scenario is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_scenario = ', $id_scenario);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $factor is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'factor = ', $factor);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $called is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'called = ', $called);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $targetCalls is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'targetCalls = ', $targetCalls);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $errorDescription is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'errorDescription = ', QUOTE($errorDescription));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF ($isActive = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $description is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'description = ', QUOTE($description));
      SET $sqlWhereCode = ' AND ';
    END IF;
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
  ELSE
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_autodial_process';
    --
    SET $sql = '
            SELECT
              HIID
              , id_autodial
              , `process`
              , ffID
              , id_scenario
              , emID
              , factor
              , called
              , targetCalls
              , planDateBegin
              , errorDescription
              , description
              , Created
              , Changed
            FROM ast_autodial_process ';
    --
    IF $id_autodial is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_autodial = ', $id_autodial);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $process is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, '`process` = ', $process);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $planDateBegin is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, '`planDateBegin` = ', QUOTE($planDateBegin));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ffID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ffID = ', $ffID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $id_scenario is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_scenario = ', $id_scenario);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $factor is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'factor = ', $factor);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $called is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'called = ', $called);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $targetCalls is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'targetCalls = ', $targetCalls);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $errorDescription is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'errorDescription = ', QUOTE($errorDescription));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF ($isActive = TRUE) THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $description is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'description = ', QUOTE($description));
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
    --
  END IF;
END $$
DELIMITER ;
--
