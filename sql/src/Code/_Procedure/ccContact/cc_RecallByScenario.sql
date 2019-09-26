DELIMITER $$
DROP PROCEDURE IF EXISTS cc_RecallByScenario;
CREATE PROCEDURE cc_RecallByScenario(
    $token              VARCHAR(100)
                                    , $qtyContact       INT(11)
)
BEGIN
    DECLARE $ffID                       INT;
    DECLARE $rcID                       INT;
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
    DECLARE $IsCallToOtherClientNumbers BIT;
    DECLARE $IsCheckCallFromOther       BIT;
    DECLARE $AllowPrefix                TEXT;
    DECLARE $destination                INT;
    DECLARE $res                        INT;
    DECLARE $id                         INT;
    DECLARE $res2                       INT;
    DECLARE $clID                       INT;
    DECLARE $ccName                     BIGINT;
    DECLARE $destdata                   INT;
    DECLARE $target                     TEXT;
    DECLARE $isActive                   BIT;
    DECLARE $sql                        VARCHAR(5000);
    DECLARE $sqlWhere                   VARCHAR(10000);
    DECLARE $sqlWhere1                  VARCHAR(100);
    DECLARE $sqlWhere2                  VARCHAR(100);
    DECLARE $sqlWhere3                  VARCHAR(100);
    -- DECLARE $uID                        VARCHAR(100);
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
    DECLARE $lostCallTime                   DATETIME;
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    --
    IF $qtyContact<1 OR $qtyContact IS NULL THEN
        call RAISE(77106, NULL);
    ELSE
        IF ($Aid = -999) THEN
            call RAISE(77068, 'ast_GetAutodialProcess');
        ELSEIF ($Aid = 0) THEN
            SET $qtyContact = IFNULL($qtyContact, 10);
            SET $NowTime = DATE_FORMAT(NOW(), '%H:%i:%s');
            SET $WeekDay = WEEKDAY(NOW())+1;
            -- SET $uID = fn_GetStamp();
            --
            CREATE TABLE IF NOT EXISTS `Recall_data_procedure` (
                                                                   `id` INT(11) NOT NULL AUTO_INCREMENT,
                                                                   `clID` INT(11) NOT NULL,
                                                                   `clName` VARCHAR(200) NOT NULL,
                                                                   `ccID` INT(11) NOT NULL,
                                                                   `ccName` VARCHAR(50) NOT NULL,
                                                                   `callerID` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
                                                                   `SleepTime` INT(10) UNSIGNED NULL DEFAULT NULL,
                                                                   `RecallAfterMin` INT(10) UNSIGNED NULL DEFAULT NULL,
                                                                   `destination` INT(11) NULL DEFAULT NULL,
                                                                   `destdata` INT(11) NULL DEFAULT NULL,
                                                                   `target` VARCHAR(1000) NULL DEFAULT NULL,
                                                                   `AutoDial` VARCHAR(100) NULL DEFAULT NULL,
                                                                   `ffID` INT(11) NOT NULL,
                                                                   `rcID` INT(11) NOT NULL,
                                                                   `curID` INT(11) NULL DEFAULT NULL,
                                                                   `curName` VARCHAR(10) NULL DEFAULT NULL,
                                                                   `langID` INT(11) NULL DEFAULT NULL,
                                                                   `langName` VARCHAR(10) NULL DEFAULT NULL,
                                                                   `sum` DECIMAL(14,2) NULL DEFAULT NULL,
                                                                   `ttsText` VARCHAR(1000) NULL DEFAULT NULL,
                                                                   `Aid` INT(11) NULL DEFAULT NULL,
                                                                   `uID` VARCHAR(100) NULL DEFAULT NULL,
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
                                                                   `emID` INT(11) NULL DEFAULT NULL,
                                                                   `emName` VARCHAR(200) NULL DEFAULT NULL,
                                                                   `sipID` INT(11) NULL DEFAULT NULL,
                                                                   `sipName` VARCHAR(200) NULL DEFAULT NULL,
                                                                   `ActDate` DATETIME NULL DEFAULT NULL,
                                                                   `cusID` VARCHAR(50) NULL DEFAULT NULL,
                                                                   `Account` BIGINT(20) NULL DEFAULT NULL,
                                                                   `Bank` VARCHAR(100) NULL DEFAULT NULL,
                                                                   `TaxCode` VARCHAR(14) NULL DEFAULT NULL,
                                                                   `RegCode` INT(11) NULL DEFAULT NULL,
                                                                   `CertNumber` INT(11) NULL DEFAULT NULL,
                                                                   `SortCode` INT(11) NULL DEFAULT NULL,
                                                                   `OrgType` VARCHAR(100) NULL DEFAULT NULL,
                                                                   `coID` INT(11) NULL DEFAULT '0',
                                                                   `type` INT(11) NULL DEFAULT '103701',
                                                                   `isChecked` ENUM('Y','N') NULL DEFAULT 'N',
                                                                   `lostCallTime` DATETIME NULL DEFAULT NULL,
                                                                   `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                                   PRIMARY KEY (`id`),
                                                                   UNIQUE INDEX `clID_ccID_ccName_AutoDial_ffID_rcID_Aid_uID` (`clID`, `ccID`, `ccName`, `ffID`, `rcID`, `Aid`, `uID`),
                                                                   INDEX `rcID` (`rcID`),
                                                                   INDEX `clID` (`clID`),
                                                                   INDEX `Created` (`Created`),
                                                                   INDEX `isChecked` (`isChecked`)
            )
                COLLATE='utf8_general_ci'
                ENGINE=MyISAM
            ;
            --
            CREATE TEMPORARY TABLE IF NOT EXISTS `current_recall` (
                                                                      `rcID` INT NULL,
                                                                      `Aid` INT NULL,
                                                                      `clID` INT NULL,
                                                                      INDEX `rcID` (`rcID`),
                                                                      INDEX `clID` (`clID`),
                                                                      INDEX `Aid` (`Aid`)
            )ENGINE=MEMORY;
            --
            SELECT count(clID) many
                   INTO $freeNums
            FROM Recall_data_procedure;
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
                                  , IF(destination = 101408, (SELECT context FROM ast_custom_destination WHERE cdID = r.destdata), NULL) destdataName
                                  , `target`
                                  , `AutoDial`
                                  , `ffID`
                                  , `rcID`
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
                                  , `emID`
                                  , `emName`
                                  , `sipID`
                                  , `sipName`
                                  , `ActDate`
                                  , `cusID`
                                  , `Account`
                                  , `Bank`
                                  , `TaxCode`
                                  , `RegCode`
                                  , `CertNumber`
                                  , `SortCode`
                                  , `OrgType`
                                  , `coID`
                                  , `uID`
                                  , NEXTVAL(dcID) dcID
                          FROM `Recall_data_procedure` r WHERE CURTIME() BETWEEN (SELECT TimeBegin FROM ast_recall WHERE rcID = r.rcID) AND ((SELECT TimeEnd FROM ast_recall WHERE rcID = r.rcID))
		  	                	AND LOCATE(DAYOFWEEK(NOW()), (SELECT DaysCall FROM ast_recall WHERE rcID = r.rcID))
                                LIMIT ', $qtyContact, ';');

                PREPARE stmt FROM @s;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                --
                INSERT INTO current_recall
                SELECT rcID, Aid, clID
                FROM `Recall_data_procedure`
                LIMIT $qtyContact;
                --
                UPDATE crmClientEx SET isDial = 1 WHERE clID IN (SELECT clID FROM current_recall);
                --
                DELETE FROM `current_recall`;
                -- DELETE FROM `Recall_data_procedure` ORDER BY clID LIMIT $qtyContact;
                DELETE FROM `Recall_data_procedure` LIMIT $qtyContact;
            ELSE
                SET $sqlWhere1 = '';
                SET $sqlWhere2 = '';
                SET $sqlWhere3 = '';
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
                                            AND Created > (SELECT CallDate FROM crmClientEx WHERE clID = cl.clID AND CallDate IS NOT NULL)
                                            AND ffID = cl.ffID
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
                SET $Where3 = CONCAT('AND cl.clID IN (SELECT clID #берем только номера без даты перезвона
                 FROM crmClientEx
                 WHERE clID = cl.clID
                       AND CallDate IS NOT NULL
                       AND CallDate < NOW()
                       AND Aid = cl.Aid
                       AND ffID = cl.ffID)');
                --
                SET $Where4 = CONCAT('AND cl.Aid IN (SELECT Aid #выбираем только тех клиентов, у кого создан сценарий Recall
                     FROM ast_recall
                     WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) AND `type` = "103701")');


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
                SET $head = CONCAT('INSERT IGNORE INTO `Recall_data_procedure`', CHAR(10));
                SET $head = CONCAT($head, 'SELECT NULL,', CHAR(10));
                SET $head = CONCAT($head, '   cl.clID clID,', CHAR(10));
                SET $head = CONCAT($head, '   cl.clName clName,', CHAR(10));
                SET $head = CONCAT($head, '   cc.ccID ccID,', CHAR(10));
                SET $head = CONCAT($head, '   cc.ccName ccName,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT callerID FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) callerID,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT SleepTime FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) SleepTime,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT RecallAfterMin FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) RecallAfterMin,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT destination FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) destination,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT destdata FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) destdata,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT target FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) target,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT AutoDial FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) AutoDial,', CHAR(10));
                SET $head = CONCAT($head, '   cl.ffID ffID,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT rcID FROM ast_recall WHERE Aid = cl.Aid AND `type` = 103701 LIMIT 1) rcID,', CHAR(10));
                --
                SET $head = CONCAT($head, '   ex.curID curID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(ex.curID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.curID AND Aid = cl.Aid LIMIT 1), NULL) curName,', CHAR(10));
                SET $head = CONCAT($head, '   ex.langID langID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(ex.langID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.langID AND Aid = cl.Aid LIMIT 1), NULL) langName,', CHAR(10));
                SET $head = CONCAT($head, '   ex.`sum` `sum`,', CHAR(10));
                SET $head = CONCAT($head, '   ex.ttsText ttsText,', CHAR(10));
                SET $head = CONCAT($head, '   cl.Aid Aid,', CHAR(10));
                SET $head = CONCAT($head, '   UUID(), ', CHAR(10));
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
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT emID FROM emEmploy WHERE emID = cl.responsibleID AND Aid = cl.Aid LIMIT 1), NULL) emID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT emName FROM emEmploy WHERE emID = cl.responsibleID AND Aid = cl.Aid LIMIT 1), NULL) emName,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT sipID FROM ast_sippeers WHERE emID = cl.responsibleID AND Aid = cl.Aid LIMIT 1), NULL) sipID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT sipName FROM ast_sippeers WHERE emID = cl.responsibleID AND Aid = cl.Aid LIMIT 1), NULL) sipName,', CHAR(10));
                SET $head = CONCAT($head, '   ex.ActDate ActDate,', CHAR(10));
                SET $head = CONCAT($head, '   ex.cusID cusID,', CHAR(10));
                SET $head = CONCAT($head, '   co.Account Account,', CHAR(10));
                SET $head = CONCAT($head, '   co.Bank Bank,', CHAR(10));
                SET $head = CONCAT($head, '   co.TaxCode TaxCode,', CHAR(10));
                SET $head = CONCAT($head, '   co.RegCode RegCode,', CHAR(10));
                SET $head = CONCAT($head, '   co.CertNumber CertNumber,', CHAR(10));
                SET $head = CONCAT($head, '   co.SortCode SortCode,', CHAR(10));
                SET $head = CONCAT($head, '   IF(co.OrgType IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = co.OrgType AND Aid = co.Aid LIMIT 1), NULL) OrgType,', CHAR(10));
                SET $head = CONCAT($head, '   0 coID,', CHAR(10));
                SET $head = CONCAT($head, '   103701 `type`,', CHAR(10));
                SET $head = CONCAT($head, '   "N" isChecked,', CHAR(10));
                SET $head = CONCAT($head, '   ex.CallDate lostCallTime,', CHAR(10));
                SET $head = CONCAT($head, '   NOW() Created', CHAR(10));
                SET $head = CONCAT($head, 'FROM crmClient cl', CHAR(10));
                SET $head = CONCAT($head, 'INNER JOIN crmContact cc ON cc.clID = cl.clID', CHAR(10));
                SET $head = CONCAT($head, 'INNER JOIN crmClientEx ex ON ex.clID = cl.clID', CHAR(10));
                SET $head = CONCAT($head, 'LEFT JOIN crmOrg co ON co.clID = cl.clID', CHAR(10));
                SET $head = CONCAT($head, 'WHERE cc.ccType = 36
                AND cc.Aid IN (SELECT Aid FROM ast_recall WHERE isActive = TRUE AND `type` = 103701)
                AND cc.ccID > 0
                AND cl.clID > 0
                AND cl.IsActive = 1
                AND ex.isDial = 0
                AND ex.isCallDate = TRUE
                AND ex.CallDate < NOW()
                AND cc.isActive = 1');
                /*IF $IsRecallForSuccess = 0 OR $IsRecallForSuccess IS NULL THEN*/
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where1);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where0);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where2);
                /*ELSE #Дозваниваться на дозвоненные номера
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where1);
                    SET $sqlWhere = CONCAT($sqlWherAND CallDate IS NOT NULLe, CHAR(10), $Where2);
                END IF;*/
                -- SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where3);
                SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where4);
                IF($AllowPrefix IS NOT NULL AND LENGTH($AllowPrefix)>0) THEN
                    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $Where8);
                END IF;
                SET $end = CONCAT(CHAR(10), '/*GROUP BY cl.clID*/ ORDER BY ex.CallDate ASC');
                --
                SET $sql = CONCAT($head, CHAR(10), $sqlWhere, CHAR(10), $end);
                SET @s = $sql;
                -- SELECT @s ;

                PREPARE stmt FROM @s;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET $Where4 = CONCAT('AND cl.Aid IN (SELECT Aid #выбираем только тех клиентов, у кого создан сценарий Recall
                     FROM ast_recall
                     WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) AND `type` = 103702)');
                SET $head = CONCAT('INSERT IGNORE INTO `Recall_data_procedure`', CHAR(10));
                SET $head = CONCAT($head, 'SELECT NULL,', CHAR(10));
                SET $head = CONCAT($head, '   c.clID clID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(c.clID IS NOT NULL, (SELECT `clName` FROM crmClient WHERE clID = c.clID AND Aid = c.Aid LIMIT 1), NULL) clName,', CHAR(10));
                SET $head = CONCAT($head, '   c.ccID ccID,', CHAR(10));
                SET $head = CONCAT($head, '   c.ccName ccName,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT callerID FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) callerID,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT SleepTime FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) SleepTime,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT RecallAfterMin FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) RecallAfterMin,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT destination FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) destination,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT destdata FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) destdata,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT target FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) target,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT AutoDial FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) AutoDial,', CHAR(10));
                SET $head = CONCAT($head, '   c.ffID ffID,', CHAR(10));
                SET $head = CONCAT($head, '   (SELECT rcID FROM ast_recall WHERE Aid = c.Aid AND `type` = 103702 LIMIT 1) rcID,', CHAR(10));
                --
                SET $head = CONCAT($head, '   ex.curID curID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(ex.curID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.curID AND Aid = c.Aid LIMIT 1), NULL) curName,', CHAR(10));
                SET $head = CONCAT($head, '   ex.langID langID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(ex.langID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.langID AND Aid = c.Aid LIMIT 1), NULL) langName,', CHAR(10));
                SET $head = CONCAT($head, '   ex.`sum` `sum`,', CHAR(10));
                SET $head = CONCAT($head, '   ex.ttsText ttsText,', CHAR(10));
                SET $head = CONCAT($head, '   c.Aid Aid,', CHAR(10));
                SET $head = CONCAT($head, '   UUID(), ', CHAR(10));
                SET $head = CONCAT($head, '   co.ShortName ShortName,', CHAR(10));
                SET $head = CONCAT($head, '   cl.CompanyID CompanyID,', CHAR(10));
                SET $head = CONCAT($head, '   ex.CallDate CallDate,', CHAR(10));
                SET $head = CONCAT($head, '   co.KVEDName KVEDName,', CHAR(10));
                SET $head = CONCAT($head, '   co.KVED KVED,', CHAR(10));
                SET $head = CONCAT($head, '   cl.Sex Sex,', CHAR(10));
                SET $head = CONCAT($head, '   cl.IsPerson IsPerson,', CHAR(10));
                SET $head = CONCAT($head, '   cl.`Comment` `Comment`,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.ParentID IS NULL, NULL, (SELECT clName FROM crmClient WHERE clID = cl.ParentID AND Aid = c.Aid LIMIT 1)) ParentName,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.ffID IS NULL, NULL, (SELECT ffName FROM fsFile WHERE ffID = c.ffID AND Aid = c.Aid LIMIT 1)) ffName,', CHAR(10));
                SET $head = CONCAT($head, '   cl.ActualStatus ActualStatus,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.`Position` IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = cl.`Position` AND Aid = c.Aid LIMIT 1), NULL) PositionName,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT emID FROM emEmploy WHERE emID = cl.responsibleID AND Aid = c.Aid LIMIT 1), NULL) emID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT emName FROM emEmploy WHERE emID = cl.responsibleID AND Aid = c.Aid LIMIT 1), NULL) emName,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT sipID FROM ast_sippeers WHERE emID = cl.responsibleID AND Aid = c.Aid LIMIT 1), NULL) sipID,', CHAR(10));
                SET $head = CONCAT($head, '   IF(cl.responsibleID IS NOT NULL, (SELECT sipName FROM ast_sippeers WHERE emID = cl.responsibleID AND Aid = c.Aid LIMIT 1), NULL) sipName,', CHAR(10));
                SET $head = CONCAT($head, '   ex.ActDate ActDate,', CHAR(10));
                SET $head = CONCAT($head, '   ex.cusID cusID,', CHAR(10));
                SET $head = CONCAT($head, '   co.Account Account,', CHAR(10));
                SET $head = CONCAT($head, '   co.Bank Bank,', CHAR(10));
                SET $head = CONCAT($head, '   co.TaxCode TaxCode,', CHAR(10));
                SET $head = CONCAT($head, '   co.RegCode RegCode,', CHAR(10));
                SET $head = CONCAT($head, '   co.CertNumber CertNumber,', CHAR(10));
                SET $head = CONCAT($head, '   co.SortCode SortCode,', CHAR(10));
                SET $head = CONCAT($head, '   IF(co.OrgType IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = co.OrgType AND Aid = co.Aid LIMIT 1), NULL) OrgType,', CHAR(10));
                SET $head = CONCAT($head, '   c.coID coID,', CHAR(10));
                SET $head = CONCAT($head, '   103702 `type`,', CHAR(10));
                SET $head = CONCAT($head, '   "N" isChecked,', CHAR(10));
                SET $head = CONCAT($head, '   c.Created lostCallTime,', CHAR(10));
                SET $head = CONCAT($head, '   NOW() Created', CHAR(10));
                SET $head = CONCAT($head, 'FROM ccContact c', CHAR(10));
                SET $head = CONCAT($head, 'LEFT JOIN crmContact cc ON cc.clID = c.clID', CHAR(10), 'LEFT JOIN crmClientEx ex ON ex.clID = c.clID', CHAR(10));
                SET $head = CONCAT($head, 'LEFT JOIN crmClient cl ON cl.clID = c.clID', CHAR(10));
                SET $head = CONCAT($head, 'LEFT JOIN crmOrg co ON co.clID = c.clID', CHAR(10));
                SET $head = CONCAT($head, 'WHERE c.IsMissed = TRUE AND c.clID >= 0 AND IsOut = FALSE AND CallType != 101320 AND c.Created > (NOW() - INTERVAL 24 HOUR) AND c.Aid IN (SELECT Aid FROM ast_recall WHERE isActive = TRUE AND `type` = 103702)', CHAR(10), $Where4, CHAR(10), 'GROUP BY ccName;', CHAR(10));
                SET @s = $head;
                -- SELECT @s ;
                PREPARE stmt FROM @s;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                --
                IF ((SELECT COUNT(1) FROM `Recall_data_procedure`) > 0) THEN
                    SET $clID = 1; -- проверяем были ли звонки за последние несколько минут (минуты указаны в сценарии)
                    WHILE $clID IS NOT NULL DO
                        SET $clID = NULL;
                        SELECT clID, rcID, ffID, lostCallTime
                               INTO $clID, $rcID, $ffID, $lostCallTime
                        FROM `Recall_data_procedure`
                        WHERE isChecked = 'N' AND `type` = 103701
                        LIMIT 1;

                        SELECT  callerID,   TimeBegin,  TimeEnd,  DaysCall,   RecallCount,  RecallAfterMin,   RecallCountPerDay,  RecallDaysCount,  RecallAfterPeriod,  SleepTime,  AutoDial,     CAST(IsCallToOtherClientNumbers AS UNSIGNED) IsCallToOtherClientNumbers,    IsCheckCallFromOther,   AllowPrefix,  destination,   destdata,   target,   isActive
                                INTO    $callerID,  $TimeBegin, $TimeEnd, $DaysCall,  $RecallCount, $RecallAfterMin,  $RecallCountPerDay, $RecallDaysCount, $RecallAfterPeriod, $SleepTime, $AutoDial,   $IsCallToOtherClientNumbers,                                                $IsCheckCallFromOther,  $AllowPrefix, $destination,  $destdata,  $target,  $isActive
                        FROM  ast_recall
                        WHERE rcID = $rcID;
                        --
                        /*IF (NOT ($NowTime BETWEEN $TimeBegin AND $TimeEnd)) THEN

                            call RAISE(77103, NULL);
                        ELSEIF (NOT FIND_IN_SET($WeekDay, $DaysCall)) THEN
                            call RAISE(77104, NULL);
                        ELSE*/
                            --
                            IF ((SELECT COUNT(1) FROM ccContact WHERE clID = $clID AND Created BETWEEN (NOW() - INTERVAL $RecallAfterMin MINUTE) AND (NOW())) > 0) THEN
                                DELETE FROM `Recall_data_procedure` WHERE clID = $clID AND rcID = $rcID;
                                -- UPDATE crmClientEx SET isCallDate = FALSE WHERE clID = $clID;
                            END IF;
                            IF($IsCheckCallFromOther = 0)THEN
                                SELECT COUNT(1)
                                       INTO $res
                                FROM ccContact
                                WHERE clID = $clID
                                  AND ffID IN (SELECT ffID FROM fsFile WHERE isActive = TRUE)
                                  AND ffID = $ffID
                                  AND Created BETWEEN ($lostCallTime - INTERVAL +1 MINUTE) AND NOW();
                            ELSE
                                SELECT COUNT(1)
                                       INTO $res
                                FROM ccContact
                                WHERE clID = $clID
                                  AND ffID IN (SELECT ffID FROM fsFile WHERE isActive = TRUE)
                                  AND Created BETWEEN ($lostCallTime - INTERVAL +1 MINUTE) AND NOW();
                            END IF;
                            IF ($res >= $RecallCountPerDay)THEN
                                DELETE FROM `Recall_data_procedure` WHERE clID = $clID AND rcID = $rcID;
                                UPDATE crmClientEx SET isCallDate = FALSE WHERE clID = $clID;
                            END IF;

                            SET $res2 = -1;
                            SELECT COUNT(dcID)
                                   INTO $res2
                            FROM ccContact
                            WHERE clID = $clID
                              AND ffID = $ffID
                              AND ((DATE(NOW()) = (SELECT MIN(DATE(Created)) FROM ccContact WHERE clID = $clID)) OR ((DATE(NOW()) = (SELECT MAX(DATE(Created + INTERVAL $RecallAfterPeriod DAY)) FROM ccContact WHERE clID = $clID))));
                            IF (($res2 > 0) AND ($res >= $RecallCountPerDay)) THEN
                                DELETE FROM `Recall_data_procedure` WHERE clID = $clID AND rcID = $rcID;
                                UPDATE crmClientEx SET isCallDate = FALSE WHERE clID = $clID;
                            END IF;
                            SET $res = -1;
                            SELECT COUNT(1)
                                   INTO $res
                            FROM ccContact
                            WHERE clID = $clID
                              AND ffID = $ffID
                              AND ((SELECT DATEDIFF(NOW(), MIN(Created)) FROM ccContact WHERE clID = $clID)<($RecallDaysCount*$RecallAfterPeriod));
                            IF ($res < 0)THEN
                                DELETE FROM `Recall_data_procedure` WHERE clID = $clID AND rcID = $rcID;
                                UPDATE crmClientEx SET isCallDate = FALSE WHERE clID = $clID;
                            END IF;SET $res = -1;

                            SELECT COUNT(1)
                                   INTO $res
                            FROM ccContact
                            WHERE clID = $clID
                              AND ffID = $ffID
                              AND ((SELECT DATEDIFF(NOW(), MIN(Created)) FROM ccContact WHERE clID = $clID)<($RecallDaysCount*$RecallAfterPeriod));
                            IF ($res < 0)THEN
                                DELETE FROM `Recall_data_procedure` WHERE clID = $clID AND rcID = $rcID;
                                UPDATE crmClientEx SET isCallDate = FALSE WHERE clID = $clID;
                            END IF;
                        -- END IF;
                        IF($clID IS NOT NULL)THEN
                            SET @s = CONCAT('UPDATE `Recall_data_procedure` SET isChecked = "Y" WHERE clID = ', $clID,';');
                            PREPARE stmt FROM @s;
                            EXECUTE stmt;
                            DEALLOCATE PREPARE stmt;
                        END IF;
                    END WHILE;

                    -- пропущенные
                    SET $ccName = 1; -- проверяем были ли звонки за последние несколько минут (минуты указаны в сценарии)
                    WHILE $ccName IS NOT NULL DO
                        SET $id = 0;
                        SELECT clID, rcID, ffID, ccName, id, lostCallTime
                               INTO $clID, $rcID, $ffID, $ccName, $id, $lostCallTime
                        FROM `Recall_data_procedure`
                        WHERE isChecked = 'N' AND `type` = 103702
                        LIMIT 1;

                        SET @s = CONCAT('UPDATE `Recall_data_procedure` SET isChecked = "Y" WHERE id = ', $id,';');
                        /*select @s;*/
                        PREPARE stmt FROM @s;
                        EXECUTE stmt;
                        DEALLOCATE PREPARE stmt;
                        --
                        IF($id IS NOT NULL)THEN
                            SELECT  callerID,   TimeBegin,  TimeEnd,  DaysCall,   RecallCount,  RecallAfterMin,   RecallCountPerDay,  RecallDaysCount,  RecallAfterPeriod,  SleepTime,  AutoDial,     CAST(IsCallToOtherClientNumbers AS UNSIGNED) IsCallToOtherClientNumbers,    IsCheckCallFromOther,   AllowPrefix,  destination,   destdata,   target,   isActive
                                    INTO    $callerID,  $TimeBegin, $TimeEnd, $DaysCall,  $RecallCount, $RecallAfterMin,  $RecallCountPerDay, $RecallDaysCount, $RecallAfterPeriod, $SleepTime, $AutoDial,   $IsCallToOtherClientNumbers,                                                $IsCheckCallFromOther,  $AllowPrefix, $destination,  $destdata,  $target,  $isActive
                            FROM  ast_recall
                            WHERE rcID = $rcID;
                                IF ((SELECT COUNT(1) FROM ccContact WHERE ccName = $ccName  AND Created BETWEEN (NOW() - INTERVAL $RecallAfterMin MINUTE) AND (NOW())) > 0) THEN
                                    DELETE FROM `Recall_data_procedure` WHERE ccName = $ccName;
                                END IF;
                                SET $res = 0;
                                SELECT COUNT(1)
                                       INTO $res
                                FROM ccContact
                                WHERE ccName = $ccName
                                  AND Created BETWEEN ($lostCallTime - INTERVAL +1 MINUTE) AND NOW();
                                IF ($res > $RecallCountPerDay)THEN
                                    DELETE FROM `Recall_data_procedure` WHERE ccName = $ccName;
                                END IF;

                                /*SET $res2 = -1;
                                SELECT COUNT(dcID)
                                       INTO $res2
                                FROM ccContact
                                WHERE ccName = $ccName
                                  AND ((DATE(NOW()) = (SELECT MIN(DATE(Created)) FROM ccContact WHERE ccName = $ccName AND IsMissed = TRUE)) OR ((DATE(NOW()) = (SELECT MAX(DATE(Created + INTERVAL $RecallAfterPeriod DAY)) FROM ccContact WHERE ccName = $ccName AND IsMissed = TRUE))));
                                IF (($res2 > 0) AND ($res >= $RecallCountPerDay)) THEN
                                    DELETE FROM `Recall_data_procedure` WHERE ccName = $ccName;
                                END IF;*/

                                SET $res = -1;
                                SELECT COUNT(1)
                                       INTO $res
                                FROM ccContact
                                WHERE ccName = $ccName
                                    AND ((SELECT DATEDIFF(NOW(), MIN(Created)) FROM ccContact WHERE clID = $clID)<($RecallDaysCount*$RecallAfterPeriod));
                                IF ($res < 0)THEN
                                    DELETE FROM `Recall_data_procedure` WHERE ccName = $ccName AND rcID = $rcID;
                                    UPDATE crmClientEx SET isCallDate = FALSE WHERE clID = $clID;
                                END IF;
                                SET $res = -1;
                                SELECT COUNT(1)
                                       INTO $res
                                FROM ccContact
                                WHERE ccName = $ccName
                                  AND IsMissed = TRUE
                                  AND IsOut = FALSE
                                  AND ((SELECT DATEDIFF(NOW(), MIN(Created)) FROM ccContact WHERE ccName = $ccName AND IsMissed = TRUE)<($RecallDaysCount*$RecallAfterPeriod));
                                IF ($res <= 0)THEN
                                    DELETE FROM `Recall_data_procedure` WHERE ccName = $ccName;
                                END IF;
                            -- END IF;
                        IF($id IS NULL OR $id = 0)THEN
                            SET $ccName = NULL;
                        END IF;
                        END IF;
                     END WHILE;
                    IF ((SELECT COUNT(1) FROM `Recall_data_procedure`) > 0) THEN
                        SET @s = CONCAT('SELECT `clID`
                                  , `clName`
                                  , `ccID`
                                  , `ccName`
                                  , `callerID`
                                  , `SleepTime`
                                  , `RecallAfterMin`
                                  , `destination`
                                  , `destdata`
                                  , IF(destination = 101408, (SELECT context FROM ast_custom_destination WHERE cdID = r.destdata), NULL) destdataName
                                  , `target`
                                  , `AutoDial`
                                  , `ffID`
                                  , `rcID`
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
                                  , `emID`
                                  , `emName`
                                  , `sipID`
                                  , `sipName`
                                  , `ActDate`
                                  , `cusID`
                                  , `Account`
                                  , `Bank`
                                  , `TaxCode`
                                  , `RegCode`
                                  , `CertNumber`
                                  , `SortCode`
                                  , `OrgType`
                                  , `coID`
                                  , `uID`
                                  , NEXTVAL(dcID) dcID
                         FROM `Recall_data_procedure` r WHERE CURTIME() BETWEEN (SELECT TimeBegin FROM ast_recall WHERE rcID = r.rcID) AND ((SELECT TimeEnd FROM ast_recall WHERE rcID = r.rcID))
		  	                    		  	AND LOCATE(DAYOFWEEK(NOW()), (SELECT DaysCall FROM ast_recall WHERE rcID = r.rcID))
                                        LIMIT ', $qtyContact, ';');

                        PREPARE stmt FROM @s;
                        EXECUTE stmt;
                        DEALLOCATE PREPARE stmt;
                        --
                        INSERT INTO current_recall
                        SELECT rcID, Aid, clID
                        FROM `Recall_data_procedure`
                        LIMIT $qtyContact;
                        --
                        UPDATE crmClientEx SET isDial = 1 WHERE clID IN (SELECT clID FROM current_recall);
                        --
                        DELETE FROM `current_recall`;
                        -- DELETE FROM `Recall_data_procedure` ORDER BY clID LIMIT $qtyContact;
                        DELETE FROM `Recall_data_procedure` LIMIT $qtyContact;
                    ELSE
                        call RAISE(77069, 'Нет номеров для прозвона!');
                    END IF;
                ELSE
                    call RAISE(77069, 'Нет номеров для прозвона!');
                END IF;

            END IF;
        ELSE
            -- SELECT NULL;
             call RAISE(77115, NULL);
        END IF;
    --
    END IF;
END $$
DELIMITER ;
--
