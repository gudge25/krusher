CREATE TABLE IF NOT EXISTS `fmForm` (
	`HIID` BIGINT(20) NOT NULL,
	`dcID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`tpID` INT(11) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dcID`),
	INDEX `FK_fmForm_fmFormType` (`tpID`),
	INDEX `HIID` (`HIID`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
