CREATE TABLE IF NOT EXISTS `ast_tts_fields` (
	`HIID` BIGINT NULL DEFAULT '0',
	`ttsfID` INT NOT NULL,
	`Aid` INT NULL DEFAULT '0',
	`field` VARCHAR(50) NULL,
	`fieldName_ru` VARCHAR(100) NULL,
	`fieldName_en` VARCHAR(100) NULL,
	`fieldName_ua` VARCHAR(100) NULL,
	`isActive` BIT NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	PRIMARY KEY (`ttsfID`),
	INDEX `Aid` (`Aid`),
	INDEX `field` (`field`),
	INDEX `fieldName_ru` (`fieldName_ru`),
	INDEX `fieldName_en` (`fieldName_en`),
	INDEX `fieldName_ua` (`fieldName_ua`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COMMENT='Поля для работы с tts'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
