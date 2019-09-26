CREATE TABLE IF NOT EXISTS `ast_custom_destination` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`cdID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`cdName` VARCHAR(50) NULL DEFAULT NULL,
	`context` VARCHAR(50) NULL DEFAULT NULL,
	`exten` VARCHAR(50) NULL DEFAULT NULL,
	`description` VARCHAR(250) NULL DEFAULT NULL,
	`notes` TEXT NULL DEFAULT NULL,
	`return` BIT(1) NOT NULL DEFAULT b'1',
	`destination` INT(11) NULL DEFAULT NULL,
	`destdata` INT(11) NULL DEFAULT NULL,
	`destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`priority` INT(11) NULL DEFAULT '1',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`cdID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `destdata` (`destdata`),
	INDEX `destination` (`destination`),
	INDEX `return` (`return`),
	INDEX `description` (`description`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`),
	INDEX `cdName` (`cdName`),
	INDEX `context` (`context`),
	INDEX `exten` (`exten`),
	INDEX `destdata2` (`destdata2`),
	INDEX `priority` (`priority`)
)
COMMENT='Индивидуальные настройки'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
