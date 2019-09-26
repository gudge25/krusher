DELIMITER $$
DROP PROCEDURE IF EXISTS mp_GetIntegrationList;
CREATE PROCEDURE mp_GetIntegrationList(
    $token                          VARCHAR(100)
    , $mpID                         INT(11)
    , $mpName                       VARCHAR(50)
    , $mpDescription                VARCHAR(500)
    , $mpLinkProvider               VARCHAR(100)
    , $mpCategory                   INT(11)
    , $mpLogo                       VARCHAR(250)
    , $mpPrice                      DECIMAL(10,2)
    , $order                        INT(11)
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
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'mp_GetIntegrationList');
  ELSEIF ($Aid > 0) THEN
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 100);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    --
    IF($sorting IS NULL) THEN
      SET $sorting_ = 'ASC';
    ELSE
      SET $sorting_ = $sorting;
    END IF;
    IF($field IS NULL) THEN
      SET $field_ = 'order';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM mp_IntegrationList s ';
    --
    SET $sql = 'SELECT
                    HIID
                    , mpID
                    , mpName
                    , mpDescription
                    , mpLinkProvider
                    , mpCategory
                    , mpLogo
                    , mpPrice
                    , countInstalls
                    , `order`
                    , isActive
                    , Created
                    , Changed
                FROM mp_IntegrationList s ';
    --
    IF $mpID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpID = ', $mpID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpName = ', QUOTE($mpName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpDescription is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpDescription = ', QUOTE($mpDescription));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpLinkProvider is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpLinkProvider = ', QUOTE($mpLinkProvider));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpCategory is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpCategory = ', QUOTE($mpCategory));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpLogo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpLogo = ', QUOTE($mpLogo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpPrice is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpPrice = ', QUOTE($mpPrice));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $order is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.`order` = ', QUOTE($order));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.Aid IN (0, ', $Aid, ')');
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY s.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
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
