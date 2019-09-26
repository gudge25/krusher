DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetRouteIncomingClear;
CREATE PROCEDURE ast_GetRouteIncomingClear(
    $Aid            INT(11)
    , $rtID         INT(11)
    , $trID         INT(11)
    , $DID          VARCHAR(50)
    , $callerID     VARCHAR(50)
    , $exten        VARCHAR(500)
    , $context      VARCHAR(100)
    , $destination  INT(11)
    , $destdata     INT(11)
    , $destdata2    VARCHAR(100)
    , $isActive     BIT
    , $sorting      VARCHAR(5)
    , $field        VARCHAR(50)
    , $offset       INT(11)
    , $limit        INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);  
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
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
              Aid
              , rtID
              , trID
              , DID
              , callerID
              , exten
              , context
              , destination
              , destdata
              , destdata2
              , stick_destination
              , isCallback
              , isFirstClient
              , isActive
              , Created
              , Changed
          FROM ast_route_incoming ';
  --
  IF $rtID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhereCode, 'rtID = ', $rtID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $trID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'trID = ', $trID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $callerID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'callerID = ', QUOTE($callerID));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $DID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'DID = ', QUOTE($DID));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $exten is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'exten = ', QUOTE($exten));
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
  IF $context is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'context = ', QUOTE($context));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $destination is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'destination = ', $destination);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $destdata is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'destdata = ', $destdata);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $destdata2 is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'destdata2 = ', QUOTE($destdata2));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Aid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    SET $sqlWhereCode = ' AND ';
  END IF;
  --
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, 'Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
--
