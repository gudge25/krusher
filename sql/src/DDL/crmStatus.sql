CREATE TABLE IF NOT EXISTS `crmStatus` (
	`clID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`ffID` INT(11) NOT NULL DEFAULT '0',
	`ccStatus` SMALLINT(6) NOT NULL,
	`clStatus` SMALLINT(6) NOT NULL,
	`isFixed` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`clID`),
	INDEX `IX_crmStatus_clStatus` (`clStatus`),
	INDEX `IX_crmStatus_ccStatus` (`ccStatus`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`),
	INDEX `isFixed` (`isFixed`),
	INDEX `ffID` (`ffID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
