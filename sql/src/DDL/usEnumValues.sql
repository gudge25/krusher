CREATE TABLE IF NOT EXISTS `usEnumValue` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`tvID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`tyID` INT(11) NULL DEFAULT NULL,
	`Name` VARCHAR(100) NULL DEFAULT NULL,
	`isActive` BIT(1) NULL DEFAULT b'1' COMMENT 'Статус активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	UNIQUE INDEX `tvID_Aid_tyID` (`tvID`, `Aid`, `tyID`),
	INDEX `Name` (`Name`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
