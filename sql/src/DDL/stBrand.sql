CREATE TABLE IF NOT EXISTS `stBrand` (
	`HIID` BIGINT(20) NOT NULL,
	`bID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`bName` VARCHAR(50) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`CreatedBy` INT(11) NOT NULL,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения запииси',
	`ChangedBy` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`bID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `bName` (`bName`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `ChangedBy` (`ChangedBy`),
	INDEX `Changed` (`Changed`),
	INDEX `CreatedBy` (`CreatedBy`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
