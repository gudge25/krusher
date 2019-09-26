DROP PROCEDURE IF EXISTS fm_GetForm;
DELIMITER $$
CREATE PROCEDURE fm_GetForm(
    $token            VARCHAR(100)
    , $dcID           int           -- ID документа
    , $dcNo           varchar(35)   -- Номер документа
    , $dcDate         date          -- дата документа
    , $dcLink         int           -- ID документа основания
    , $dcComment      varchar(200)  -- комментарий
    , $dcStatus       int           -- статус документа
    , $clID           int           -- ID клиента
    , $emID           int           -- ID владельца
    , $isActive       BIT
    , $tpID           INT
    , $sorting        VARCHAR(5)
    , $field          VARCHAR(50)
    , $offset         INT(11)
    , $limit          INT(11)
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
    call RAISE(77068, 'fm_GetForm');
  ELSE
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
    SET $sqlCount = 'SELECT count(*) Qty FROM dcDoc d
                  INNER JOIN fmForm f ON f.dcID = d.dcID
                  INNER JOIN emEmploy em ON em.emID = d.emID
                  INNER JOIN crmClient cl ON d.clID = cl.clID
                  INNER JOIN emEmploy c ON d.CreatedBy = c.emID
                  LEFT OUTER JOIN emEmploy e ON d.ChangedBy = e.emID ';
    --
    SET $sql = 'SELECT
                  f.HIID                        HIID
                  , d.dcID                      dcID
                  , d.dcNo                      dcNo
                  , d.dcDate                    dcDate
                  , d.dcLink                    dcLink
                  , d.dcComment                 dcComment
                  , d.dcStatus                  dcStatus
                  , d.clID                      clID
                  , cl.clName                   clName
                  , d.emID                      emID
                  , em.emName                   emName
                  , d.Created                   Created
                  , d.CreatedBy                 CreatedBy
                  , c.emName                    CreatedName
                  , d.Changed                   Changed
                  , d.ChangedBy                 ChangedBy
                  , e.emName                    EditedName
                  , CONVERT(d.uID,CHAR(20))     uID
                  , f.tpID                      tpID
                FROM dcDoc d
                  INNER JOIN fmForm f ON f.dcID = d.dcID
                  INNER JOIN emEmploy em ON em.emID = d.emID
                  INNER JOIN crmClient cl ON d.clID = cl.clID
                  INNER JOIN emEmploy c ON d.CreatedBy = c.emID
                  LEFT OUTER JOIN emEmploy e ON d.ChangedBy = e.emID ';
    --
    IF $dcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcID = ', $dcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcNo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcNo = ', QUOTE($dcNo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcDate is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcDate = ', QUOTE($dcDate));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcLink is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcLink = ', $dcLink);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcComment is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcComment = ', QUOTE($dcComment));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.dcStatus = ', $dcStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $tpID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'f.tpID = ', $tpID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'f.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'f.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'f.Aid = ', $Aid, ' AND d.dctID = 4');
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY f.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
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
