DELIMITER $$
DROP PROCEDURE IF EXISTS dc_GetDoc;
CREATE PROCEDURE dc_GetDoc(
    $token          VARCHAR(100)
    , $dcID         INT
    , $dcNo         varchar(35)
    , $dcState      INT
    , $dcComment    varchar(200)
    , $dcSum        DECIMAL(14,2)
    , $dcStatus     INT
    , $clID         INT
    , $emID         int
    , $isActive     BIT
    , $dateFrom     date
    , $dateTo       date
    , $dctID        int
    , $clName       varchar(200)
    , $crID         INT
    , $dcRate       DECIMAL(14,2)
    , $pcID         INT
    , $uID          INT
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
  DECLARE $sqlJoin        VARCHAR(2000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_GetDoc');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 100);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    set $clName = NULLIF(TRIM($clName),'');
    set $dcComment = NULLIF(TRIM($dcComment),'');
    set $dcNo = NULLIF(TRIM($dcNo),'');
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
    SET $sqlCount = 'SELECT count(*) Qty FROM dcDoc_finder;';
    --
    SET $sql = CONCAT('INSERT IGNORE INTO dcDoc_finder
            SELECT
              d.HIID                                                            HIID
              , d.dcID                                                          dcID
              , ', $Aid, '                                                      Aid
              , d.dctID       dctID
              , IF(d.dctID IS NULL OR d.dctID = 0, NULL, (SELECT dctName FROM dcType WHERE dctID = d.dctID AND Aid IN ( ', $Aid, ', 0) LIMIT 1))       dctType
              , d.dcNo                                                          dcNo
              , d.dcDate                                                        dcDate
              , d.dcLink                                                        dcLink
              , IF(d.dcLink IS NULL OR d.dcLink = 0, NULL, (SELECT dctName FROM dcType WHERE dctID = d.dcLink AND Aid = ', $Aid, ' LIMIT 1))       dcLinkType
              , IF(d.dcLink IS NULL OR d.dcLink = 0, NULL, (SELECT dcDate FROM dcDoc WHERE dcID = d.dcLink AND Aid = ', $Aid, ' LIMIT 1))       dcLinkDate
              , IF(d.dcLink IS NULL OR d.dcLink = 0, NULL, (SELECT dcNo FROM dcDoc WHERE dcID = d.dcLink AND Aid = ', $Aid, ' LIMIT 1))       dcLinkNo
              , d.dcComment                                                     dcComment
              , d.dcSum                                                         dcSum
              , d.dcStatus                                                      dcStatus
              , IF(d.dcStatus IS NULL OR d.dcStatus = 0, NULL, (SELECT Name FROM usEnumValue WHERE tvID = d.dcStatus AND Aid = ', $Aid, ' LIMIT 1))       dcStatusName
              , d.clID                                                          clID
              , IF(d.clID IS NULL OR d.clID = 0, NULL, (SELECT clName FROM crmClient WHERE clID = d.clID AND Aid = ', $Aid, ' LIMIT 1))       clName
              , d.emID                                                          emID
              , IF(d.emID IS NULL OR d.emID = 0, NULL, (SELECT emName FROM emEmploy WHERE emID = d.emID AND Aid = ', $Aid, ' LIMIT 1))       emName
              , d.Created                                                       Created
              , d.CreatedBy                                                     CreatedBy
              , IF(d.CreatedBy IS NULL OR d.CreatedBy = 0, NULL, (SELECT emName FROM emEmploy WHERE emID = d.CreatedBy AND Aid = ', $Aid, ' LIMIT 1))       CreatedName
              , d.Changed                                                       Changed
              , d.ChangedBy                                                     ChangedBy
              , IF(d.ChangedBy IS NULL OR d.ChangedBy = 0, NULL, (SELECT emName FROM emEmploy WHERE emID = d.ChangedBy AND Aid = ', $Aid, ' LIMIT 1))       EditedName
              , d.uID
              , d.isActive
              , d.pcID
              , d.dcRate
              , d.crID
              , IF(d.dctID IS NULL OR d.dctID = 0, NULL, (SELECT tpName FROM fmFormType WHERE tpID IN (SELECT tpID FROM fmForm WHERE dcID = d.dcID AND Aid = ', $Aid, ') AND Aid = ', $Aid, ' LIMIT 1))       tpName
              ');
    --
    set $sqlJoin = 'FROM dcDoc d ';
    --
    IF $dateFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcDate >= ', QUOTE($dateFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dateTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcDate <=', QUOTE($dateTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.emID = ', $emID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dctID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dctID = ', $dctID);
      SET $sqlWhereCode = ' AND ';
      IF $dctID = 4 THEN
        IF $dcNo is NOT NULL then
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcID IN (SELECT dcID FROM fmForm WHERE tpID IN (SELECT tpID FROM fmFormType WHERE tpName = ', QUOTE($dcNo), ')) ');
        END IF;
      ELSE
        IF $dcNo is NOT NULL then
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcNo like "%', $dcNo ,'%"');
        END IF;
      END IF;
    END IF;
    IF $dcComment is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcComment like ', QUOTE($dcComment));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcID = ', $dcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.clID IN (SELECT clID FROM crmClient WHERE clName = ', QUOTE($dcNo), ') ');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcState is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcState = ', $dcState);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcSum is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcSum = ', $dcSum);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcStatus is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcStatus = ', $dcStatus);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $dcRate is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.dcRate = ', $dcRate);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $crID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.crID = ', $crID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $clID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.clID = ', $clID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $pcID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.pcID = ', $pcID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $uID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'd.uID = ', $uID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $isActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'd.Aid = ', $Aid);

    CREATE TABLE IF NOT EXISTS `dcDoc_finder` (
        `HIID` BIGINT(20) NULL DEFAULT NULL,
        `dcID` INT(11) NOT NULL DEFAULT '0',
        `Aid` INT(11) NOT NULL DEFAULT '0',
        `dctType` INT(11) NULL DEFAULT NULL,
        `dctName` VARCHAR(50) NULL DEFAULT NULL,
        `dcNo` VARCHAR(35) NULL DEFAULT NULL,
        `dcDate` DATE NULL DEFAULT NULL,
        `dcLink` INT(11) NULL DEFAULT NULL,
        `dcLinkType` INT(100) NULL DEFAULT NULL,
        `dcLinkDate` DATE NULL DEFAULT NULL,
        `dcLinkNo` VARCHAR(35) NULL DEFAULT NULL,
        `dcComment` VARCHAR(200) NULL DEFAULT NULL,
        `dcSum` DECIMAL(14,2) NULL DEFAULT NULL,
        `dcStatus` INT(11) NULL DEFAULT NULL,
        `dcStatusName` VARCHAR(100) NULL DEFAULT NULL,
        `clID` INT(11) NULL DEFAULT NULL,
        `clName` VARCHAR(200) NULL DEFAULT NULL,
        `emID` INT(11) NULL DEFAULT NULL,
        `emName` VARCHAR(200) NULL DEFAULT NULL,
        `Created` DATETIME NULL DEFAULT NULL,
        `CreatedBy` INT(11) NULL DEFAULT NULL,
        `CreatedName` VARCHAR(200) NULL DEFAULT NULL,
        `Changed` DATETIME NULL DEFAULT NULL,
        `ChangedBy` INT(11) NULL DEFAULT NULL,
        `EditedName` VARCHAR(200) NULL DEFAULT NULL,
        `uID` BIGINT(20) UNSIGNED NOT NULL,
        `isActive` BIT(1) NULL DEFAULT NULL,
        `pcID` INT(11) NULL DEFAULT NULL,
        `dcRate` DECIMAL(14,2) NULL DEFAULT NULL,
        `crID` INT(11) NULL DEFAULT NULL,
        `tpName` VARCHAR(250) NULL DEFAULT NULL,
        PRIMARY KEY (`dcID`),
        INDEX `HIID` (`HIID`),
        INDEX `dctType` (`dctType`),
        INDEX `dctName` (`dctName`),
        INDEX `dcNo` (`dcNo`),
        INDEX `pcID` (`pcID`),
        INDEX `dcRate` (`dcRate`),
        INDEX `crID` (`crID`),
        INDEX `dcDate` (`dcDate`),
        INDEX `dcLink` (`dcLink`),
        INDEX `dcLinkType` (`dcLinkType`),
        INDEX `dcLinkDate` (`dcLinkDate`),
        INDEX `dcLinkNo` (`dcLinkNo`),
        INDEX `dcComment` (`dcComment`),
        INDEX `dcSum` (`dcSum`),
        INDEX `dcStatus` (`dcStatus`),
        INDEX `dcStatusName` (`dcStatusName`),
        INDEX `clID` (`clID`),
        INDEX `clName` (`clName`),
        INDEX `emID` (`emID`),
        INDEX `emName` (`emName`),
        INDEX `Created` (`Created`),
        INDEX `CreatedBy` (`CreatedBy`),
        INDEX `CreatedName` (`CreatedName`),
        INDEX `Changed` (`Changed`),
        INDEX `ChangedBy` (`ChangedBy`),
        INDEX `EditedName` (`EditedName`),
        INDEX `isActive` (`isActive`),
        INDEX `uID` (`uID`),
        INDEX `tpName` (`tpName`),
        INDEX `Aid` (`Aid`)
    )
      COLLATE='utf8_general_ci'
      ENGINE=MyISAM
    ;
    --

    SET @s = CONCAT($sql, CHAR(10), $sqlJoin, CHAR(10), $sqlWhere);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT('SELECT HIID
                                , dcID
                                , dctType
                                , dctName
                                , dcNo
                                , dcDate
                                , dcLink
                                , dcLinkType
                                , dcLinkDate
                                , dcLinkNo
                                , dcComment
                                , dcSum
                                , dcStatus
                                , dcStatusName
                                , clID
                                , clName
                                , emID
                                , emName
                                , Created
                                , CreatedBy
                                , CreatedName
                                , Changed
                                , ChangedBy
                                , EditedName
                                , uID
                                , isActive
                                , pcID
                                , dcRate
                                , crID
                                , tpName
                      FROM dcDoc_finder
                        ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    DROP TABLE dcDoc_finder;
  END IF;
END $$
DELIMITER ;
--
