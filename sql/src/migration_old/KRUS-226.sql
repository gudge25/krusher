CREATE TABLE IF NOT EXISTS `ast_route_incoming` (
  `rtID` INT(10) UNSIGNED NOT NULL COMMENT 'ID маршрута',
  `Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID клиента',
  `trID` INT(11) UNSIGNED NOT NULL COMMENT 'ID транка',
  `DID` VARCHAR(50) NOT NULL COMMENT 'Номер выделенный в транке',
  `callerID` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'ID абонента, к которому привязывается правило',
  `exten` VARCHAR(500) NOT NULL COMMENT 'Раширение для Астериска',
  `IsActive` BIT(1) NOT NULL COMMENT 'Признак активности',
  `context` VARCHAR(100) NOT NULL DEFAULT 'office' COMMENT 'Контекст для Астриска',
  `Destination` INT(11) NULL DEFAULT NULL COMMENT 'Тип обработчика звонка',
  `DestData` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Варианты обработчика из поля Destination',
  PRIMARY KEY (`rtID`),
  INDEX `id_user` (`Aid`),
  INDEX `id_trunk` (`trID`),
  INDEX `did` (`DID`),
  INDEX `isActive` (`IsActive`),
  INDEX `callerID` (`callerID`)
)
  COMMENT='таблица для хранения настроек роутинга входного звонка'
  COLLATE='utf8_general_ci'
  ENGINE=InnoDB
  ROW_FORMAT=COMPACT
;

