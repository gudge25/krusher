CREATE TABLE IF NOT EXISTS `ast_scenario`  (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`id_scenario` INT(10) UNSIGNED NOT NULL COMMENT 'ID сценария',
	`name_scenario` VARCHAR(255) NOT NULL DEFAULT '0' COMMENT 'название сценария',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`callerID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Номер выделенный в транке',
	`TimeBegin` TIME NOT NULL DEFAULT '08:00:00' COMMENT 'Время начала обзвона',
	`TimeEnd` TIME NOT NULL DEFAULT '20:00:00' COMMENT 'Время окончания обзвона',
	`DaysCall` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Дни обзвона',
	`RecallCount` INT(10) NOT NULL DEFAULT '10',
	`RecallAfterMin` INT(10) NOT NULL DEFAULT '60',
	`RecallCountPerDay` INT(10) NOT NULL DEFAULT '7',
	`RecallDaysCount` INT(10) NOT NULL DEFAULT '2',
	`RecallAfterPeriod` INT(10) NOT NULL DEFAULT '1',
	`SleepTime` INT(10) NOT NULL DEFAULT '2',
	`AutoDial` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Информация, которую отображать при звонке на экране',
	`IsRecallForSuccess` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак дозваниваться до абонента, если он поднял трубку',
	`IsCallToOtherClientNumbers` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак нужно ли звонить на остальные номера клиента, если на хотя бы один дозвонились.',
	`IsCheckCallFromOther` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак - проверять ли дозвоны на данный номер из других БД',
	`AllowPrefix` LONGTEXT NULL DEFAULT NULL COMMENT 'Префиксы разрешенные в обзвоне',
	`destination` INT(11) NULL DEFAULT NULL COMMENT 'ID destination',
	`destdata` INT(11) NULL DEFAULT NULL COMMENT 'DestData',
	`destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`target` LONGTEXT NULL DEFAULT NULL COMMENT 'Описание метода достижения цели',
	`roID` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Выбор роутов для данного сценария',
	`isFirstClient` BIT(1) NULL DEFAULT b'1' COMMENT 'Кому звонить в первую очередь',
    `limitChecker` INT(11) NULL DEFAULT NULL,
    `limitStatuses` LONGTEXT NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`id_scenario`),
	INDEX `id_user` (`Aid`),
	INDEX `did` (`callerID`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `Changed` (`Changed`),
	INDEX `HIID` (`HIID`),
	INDEX `name_scenario` (`name_scenario`),
	INDEX `isFirstClient` (`isFirstClient`)
)
COMMENT='таблица для хранения настроек сценариев автообзвона'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

