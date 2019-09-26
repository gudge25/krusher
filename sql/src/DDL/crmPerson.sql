CREATE TABLE IF NOT EXISTS crmPerson (
	`HIID` BIGINT(20) NOT NULL,
	`pnID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`clID` INT(11) NOT NULL,
	`pnName` VARCHAR(100) NOT NULL,
	`Post` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`pnID`),
	INDEX `FK_crmPerson_crmClient` (`clID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
