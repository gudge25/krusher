CREATE TABLE IF NOT EXISTS `dcDocTemplate` (
	`HIID` BIGINT(20) NOT NULL,
	`dtID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`dtName` VARCHAR(100) NOT NULL,
	`dcTypeID` TINYINT(4) NOT NULL,
	`dtTemplate` TEXT NOT NULL,
	`isDefault` BIT(1) NOT NULL DEFAULT b'0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dtID`),
	UNIQUE INDEX `UIX_dcDocTemplate_dtID_dcTypeID` (`dtID`),
	INDEX `FK_dcDocTemplate_dcType` (`dcTypeID`),
	INDEX `Aid` (`Aid`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `isDefault` (`isDefault`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
