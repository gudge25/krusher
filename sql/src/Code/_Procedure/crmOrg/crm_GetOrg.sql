DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetOrg;
CREATE PROCEDURE crm_GetOrg(
    $token          VARCHAR(100)
    , $clID         INT
    , $Account      BIGINT
    , $Bank         VARCHAR(100)
    , $TaxCode      VARCHAR(14)
    , $SortCode     INT
    , $RegCode      INT
    , $CertNumber   INT
    , $OrgType      INT
    , $ShortName    VARCHAR(50)
    , $KVED         VARCHAR(7)
    , $KVEDName     VARCHAR(250)
    , $headPost     VARCHAR(50)
    , $headFIO      VARCHAR(100)
    , $headFam      VARCHAR(50)
    , $headIO       VARCHAR(100)
    , $headSex      VARCHAR(10)
    , $orgNote      VARCHAR(100)
    , $isActive     BIT
    , $sorting      VARCHAR(5)
    , $field        VARCHAR(50)
    , $offset       INT
    , $limit        INT
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
    call RAISE(77068, 'crm_GetOrg');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM crmOrg';
    --
    SET $sql = '
            SELECT
              HIID
              , clID
              , Account
              , Bank
              , TaxCode
              , SortCode
              , RegCode
              , CertNumber
              , OrgType
              , ShortName
              , KVED
              , KVEDName
              , headPost
              , headFIO
              , headFam
              , headIO
              , headSex
              , orgNote
              , CreatedBy
              , ChangedBy
              , isActive
              , Created
              , Changed
            FROM crmOrg ';
    --
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Account is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Account = ', $Account);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Bank is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Bank = ', QUOTE($Bank));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $TaxCode is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'TaxCode = ', QUOTE($TaxCode));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $SortCode is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'SortCode = ', $SortCode);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $RegCode is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'RegCode = ', $RegCode);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $CertNumber is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'CertNumber = ', $CertNumber);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $OrgType is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'OrgType = ', $OrgType);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ShortName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'ShortName = ', QUOTE($ShortName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $KVED is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'KVED = ', QUOTE($KVED));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $KVEDName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'KVEDName = ', QUOTE($KVEDName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $headPost is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'headPost = ', QUOTE($headPost));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $headFIO is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'headFIO = ', QUOTE($headFIO));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $headFam is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'headFam = ', QUOTE($headFam));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $headIO is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'headIO = ', QUOTE($headIO));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $headSex is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'headSex = ', QUOTE($headSex));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $orgNote is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'orgNote = ', QUOTE($orgNote));
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
