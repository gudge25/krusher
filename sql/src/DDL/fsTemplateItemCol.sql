CREATE TABLE IF NOT EXISTS `fsTemplateItemCol` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`ftiID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`ColNumber` INT(11) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности клиента',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`ftiID`, `ColNumber`),
	INDEX `Aid` (`Aid`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
