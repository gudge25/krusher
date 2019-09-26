DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetTrunkClear;
CREATE PROCEDURE ast_GetTrunkClear(
    $Aid                  INT(11)
    , $trID               INT(11)
    , $trName             VARCHAR(50)
    , $template           VARCHAR(50)
    , $secret             VARCHAR(50)
    , $context            VARCHAR(50)
    , $callgroup          INT(4) UNSIGNED
    , $pickupgroup        INT(4) UNSIGNED
    , $callerid           VARCHAR(80)
    , $host               VARCHAR(80)
    , $nat                INT
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
  --
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetTrunkClear');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 10000);
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
              t.HIID
              , t.Aid
              , t.trID
              , t.trName
              , t.template
              , t.secret
              , t.context
              , t.callgroup
              , t.pickupgroup
              , t.callerid
              , t.host
              , IF(nat IS NULL, "NULL", (SELECT Name FROM usEnumValue WHERE tvID=t.nat AND Aid = t.Aid)) nat
              , t.fromuser
              , t.defaultuser
              , t.fromdomain
              , t.callbackextension
              , t.port
              , t.isServer
              , IF(t.`type` IS NULL, "NULL", (SELECT Name FROM usEnumValue WHERE tvID=t.`type` AND Aid = t.Aid)) type
              , IF(t.`directmedia` IS NULL, "NULL", (SELECT Name FROM usEnumValue WHERE tvID=t.`directmedia` AND Aid = t.Aid)) directmedia
              , IF(t.`insecure` IS NULL, "NULL", (SELECT Name FROM usEnumValue WHERE tvID=t.`insecure` AND Aid = t.Aid)) insecure
              , t.outboundproxy
              , t.acl
              , t.dtmfmode
              , IF(t.dtmfmode IS NOT NULL AND t.dtmfmode>0, (SELECT `Name` FROM usEnumValue WHERE tvID = t.`dtmfmode` AND Aid = t.Aid), NULL) dtmfmodeName
              , t.uniqName
              , t.lines
              , t.DIDs
              , t.ManageID
              , t.coID
              , IF(t.coID IS NULL, "NULL", (SELECT coName FROM crmCompany WHERE coID = t.coID AND Aid = t.Aid)) coName
              , IF(t.coID IS NULL, "NULL", (SELECT coDescription FROM crmCompany WHERE coID=t.coID AND Aid = t.Aid)) coDescription
              , t.transport
              , t.encryption
              , t.avpf
              , t.force_avp
              , t.icesupport
              , t.videosupport
              , t.allow
              , t.dtlsenable
              , t.dtlsverify
              , t.dtlscertfile
              , t.dtlscafile
              , t.dtlssetup
              , t.Created
              , t.Changed
            FROM ast_trunk t ';
    --
    IF $trID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.trID = ', $trID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $trName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.trName = ', QUOTE($trName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $template is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.template = ', QUOTE($template));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $secret is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.secret = ', QUOTE($secret));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $context is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.context = ', QUOTE($context));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callgroup is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.callgroup = ', $callgroup);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 't.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 't.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isServer is NOT NULL THEN
      IF $isServer = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 't.isServer = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 't.isServer = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $pickupgroup is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.pickupgroup = ', $pickupgroup);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callerid is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.callerid = ', QUOTE($callerid));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $host is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.host = ', QUOTE($host));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $nat is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.nat = ', $nat);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $fromuser is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.fromuser = ', QUOTE($fromuser));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $fromdomain is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.fromdomain = ', QUOTE($fromdomain));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $callbackextension is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.callbackextension = ', QUOTE($callbackextension));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $outboundproxy is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.outboundproxy = ', QUOTE($outboundproxy));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $acl is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.acl = ', QUOTE($acl));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $port is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.port = ', $port);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $type is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.`type` = ', $type);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $directmedia is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.directmedia = ', $directmedia);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $insecure is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.insecure = ', $insecure);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dtmfmode is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.dtmfmode = ', $dtmfmode);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Aid is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.Aid = ', $Aid);
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, ' t.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY t.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
