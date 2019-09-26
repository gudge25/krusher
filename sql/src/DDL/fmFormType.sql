CREATE TABLE IF NOT EXISTS `fmFormType` (
	`HIID` BIGINT(20) NOT NULL,
	`tpID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`tpName` VARCHAR(250) NOT NULL,
	`ffID` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`tpID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `tpName` (`tpName`),
	INDEX `ffID` (`ffID`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
