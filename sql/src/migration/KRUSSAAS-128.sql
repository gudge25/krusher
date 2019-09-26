CREATE TABLE IF NOT EXISTS `ccContactRecords` (
                                                  `idCR` INT(11) NOT NULL AUTO_INCREMENT,
                                                  `Aid` INT(11) NOT NULL DEFAULT '0',
                                                  `link` VARCHAR(250) NULL DEFAULT NULL,
                                                  `statusReady` INT(11) NULL DEFAULT '103801',
                                                  `DateFrom` DATETIME NULL DEFAULT NULL,
                                                  `DateTo` DATETIME NULL DEFAULT NULL,
                                                  `dcIDs` VARCHAR(250) NULL DEFAULT NULL,
                                                  `emIDs` VARCHAR(250) NULL DEFAULT NULL,
                                                  `dcStatuss` VARCHAR(250) NULL DEFAULT NULL,
                                                  `ffIDs` VARCHAR(250) NULL DEFAULT NULL,
                                                  `isMissed` BIT(1) NULL DEFAULT NULL,
                                                  `isUnique` BIT(1) NULL DEFAULT NULL,
                                                  `CallTypes` VARCHAR(250) NULL DEFAULT NULL,
                                                  `ccNames` VARCHAR(250) NULL DEFAULT NULL,
                                                  `channels` VARCHAR(250) NULL DEFAULT NULL,
                                                  `comparison` VARCHAR(250) NULL DEFAULT NULL,
                                                  `billsec` VARCHAR(250) NULL DEFAULT NULL,
                                                  `clIDs` VARCHAR(250) NULL DEFAULT NULL,
                                                  `IsOut` BIT(1) NULL DEFAULT NULL,
                                                  `id_autodials` VARCHAR(250) NULL DEFAULT NULL,
                                                  `id_scenarios` VARCHAR(250) NULL DEFAULT NULL,
                                                  `ManageIDs` VARCHAR(250) NULL DEFAULT NULL,
                                                  `target` VARCHAR(250) NULL DEFAULT NULL,
                                                  `coIDs` VARCHAR(250) NULL DEFAULT NULL,
                                                  `destination` INT(11) NULL DEFAULT NULL,
                                                  `destdata` INT(11) NULL DEFAULT NULL,
                                                  `destdata2` VARCHAR(250) NULL DEFAULT NULL,
                                                  `ContactStatuses` INT(11) NULL DEFAULT NULL,
                                                  `emID` INT(11) NULL DEFAULT NULL,
                                                  `isActive` BIT(1) NULL DEFAULT b'1',
                                                  `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                  `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                                  PRIMARY KEY (`idCR`),
                                                  INDEX `statusReady` (`statusReady`),
                                                  INDEX `Aid` (`Aid`),
                                                  INDEX `isActive` (`isActive`),
                                                  INDEX `Created` (`Created`),
                                                  INDEX `DateFrom` (`DateFrom`),
                                                  INDEX `DateTo` (`DateTo`),
                                                  INDEX `dcIDs` (`dcIDs`),
                                                  INDEX `emIDs` (`emIDs`),
                                                  INDEX `dcStatuss` (`dcStatuss`),
                                                  INDEX `ffIDs` (`ffIDs`),
                                                  INDEX `isMissed` (`isMissed`),
                                                  INDEX `isUnique` (`isUnique`),
                                                  INDEX `CallTypes` (`CallTypes`),
                                                  INDEX `ccNames` (`ccNames`),
                                                  INDEX `channels` (`channels`),
                                                  INDEX `comparison` (`comparison`),
                                                  INDEX `clIDs` (`clIDs`),
                                                  INDEX `billsec` (`billsec`),
                                                  INDEX `IsOut` (`IsOut`),
                                                  INDEX `id_autodials` (`id_autodials`),
                                                  INDEX `id_scenarios` (`id_scenarios`),
                                                  INDEX `ManageIDs` (`ManageIDs`),
                                                  INDEX `target` (`target`),
                                                  INDEX `coIDs` (`coIDs`),
                                                  INDEX `destination` (`destination`),
                                                  INDEX `destdata` (`destdata`),
                                                  INDEX `destdata2` (`destdata2`),
                                                  INDEX `ContactStatuses` (`ContactStatuses`),
                                                  INDEX `emID` (`emID`)
)
    COMMENT='Заявка на экпорт записей разговоров - массово'
    ENGINE=MyISAM
;
--
CREATE TABLE IF NOT EXISTS `mp_IntegrationList` (	`HIID` BIGINT(20) NOT NULL DEFAULT '0',
                                                    `mpID` INT(11) NOT NULL AUTO_INCREMENT,
                                                    `Aid` INT(11) NOT NULL DEFAULT '0',
                                                    `mpName` VARCHAR(50) NULL DEFAULT NULL,
                                                    `mpDescription` VARCHAR(500) NULL DEFAULT NULL,
                                                    `mpLinkProvider` VARCHAR(100) NULL DEFAULT NULL,
                                                    `mpCategory` INT(11) NULL DEFAULT '103901',
                                                    `mpLogo` VARCHAR(250) NULL DEFAULT NULL,
                                                    `mpPrice` DECIMAL(10,2) NULL DEFAULT '0',
                                                    `countInstalls` INT(11) NULL DEFAULT '0',
                                                    `order` INT(11) NULL DEFAULT '0',
                                                    `isActive` BIT(1) NULL DEFAULT b'1',
                                                    `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                    `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
                                                    PRIMARY KEY (`mpID`),
                                                    INDEX `mpName` (`mpName`),
                                                    INDEX `mpLinkProvider` (`mpLinkProvider`),
                                                    INDEX `mpCategory` (`mpCategory`),
                                                    INDEX `mpLogo` (`mpLogo`),
                                                    INDEX `mpPrice` (`mpPrice`),
                                                    INDEX `countInstalls` (`countInstalls`),
                                                    INDEX `Created` (`Created`),
                                                    INDEX `isActive` (`isActive`),
                                                    INDEX `order` (`order`)
)
    COMMENT='Список механизмов интеграции'
    ENGINE=MyISAM
;
--
CREATE TABLE IF NOT EXISTS  `mp_IntegrationInstall` (	`HIID` BIGINT(20) NOT NULL DEFAULT '0',
                                                        `mpiID` INT(11) NOT NULL,
                                                        `Aid` INT(11) NOT NULL DEFAULT '0',
                                                        `mpID` INT(11) NOT NULL DEFAULT '0',
                                                        `login` VARCHAR(50) NULL DEFAULT NULL,
                                                        `pass` VARCHAR(50) NULL DEFAULT NULL,
                                                        `token` VARCHAR(50) NULL DEFAULT NULL,
                                                        `link` VARCHAR(50) NULL DEFAULT NULL,
                                                        `isActive` BIT(1) NULL DEFAULT b'1',
                                                        `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                        `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
                                                        PRIMARY KEY (`mpiID`),
                                                        INDEX `Aid` (`Aid`),
                                                        INDEX `mpID` (`mpID`),
                                                        INDEX `login` (`login`),
                                                        INDEX `pass` (`pass`),
                                                        INDEX `token` (`token`),
                                                        INDEX `link` (`link`),
                                                        INDEX `isActive` (`isActive`),
                                                        INDEX `Created` (`Created`)
)
    COMMENT='Установки из маркет плейса'
    ENGINE=MyISAM
;

call us_InsNewEnums(60, 5, 'CompanyID', TRUE);
call us_InsNewEnums(7012, 7, 'WAITING', TRUE);
call us_InsNewEnums(7013, 7, 'SENT', TRUE);
call us_InsNewEnums(7014, 7, 'DELIVERED', TRUE);
call us_InsNewEnums(7015, 7, 'UNDELIVERED', TRUE);
call us_InsNewEnums(7016, 7, 'EXPIRED', TRUE);
-- Records status ready
call us_InsNewEnums(103801, 1038, 'new', TRUE);
call us_InsNewEnums(103802, 1038, 'working', TRUE);
call us_InsNewEnums(103803, 1038, 'ready', TRUE);
-- MarketPlace types
call us_InsNewEnums(103901, 1039, 'All', TRUE);
call us_InsNewEnums(103902, 1039, 'Telefony', TRUE);
call us_InsNewEnums(103903, 1039, 'Autodial', TRUE);

CREATE SEQUENCE IF NOT EXISTS mpiID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS mpID START WITH 1 INCREMENT BY 1;
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContactRecords' AND COLUMN_NAME='emID'
                             ) > 0,
                             "SELECT '+128_674'",
                             "ALTER TABLE `ccContactRecords`
                                    ADD COLUMN `emID` INT(11) NULL DEFAULT NULL AFTER `ContactStatuses`,
                                    ADD INDEX `DateFrom` (`DateFrom`),
                                    ADD INDEX `DateTo` (`DateTo`),
                                    ADD INDEX `dcIDs` (`dcIDs`),
                                    ADD INDEX `emIDs` (`emIDs`),
                                    ADD INDEX `dcStatuss` (`dcStatuss`),
                                    ADD INDEX `ffIDs` (`ffIDs`),
                                    ADD INDEX `isMissed` (`isMissed`),
                                    ADD INDEX `isUnique` (`isUnique`),
                                    ADD INDEX `CallTypes` (`CallTypes`),
                                    ADD INDEX `ccNames` (`ccNames`),
                                    ADD INDEX `channels` (`channels`),
                                    ADD INDEX `comparison` (`comparison`),
                                    ADD INDEX `clIDs` (`clIDs`),
                                    ADD INDEX `billsec` (`billsec`),
                                    ADD INDEX `IsOut` (`IsOut`),
                                    ADD INDEX `id_autodials` (`id_autodials`),
                                    ADD INDEX `id_scenarios` (`id_scenarios`),
                                    ADD INDEX `ManageIDs` (`ManageIDs`),
                                    ADD INDEX `target` (`target`),
                                    ADD INDEX `coIDs` (`coIDs`),
                                    ADD INDEX `destination` (`destination`),
                                    ADD INDEX `destdata` (`destdata`),
                                    ADD INDEX `destdata2` (`destdata2`),
                                    ADD INDEX `ContactStatuses` (`ContactStatuses`),
                                    ADD INDEX `emID` (`emID`);"
                     ));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `cc_Sms` (
                                        `HIID` BIGINT(20) NULL DEFAULT '0',
                                        `dcID` INT(11) NOT NULL DEFAULT '0',
                                        `Aid` INT(11) NULL DEFAULT '0',
                                        `emID` INT(11) NULL DEFAULT '0',
                                        `timeSend` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                        `originator` VARCHAR(15) NULL DEFAULT NULL,
                                        `phone` BIGINT(20) NULL DEFAULT NULL,
                                        `text_sms` TEXT NULL DEFAULT NULL,
                                        `priority` INT(11) NULL DEFAULT '1',
                                        `statusSms` INT(11) NULL DEFAULT '7012',
                                        `IsOut` BIT(1) NULL DEFAULT b'1',
                                        `isActive` BIT(1) NULL DEFAULT b'1',
                                        `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
                                        `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
                                        PRIMARY KEY (`dcID`),
                                        INDEX `HIID` (`HIID`),
                                        INDEX `Aid` (`Aid`),
                                        INDEX `emID` (`emID`),
                                        INDEX `timeSend` (`timeSend`),
                                        INDEX `originator` (`originator`),
                                        INDEX `phone` (`phone`),
                                        INDEX `isActive` (`isActive`),
                                        INDEX `Created` (`Created`),
                                        INDEX `statusSms` (`statusSms`),
                                        INDEX `priority` (`priority`),
                                        INDEX `IsOut` (`IsOut`)
)
    COMMENT='Отправленные СМС'
    COLLATE='utf8_general_ci'
    ENGINE=MyISAM
;
--

CREATE TABLE IF NOT EXISTS `cc_SmsParts` (
                                             `id_part` INT(11) NOT NULL AUTO_INCREMENT,
                                             `dcID` INT(11) NOT NULL DEFAULT '0',
                                             `part_num` INT(11) NOT NULL DEFAULT '0',
                                             `supplier_id` INT(11) NOT NULL DEFAULT '0',
                                             `supplier_part_id` VARCHAR(50) NULL DEFAULT NULL,
                                             `statusDelivering` ENUM('SENT','DELIVERED','UNDELIVERED','EXPIRED') NOT NULL DEFAULT 'SENT',
                                             `sentTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                             `statusTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                             PRIMARY KEY (`id_part`),
                                             INDEX `dcID` (`dcID`),
                                             INDEX `statusDelivering` (`statusDelivering`),
                                             INDEX `part_num` (`part_num`),
                                             INDEX `supplier_id` (`supplier_id`),
                                             INDEX `sentTime` (`sentTime`),
                                             INDEX `statusTime` (`statusTime`),
                                             INDEX `supplier_part_id` (`supplier_part_id`)
)
    COMMENT='Части смс'
    COLLATE='utf8_general_ci'
    ENGINE=MyISAM
;

--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND COLUMN_NAME='coID'
                             ) > 0,
                             "SELECT '+128_240'",
                             "ALTER TABLE `emEmploy`
                                ADD COLUMN `coID` INT NULL DEFAULT NULL AFTER `uID`,
                                ADD INDEX `coID` (`coID`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'DUP_emEmploy' AND COLUMN_NAME='coID'
                             ) > 0,
                             "SELECT '+128_252'",
                             "ALTER TABLE `DUP_emEmploy`
                                    ADD COLUMN `coID` INT NULL DEFAULT NULL AFTER `uID`,
                                    ADD INDEX `coID` (`coID`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND COLUMN_NAME='trID'
                             ) > 0,
                             "SELECT '+128_264'",
                             "ALTER TABLE `ccContact`
                                    ADD COLUMN `trID` INT NULL DEFAULT NULL AFTER `channel`,
                                    ADD INDEX `trID` (`trID`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'mp_IntegrationInstall' AND COLUMN_NAME='data1'
                             ) > 0,
                             "SELECT '+128_276'",
                             "ALTER TABLE `mp_IntegrationInstall`
                                    ADD COLUMN `data1` VARCHAR(250) NULL DEFAULT NULL AFTER `link`,
                                    ADD COLUMN `data2` VARCHAR(250) NULL DEFAULT NULL AFTER `data1`,
                                    ADD COLUMN `data3` VARCHAR(250) NULL DEFAULT NULL AFTER `data2`,
                                    ADD INDEX `data1` (`data1`),
                                    ADD INDEX `data2` (`data2`),
                                    ADD INDEX `data3` (`data3`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'cc_Sms' AND COLUMN_NAME='bulkID'
                             ) > 0,
                             "SELECT '+128_292'",
                             "ALTER TABLE `cc_Sms`
                                    ADD COLUMN `bulkID` INT NULL DEFAULT NULL AFTER `isActive`,
                                    ADD INDEX `bulkID` (`bulkID`);"
                     ));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `cc_SmsBulk` (
                                            `HIID` BIGINT(20) NULL DEFAULT NULL,
                                            `bulkID` INT(11) NULL DEFAULT NULL,
                                            `Aid` INT(11) NULL DEFAULT '0',
                                            `originator` VARCHAR(15) NULL DEFAULT NULL,
                                            `ffID` INT(11) NULL DEFAULT NULL,
                                            `text_sms` TEXT NULL DEFAULT NULL,
                                            `timeBegin` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                            `emID` INT(11) NULL DEFAULT NULL,
                                            `status` INT(11) NULL DEFAULT NULL,
                                            `isActive` BIT(1) NULL DEFAULT b'1',
                                            `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
                                            `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
                                            INDEX `HIID` (`HIID`),
                                            INDEX `bulkID` (`bulkID`),
                                            INDEX `Aid` (`Aid`),
                                            INDEX `originator` (`originator`),
                                            INDEX `ffID` (`ffID`),
                                            INDEX `timeBegin` (`timeBegin`),
                                            INDEX `isActive` (`isActive`),
                                            INDEX `Created` (`Created`),
                                            INDEX `emID` (`emID`),
                                            INDEX `status` (`status`)
)
    COMMENT='Массовая рассылка'
    ENGINE=MyISAM
;
--
CREATE SEQUENCE IF NOT EXISTS bulkID START WITH 1 INCREMENT BY 1;
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContactRecords' AND COLUMN_NAME='convertFormat'
                             ) > 0,
                             "SELECT '+128_335'",
                             "ALTER TABLE `ccContactRecords`
                                ADD COLUMN `convertFormat` INT(11) NULL DEFAULT NULL AFTER `emID`,
                                ADD INDEX `convertFormat` (`convertFormat`);"
                     ));
CALL query_exec(@s);
call us_IPInsEnum(0, 1040, 1, 'Formats of records', 1);
call us_InsNewEnums(104001, 1040, 'mp3', TRUE);
call us_InsNewEnums(104002, 1040, 'wav', TRUE);
call us_InsNewEnums(104003, 1040, 'ogg', TRUE);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND COLUMN_NAME='coID' AND  DATA_TYPE='varchar'
                             ) > 0,
                             "SELECT '+128_350'",
                             "ALTER TABLE `DUP_emEmploy`
                                CHANGE COLUMN `coID` `coID` VARCHAR(50) NULL DEFAULT NULL AFTER `uID`;"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND COLUMN_NAME='coID' AND  DATA_TYPE='varchar'
                             ) > 0,
                             "SELECT '+128_361'",
                             "ALTER TABLE `emEmploy`
                                CHANGE COLUMN `coID` `coID` VARCHAR(50) NULL DEFAULT NULL AFTER `uID`;"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND COLUMN_NAME='pauseDelay'
                             ) > 0,
                             "SELECT '+128_372'",
                             "ALTER TABLE `emEmploy`
                                ADD COLUMN `pauseDelay` INT NULL DEFAULT NULL AFTER `coID`,
                                ADD INDEX `pauseDelay` (`pauseDelay`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'DUP_emEmploy' AND COLUMN_NAME='pauseDelay'
                             ) > 0,
                             "SELECT '+128_372'",
                             "ALTER TABLE `DUP_emEmploy`
                                    ADD COLUMN `pauseDelay` INT NULL DEFAULT NULL AFTER `coID`,
                                    ADD INDEX `pauseDelay` (`pauseDelay`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emClient' AND COLUMN_NAME='pauseDelay'
                             ) > 0,
                             "SELECT '+128_384'",
                             "ALTER TABLE `emClient`
                                    ADD COLUMN `pauseDelay` INT(11) NULL DEFAULT NULL AFTER `vTigerID`,
                                    ADD INDEX `pauseDelay` (`pauseDelay`);"
                     ));
CALL query_exec(@s);
--
call us_InsNewEnums(103508, 1035, 'Post Processing', TRUE);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmCompany' AND COLUMN_NAME='pauseDelay'
                             ) > 0,
                             "SELECT '+128_384'",
                             "ALTER TABLE `crmCompany`
                                    ADD COLUMN `pauseDelay` INT NULL DEFAULT NULL AFTER `outMessage`,
                                    ADD INDEX `pauseDelay` (`pauseDelay`);"
                     ));
CALL query_exec(@s);
--
SET @s = (SELECT IF(
                             (SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmCompany' AND COLUMN_NAME='isActivePOPup'
                             ) > 0,
                             "SELECT '+128_422'",
                             "ALTER TABLE `crmCompany`
                                    ADD COLUMN `isActivePOPup` BIT NULL DEFAULT b'1' AFTER `pauseDelay`,
                                    ADD COLUMN `isRingingPOPup` BIT NULL DEFAULT b'1' AFTER `isActivePOPup`,
                                    ADD COLUMN `isUpPOPup` BIT NULL DEFAULT b'1' AFTER `isRingingPOPup`,
                                    ADD COLUMN `isCCPOPup` BIT NULL DEFAULT b'1' AFTER `isUpPOPup`,
                                    ADD COLUMN `isClosePOPup` BIT NULL DEFAULT b'1' AFTER `isCCPOPup`,
                                    ADD INDEX `isActivePOPup` (`isActivePOPup`),
                                    ADD INDEX `isRingingPOPup` (`isRingingPOPup`),
                                    ADD INDEX `isUpPOPup` (`isUpPOPup`),
                                    ADD INDEX `isCCPOPup` (`isCCPOPup`),
                                    ADD INDEX `isClosePOPup` (`isClosePOPup`);"
                     ));
CALL query_exec(@s);

call em_InsNewRole('Client', 5);
call em_InsNewRole('Validator', 6);








