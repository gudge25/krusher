CREATE TABLE IF NOT EXISTS `ccContact` (
    `HIID` BIGINT(20) NOT NULL COMMENT 'временная метка',
    `dcID` INT(11) NOT NULL COMMENT 'ID документа',
    `Aid` INT(11) NOT NULL DEFAULT '0',
    `ccID` INT(11) NULL DEFAULT NULL COMMENT 'ID контакта клиента',
    `ccName` VARCHAR(50) NOT NULL COMMENT 'контакт',
    `IsOut` BIT(1) NOT NULL COMMENT 'исходящий или входящий',
    `SIP` VARCHAR(50) NULL DEFAULT NULL COMMENT 'сип имя',
    `LinkFile` VARCHAR(200) NULL DEFAULT NULL COMMENT 'ссылка на файл',
    `duration` INT(11) NULL DEFAULT NULL,
    `billsec` INT(11) NULL DEFAULT NULL,
    `holdtime` INT(11) NULL DEFAULT NULL,
    `serviceLevel` INT(11) NULL DEFAULT NULL,
    `channel` VARCHAR(50) NULL DEFAULT NULL,
    `trID` INT(11) NULL DEFAULT NULL,
    `isAutocall` BIT(1) NOT NULL DEFAULT b'0',
    `CauseCode` INT(11) NULL DEFAULT NULL,
    `CauseDesc` VARCHAR(200) NULL DEFAULT NULL,
    `CauseWho` INT(11) NULL DEFAULT NULL,
    `CallType` INT(11) NULL DEFAULT NULL,
    `IsMissed` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак, что на этот пропущенный звонок еще не перезвонили',
    `id_autodial` INT(11) NOT NULL DEFAULT '0',
    `id_scenario` INT(11) NOT NULL DEFAULT '0',
    `IsTarget` BIT(1) NULL DEFAULT NULL COMMENT 'Достигнута ли цели по сценарию автообзвона',
    `target` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Данные о достижения цели (например последовательность нажатия цифр в IVR)',
    `ccStatus` INT(11) NULL DEFAULT NULL COMMENT 'Статус звонка',
    `emID` INT(11) NULL DEFAULT NULL COMMENT 'ID ответственного',
    `clID` INT(11) NULL DEFAULT NULL COMMENT 'ID клиента',
    `ffID` INT(11) NULL DEFAULT NULL COMMENT 'ID базы',
    `uID` BIGINT(20) NULL DEFAULT NULL COMMENT 'Уникальный идентификатор звонка',
    `coID` INT(11) NULL DEFAULT '0',
    `destination` INT(11) NULL DEFAULT NULL,
    `destdata` INT(11) NULL DEFAULT NULL,
    `destdata2` VARCHAR(100) NULL DEFAULT NULL,
    `transferFrom` VARCHAR(250) NULL DEFAULT NULL,
    `transferTo` VARCHAR(250) NULL DEFAULT NULL,
    `Comment` VARCHAR(250) NULL DEFAULT NULL,
    `ContactStatus` INT(11) NULL DEFAULT NULL,
    `isActive` BIT(1) NULL DEFAULT b'0' COMMENT 'Признак активности записи',
    `upTime` DATETIME NULL DEFAULT NULL,
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
    PRIMARY KEY (`dcID`),
    INDEX `Aid` (`Aid`),
    INDEX `Created` (`Created`),
    INDEX `IsMissed` (`IsMissed`),
    INDEX `id_autodial` (`id_autodial`),
    INDEX `id_scenario` (`id_scenario`),
    INDEX `emID` (`emID`),
    INDEX `clID` (`clID`),
    INDEX `ffID` (`ffID`),
    INDEX `IsOut` (`IsOut`),
    INDEX `isAutocall` (`isAutocall`),
    INDEX `channel` (`channel`),
    INDEX `CallType` (`CallType`),
    INDEX `isActive` (`isActive`),
    INDEX `IsTarget` (`IsTarget`),
    INDEX `ccStatus` (`ccStatus`),
    INDEX `HIID` (`HIID`),
    INDEX `uID` (`uID`),
    INDEX `target` (`target`),
    INDEX `SIP` (`SIP`),
    INDEX `duration` (`duration`),
    INDEX `LinkFile` (`LinkFile`),
    INDEX `coID` (`coID`),
    INDEX `ccName` (`ccName`),
    INDEX `ccID` (`ccID`),
    INDEX `destination` (`destination`),
    INDEX `destdata` (`destdata`),
    INDEX `destdata2` (`destdata2`),
    INDEX `ContactStatus` (`ContactStatus`),
    INDEX `serviceLevel` (`serviceLevel`),
    INDEX `holdtime` (`holdtime`),
    INDEX `billsec` (`billsec`),
    INDEX `upTime` (`upTime`),
    INDEX `trID` (`trID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
