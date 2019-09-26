CREATE TABLE IF NOT EXISTS `stCategory`  (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`pctID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`pctName` VARCHAR(50) NOT NULL,
	`ParentID` INT(11) NULL DEFAULT NULL,
	`isActive` INT(11) NOT NULL DEFAULT '0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`pctID`),
	INDEX `FK_stCategory_stCategory` (`ParentID`),
	INDEX `pctName` (`pctName`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
