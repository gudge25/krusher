CREATE TABLE IF NOT EXISTS `crmTagList` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`ctgID` INT(11) NOT NULL,
	`tagID` INT(11) NOT NULL,
	`clID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	UNIQUE INDEX `crmTag_tagID_clID` (`tagID`, `clID`),
	INDEX `FK_crmTag_crmClient` (`clID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `ctgID` (`ctgID`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
