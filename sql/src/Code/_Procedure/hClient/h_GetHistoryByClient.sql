DELIMITER $$
DROP PROCEDURE IF EXISTS h_GetHistoryByClient;
CREATE PROCEDURE h_GetHistoryByClient(
    $token            VARCHAR(100)
    , $RowID          INT
    , $DateChangeFrom DATETIME
    , $DateChangeTo   DATETIME
    , $host           VARCHAR(128)
    , $AppName        VARCHAR(128)
    , $clID           INT
    , $clName         VARCHAR(200)
    , $IsPerson       BIT
    , $Sex            BIT
    , $ParentID       INT
    , $ffID           INT
    , $CompanyID      INT
    , $uID            BIGINT
    , $isActual       BIT
    , $ActualStatus   INT
    , $Position       INT
    , $responsibleID  INT
    , $CreatedBy      INT
    , $ChangedBy      INT
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
  DECLARE $sql            VARCHAR(10000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'h_GetHistoryByClient');
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
      SET $field_ = 'RowID';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    /*SET $sqlCount = '
  SELECT
     count(*) Qty
  FROM crmClient cl
    INNER JOIN crmStatus cs ON cs.clID = cl.clID
    LEFT OUTER JOIN crmClientEx ex ON ex.clID = cl.clID';*/
    SET $sqlCount = '
  SELECT
     count(*) Qty
  FROM DUP_crmClient cl ';
    --
    SET $sql = CONCAT('
        SELECT RowID
          , cl.DUP_InsTime                                                                                                                      DUP_InsTime
          , cl.DUP_action                                                                                                                       DUP_action
          , cl.DUP_HostName                                                                                                                     DUP_HostName
          , cl.DUP_AppName                                                                                                                      DUP_AppName
          , cl.HIID                                                                                                                             HIID
          , cl.clID                                                                                                                             clID
          , cl.clName                                                                                                                           clName
          , cl.IsPerson                                                                                                                         IsPerson
          , cl.Sex                                                                                                                              Sex
          , cl.`Comment`                                                                                                                        Comment
          , cl.ParentID                                                                                                                         ParentID
          , cl.ffID                                                                                                                             ffID
          , cl.CompanyID                                                                                                                        CompanyID
          , cl.uID                                                                                                                              uID
          , cl.isActual                                                                                                                         isActual
          , cl.ActualStatus                                                                                                                     ActualStatus
          , cl.`Position`                                                                                                                       Position
          , cl.responsibleID                                                                                                                    responsibleID
          , cl.CreatedBy                                                                                                                        CreatedBy
          , cl.ChangedBy                                                                                                                        ChangedBy
          , cl.IsActive                                                                                                                         isActive
          , cl.Created                                                                                                                          Created
          , cl.Changed                                                                                                                          Changed
          , cl.OLD_HIID                                                                                                                         OLD_HIID
          , IF(OLD_HIID IS NOT NULL, (SELECT clID FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                                OLD_clID
          , IF(OLD_HIID IS NOT NULL, (SELECT clName FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                              OLD_clName
          , IF(OLD_HIID IS NOT NULL, (SELECT IsPerson FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                            OLD_IsPerson
          , IF(OLD_HIID IS NOT NULL, (SELECT Sex FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                                 OLD_Sex
          , IF(OLD_HIID IS NOT NULL, (SELECT Comment FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                             OLD_Comment
          , IF(OLD_HIID IS NOT NULL, (SELECT ParentID FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                            OLD_ParentID
          , IF(OLD_HIID IS NOT NULL, (SELECT ffID FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                                OLD_ffID
          , IF(OLD_HIID IS NOT NULL, (SELECT CompanyID FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                           OLD_CompanyID
          , IF(OLD_HIID IS NOT NULL, (SELECT uID FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                                 OLD_uID
          , IF(OLD_HIID IS NOT NULL, (SELECT isActual FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                            OLD_isActual
          , IF(OLD_HIID IS NOT NULL, (SELECT ActualStatus FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                        OLD_ActualStatus
          , IF(OLD_HIID IS NOT NULL, (SELECT Position FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                            OLD_Position
          , IF(OLD_HIID IS NOT NULL, (SELECT responsibleID FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                       OLD_responsibleID
          , IF(OLD_HIID IS NOT NULL, (SELECT CreatedBy FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                           OLD_CreatedBy
          , IF(OLD_HIID IS NOT NULL, (SELECT ChangedBy FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                           OLD_ChangedBy
          , IF(OLD_HIID IS NOT NULL, (SELECT IsActive FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                            OLD_isActive
          , IF(OLD_HIID IS NOT NULL, (SELECT Created FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                             OLD_Created
          , IF(OLD_HIID IS NOT NULL, (SELECT Changed FROM DUP_crmClient WHERE HIID = cl.OLD_HIID LIMIT 1), NULL)                             OLD_Changed
        FROM DUP_crmClient cl
        ');
    --
    IF $RowID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'RowID = ', $RowID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateChangeFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'DUP_InsTime >= ', QUOTE($DateChangeFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateChangeTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'DUP_InsTime <= ', QUOTE($DateChangeTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $host is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'DUP_HostName = ', QUOTE($host));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $AppName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'DUP_AppName = ', QUOTE($AppName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'clName = ', QUOTE($clName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ParentID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ParentID = ', $ParentID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ffID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ffID = ', $ffID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $CompanyID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'CompanyID = ', $CompanyID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $uID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'uID = ', $uID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ActualStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ActualStatus = ', $ActualStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Position is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Position = ', $Position);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $responsibleID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'responsibleID = ', $responsibleID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $CreatedBy is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'CreatedBy = ', $CreatedBy);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ChangedBy is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ChangedBy = ', $ChangedBy);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsPerson is NOT NULL THEN
      IF $IsPerson = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsPerson = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsPerson = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Sex is NOT NULL THEN
      IF $Sex = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Sex = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Sex = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActual is NOT NULL THEN
      IF $isActual = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActual = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActual = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    /*SELECT @s;*/
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
