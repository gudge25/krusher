CREATE TABLE IF NOT EXISTS `fmFormItem` (
	`HIID` BIGINT(20) NOT NULL,
	`fiID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`dcID` INT(11) NOT NULL,
	`qID` INT(11) NOT NULL,
	`qName` VARCHAR(300) NOT NULL,
	`qiID` INT(11) NULL DEFAULT NULL,
	`qiAnswer` VARCHAR(100) NULL DEFAULT NULL,
	`qiComment` VARCHAR(200) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`fiID`),
	INDEX `FK_fmFormItem_fmForm` (`dcID`),
	INDEX `Aid` (`Aid`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `qID` (`qID`),
	INDEX `qName` (`qName`),
	INDEX `qiID` (`qiID`),
	INDEX `qiAnswer` (`qiAnswer`),
	INDEX `qiComment` (`qiComment`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
