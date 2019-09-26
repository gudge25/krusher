CREATE TABLE IF NOT EXISTS `ccComment`  (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`cccID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`dcID` INT(11) NOT NULL,
	`comID` INT(11) NOT NULL,
	`comName` VARCHAR(200) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`cccID`),
	INDEX `FK_ccComment_ccCommentList` (`comID`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `dcID` (`dcID`),
	INDEX `comName` (`comName`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
