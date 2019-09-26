CREATE TABLE IF NOT EXISTS `crmTag` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`tagID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`tagName` VARCHAR(50) NOT NULL,
	`tagDesc` VARCHAR(255) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`tagID`),
	INDEX `Aid` (`Aid`),
	INDEX `isActive` (`isActive`),
	INDEX `tagName` (`tagName`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
