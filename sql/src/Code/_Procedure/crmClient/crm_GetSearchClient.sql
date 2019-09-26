DElIMITER $$
DROP PROCEDURE IF EXISTS crm_GetSearchClient;
CREATE PROCEDURE crm_GetSearchClient(
    $token          VARCHAR(100)
    , $clName       varchar(200)
    , $emID         int
    , $ccName       varchar(50)
    , $ccType       int
    , $isActive       INT
    , $sorting        VARCHAR(5)
    , $field          VARCHAR(50)
    , $offset         INT
    , $limit          INT
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetSearchClient');
  ELSE
    set $clName = NULLIF(TRIM($clName),'');
    set $ccName = NULLIF(TRIM($ccName),'');
    set $ccType = IFNULL($ccType,36);
    SET $offset = IFNULL($offset, 0);
    SET $limit = IFNULL($limit, 100);
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
      SET $field_ = 'clName';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = 'SELECT count(*) Qty FROM crmClient cl
      left outer join crmContact cc on cc.clID = cl.clID ';
    --
    set $sql = '
    select
      cl.clID      as clID
      , cl.clName    as clName
      , cl.IsPerson  as IsPerson
      , cl.IsActive  as isActive
      , cl.`Comment` as `Comment`
      , cl.Created   as Created
      , cl.CreatedBy as CreatedBy
      , cl.Changed   as Changed
      , cl.ChangedBy  as ChangedBy
      , GROUP_CONCAT(distinct cc.ccName order by cc.ccType asc separator '','') as Contacts
      , cl.responsibleID                                                        Responsibles
    from crmClient cl
      left outer join crmContact cc on cc.clID = cl.clID ';
    --
    IF $clName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'cl.clName like ', QUOTE(CONCAT($clName, '%')));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'cl.responsibleID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ccName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  '(cc.ccType = ', $ccType,' and cc.ccName like ', QUOTE($ccName),')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.IsActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.IsActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'GROUP BY cl.clID', CHAR(10), 'ORDER BY cl.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
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
