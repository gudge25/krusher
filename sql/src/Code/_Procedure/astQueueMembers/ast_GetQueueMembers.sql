DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetQueueMembers;
CREATE PROCEDURE ast_GetQueueMembers(
  $token            VARCHAR(100)
  , $quemID         INT(11)
  , $emID           INT(11)
  , $queID          INT(11)
  , $membername     VARCHAR(40)
  , $queue_name     VARCHAR(128)
  , $interface      VARCHAR(128)
  , $penalty        INT(11)
  , $paused         INT(11)
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
    call RAISE(77068, 'ast_GetQueueMembers');
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
      SET $field_ = 'membername';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_queue_members';
    --
    SET $sql = '
            SELECT
              HIID
              , quemID
              , emID
              , queID
              , membername
              , queue_name
              , interface
              , penalty
              , paused
              , isActive
              , Created
              , Changed
            FROM ast_queue_members ';
    --
    IF $quemID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'quemID = ', $quemID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $queID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queID = ', $queID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $membername is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'membername = ', QUOTE($membername));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $queue_name is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_name = ', QUOTE($queue_name));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $interface is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'interface = ', QUOTE($interface));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $penalty is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'penalty = ', $penalty);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $paused is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'paused = ', $paused);
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
    set @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
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
