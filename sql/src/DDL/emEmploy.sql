CREATE TABLE IF NOT EXISTS `emEmploy` (
                                          `HIID` BIGINT(20) NOT NULL,
                                          `emID` INT(11) NOT NULL,
                                          `Aid` INT(11) NOT NULL DEFAULT '0',
                                          `SipAccount` INT(11) NULL DEFAULT NULL COMMENT 'Уникальный ID, служащий логином при подлкючении телефона',
                                          `emName` VARCHAR(200) NOT NULL,
                                          `LoginName` VARCHAR(30) NOT NULL,
                                          `Password` VARCHAR(100) NOT NULL COMMENT 'Пароль пользователя',
                                          `Token` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Token пользователя',
                                          `TokenExpiredDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                          `url` VARCHAR(250) NOT NULL COMMENT 'URL клиента',
                                          `ManageID` INT(11) NULL DEFAULT NULL,
                                          `roleID` INT(11) NOT NULL DEFAULT '0',
                                          `sipID` INT(11) NULL DEFAULT NULL,
                                          `sipName` VARCHAR(50) NULL DEFAULT NULL,
                                          `Queue` VARCHAR(128) NULL DEFAULT NULL,
                                          `CompanyID` INT(11) NULL DEFAULT NULL COMMENT 'Внешний ID, для интеграции',
                                          `onlineStatus` INT(11) NULL DEFAULT NULL COMMENT 'Статус пользователя',
                                          `uID` BIGINT(20) NULL DEFAULT NULL,
                                          `coID` VARCHAR(50) NULL DEFAULT NULL,
                                          `pauseDelay` INT(11) NULL DEFAULT NULL,
                                          `isActive` BIT(1) NOT NULL,
                                          `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
                                          `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
                                          PRIMARY KEY (`emID`),
                                          UNIQUE INDEX `LoginName_url` (`LoginName`, `url`),
                                          INDEX `IX_emEmploy_Queue` (`Queue`),
                                          INDEX `IX_emEmploy_SipNum` (`sipName`),
                                          INDEX `FK_emEmploy_emEmploy` (`ManageID`),
                                          INDEX `LoginName_Password` (`LoginName`, `Password`),
                                          INDEX `Token_TokenExpiredDate_IsActive` (`Token`, `TokenExpiredDate`, `isActive`),
                                          INDEX `Created` (`Created`),
                                          INDEX `Aid` (`Aid`),
                                          INDEX `SipAccount` (`SipAccount`),
                                          INDEX `roleID` (`roleID`),
                                          INDEX `HIID` (`HIID`),
                                          INDEX `idSIP` (`sipID`),
                                          INDEX `coID` (`coID`),
                                          INDEX `CompanyID` (`CompanyID`),
                                          INDEX `emName` (`emName`),
                                          INDEX `onlineStatus` (`onlineStatus`),
                                          INDEX `uID` (`uID`),
                                          INDEX `pauseDelay` (`pauseDelay`)
)
    COLLATE='utf8_general_ci'
    ENGINE=MyISAM
;
--
CREATE TABLE IF NOT EXISTS DUP_emEmploy
(
    RowID            BIGINT               NOT NULL auto_increment
    , OLD_HIID       BIGINT(20) UNSIGNED  NULL
    , DUP_InsTime    DATETIME             NOT NULL
    , DUP_action     ENUM('I','U','D')    NOT NULL
    , DUP_HostName   VARCHAR(128)         NOT NULL
    , DUP_AppName    INT(11)              NOT NULL
    , `HIID` BIGINT(20) NULL DEFAULT NULL
    , `emID` INT(11) NOT NULL
    , `Aid` INT(11) NOT NULL DEFAULT '0'
    , `SipAccount` INT(11) NULL DEFAULT NULL COMMENT 'Уникальный ID, служащий логином при подлкючении телефона'
    , `emName` VARCHAR(200) NOT NULL
    , `LoginName` VARCHAR(30) NOT NULL
    , `Password` VARCHAR(100) NOT NULL COMMENT 'Пароль пользователя'
    , `Token` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Token пользователя'
    , `TokenExpiredDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP
    , `url` VARCHAR(250) NOT NULL COMMENT 'URL клиента'
    , `ManageID` INT(11) NULL DEFAULT NULL
    , `roleID` INT(11) NOT NULL DEFAULT '0'
    , `sipID` INT(11) NULL DEFAULT NULL
    , `sipName` VARCHAR(50) NULL DEFAULT NULL
    ,  `Queue` VARCHAR(128) NULL DEFAULT NULL
    , `CompanyID` INT(11) NULL DEFAULT NULL COMMENT 'Внешний ID, для интеграции'
    , `onlineStatus` INT(11) NULL DEFAULT NULL COMMENT 'Статус пользователя'
    , `uID` BIGINT(20) NULL DEFAULT NULL
    , `coID` VARCHAR(50) NULL DEFAULT NULL
    , `pauseDelay` INT(11) NULL DEFAULT NULL
    , `isActive` BIT(1) NOT NULL
    , `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    , PRIMARY KEY (`RowID`),
    INDEX `IX_emEmploy_Queue` (`Queue`),
    INDEX `IX_emEmploy_SipNum` (`sipName`),
    INDEX `FK_emEmploy_emEmploy` (`ManageID`),
    INDEX `LoginName_Password` (`LoginName`, `Password`),
    INDEX `Token_TokenExpiredDate_IsActive` (`Token`, `TokenExpiredDate`, `isActive`),
    INDEX `Created` (`Created`),
    INDEX `Aid` (`Aid`),
    INDEX `SipAccount` (`SipAccount`),
    INDEX `roleID` (`roleID`),
    INDEX `HIID` (`HIID`),
    INDEX `idSIP` (`sipID`),
    INDEX `coID` (`coID`),
    INDEX `CompanyID` (`CompanyID`),
    INDEX `emName` (`emName`),
    INDEX `onlineStatus` (`onlineStatus`),
    INDEX `uID` (`uID`)
)
    COLLATE='utf8_general_ci'
    ENGINE=MyISAM
;
--
