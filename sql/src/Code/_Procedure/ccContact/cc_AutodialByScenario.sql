DELIMITER $$
DROP PROCEDURE IF EXISTS cc_AutodialByScenario;
CREATE PROCEDURE cc_AutodialByScenario(
    $token              VARCHAR(100)
    , $id_autodial      INT(11)
    , $qtyContact       INT(11)
)
BEGIN
  DECLARE $ffID                       INT;
  DECLARE $id_scenario                INT DEFAULT 0;
  DECLARE $callerID                   VARCHAR(50);
  DECLARE $TimeBegin                  TIME;
  DECLARE $TimeEnd                    TIME;
  DECLARE $NowTime                    TIME;
  DECLARE $WeekDay                    INT;
  DECLARE $DaysCall                   VARCHAR(500);
  DECLARE $RecallCount                INT;
  DECLARE $RecallAfterMin             INT;
  DECLARE $RecallCountPerDay          INT;
  DECLARE $RecallDaysCount            INT;
  DECLARE $RecallAfterPeriod          INT;
  DECLARE $SleepTime                  INT;
  DECLARE $AutoDial                   VARCHAR(500);
  DECLARE $IsRecallForSuccess         BIT;
  DECLARE $IsCallToOtherClientNumbers BIT;
  DECLARE $IsCheckCallFromOther       BIT;
  DECLARE $AllowPrefix                TEXT;
  DECLARE $destination                INT;
  DECLARE $res                        INT;
  DECLARE $res2                        INT;
  DECLARE $clID                       INT;
  DECLARE $destdata                   INT;
  DECLARE $target                     TEXT;
  DECLARE $isActive                   BIT;
  DECLARE $sql                        VARCHAR(5000);
  DECLARE $sqlWhere                   VARCHAR(10000);
  DECLARE $sqlWhere1                  VARCHAR(100);
  DECLARE $sqlWhere2                  VARCHAR(100);
  DECLARE $sqlWhere3                  VARCHAR(100);
  DECLARE $uID                        VARCHAR(100);
  DECLARE $head                       VARCHAR(5000);
  DECLARE $end                        VARCHAR(100);
  DECLARE $Where0                     VARCHAR(1000);
  DECLARE $Where1                     VARCHAR(1000);
  DECLARE $Where2                     VARCHAR(1000);
  DECLARE $Where3                     VARCHAR(1000);
  DECLARE $Where4                     VARCHAR(2000);
  DECLARE $Where5                     VARCHAR(2000);
  DECLARE $Where6                     VARCHAR(2000);
  DECLARE $Where7                     VARCHAR(2000);
  DECLARE $Where8                     VARCHAR(2000);
  DECLARE $Aid                        INT;
  DECLARE $freeNums                   INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  --
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetAutodialProcess');
  ELSEIF ($Aid = 0) THEN
    SET $qtyContact = IFNULL($qtyContact, 10);
    SET $NowTime = DATE_FORMAT(NOW(), '%H:%i:%s');
    SET $WeekDay = WEEKDAY(NOW())+1;
    SET $uID = fn_GetStamp();
    --
    SELECT ffID, id_scenario
    INTO $ffID, $id_scenario
    FROM ast_autodial_process
    WHERE id_autodial = $id_autodial;
    --
    IF ($id_scenario != 0) THEN
      SELECT  callerID,   TimeBegin,  TimeEnd,  DaysCall,   RecallCount,  RecallAfterMin,   RecallCountPerDay,  RecallDaysCount,  RecallAfterPeriod,  SleepTime,  AutoDial,   IsRecallForSuccess,   CAST(IsCallToOtherClientNumbers AS UNSIGNED) IsCallToOtherClientNumbers,    IsCheckCallFromOther,   AllowPrefix,  destination,   destdata,   target,   isActive
      INTO    $callerID,  $TimeBegin, $TimeEnd, $DaysCall,  $RecallCount, $RecallAfterMin,  $RecallCountPerDay, $RecallDaysCount, $RecallAfterPeriod, $SleepTime, $AutoDial,  $IsRecallForSuccess,  $IsCallToOtherClientNumbers,                                                $IsCheckCallFromOther,  $AllowPrefix, $destination,  $destdata,  $target,  $isActive
      FROM ast_scenario
      WHERE id_scenario = $id_scenario;
      --
      IF (!$isActive) THEN
        call RAISE(77102, NULL);
      ELSEIF NOT ($NowTime BETWEEN $TimeBegin AND $TimeEnd) THEN
        call RAISE(77103, NULL);
      ELSEIF NOT FIND_IN_SET($WeekDay, $DaysCall) THEN
        call RAISE(77104, NULL);
      ELSEIF $qtyContact<1 OR $qtyContact IS NULL THEN
        call RAISE(77106, NULL);
      ELSE
        CREATE TABLE IF NOT EXISTS `AutoCall_data_procedure`(
          `clID` INT NOT NULL,
          `clName` VARCHAR(200) NOT NULL,
          `ccID` INT NOT NULL,
          `ccName` VARCHAR(50) NOT NULL,
          `callerID` BIGINT(20) UNSIGNED NULL,
          `SleepTime` INT(10) UNSIGNED NULL,
          `RecallAfterMin` INT(10) UNSIGNED NULL,
          `destination` INT(11) NULL,
          `destdata` INT(11) NULL,
          `target` VARCHAR(1000) NULL,
          `AutoDial` VARCHAR(100) NULL,
          `ffID` INT(11) NOT NULL,
          `id_autodial` INT(11) NOT NULL,
          `curID` INT(11) NULL,
          `curName` VARCHAR(10) NULL,
          `langID` INT(11) NULL,
          `langName` VARCHAR(10) NULL,
          `sum` DECIMAL(14, 2) NULL,
          `ttsText` VARCHAR(1000) NULL,
          `Aid` INT(11) NULL,
          `uID` VARCHAR(100) NULL,
          `ShortName` VARCHAR(200) NULL DEFAULT NULL,
          `CompanyID` INT(11) NULL DEFAULT NULL,
          `CallDate` DATETIME NULL DEFAULT NULL,
          `KVEDName` VARCHAR(250) NULL DEFAULT NULL,
          `KVED` VARCHAR(7) NULL DEFAULT NULL,
          `Sex` INT(11) NULL DEFAULT NULL,
          `IsPerson` BIT(1) NULL DEFAULT NULL,
          `Comment` VARCHAR(1020) NULL DEFAULT NULL,
          `ParentName` VARCHAR(200) NULL DEFAULT NULL,
          `ffName` VARCHAR(200) NULL DEFAULT NULL,
          `ActualStatus` INT(11) NULL DEFAULT NULL,
          `PositionName` VARCHAR(100) NULL DEFAULT NULL,
          `emName` VARCHAR(200) NULL DEFAULT NULL,
          `ActDate` DATETIME NULL DEFAULT NULL,
          `cusID` VARCHAR(50) NULL DEFAULT NULL,
          `Account` BIGINT(20) NULL DEFAULT NULL,
          `Bank` VARCHAR(100) NULL DEFAULT NULL,
          `TaxCode` VARCHAR(14) NULL DEFAULT NULL,
          `RegCode` INT(11) NULL DEFAULT NULL,
          `CertNumber` INT(11) NULL DEFAULT NULL,
          `SortCode` INT(11) NULL DEFAULT NULL,
          `OrgType` VARCHAR(100) NULL DEFAULT NULL,
          `isChecked` ENUM('Y','N') NULL DEFAULT 'N',
          `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
          UNIQUE INDEX `ccName_id_autodial` (`ccName`, `id_autodial`),
          INDEX `id_autodial` (`id_autodial`),
          INDEX `clID` (`clID`),
          INDEX `Created` (`Created`),
          INDEX `isChecked` (`isChecked`)
        ) COLLATE='utf8_general_ci'
        ENGINE=MyISAM;
        --
        SELECT count(clID) many
          INTO $freeNums
        FROM AutoCall_data_procedure
        WHERE id_autodial = $id_autodial;
        --
        IF($freeNums IS NOT NULL AND $freeNums>0) THEN
          SET @s = CONCAT('SELECT `clID`
                                  , `clName`
                                  , `ccID`
                                  , `ccName`
                                  , `callerID`
                                  , `SleepTime`
                                  , `RecallAfterMin`
                                  , `destination`
                                  , `destdata`
                                  , `target`
                                  , `AutoDial`
                                  , `ffID`
                                  , `id_autodial`
                                  , `curID`
                                  , `curName`
                                  , `langID`
                                  , `langName`
                                  , `sum`
                                  , `ttsText`
                                  , `Aid`
                                  , `ShortName`
                                  , `CompanyID`
                                  , `CallDate`
                                  , `KVEDName`
                                  , `KVED`
                                  , `Sex`
                                  , `IsPerson`
                                  , `Comment`
                                  , `ParentName`
                                  , `ffName`
                                  , `ActualStatus`
                                  , `PositionName`
                                  , `emName`
                                  , `ActDate`
                                  , `cusID`
                                  , `Account`
                                  , `Bank`
                                  , `TaxCode`
                                  , `RegCode`
                                  , `CertNumber`
                                  , `SortCode`
                                  , `OrgType`
                                  , NEXTVAL(dcID) dcID
                          FROM `AutoCall_data_procedure` WHERE id_autodial = ', $id_autodial, ' ORDER BY clID LIMIT ', $qtyContact, ';');

          PREPARE stmt FROM @s;
          EXECUTE stmt;
          DEALLOCATE PREPARE stmt;
          --
          DELETE FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial ORDER BY clID LIMIT $qtyContact;
        ELSEIF((SELECT COUNT(1) FROM `ccContact` WHERE ffID = $ffID) = 0) THEN
            SET $sqlWhere1 = '';
            SET $sqlWhere2 = '';
            SET $sqlWhere3 = '';
            IF $IsCheckCallFromOther = 0 THEN #проверять ли дозвоненные номера в рамках компании
                SET $sqlWhere1 = CONCAT(' AND ffID = ', $ffID);
            END IF;
            IF $IsRecallForSuccess = 0 THEN
                SET $sqlWhere2 = ' AND ccStatus != 7001 ';
                SET $sqlWhere3 = ' AND ccStatus = 7001 ';
            END IF;
            --
            /*SET $Where1 = CONCAT('AND exists (# описать это, когда узнаю что такое 101
                            SELECT 1
                            FROM crmStatus
                            WHERE clID = cl.clID
                                  AND clStatus = 101
                                  AND Aid = cl.Aid)');*/
            SET $Where1 = CONCAT('AND cl.clID IN (SELECT clID #берем только номера со статусом ПРОЗВОН
                                                  FROM crmStatus
                                                  WHERE clID = cl.clID
                                                        AND clStatus = 101
                                                        AND Aid = cl.Aid
                                                        AND ffID = cl.ffID)');
            --
            /*SET $Where0 = CONCAT('AND NOT exists (# не было дозвона на этот номер
                            SELECT 1
                            FROM ccContact
                            WHERE ccName = cc.ccName
                                  AND ccStatus=7001 AND CallType = 101316 AND ffID = ', $ffID,'
                                  AND Aid = cl.Aid)');*/
            SET $Where0 = CONCAT('AND cl.clID NOT IN (SELECT clID #не было дозвона на этот номер
                                      FROM ccContact
                                      WHERE clID = cl.clID
                                            AND ccStatus = 7001
                                            /*AND CallType = 101316*/
                                            AND ffID = ', $ffID,'
                                            AND Aid = cl.Aid)');
            --
            /*SET $Where2 = 'AND NOT exists (SELECT 1 # нужно ли звонить на эту компанию (Компания "Жива")
                            FROM crmClient
                            WHERE clID = cl.clID
                                  AND ActualStatus IS NOT NULL
                                  AND Aid = cl.Aid)';*/
            SET $Where2 = 'AND cl.ActualStatus IS NULL #нужно ли звонить на эту компанию (Компания "Жива")';
            --
            /*SET $Where3 = CONCAT('AND NOT exists (SELECT 1 # есть ли звонки на этот номер в течении выбранного кол-ва минут
                            FROM ccContact
                            WHERE ccName = cc.ccName ', $sqlWhere1, ' AND Aid = cl.Aid AND Created BETWEEN (NOW() - INTERVAL ', $RecallAfterMin, ' MINUTE) AND (NOW()))');*/
            /*SET $Where3 = CONCAT('AND cl.clID NOT IN (SELECT clID #есть ли звонки на этот номер в течении выбранного кол-ва минут
                            FROM ccContact
                            WHERE clID = cl.clID AND Aid = cl.Aid AND Created BETWEEN (NOW() - INTERVAL ', $RecallAfterMin, ' MINUTE) AND (NOW()))');*/
            SET $Where3 = CONCAT('AND cl.clID IN (SELECT clID #берем только номера без даты перезвона
                 FROM crmClientEx
                 WHERE clID = cl.clID
                       AND CallDate IS NULL
                       AND Aid = cl.Aid
                       AND ffID = cl.ffID)');
            --
            /*SET $Where4 = CONCAT('AND NOT exists (SELECT 1 # количество попыток звонка на номер в течении дня не больше $RecallCountPerDay
                                                        FROM ccContact
                                                        WHERE ccName = cc.ccName', $sqlWhere2, ' AND Aid = cl.Aid AND ffID IN (SELECT ffID FROM fsFile WHERE isActive=TRUE AND Aid = cl.Aid) ', IF($IsCheckCallFromOther = 0, 'AND ffID = cl.ffID ', ''), 'AND Created BETWEEN (NOW() - INTERVAL 24 HOUR) AND (NOW())
                                                        HAVING COUNT(*) > ', $RecallCountPerDay-1, ')');
            --
            SET $Where5 = CONCAT('AND NOT EXISTS (SELECT 1 # количество дней попыток дозвона $RecallDaysCount
                                                        FROM ccContact
                                                        WHERE ccName = cc.ccName ',
                                                              $sqlWhere2,
                                                              ' AND ffID = ', $ffID, ' AND Aid = cl.Aid HAVING (TO_DAYS(MAX(`Created`)) - TO_DAYS(MIN(`Created`)) ) > ', $RecallDaysCount-1, ') ');
            --
            SET $Where6 = 'AND NOT exists (SELECT 1 FROM ccContact WHERE clID = cl.clID AND ccStatus = 7001 AND Aid = cl.Aid)';
            --
            SET $Where7 = CONCAT('AND exists (SELECT 1 FROM ccContact WHERE ccName = cc.ccName AND Aid = cl.Aid AND ffID IN (SELECT ffID FROM fsFile WHERE isActive=TRUE AND Aid = cl.Aid) ', $sqlWhere3, ' AND (SELECT MAX(Created) FROM ccContact WHERE ccName = cc.ccName AND Aid = cl.Aid AND ffID IN (SELECT ffID FROM fsFile WHERE isActive=TRUE AND Aid = cl.Aid) ', $sqlWhere3, ')<(NOW() - INTERVAL ', $RecallAfterPeriod, ' DAY))');

             */
            --
            IF($AllowPrefix IS NOT NULL AND LENGTH($AllowPrefix)>0) THEN
                SET $AllowPrefix = REPLACE($AllowPrefix, ",", "|");
            END IF;
            SET $Where8 = CONCAT('AND cc.MCC IN (SELECT MCC FROM reg_validation WHERE prefix REGEXP "', $AllowPrefix, '")
                                AND cc.MNC IN (SELECT MNC FROM reg_validation WHERE prefix REGEXP "', $AllowPrefix, '")
                                AND cc.Aid = cl.Aid');
            --
            SET $sqlWhere = '';
            SET $head = CONCAT('INSERT IGNORE INTO `AutoCall_data_procedure`', CHAR(10));
            SET $head = CONCAT($head, 'SELECT cl.clID  clID,', CHAR(10));
            SET $head = CONCAT($head, '   cl.clName clName,', CHAR(10));
            SET $head = CONCAT($head, '   cc.ccID ccID,', CHAR(10));
            SET $head = CONCAT($head, '   cc.ccName ccName,', CHAR(10));
            IF ($callerID IS NULL) THEN
                SET $head = CONCAT($head, ' NULL callerID,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', QUOTE($callerID), ' callerID,', CHAR(10));
            END IF;
            IF ($SleepTime IS NULL) THEN
                SET $head = CONCAT($head, ' NULL SleepTime,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', QUOTE($SleepTime), ' SleepTime,', CHAR(10));
            END IF;
            IF ($RecallAfterMin IS NULL) THEN
                SET $head = CONCAT($head, ' NULL RecallAfterMin,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', QUOTE($RecallAfterMin), ' RecallAfterMin,', CHAR(10));
            END IF;
            IF ($destination IS NULL) THEN
                SET $head = CONCAT($head, ' NULL destination,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', $destination, ' destination,', CHAR(10));
            END IF;
            IF ($destdata IS NULL) THEN
                SET $head = CONCAT($head, ' NULL destdata,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', $destdata, ' destdata,', CHAR(10));
            END IF;
            IF ($target IS NULL) THEN
                SET $head = CONCAT($head, ' NULL target,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', QUOTE($target), ' target,', CHAR(10));
            END IF;
            IF ($AutoDial IS NULL) THEN
                SET $head = CONCAT($head, ' NULL AutoDial,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', QUOTE($AutoDial), ' AutoDial,', CHAR(10));
            END IF;
            SET $head = CONCAT($head, '   cl.ffID ffID,', CHAR(10));
            IF ($id_autodial IS NULL) THEN
                SET $head = CONCAT($head, ' NULL id_autodial,', CHAR(10));
            ELSE
                SET $head = CONCAT($head, ' ', QUOTE($id_autodial), ' id_autodial,', CHAR(10));
            END IF;
            --
            SET $head = CONCAT($head, '   ex.curID curID,', CHAR(10));
            SET $head = CONCAT($head, '   IF(ex.curID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.curID AND Aid = cl.Aid LIMIT 1), NULL) curName,', CHAR(10));
            SET $head = CONCAT($head, '   ex.langID langID,', CHAR(10));
            SET $head = CONCAT($head, '   IF(ex.langID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.langID AND Aid = cl.Aid LIMIT 1), NULL) langName,', CHAR(10));
            SET $head = CONCAT($head, '   ex.`sum` `sum`,', CHAR(10));
            SET $head = CONCAT($head, '   ex.ttsText ttsText,', CHAR(10));
            SET $head = CONCAT($head, '   cl.Aid Aid,', CHAR(10));
            SET $head = CONCAT($head, ' ', $uID, ', ', CHAR(10));
            SET $head = CONCAT($head, '   co.ShortName ShortName,', CHAR(10));
            SET $head = CONCAT($head, '   cl.CompanyID CompanyID,', CHAR(10));
            SET $head = CONCAT($head, '   ex.CallDate CallDate,', CHAR(10));
            SET $head = CONCAT($head, '   co.KVEDName KVEDName,', CHAR(10));
            SET $head = CONCAT($head, '   co.KVED KVED,', CHAR(10));
            SET $head = CONCAT($head, '   cl.Sex Sex,', CHAR(10));
            SET $head = CONCAT($head, '   cl.IsPerson IsPerson,', CHAR(10));
            SET $head = CONCAT($head, '   cl.`Comment` `Comment`,', CHAR(10));
            SET $head = CONCAT($head, '   IF(cl.ParentID IS NULL, NULL, (SELECT clName FROM crmClient WHERE clID = cl.ParentID AND Aid = cl.Aid LIMIT 1)) ParentName,', CHAR(10));
            SET $head = CONCAT($head, '   IF(cl.ffID IS NULL, NULL, (SELECT ffName FROM fsFile WHERE ffID = cl.ffID AND Aid = cl.Aid LIMIT 1)) ffName,', CHAR(10));
            SET $head = CONCAT($head, '   cl.ActualStatus ActualStatus,', CHAR(10));
            SET $head = CONCAT($head, '   IF(cl.`Position` IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = cl.`Position` AND Aid = cl.Aid LIMIT 1), NULL) PositionName,', CHAR(10));
            SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT emName FROM emEmploy WHERE emID = cl.responsibleID AND Aid = cl.Aid LIMIT 1), NULL) emName,', CHAR(10));
            SET $head = CONCAT($head, '   ex.ActDate ActDate,', CHAR(10));
            SET $head = CONCAT($head, '   ex.cusID cusID,', CHAR(10));
            SET $head = CONCAT($head, '   co.Account Account,', CHAR(10));
            SET $head = CONCAT($head, '   co.Bank Bank,', CHAR(10));
            SET $head = CONCAT($head, '   co.TaxCode TaxCode,', CHAR(10));
            SET $head = CONCAT($head, '   co.RegCode RegCode,', CHAR(10));
            SET $head = CONCAT($head, '   co.CertNumber CertNumber,', CHAR(10));
            SET $head = CONCAT($head, '   co.SortCode SortCode,', CHAR(10));
            SET $head = CONCAT($head, '   IF(co.OrgType IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = co.OrgType AND Aid = co.Aid LIMIT 1), NULL) OrgType,', CHAR(10));
            SET $head = CONCAT($head, '   "N" isChecked,', CHAR(10));
            SET $head = CONCAT($head, '   NOW() Created', CHAR(10));
            SET $head = CONCAT($head, 'FROM crmClient cl', CHAR(10));
            SET $head = CONCAT($head, 'INNER JOIN crmContact cc ON cc.clID = cl.clID', CHAR(10), 'INNER JOIN crmClientEx ex ON ex.clID = cl.clID', CHAR(10));
            SET $head = CONCAT($head, 'LEFT JOIN crmOrg co ON co.clID = cl.clID', CHAR(10));
            SET $head = CONCAT($head, 'WHERE cc.ccType = 36
                AND cl.ffID = ', $ffID, '
                AND cc.ccID != 0
                AND cl.clID != 0
                AND ex.isDial = 0
                AND cl.IsActive = 1
                AND cc.isActive = 1');
            IF $IsRecallForSuccess = 0 OR $IsRecallForSuccess IS NULL THEN
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where1);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where0);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where2);
                IF $RecallAfterMin>0 THEN
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
                END IF;
                /*SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where4);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where5);
                #IF $IsCallToOtherClientNumbers = 0 THEN #проверять ли дозвоненные номера в рамках компании
                  SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where6);
                #END IF;
                IF $IsCheckCallFromOther = 1 AND $RecallAfterPeriod>0 THEN #используя номера из других БД
                  SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where7);
                END IF;*/
            ELSE #Дозваниваться на дозвоненные номера
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where1);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where2);

                /*IF $RecallAfterMin>0 THEN
                  SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
                END IF;*/


                /*SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where4);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where5);
                IF $IsCheckCallFromOther = 1 AND $RecallAfterPeriod>0 THEN #используя номера из других БД
                  SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where7);
                END IF;*/
            END IF;
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
            IF($AllowPrefix IS NOT NULL AND LENGTH($AllowPrefix)>0) THEN
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where8);
            END IF;
            SET $end = CONCAT(CHAR(10), 'GROUP BY cl.clID ');
            --
            SET $sql = CONCAT($head, CHAR(10), $sqlWhere, CHAR(10), $end);
            SET @s = $sql;
            /*SELECT @s ;*/

            PREPARE stmt FROM @s;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            SET @s = CONCAT('SELECT `clID`
                                        , `clName`
                                        , `ccID`
                                        , `ccName`
                                        , `callerID`
                                        , `SleepTime`
                                        , `RecallAfterMin`
                                        , `destination`
                                        , `destdata`
                                        , `target`
                                        , `AutoDial`
                                        , `ffID`
                                        , `id_autodial`
                                        , `curID`
                                        , `curName`
                                        , `langID`
                                        , `langName`
                                        , `sum`
                                        , `ttsText`
                                        , `Aid`
                                        , `ShortName`
                                        , `CompanyID`
                                        , `CallDate`
                                        , `KVEDName`
                                        , `KVED`
                                        , `Sex`
                                        , `IsPerson`
                                        , `Comment`
                                        , `ParentName`
                                        , `ffName`
                                        , `ActualStatus`
                                        , `PositionName`
                                        , `emName`
                                        , `ActDate`
                                        , `cusID`
                                        , `Account`
                                        , `Bank`
                                        , `TaxCode`
                                        , `RegCode`
                                        , `CertNumber`
                                        , `SortCode`
                                        , `OrgType`
                                        , NEXTVAL(dcID) dcID
                                FROM `AutoCall_data_procedure` WHERE id_autodial = ', $id_autodial, ' ORDER BY clID LIMIT ', $qtyContact, ';');

            PREPARE stmt FROM @s;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;

            /*                              SET @s = CONCAT('UPDATE crmClientEx SET isDial = TRUE WHERE clID IN (SELECT clID FROM `AutoCall_data_procedure` WHERE id_autodial = ', $id_autodial, ' ORDER BY clID LIMIT ', $qtyContact, ');');
                                          PREPARE stmt FROM @s;
                                          EXECUTE stmt;
                                          DEALLOCATE PREPARE stmt;*/
            --
            DELETE FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial ORDER BY clID LIMIT $qtyContact;
            SELECT 'hrtr';
        ELSE
          SET $sqlWhere1 = '';
          SET $sqlWhere2 = '';
          SET $sqlWhere3 = '';
          IF $IsCheckCallFromOther = 0 THEN #проверять ли дозвоненные номера в рамках компании
            SET $sqlWhere1 = CONCAT(' AND ffID = ', $ffID);
          END IF;
          IF $IsRecallForSuccess = 0 THEN
            SET $sqlWhere2 = ' AND ccStatus != 7001 ';
            SET $sqlWhere3 = ' AND ccStatus = 7001 ';
          END IF;
          --
          /*SET $Where1 = CONCAT('AND exists (# описать это, когда узнаю что такое 101
                          SELECT 1
                          FROM crmStatus
                          WHERE clID = cl.clID
                                AND clStatus = 101
                                AND Aid = cl.Aid)');*/
          SET $Where1 = CONCAT('AND cl.clID IN (SELECT clID #берем только номера со статусом ПРОЗВОН
                                                  FROM crmStatus
                                                  WHERE clID = cl.clID
                                                        AND clStatus = 101
                                                        AND Aid = cl.Aid
                                                        AND ffID = cl.ffID)');
          --
          /*SET $Where0 = CONCAT('AND NOT exists (# не было дозвона на этот номер
                          SELECT 1
                          FROM ccContact
                          WHERE ccName = cc.ccName
                                AND ccStatus=7001 AND CallType = 101316 AND ffID = ', $ffID,'
                                AND Aid = cl.Aid)');*/
          SET $Where0 = CONCAT('AND cl.clID NOT IN (SELECT clID #не было дозвона на этот номер
                                      FROM ccContact
                                      WHERE clID = cl.clID
                                            AND ccStatus = 7001
                                            /*AND CallType = 101316*/
                                            AND ffID = ', $ffID,'
                                            AND Aid = cl.Aid)');
          --
          /*SET $Where2 = 'AND NOT exists (SELECT 1 # нужно ли звонить на эту компанию (Компания "Жива")
                          FROM crmClient
                          WHERE clID = cl.clID
                                AND ActualStatus IS NOT NULL
                                AND Aid = cl.Aid)';*/
          SET $Where2 = 'AND cl.ActualStatus IS NULL #нужно ли звонить на эту компанию (Компания "Жива")';
          --
          /*SET $Where3 = CONCAT('AND NOT exists (SELECT 1 # есть ли звонки на этот номер в течении выбранного кол-ва минут
                          FROM ccContact
                          WHERE ccName = cc.ccName ', $sqlWhere1, ' AND Aid = cl.Aid AND Created BETWEEN (NOW() - INTERVAL ', $RecallAfterMin, ' MINUTE) AND (NOW()))');*/
          /*SET $Where3 = CONCAT('AND cl.clID NOT IN (SELECT clID #есть ли звонки на этот номер в течении выбранного кол-ва минут
                          FROM ccContact
                          WHERE clID = cl.clID AND Aid = cl.Aid AND Created BETWEEN (NOW() - INTERVAL ', $RecallAfterMin, ' MINUTE) AND (NOW()))');*/
            SET $Where3 = CONCAT('AND cl.clID IN (SELECT clID #берем только номера без даты перезвона
                 FROM crmClientEx
                 WHERE clID = cl.clID
                       AND CallDate IS NULL
                       AND Aid = cl.Aid
                       AND ffID = cl.ffID)');
          --
          /*SET $Where4 = CONCAT('AND NOT exists (SELECT 1 # количество попыток звонка на номер в течении дня не больше $RecallCountPerDay
                                                      FROM ccContact
                                                      WHERE ccName = cc.ccName', $sqlWhere2, ' AND Aid = cl.Aid AND ffID IN (SELECT ffID FROM fsFile WHERE isActive=TRUE AND Aid = cl.Aid) ', IF($IsCheckCallFromOther = 0, 'AND ffID = cl.ffID ', ''), 'AND Created BETWEEN (NOW() - INTERVAL 24 HOUR) AND (NOW())
                                                      HAVING COUNT(*) > ', $RecallCountPerDay-1, ')');
          --
          SET $Where5 = CONCAT('AND NOT EXISTS (SELECT 1 # количество дней попыток дозвона $RecallDaysCount
                                                      FROM ccContact
                                                      WHERE ccName = cc.ccName ',
                                                            $sqlWhere2,
                                                            ' AND ffID = ', $ffID, ' AND Aid = cl.Aid HAVING (TO_DAYS(MAX(`Created`)) - TO_DAYS(MIN(`Created`)) ) > ', $RecallDaysCount-1, ') ');
          --
          SET $Where6 = 'AND NOT exists (SELECT 1 FROM ccContact WHERE clID = cl.clID AND ccStatus = 7001 AND Aid = cl.Aid)';
          --
          SET $Where7 = CONCAT('AND exists (SELECT 1 FROM ccContact WHERE ccName = cc.ccName AND Aid = cl.Aid AND ffID IN (SELECT ffID FROM fsFile WHERE isActive=TRUE AND Aid = cl.Aid) ', $sqlWhere3, ' AND (SELECT MAX(Created) FROM ccContact WHERE ccName = cc.ccName AND Aid = cl.Aid AND ffID IN (SELECT ffID FROM fsFile WHERE isActive=TRUE AND Aid = cl.Aid) ', $sqlWhere3, ')<(NOW() - INTERVAL ', $RecallAfterPeriod, ' DAY))');

           */
          --
          IF($AllowPrefix IS NOT NULL AND LENGTH($AllowPrefix)>0) THEN
            SET $AllowPrefix = REPLACE($AllowPrefix, ",", "|");
          END IF;
          SET $Where8 = CONCAT('AND cc.MCC IN (SELECT MCC FROM reg_validation WHERE prefix REGEXP "', $AllowPrefix, '")
                                AND cc.MNC IN (SELECT MNC FROM reg_validation WHERE prefix REGEXP "', $AllowPrefix, '")
                                AND cc.Aid = cl.Aid');
          --
          SET $sqlWhere = '';
          SET $head = CONCAT('INSERT IGNORE INTO `AutoCall_data_procedure`', CHAR(10));
          SET $head = CONCAT($head, 'SELECT cl.clID  clID,', CHAR(10));
          SET $head = CONCAT($head, '   cl.clName clName,', CHAR(10));
          SET $head = CONCAT($head, '   cc.ccID ccID,', CHAR(10));
          SET $head = CONCAT($head, '   cc.ccName ccName,', CHAR(10));
          IF ($callerID IS NULL) THEN
            SET $head = CONCAT($head, ' NULL callerID,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', QUOTE($callerID), ' callerID,', CHAR(10));
          END IF;
          IF ($SleepTime IS NULL) THEN
            SET $head = CONCAT($head, ' NULL SleepTime,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', QUOTE($SleepTime), ' SleepTime,', CHAR(10));
          END IF;
          IF ($RecallAfterMin IS NULL) THEN
            SET $head = CONCAT($head, ' NULL RecallAfterMin,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', QUOTE($RecallAfterMin), ' RecallAfterMin,', CHAR(10));
          END IF;
          IF ($destination IS NULL) THEN
            SET $head = CONCAT($head, ' NULL destination,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', $destination, ' destination,', CHAR(10));
          END IF;
          IF ($destdata IS NULL) THEN
            SET $head = CONCAT($head, ' NULL destdata,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', $destdata, ' destdata,', CHAR(10));
          END IF;
          IF ($target IS NULL) THEN
            SET $head = CONCAT($head, ' NULL target,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', QUOTE($target), ' target,', CHAR(10));
          END IF;
          IF ($AutoDial IS NULL) THEN
            SET $head = CONCAT($head, ' NULL AutoDial,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', QUOTE($AutoDial), ' AutoDial,', CHAR(10));
          END IF;
          SET $head = CONCAT($head, '   cl.ffID ffID,', CHAR(10));
          IF ($id_autodial IS NULL) THEN
            SET $head = CONCAT($head, ' NULL id_autodial,', CHAR(10));
          ELSE
            SET $head = CONCAT($head, ' ', QUOTE($id_autodial), ' id_autodial,', CHAR(10));
          END IF;
          --
          SET $head = CONCAT($head, '   ex.curID curID,', CHAR(10));
          SET $head = CONCAT($head, '   IF(ex.curID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.curID AND Aid = cl.Aid LIMIT 1), NULL) curName,', CHAR(10));
          SET $head = CONCAT($head, '   ex.langID langID,', CHAR(10));
          SET $head = CONCAT($head, '   IF(ex.langID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.langID AND Aid = cl.Aid LIMIT 1), NULL) langName,', CHAR(10));
          SET $head = CONCAT($head, '   ex.`sum` `sum`,', CHAR(10));
          SET $head = CONCAT($head, '   ex.ttsText ttsText,', CHAR(10));
          SET $head = CONCAT($head, '   cl.Aid Aid,', CHAR(10));
          SET $head = CONCAT($head, ' ', $uID, ', ', CHAR(10));
          SET $head = CONCAT($head, '   co.ShortName ShortName,', CHAR(10));
          SET $head = CONCAT($head, '   cl.CompanyID CompanyID,', CHAR(10));
          SET $head = CONCAT($head, '   ex.CallDate CallDate,', CHAR(10));
          SET $head = CONCAT($head, '   co.KVEDName KVEDName,', CHAR(10));
          SET $head = CONCAT($head, '   co.KVED KVED,', CHAR(10));
          SET $head = CONCAT($head, '   cl.Sex Sex,', CHAR(10));
          SET $head = CONCAT($head, '   cl.IsPerson IsPerson,', CHAR(10));
          SET $head = CONCAT($head, '   cl.`Comment` `Comment`,', CHAR(10));
          SET $head = CONCAT($head, '   IF(cl.ParentID IS NULL, NULL, (SELECT clName FROM crmClient WHERE clID = cl.ParentID AND Aid = cl.Aid LIMIT 1)) ParentName,', CHAR(10));
          SET $head = CONCAT($head, '   IF(cl.ffID IS NULL, NULL, (SELECT ffName FROM fsFile WHERE ffID = cl.ffID AND Aid = cl.Aid LIMIT 1)) ffName,', CHAR(10));
          SET $head = CONCAT($head, '   cl.ActualStatus ActualStatus,', CHAR(10));
          SET $head = CONCAT($head, '   IF(cl.`Position` IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = cl.`Position` AND Aid = cl.Aid LIMIT 1), NULL) PositionName,', CHAR(10));
          SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT emName FROM emEmploy WHERE emID = cl.responsibleID AND Aid = cl.Aid LIMIT 1), NULL) emName,', CHAR(10));
          SET $head = CONCAT($head, '   ex.ActDate ActDate,', CHAR(10));
          SET $head = CONCAT($head, '   ex.cusID cusID,', CHAR(10));
          SET $head = CONCAT($head, '   co.Account Account,', CHAR(10));
          SET $head = CONCAT($head, '   co.Bank Bank,', CHAR(10));
          SET $head = CONCAT($head, '   co.TaxCode TaxCode,', CHAR(10));
          SET $head = CONCAT($head, '   co.RegCode RegCode,', CHAR(10));
          SET $head = CONCAT($head, '   co.CertNumber CertNumber,', CHAR(10));
          SET $head = CONCAT($head, '   co.SortCode SortCode,', CHAR(10));
          SET $head = CONCAT($head, '   IF(co.OrgType IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = co.OrgType AND Aid = co.Aid LIMIT 1), NULL) OrgType,', CHAR(10));
          SET $head = CONCAT($head, '   "N" isChecked,', CHAR(10));
          SET $head = CONCAT($head, '   NOW() Created', CHAR(10));
          SET $head = CONCAT($head, 'FROM crmClient cl', CHAR(10));
          SET $head = CONCAT($head, 'INNER JOIN crmContact cc ON cc.clID = cl.clID', CHAR(10), 'INNER JOIN crmClientEx ex ON ex.clID = cl.clID', CHAR(10));
          SET $head = CONCAT($head, 'LEFT JOIN crmOrg co ON co.clID = cl.clID', CHAR(10));
          SET $head = CONCAT($head, 'WHERE cc.ccType = 36
                AND cl.ffID = ', $ffID, '
                AND cc.ccID != 0
                AND cl.clID != 0
                AND ex.isDial = 0
                AND cl.IsActive = 1
                AND cc.isActive = 1');
          IF $IsRecallForSuccess = 0 OR $IsRecallForSuccess IS NULL THEN
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where1);
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where0);
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where2);
            IF $RecallAfterMin>0 THEN
              SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
            END IF;
            /*SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where4);
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where5);
            #IF $IsCallToOtherClientNumbers = 0 THEN #проверять ли дозвоненные номера в рамках компании
              SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where6);
            #END IF;
            IF $IsCheckCallFromOther = 1 AND $RecallAfterPeriod>0 THEN #используя номера из других БД
              SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where7);
            END IF;*/
          ELSE #Дозваниваться на дозвоненные номера
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where1);
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where2);

            /*IF $RecallAfterMin>0 THEN
              SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
            END IF;*/


            /*SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where4);
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where5);
            IF $IsCheckCallFromOther = 1 AND $RecallAfterPeriod>0 THEN #используя номера из других БД
              SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where7);
            END IF;*/
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
          IF($AllowPrefix IS NOT NULL AND LENGTH($AllowPrefix)>0) THEN
            SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where8);
          END IF;
          SET $end = CONCAT(CHAR(10), 'GROUP BY cl.clID ');
          --
          SET $sql = CONCAT($head, CHAR(10), $sqlWhere, CHAR(10), $end);
          SET @s = $sql;
          /*SELECT @s ;*/

          PREPARE stmt FROM @s;
          EXECUTE stmt;
          DEALLOCATE PREPARE stmt;
          --
              /*SELECT '407';*/
          /*SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial;*/
          IF ((SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial) > 0) THEN
              SET $clID = 1; -- проверяем были ли звонки за последние несколько минут (минуты указаны в сценарии)
              WHILE $clID IS NOT NULL AND $clID != 0 DO
                SET $clID = NULL;
                SELECT clID
                INTO $clID
                FROM `AutoCall_data_procedure`
                WHERE isChecked = 'N' AND 1 = 1 AND id_autodial = $id_autodial
                LIMIT 1;
                --
                IF($clID IS NOT NULL AND $clID>0)THEN
                    IF ((SELECT COUNT(1) FROM ccContact WHERE clID = $clID AND Created BETWEEN (NOW() - INTERVAL $RecallAfterMin MINUTE) AND (NOW())) > 0) THEN
                        DELETE FROM `AutoCall_data_procedure` WHERE clID = $clID AND id_autodial = $id_autodial;
                        /*SELECT $clID, $id_autodial;
                        SELECT '419';*/
                    ELSE
                        SET @s = CONCAT('UPDATE `AutoCall_data_procedure` SET isChecked = "Y" WHERE clID = ', $clID,' /*AND id_autodial = ', $id_autodial, '*/;');
                        /*select @s;
                        SELECT $clID, $id_autodial;
                        SELECT '423';*/
                        PREPARE stmt FROM @s;
                        EXECUTE stmt;
                        DEALLOCATE PREPARE stmt;
                    END IF;
                END IF;
              END WHILE;
              /*select '433';
              SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial;*/
              IF ((SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial) > 0) THEN
                  UPDATE `AutoCall_data_procedure` SET isChecked = "N";
                  SET $clID = 1;-- проверяем кол-во звонков за сутки
                  --
                  WHILE $clID IS NOT NULL AND $clID != 0 DO
                        SET $clID = NULL;
                      SELECT clID
                             INTO $clID
                      FROM `AutoCall_data_procedure`
                      WHERE isChecked = 'N'  AND 2 = 2 AND id_autodial = $id_autodial
                      LIMIT 1;
                      --
                      SET $res = 0;
                      IF($clID IS NOT NULL AND $clID>0)THEN
                          IF($IsCheckCallFromOther = 0)THEN
                              SELECT COUNT(1)
                                     INTO $res
                              FROM ccContact
                              WHERE clID = $clID
                                AND ffID IN (SELECT ffID FROM fsFile WHERE isActive = TRUE)
                                AND ffID = $ffID
                                AND Created BETWEEN CURDATE() AND NOW();
                          ELSE
                              SELECT COUNT(1)
                                     INTO $res
                              FROM ccContact
                              WHERE clID = $clID
                                AND ffID IN (SELECT ffID FROM fsFile WHERE isActive = TRUE)
                                AND Created BETWEEN CURDATE() AND NOW();
                          END IF;
                          IF ($res < $RecallCountPerDay)THEN
                              SET @s = CONCAT('UPDATE `AutoCall_data_procedure` SET isChecked = "Y" WHERE clID = ', $clID,' /*AND id_autodial = ', $id_autodial, '*/;');
                              /*SELECT $clID, $id_autodial;
                              SELECT '468';
                              select @s;*/

                              PREPARE stmt FROM @s;
                              EXECUTE stmt;
                              DEALLOCATE PREPARE stmt;

                          ELSE
                              DELETE FROM `AutoCall_data_procedure` WHERE clID = $clID AND id_autodial = $id_autodial;
                              /*SELECT $clID, $id_autodial;
                              SELECT '463';*/
                          END IF;
                      END IF;
                  END WHILE;
                  IF ((SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial) > 0) THEN
                      -- UPDATE `AutoCall_data_procedure` SET isChecked = "N";
                      SET $clID = 1;-- проверяем прошел ли период в днях
                      /*WHILE $clID IS NOT NULL DO
                            SET $clID = NULL;
                          SELECT clID
                                 INTO $clID
                          FROM `AutoCall_data_procedure`
                          WHERE isChecked = 'N'
                          LIMIT 1;
                          --
                          SET $res = 0;
                          IF($clID IS NOT NULL AND $clID>0)THEN
                              SELECT COUNT(dcID)
                                     INTO $res
                              FROM ccContact
                              WHERE clID = $clID
                                  AND ffID = $ffID
                                  AND ((DATE(NOW()) = (SELECT MIN(DATE(Created)) FROM ccContact WHERE clID = $clID)) OR ((DATE(NOW()) = (SELECT MAX(DATE(Created + INTERVAL $RecallAfterPeriod DAY)) FROM ccContact WHERE clID = $clID))));
                              IF ($res != 0)THEN
                                  DELETE FROM `AutoCall_data_procedure` WHERE clID = $clID AND id_autodial = $id_autodial;
                              ELSE
                                  SET @s = CONCAT('UPDATE `AutoCall_data_procedure` SET isChecked = "Y" WHERE clID = ', $clID,' ;');
                                  PREPARE stmt FROM @s;
                                  EXECUTE stmt;
                                  DEALLOCATE PREPARE stmt;
                              END IF;
                          END IF;
                      END WHILE;*/
                      IF ((SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial) > 0) THEN
                          UPDATE `AutoCall_data_procedure` SET isChecked = "N";
                          SET $clID = 1;-- исчерпан период времени на обзвон
                          WHILE $clID IS NOT NULL AND $clID != 0 DO
                          SELECT clID
                                 INTO $clID
                          FROM `AutoCall_data_procedure`
                          WHERE isChecked = 'N' AND 3 = 3 AND id_autodial = $id_autodial
                          LIMIT 1;
                          --
                          SET $res = 0;
                          IF($clID IS NOT NULL AND $clID>0)THEN
                              SET $clID = NULL;
                              SELECT COUNT(1)
                                     INTO $res
                              FROM ccContact
                              WHERE clID = $clID
                                AND ffID = $ffID
                                AND ((SELECT DATEDIFF(NOW(), MIN(Created)) FROM ccContact WHERE clID = $clID)<($RecallDaysCount*$RecallAfterPeriod));

                              IF ($res = 0)THEN
                                  DELETE FROM `AutoCall_data_procedure` WHERE clID = $clID AND id_autodial = $id_autodial;
                              ELSE
                                  SET @s = CONCAT('UPDATE `AutoCall_data_procedure` SET isChecked = "Y" WHERE clID = ', $clID,' /*AND id_autodial = ', $id_autodial, '*/;');
                                  PREPARE stmt FROM @s;
                                  EXECUTE stmt;
                                  DEALLOCATE PREPARE stmt;
                              END IF;
                          END IF;
                          END WHILE;
                          IF ((SELECT COUNT(1) FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial) > 0) THEN
                              SET @s = CONCAT('SELECT `clID`
                                        , `clName`
                                        , `ccID`
                                        , `ccName`
                                        , `callerID`
                                        , `SleepTime`
                                        , `RecallAfterMin`
                                        , `destination`
                                        , `destdata`
                                        , `target`
                                        , `AutoDial`
                                        , `ffID`
                                        , `id_autodial`
                                        , `curID`
                                        , `curName`
                                        , `langID`
                                        , `langName`
                                        , `sum`
                                        , `ttsText`
                                        , `Aid`
                                        , `ShortName`
                                        , `CompanyID`
                                        , `CallDate`
                                        , `KVEDName`
                                        , `KVED`
                                        , `Sex`
                                        , `IsPerson`
                                        , `Comment`
                                        , `ParentName`
                                        , `ffName`
                                        , `ActualStatus`
                                        , `PositionName`
                                        , `emName`
                                        , `ActDate`
                                        , `cusID`
                                        , `Account`
                                        , `Bank`
                                        , `TaxCode`
                                        , `RegCode`
                                        , `CertNumber`
                                        , `SortCode`
                                        , `OrgType`
                                        , NEXTVAL(dcID) dcID
                                FROM `AutoCall_data_procedure` WHERE id_autodial = ', $id_autodial, ' ORDER BY clID LIMIT ', $qtyContact, ';');

                              PREPARE stmt FROM @s;
                              EXECUTE stmt;
                              DEALLOCATE PREPARE stmt;

/*                              SET @s = CONCAT('UPDATE crmClientEx SET isDial = TRUE WHERE clID IN (SELECT clID FROM `AutoCall_data_procedure` WHERE id_autodial = ', $id_autodial, ' ORDER BY clID LIMIT ', $qtyContact, ');');
                              PREPARE stmt FROM @s;
                              EXECUTE stmt;
                              DEALLOCATE PREPARE stmt;*/
                              --
                              DELETE FROM `AutoCall_data_procedure` WHERE id_autodial = $id_autodial ORDER BY clID LIMIT $qtyContact;
                              /*SELECT '586';*/
                          ELSE
                              call RAISE(77069, 'Исчерпан период времени на обзвон!');
                              /*call RAISE(77069, 'Обзвон окончен!');*/
                          END IF;
                      ELSE
                          call RAISE(77069, 'Не прошло нужное кол-во дней, чтобы можно было перезвонить!');
                      END IF;
                  ELSE
                      call RAISE(77069, 'Превышен лимит звонков на номер, в течении дня!');
                  END IF;
              ELSE
                  call RAISE(77069, 'Не прошло кол-во минут для перезвона!');
                  /*call RAISE(77069, 'Превышен лимит звонков на номер, в течении дня!');*/
              END IF;
          ELSE
              IF ((SELECT COUNT(1) FROM crmStatus WHERE clStatus = 101) = (SELECT COUNT(1) FROM crmStatus WHERE ccStatus IN (201, 202))) THEN
                  call RAISE(77069, 'База обзвонена!');
              ELSE
                  call RAISE(77069, 'Нет номеров для прозвона!');
              END IF;
          END IF;
        END IF;
      END IF;
    ELSE
      call RAISE(77101, NULL);
    END IF;
  ELSE
      -- SELECT NULL;
     call RAISE(77115, NULL);
  END IF;
  --
END $$
DELIMITER ;
--
