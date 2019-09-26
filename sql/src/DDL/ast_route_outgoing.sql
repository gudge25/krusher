CREATE TABLE IF NOT EXISTS `ast_route_outgoing` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`roID` INT(11) NOT NULL,
	`roName` VARCHAR(50) NULL DEFAULT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`destination` INT(11) NULL DEFAULT NULL,
	`destdata` INT(11) NULL DEFAULT NULL,
  `destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`category` INT(11) NULL DEFAULT NULL,
	`prepend` VARCHAR(50) NULL DEFAULT NULL,
	`prefix` VARCHAR(50) NULL DEFAULT NULL,
	`callerID` VARCHAR(50) NULL DEFAULT NULL,
	`priority` INT(11) NULL DEFAULT '1',
	`coID` INT(11) NULL DEFAULT '0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`roID`),
	UNIQUE INDEX `Aid_category_callerID` (`Aid`, `category`, `callerID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `destination` (`destination`),
	INDEX `destdata` (`destdata`),
	INDEX `HIID` (`HIID`),
	INDEX `roName` (`roName`),
	INDEX `priority` (`priority`),
	INDEX `prepend` (`prepend`),
	INDEX `prefix` (`prefix`),
	INDEX `destdata2` (`destdata2`),
	INDEX `coID` (`coID`)
)
COMMENT='Схема трафика для голоса'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
