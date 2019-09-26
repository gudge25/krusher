CREATE TABLE IF NOT EXISTS `ast_autodial_process` (
  `HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`id_autodial` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL COMMENT 'ID клиента',
	`process` INT(11) NOT NULL COMMENT 'Статус процесса',
	`ffID` INT(11) NOT NULL COMMENT 'ID базы обзвона',
	`id_scenario` INT(11) NOT NULL COMMENT 'ID сценария',
	`emID` INT(11) NULL COMMENT 'ID пользователя, запустившего обзвон',
	`factor` INT(11) NOT NULL COMMENT 'Фактор обзвона',
	`called` INT(11) NULL DEFAULT '0' COMMENT 'Кол-во осуществленных звонков',
	`targetCalls` INT(11) NULL DEFAULT '0' COMMENT 'Кол-во звонков, достигших цели',
	`planDateBegin` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Запланированное время начала обзвона',
	`planDateEnd` DATETIME NULL DEFAULT NULL COMMENT 'Запланированное время окончания обзвона',
	`errorDescription` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Описание последней ошибки',
	`description` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Описание',
	`isActive` BIT(1) NULL DEFAULT b'1' COMMENT 'Признак активности записи',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`id_autodial`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `Changed` (`Changed`),
	INDEX `id_scenario` (`id_scenario`),
	INDEX `ffID` (`ffID`),
	INDEX `Aid` (`Aid`),
	INDEX `process` (`process`),
	INDEX `HIID` (`HIID`),
	INDEX `planDateBegin` (`planDateBegin`)
)
COMMENT='Текущие автообзвоны'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
