CREATE TABLE IF NOT EXISTS `ccCommentList` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`comID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`comName` VARCHAR(200) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	INDEX `comID` (`comID`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
