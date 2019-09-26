CREATE TABLE IF NOT EXISTS `ast_time_group_items` (
	`HIID` BIGINT(20) NULL DEFAULT '0',
	`tgiID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`tgID` INT(11) NULL DEFAULT '0',
	`TimeStart` TIME NULL DEFAULT NULL,
	`TimeFinish` TIME NULL DEFAULT NULL,
	`DayNumStart` INT(11) NULL DEFAULT NULL,
	`DayNumFinish` INT(11) NULL DEFAULT NULL,
	`DayStart` VARCHAR(10) NULL DEFAULT NULL,
	`DayFinish` VARCHAR(10) NULL DEFAULT NULL,
	`MonthStart` VARCHAR(10) NULL DEFAULT NULL,
	`MonthFinish` VARCHAR(10) NULL DEFAULT NULL,
	`isActive` BIT(1) NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`tgiID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `TimeStart` (`TimeStart`),
	INDEX `TimeFinish` (`TimeFinish`),
	INDEX `DayStart` (`DayStart`),
	INDEX `DayFinish` (`DayFinish`),
	INDEX `MonthStart` (`MonthStart`),
	INDEX `MonthFinish` (`MonthFinish`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `tgID` (`tgID`),
	INDEX `DayNumStart` (`DayNumStart`),
	INDEX `DayNumFinish` (`DayNumFinish`)
)
COMMENT='Конфиги для временных настроек'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
