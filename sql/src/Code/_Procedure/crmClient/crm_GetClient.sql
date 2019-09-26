DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetClient;
CREATE PROCEDURE crm_GetClient(
    $token            VARCHAR(100)
    , $clID           INT
    , $clName         VARCHAR(200)
    , $IsPerson       BIT
    , $ffID           INT
    , $CompanyID      VARCHAR(20000)
    , $emID           INT
    , $tagID          INT
    , $ccStatus       INT
    , $clStatus       INT
    , $CallDate       DATETIME
    , $CallDateTo     DATETIME
    , $cID            INT
    , $dctID          INT
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
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetClient');
  ELSE
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
      SET $field_ = 'clName';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    SET $sqlCount = '
  SELECT
     count(*) Qty
  FROM crmClient cl
    INNER JOIN crmStatus cs ON cs.clID = cl.clID
    LEFT OUTER JOIN crmClientEx ex ON ex.clID = cl.clID';
    --
    SET $sql = CONCAT('
  SELECT
    cl.HIID                             HIID
    , cl.clID                           clID
    , cl.clName                         clName
    , cl.IsPerson                       IsPerson
    , cl.Sex                            Sex
    , cl.IsActive                       isActive
    , cl.Comment                        Comment
    , cl.Created                        Created
    , cl.CreatedBy                      CreatedBy
    , cl.Changed                        Changed
    , cl.ChangedBy                      ChangedBy
    , cl.responsibleID                  emID
    , IF(cl.responsibleID IS NULL, NULL, (SELECT emName FROM emEmploy WHERE Aid=', $Aid,' AND emID = cl.responsibleID LIMIT 1))                         emName
    , ex.cusID                          cusID
    , cs.clStatus                       clStatus
    , cs.ccStatus                       ccStatus
    , cs.isFixed                        isFixed
    , cl.ffID                           ffID
    , cl.ParentID                       ParentID
    , CONVERT(cl.uID,CHAR(20))          uID
    #, CONVERT(ex.CallDate,char(10))    CallDate
    , ex.CallDate                       CallDate
    , (SELECT crm_IPGetContact(cl.clID, 36))    Phone
    , (SELECT crm_IPGetContact(cl.clID, 37))    Email
    , (
       SELECT
        COUNT(d.dcID)
        FROM dcDoc d
        WHERE d.clID = cl.clID AND d.Aid = ', $Aid,'
          AND d.dctID = 1
     )                                 ccQty
    , cl.CompanyID                     CompanyID
    , cl.ActualStatus                  ActualStatus
    , ex.isNotice                      isNotice
    , cl.Position                      Position
    , ex.curID
    , ex.langID
    , ex.`sum`
    , ex.ttsText
    , ex.isDial
  FROM crmClient cl
    INNER JOIN crmStatus cs ON cs.clID = cl.clID
    LEFT OUTER JOIN crmClientEx ex ON ex.clID = cl.clID');
    --
    IF $ffID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.ffID = ', $ffID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cs.clStatus = ', $clStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $CompanyID is NOT NULL AND LENGTH($CompanyID)>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.CompanyID IN (', $CompanyID, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ccStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cs.ccStatus = ', $ccStatus);
      IF $ccStatus = 206 THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cs.clStatus = 101');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.responsibleID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $cID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.clID IN (SELECT clID FROM crmContact WHERE id_country = ', $cID, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dctID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'EXISTS (SELECT 1 FROM dcDoc WHERE clID = cl.clID AND dctID = ', $dctID, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF(($CallDate is NOT NULL ) AND ($CallDateTo is NOT NULL )) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'EXISTS (SELECT 1 FROM crmClientEx e WHERE e.clID = cl.clID AND CallDate BETWEEN ', QUOTE($CallDate), ' AND ', QUOTE($CallDateTo), ')');
      SET $sqlWhereCode = ' AND ';
    ELSE
      IF $CallDate is NOT NULL THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'EXISTS (SELECT 1 FROM crmClientEx e WHERE e.clID = cl.clID AND DATEDIFF(CallDate, ', QUOTE($CallDate), ') = 0)');
        SET $sqlWhereCode = ' AND ';
      END IF;
    END IF;
    IF $tagID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'EXISTS (SELECT 1 FROM crmTagList WHERE clID = cl.clID AND tagID = ', $tagID, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.clName LIKE ', QUOTE($clName));
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
    IF $IsPerson is NOT NULL THEN
      IF $IsPerson = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.IsPerson = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.IsPerson = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'cl.Aid = ', $Aid);
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
