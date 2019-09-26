DELIMITER $$
DROP PROCEDURE IF EXISTS mp_GetIntegrationInstall;
CREATE PROCEDURE mp_GetIntegrationInstall(
    $token                          VARCHAR(100)
    , $mpiID                        INT(11)
    , $mpID                         INT(11)
    , $login                        VARCHAR(50)
    , $pass                         VARCHAR(50)
    , $tokenAccess                  VARCHAR(50)
    , $link                         VARCHAR(50)
    , $data1                        VARCHAR(250)
    , $data2                        VARCHAR(250)
    , $data3                        VARCHAR(250)
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
    call RAISE(77068, 'mp_GetIntegrationInstall');
  ELSEIF ($Aid > 0) THEN
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
    SET $sqlCount = 'SELECT count(*) Qty FROM mp_IntegrationInstall s ';
    --
    SET $sql = 'SELECT
                    HIID
                    , mpiID
                    , mpID
                    , login
                    , token tokenAccess
                    , link
                    , data1
                    , data2
                    , data3
                    , isActive
                    , Created
                    , Changed
                FROM mp_IntegrationInstall s ';
    --
    IF $mpID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpID = ', $mpID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $mpiID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mpiID = ', $mpiID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $login is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.login = ', QUOTE($login));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $tokenAccess is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.token = ', QUOTE($tokenAccess));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $link is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.link = ', QUOTE($link));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $data1 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.data1 = ', QUOTE($data1));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $data2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.data2 = ', QUOTE($data2));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $data3 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.data3 = ', QUOTE($data3));
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
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.Aid IN (', $Aid, ')');
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
