DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetTrunk;
CREATE PROCEDURE ast_GetTrunk(
    $token                VARCHAR(100)
    , $trID               INT(11)
    , $trName             VARCHAR(50)
    , $template           VARCHAR(50)
    , $secret             VARCHAR(50)
    , $context            VARCHAR(50)
    , $callgroup          INT(4) UNSIGNED
    , $pickupgroup        INT(4) UNSIGNED
    , $callerid           VARCHAR(80)
    , $host               VARCHAR(80)
    , $nat                INT(11)
    , $defaultuser        VARCHAR(40)
    , $fromuser           VARCHAR(40)
    , $fromdomain         VARCHAR(40)
    , $callbackextension  VARCHAR(40)
    , $port               INT
    , $isServer           BIT
    , $type               INT
    , $directmedia        INT
    , $insecure           INT
    , $outboundproxy      VARCHAR(60)
    , $acl                VARCHAR(60)
    , $dtmfmode           INT(11)
    , $lines              INT(11)
    , $DIDs               VARCHAR(250)
    , $ManageID           INT(11)
    , $coID               INT(11)
    , $transport          VARCHAR(50)
    , $encryption         BIT
    , $avpf               BIT
    , $force_avp          BIT
    , $icesupport         BIT
    , $videosupport       BIT
    , $allow              VARCHAR(50)
    , $dtlsenable         BIT
    , $dtlsverify         BIT
    , $dtlscertfile       VARCHAR(100)
    , $dtlscafile         VARCHAR(100)
    , $dtlssetup          VARCHAR(100)
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
    call RAISE(77068, 'ast_GetTrunk');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM ast_trunk';
    --
    SET $sql = '
            SELECT
              HIID
              , trID
              , trName
              , template
              , context
              , callgroup
              , pickupgroup
              , callerid
              , host
              , nat
              , defaultuser
              , fromuser
              , fromdomain
              , callbackextension
              , port
              , isServer
              , `type`
              , directmedia
              , insecure
              , outboundproxy
              , acl
              , dtmfmode
              , DIDs
              , `lines`
              , ManageID
              , coID
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
              , isActive
              , Created
              , Changed
            FROM ast_trunk ';
    --
    IF $trID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'trID = ', $trID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $trName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'trName = ', QUOTE($trName));
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
    IF $ManageID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'ManageID = ', $ManageID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callgroup is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'callgroup = ', $callgroup);
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
    IF $isServer is NOT NULL THEN
      IF $isServer = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isServer = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isServer = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $pickupgroup is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'pickupgroup = ', $pickupgroup);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callerid is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'callerid = ', QUOTE($callerid));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $host is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'host = ', QUOTE($host));
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
    IF $fromuser is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'fromuser = ', QUOTE($fromuser));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DIDs is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'DIDs LIKE ', QUOTE(CONCAT('%', $DIDs, '%')));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $defaultuser is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'defaultuser = ', QUOTE($defaultuser));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $fromdomain is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'fromdomain = ', QUOTE($fromdomain));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callbackextension is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'callbackextension = ', QUOTE($callbackextension));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $outboundproxy is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'outboundproxy = ', QUOTE($outboundproxy));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $acl is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'acl = ', QUOTE($acl));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $port is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'port = ', $port);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $type is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  '`type` = ', $type);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $directmedia is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'directmedia = ', $directmedia);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $insecure is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'insecure = ', $insecure);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $lines is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'lines = ', $lines);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $coID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'coID = ', $coID);
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
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY `', $field_, '` ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
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
