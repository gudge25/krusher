CREATE TABLE IF NOT EXISTS `fmQuestion` (
	`HIID` BIGINT(20) NOT NULL,
	`qID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`qName` VARCHAR(500) NOT NULL,
	`ParentID` INT(11) NULL DEFAULT NULL,
	`tpID` INT(11) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`qID`),
	INDEX `FK_fmQuestion_fmFormType` (`tpID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `qName` (`qName`(333)),
	INDEX `ParentID` (`ParentID`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
