CREATE TABLE IF NOT EXISTS `crmCompany` (
	`HIID` BIGINT(20) NULL DEFAULT '0',
	`coID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`coName` VARCHAR(100) NULL DEFAULT NULL,
	`coDescription` VARCHAR(100) NULL DEFAULT NULL,
    `inMessage` TEXT NULL DEFAULT NULL,
    `outMessage` TEXT NULL DEFAULT NULL,
    `pauseDelay` INT(11) NULL DEFAULT NULL,
    `isActivePOPup` BIT(1) NULL DEFAULT b'1',
    `isRingingPOPup` BIT(1) NULL DEFAULT b'1',
    `isUpPOPup` BIT(1) NULL DEFAULT b'1',
    `isCCPOPup` BIT(1) NULL DEFAULT b'1',
    `isClosePOPup` BIT(1) NULL DEFAULT b'1',
	`isActive` BIT(1) NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`coID`),
	INDEX `HIID` (`HIID`),
	INDEX `coName` (`coName`),
	INDEX `isActive` (`isActive`),
	INDEX `coDescription` (`coDescription`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`),
    INDEX `pauseDelay` (`pauseDelay`),
    INDEX `isActivePOPup` (`isActivePOPup`),
    INDEX `isRingingPOPup` (`isRingingPOPup`),
    INDEX `isUpPOPup` (`isUpPOPup`),
    INDEX `isCCPOPup` (`isCCPOPup`),
    INDEX `isClosePOPup` (`isClosePOPup`)
)
ENGINE=MyISAM
;
--
