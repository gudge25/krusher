CREATE TABLE IF NOT EXISTS `ast_route_incoming` (
  `HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`rtID` INT(10) UNSIGNED NOT NULL COMMENT 'ID маршрута',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`trID` INT(11) UNSIGNED NOT NULL COMMENT 'ID транка',
	`DID` VARCHAR(50) NOT NULL COMMENT 'Номер выделенный в транке',
	`callerID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'ID абонента, к которому привязывается правило',
	`exten` VARCHAR(500) NOT NULL COMMENT 'Раширение для Астериска',
	`context` VARCHAR(100) NOT NULL DEFAULT 'office' COMMENT 'Контекст для Астриска',
	`destination` INT(11) NULL DEFAULT NULL COMMENT 'Тип обработчика звонка',
	`destdata` INT(11) NULL DEFAULT NULL COMMENT 'Варианты обработчика из поля Destination',
  `destdata2` VARCHAR(100) NULL DEFAULT NULL,
  `stick_destination` INT(11) NULL DEFAULT NULL,
  `isCallback` BIT(1) NULL DEFAULT b'0',
	`isFirstClient` BIT(1) NULL DEFAULT b'1',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`rtID`),
	INDEX `id_user` (`Aid`),
	INDEX `id_trunk` (`trID`),
	INDEX `did` (`DID`),
	INDEX `isActive` (`isActive`),
	INDEX `callerID` (`callerID`),
	INDEX `Created` (`Created`),
	INDEX `Changed` (`Changed`),
	INDEX `HIID` (`HIID`),
	INDEX `isCallback` (`isCallback`),
	INDEX `isFirstClient` (`isFirstClient`),
	INDEX `stick_destination` (`stick_destination`)
)
COMMENT='таблица для хранения настроек роутинга входного звонка'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
