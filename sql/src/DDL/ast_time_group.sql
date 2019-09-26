CREATE TABLE IF NOT EXISTS `ast_time_group` (
	`HIID` BIGINT NULL DEFAULT '0',
	`tgID` INT NOT NULL DEFAULT '0',
	`Aid` INT NULL DEFAULT '0',
	`tgName` VARCHAR(50) NULL DEFAULT NULL,
	`destination` INT(11) NULL DEFAULT NULL,
	`destdata` INT(11) NULL DEFAULT NULL,
	`destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`invalid_destination` INT(11) NULL DEFAULT NULL,
	`invalid_destdata` INT(11) NULL DEFAULT NULL,
	`invalid_destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`isActive` BIT NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	PRIMARY KEY (`tgID`),
	INDEX `Aid` (`Aid`),
	INDEX `tgName` (`tgName`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `destination` (`destination`),
	INDEX `destdata` (`destdata`),
	INDEX `destdata2` (`destdata2`),
	INDEX `invalid_destination` (`invalid_destination`),
	INDEX `invalid_destdata` (`invalid_destdata`),
	INDEX `invalid_destdata2` (`invalid_destdata2`)
)
COMMENT='Таблица категорий временных настроек'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
