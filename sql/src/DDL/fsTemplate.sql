CREATE TABLE IF NOT EXISTS `fsTemplate` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`ftID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`ftName` VARCHAR(50) NOT NULL,
	`delimiter` CHAR(1) NOT NULL,
	`Encoding` VARCHAR(32) NOT NULL,
	`isPerson` BIT(1) NOT NULL DEFAULT b'0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`ftID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `ftName` (`ftName`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
