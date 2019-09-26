CREATE TABLE IF NOT EXISTS `dcType` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL,
	`dctID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`dctName` VARCHAR(100) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dctID`),
	INDEX `Aid` (`Aid`),
	INDEX `dctName` (`dctName`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
