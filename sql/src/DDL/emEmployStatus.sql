CREATE TABLE IF NOT EXISTS `emStatus` (
    `HIID` BIGINT NULL DEFAULT '0',
    `emsID` INT(11) NOT NULL AUTO_INCREMENT,
    `Aid` INT(11) NOT NULL DEFAULT '0',
    `emID` INT NULL DEFAULT '0',
    `onlineStatus` INT NULL DEFAULT '0',
    `timeSpent` INT UNSIGNED NULL DEFAULT '0',
    `isCurrent` BIT(1) NULL DEFAULT b'0',
    `isActive` BIT(1) NULL DEFAULT b'1',
    `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `HIID` (`HIID`),
    PRIMARY KEY (`emsID`),
    INDEX `emID` (`emID`),
    INDEX `onlineStatus` (`onlineStatus`),
    INDEX `timeSpent` (`timeSpent`),
    INDEX `isActive` (`isActive`),
    INDEX `Created` (`Created`),
    INDEX `isCurrent` (`isCurrent`),
    INDEX `Aid` (`Aid`)
)
  COMMENT='Статусы сотрудников'
  COLLATE='utf8_general_ci'
  ENGINE=MyISAM
;
--
