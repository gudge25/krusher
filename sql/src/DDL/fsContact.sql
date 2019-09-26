CREATE TABLE IF NOT EXISTS `fsContact` (
	`fccID` INT(11) NOT NULL AUTO_INCREMENT,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`fclID` INT(11) NOT NULL,
	`fccName` VARCHAR(250) NOT NULL,
	`ftType` INT(11) NOT NULL,
	`ftDelim` VARCHAR(12) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`fccID`),
	INDEX `IX_fsContact_fclID` (`fclID`),
	INDEX `IX_fsContact_ftType` (`ftType`),
	INDEX `IX_fsContact_ffID` (`fccName`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
