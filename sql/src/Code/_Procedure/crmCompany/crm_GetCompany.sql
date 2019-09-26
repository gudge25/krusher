DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetCompany;
CREATE PROCEDURE crm_GetCompany(
    $token                VARCHAR(100)
    , $coID               INT(11)
    , $coName             VARCHAR(100)
    , $coDescription      VARCHAR(100)
    , $pauseDelay         INT(11)
    , $isActivePOPup      BIT
    , $isRingingPOPup     BIT
    , $isUpPOPup          BIT
    , $isCCPOPup          BIT
    , $isClosePOPup       BIT
    , $isActive           BIT
    , $sorting            VARCHAR(5)
    , $field              VARCHAR(50)
    , $offset             INT(11)
    , $limit              INT(11)
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
    call RAISE(77068, 'crm_GetCompany');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM crmCompany';
    --
    SET $sql = '
            SELECT
              HIID
              , coID
              , coName
              , coDescription
              , inMessage
              , outMessage
              , pauseDelay
              , isActivePOPup
              , isRingingPOPup
              , isUpPOPup
              , isCCPOPup
              , isClosePOPup
              , isActive
              , Created
              , Changed
            FROM crmCompany ';
    --
    IF $coID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coID = ', $coID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $coName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coName = ', QUOTE($coName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $coDescription is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coDescription = ', QUOTE($coDescription));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $pauseDelay is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pauseDelay = ', QUOTE($pauseDelay));
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
    IF $isActivePOPup is NOT NULL THEN
      IF $isActivePOPup = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActivePOPup = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActivePOPup = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isRingingPOPup is NOT NULL THEN
      IF $isRingingPOPup = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isRingingPOPup = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isRingingPOPup = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isUpPOPup is NOT NULL THEN
      IF $isUpPOPup = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isUpPOPup = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isUpPOPup = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isCCPOPup is NOT NULL THEN
      IF $isCCPOPup = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isCCPOPup = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isCCPOPup = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isClosePOPup is NOT NULL THEN
      IF $isClosePOPup = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isClosePOPup = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isClosePOPup = 0');
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
