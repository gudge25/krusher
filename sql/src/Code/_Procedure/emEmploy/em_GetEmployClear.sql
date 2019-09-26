DELIMITER $$
DROP PROCEDURE IF EXISTS em_GetEmployClear;
CREATE PROCEDURE em_GetEmployClear(
  $Aid                    INT(11)
  , $emID                 INT(11)
  , $emName               VARCHAR(200)
  , $LoginName            VARCHAR(30)
  , $ManageID             INT(11)
  , $roleID               INT(11)
  , $sipName              VARCHAR(50)
  , $Queue                VARCHAR(128)
  , $sipID                INT(11)
  , $IsActive             BIT
  , $sorting              VARCHAR(5)
  , $field                VARCHAR(50)
  , $offset               INT(11)
  , $limit                INT(11)
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
  SET $sqlCount = 'SELECT count(*) Qty FROM emEmploy e';
  --
  SET $sql = CONCAT('
          SELECT
            e.HIID
            , e.Aid
            , e.emID
            , e.emName
            , e.LoginName
            , e.Token
            , e.TokenExpiredDate
            , e.ManageID
            , e.roleID
            , e.sipID
            , e.sipName
            , e.Queue
            , e.IsActive  isActive
            , e.Created
            , e.Changed
          FROM emEmploy e ');
  --
  IF $emID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.emID = ', $emID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $emName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.emName = ', QUOTE($emName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $LoginName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.LoginName = ', QUOTE($LoginName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $ManageID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.ManageID = ', $ManageID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $roleID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.roleID = ', $roleID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $sipName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.sipName = ', QUOTE($sipName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Queue is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.Queue = ', QUOTE($Queue));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $sipID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.sipID = ', $sipID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Aid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.Aid = ', $Aid);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $isActive is NOT NULL THEN
    IF $isActive = TRUE THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.IsActive = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'e.IsActive = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  --
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, 'e.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY e.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  --
  SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  --
END $$
DELIMITER ;
--
