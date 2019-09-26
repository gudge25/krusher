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
                          `bulkID` INT(11) NULL DEFAULT NULL,
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
                          INDEX `IsOut` (`IsOut`),
                          INDEX `bulkID` (`bulkID`)
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

