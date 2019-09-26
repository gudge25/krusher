DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetSippeersClear;
CREATE PROCEDURE ast_GetSippeersClear(
    $sipID              INT(11)
    , $sipName          VARCHAR(50)
    , $template         VARCHAR(50)
    , $secret           VARCHAR(50)
    , $context          VARCHAR(50)
    , $callgroup        INT(11)
    , $pickupgroup      INT(11)
    , $callerid         VARCHAR(80)
    , $nat              INT(11)
    , $dtmfmode         INT(11)
    , $emID             INT(11)
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
  SET $sqlCount = 'SELECT count(*) Qty FROM ast_sippeers';
  --
  SET $sql = '
          SELECT
            HIID
            , sipID
            , Aid
            , sipName
            , template
            , context
            , callgroup
            , pickupgroup
            , callerid
            , nat
            , `lines`
            , dtmfmode
            , RowVersion
            , emID
            , transport
            , encryption
            , avpf
            , force_avp
            , icesupport
            , videosupport
            , allow
            , dtlsenable
            , dtlsverify
            , dtlscertfile
            , dtlscafile
            , dtlssetup
            , isPrimary
            , `sipType`
            , isActive
            , Created
            , Changed
          FROM ast_sippeers ';
  --
  IF $sipID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'sipID = ', $sipID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $sipName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'sipName = ', QUOTE($sipName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $template is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'template = ', QUOTE($template));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $secret is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'secret = ', QUOTE($secret));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $context is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'context = ', QUOTE($context));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $callgroup is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'callgroup = ', QUOTE($callgroup));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $IsActive is NOT NULL THEN
    IF $IsActive = TRUE THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $pickupgroup is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pickupgroup = ', $pickupgroup);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $nat is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'nat = ', $nat);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $dtmfmode is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtmfmode = ', $dtmfmode);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $callerid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'callerid = ', QUOTE($callerid));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $emID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'emID = ', $emID);
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
END $$
DELIMITER ;
--
