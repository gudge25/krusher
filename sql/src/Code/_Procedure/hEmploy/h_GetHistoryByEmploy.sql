DELIMITER $$
DROP PROCEDURE IF EXISTS h_GetHistoryByEmploy;
CREATE PROCEDURE h_GetHistoryByEmploy(
    $token            VARCHAR(100)
    , $RowID          INT
    , $emID           INT
    , $emName         VARCHAR(200)
    , $LoginName      VARCHAR(200)
    , $url            VARCHAR(200)
    , $ManageID       INT
    , $roleID         INT
    , $sipID          INT
    , $sipName        VARCHAR(200)
    , $Queue          VARCHAR(200)
    , $CompanyID      INT
    , $isActive       INT
    , $DateChangeFrom DATETIME
    , $DateChangeTo   DATETIME
    , $host           VARCHAR(128)
    , $AppName        VARCHAR(128)
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
    call RAISE(77068, 'h_GetHistoryByEmploy');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM DUP_emEmploy cl ';
    --
    SET $sql = CONCAT('
        SELECT RowID
          , em.DUP_InsTime                                                                                                                      DUP_InsTime
          , em.DUP_action                                                                                                                       DUP_action
          , em.DUP_HostName                                                                                                                     DUP_HostName
          , em.DUP_AppName                                                                                                                      DUP_AppName
          , em.HIID                                                                                                                             HIID
          , em.emID                                                                                                                             emID
          , em.emName                                                                                                                           emName
          , em.LoginName                                                                                                                        LoginName
          , em.url                                                                                                                              url
          , em.ManageID                                                                                                                         ManageID
          , em.roleID                                                                                                                           roleID
          , em.sipID                                                                                                                            sipID
          , em.sipName                                                                                                                          sipName
          , em.Queue                                                                                                                            Queue
          , em.CompanyID                                                                                                                        CompanyID
          , em.onlineStatus                                                                                                                     onlineStatus
          , em.isActive                                                                                                                         isActive
          , em.Created                                                                                                                          Created
          , em.Changed                                                                                                                          Changed
          , em.OLD_HIID                                                                                                                         OLD_HIID
          , IF(OLD_HIID IS NOT NULL, (SELECT emID FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                    OLD_emID
          , IF(OLD_HIID IS NOT NULL, (SELECT emName FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                  OLD_emName
          , IF(OLD_HIID IS NOT NULL, (SELECT LoginName FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                               OLD_LoginName
          , IF(OLD_HIID IS NOT NULL, (SELECT ManageID FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                OLD_ManageID
          , IF(OLD_HIID IS NOT NULL, (SELECT roleID FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                  OLD_roleID
          , IF(OLD_HIID IS NOT NULL, (SELECT sipID FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                   OLD_sipID
          , IF(OLD_HIID IS NOT NULL, (SELECT sipName FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                 OLD_sipName
          , IF(OLD_HIID IS NOT NULL, (SELECT Queue FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                   OLD_Queue
          , IF(OLD_HIID IS NOT NULL, (SELECT CompanyID FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                               OLD_CompanyID
          , IF(OLD_HIID IS NOT NULL, (SELECT onlineStatus FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                            OLD_onlineStatus
          , IF(OLD_HIID IS NOT NULL, (SELECT isActive FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                OLD_isActive
          , IF(OLD_HIID IS NOT NULL, (SELECT Created FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                 OLD_Created
          , IF(OLD_HIID IS NOT NULL, (SELECT Changed FROM DUP_emEmploy WHERE HIID = em.OLD_HIID LIMIT 1), NULL)                                 OLD_Changed
        FROM DUP_emEmploy em
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
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'emName = ', QUOTE($emName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $LoginName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'LoginName = ', QUOTE($LoginName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $url is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'url = ', QUOTE($url));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ManageID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ManageID = ', $ManageID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $roleID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'roleID = ', $roleID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $sipID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'sipID = ', $sipID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $sipName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'sipName = ', QUOTE($sipName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Queue is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Queue = ', QUOTE($Queue));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $CompanyID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'CompanyID = ', $CompanyID);
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
