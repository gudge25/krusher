CREATE TABLE IF NOT EXISTS `fsTemplateItem` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`ftiID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`ftID` INT(11) NOT NULL,
	`ftType` INT(11) NOT NULL,
	`ftDelim` VARCHAR(12) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`ftiID`),
	INDEX `IX_fsTemplateItem_ftID` (`ftID`),
	INDEX `IX_fsTemplateItem_ftType` (`ftType`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
