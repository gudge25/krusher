DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetSippeers;
CREATE PROCEDURE ast_GetSippeers(
    $token              VARCHAR(100)
    , $sipID            INT(11)
    , $sipName          VARCHAR(50)
    , $template         VARCHAR(50)
    , $secret           VARCHAR(50)
    , $context          VARCHAR(50)
    , $callgroup        INT(11)
    , $pickupgroup      INT(11)
    , $callerid         VARCHAR(80)
    , $nat              INT(11)
    , $lines            INT(11)
    , $dtmfmode         INT(11)
    , $emID             INT(11)
    , $transport        VARCHAR(50)
    , $encryption       BIT
    , $avpf             BIT
    , $force_avp        BIT
    , $icesupport       BIT
    , $videosupport     BIT
    , $allow            VARCHAR(50)
    , $dtlsenable       BIT
    , $dtlsverify       BIT
    , $dtlscertfile     VARCHAR(100)
    , $dtlscafile       VARCHAR(100)
    , $dtlssetup        VARCHAR(100)
    , $isPrimary        BIT
    , $sipType          INT(11)
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
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetSippeers');
  ELSEIF($Aid = 0) THEN
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
    SET $sql = 'SELECT
                  HIID
                  , Aid
                  , sipID
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
                  , CONCAT(sipName, "_", Aid) sipLogin
                  , IF(LENGTH(secret)>=12, CONCAT(SUBSTR(secret, 1, 3), "***", SUBSTR(secret, LENGTH(secret)-2, 3)), CONCAT(SUBSTR(secret, 1, 3), "***")) sipPass
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
    IF $lines is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  '`lines` = ', $lines);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $sipType is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  '`sipType` = ', $sipType);
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
    IF $transport is NOT NULL AND LENGTH(TRIM($transport))>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'transport IN (', QUOTE($transport),')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $encryption is NOT NULL THEN
      IF $encryption = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'encryption = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'encryption = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $avpf is NOT NULL THEN
      IF $avpf = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'avpf = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'avpf = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $force_avp is NOT NULL THEN
      IF $force_avp = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'force_avp = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'force_avp = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $icesupport is NOT NULL THEN
      IF $icesupport = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'icesupport = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'icesupport = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $videosupport is NOT NULL THEN
      IF $videosupport = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'videosupport = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'videosupport = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $allow is NOT NULL AND LENGTH(TRIM($allow))>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'allow IN (', QUOTE($allow),')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlsenable is NOT NULL THEN
      IF $dtlsenable = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsenable = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsenable = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlsverify is NOT NULL THEN
      IF $dtlsverify = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsverify = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsverify = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isPrimary is NOT NULL THEN
      IF $isPrimary = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isPrimary = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isPrimary = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlscertfile is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtlscertfile =', QUOTE($dtlscertfile));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlscafile is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtlscafile =', QUOTE($dtlscafile));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlssetup is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtlssetup =', QUOTE($dtlssetup));
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
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_sippeers';
    --
    SET $sql = 'SELECT
                  HIID
                  , sipID
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
                  , CONCAT(sipName, "_", Aid) sipLogin
                  , IF(LENGTH(secret)>=12, CONCAT(SUBSTR(secret, 1, 3), "***", SUBSTR(secret, LENGTH(secret)-2, 3)), CONCAT(SUBSTR(secret, 1, 3), "***")) sipPass
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
    IF $lines is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  '`lines` = ', $lines);
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
    IF $transport is NOT NULL AND LENGTH(TRIM($transport))>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'transport IN (', QUOTE($transport),')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isPrimary is NOT NULL THEN
      IF $isPrimary = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isPrimary = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isPrimary = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $sipType is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  '`sipType` = ', $sipType);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $encryption is NOT NULL THEN
      IF $encryption = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'encryption = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'encryption = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $avpf is NOT NULL THEN
      IF $avpf = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'avpf = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'avpf = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $force_avp is NOT NULL THEN
      IF $force_avp = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'force_avp = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'force_avp = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $icesupport is NOT NULL THEN
      IF $icesupport = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'icesupport = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'icesupport = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $videosupport is NOT NULL THEN
      IF $videosupport = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'videosupport = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'videosupport = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $allow is NOT NULL AND LENGTH(TRIM($allow))>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'allow IN (', QUOTE($allow),')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlsenable is NOT NULL THEN
      IF $dtlsenable = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsenable = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsenable = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlsverify is NOT NULL THEN
      IF $dtlsverify = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsverify = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'dtlsverify = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlscertfile is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtlscertfile = ', QUOTE($dtlscertfile));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlscafile is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtlscafile = ', QUOTE($dtlscafile));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtlssetup is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'dtlssetup = ', QUOTE($dtlssetup));
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
