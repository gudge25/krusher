CREATE TABLE IF NOT EXISTS `ast_scenario` (
	`id_scenario` INT(10) UNSIGNED NOT NULL COMMENT 'ID сценария',
	`name_scenario` VARCHAR(255) NOT NULL DEFAULT '0' COMMENT 'название сценария',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`callerID` BIGINT(20) UNSIGNED NOT NULL COMMENT 'Номер выделенный в транке',
	`TimeBegin` TIME NOT NULL DEFAULT '08:00:00' COMMENT 'Время начала обзвона',
	`TimeEnd` TIME NOT NULL DEFAULT '20:00:00' COMMENT 'Время окончания обзвона',
	`DaysCall` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Дни обзвона',
	`RecallCount` INT(10) NOT NULL DEFAULT '3' COMMENT 'Кол-во раз дозвона до абонента, в случае неудачи',
	`RecallAfterMin` INT(10) NOT NULL DEFAULT '60' COMMENT 'Минут через сколько повторять дозвон',
	`RecallCountPerDay` INT(10) NOT NULL DEFAULT '5' COMMENT 'Кол-во попыток дозвона за сутки',
	`RecallDaysCount` INT(10) NOT NULL DEFAULT '5' COMMENT 'Кол-во дней попыток дозвона',
	`RecallAfterPeriod` INT(10) NOT NULL DEFAULT '50' COMMENT 'Время в сутках, через которые можно звонить на уже дозвоненные номера',
	`SleepTime` INT(10) NOT NULL DEFAULT '2' COMMENT 'Время ожидания, перед следующим заходом',
	`AutoDial` VARCHAR(100) NOT NULL DEFAULT '50' COMMENT 'Информация, которую отображать при звонке на экране',
	`IsRecallForSuccess` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак дозваниваться до абонента, если он поднял трубку',
	`IsCallToOtherClientNumbers` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак нужно ли звонить на остальные номера клиента, если на хотя бы один дозвонились.',
	`IsCheckCallFromOther` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак - проверять ли дозвоны на данный номер из других БД',
	`AllowPrefix` LONGTEXT NULL DEFAULT NULL COMMENT 'Префиксы разрешенные в обзвоне',
	`destination` INT(11) NULL DEFAULT NULL COMMENT 'ID destination',
	`destdata` LONGTEXT NULL DEFAULT NULL COMMENT 'DestData',
	`target` LONGTEXT NULL DEFAULT NULL COMMENT 'Описание метода достижения цели',
	`isActive` BIT(1) NULL DEFAULT b'0' COMMENT 'Признак активности',
	PRIMARY KEY (`id_scenario`),
	INDEX `id_user` (`Aid`),
	INDEX `did` (`callerID`),
	INDEX `isActive` (`isActive`)
)
COMMENT='таблица для хранения настроек сценариев автообзвона'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ast_scenario'
           AND column_name = 'SleepTime'
    ) > 0,
    "SELECT '+283_47'",
    "ALTER TABLE `ast_scenario`
	      ADD COLUMN `SleepTime` INT(10) UNSIGNED NOT NULL DEFAULT '2' COMMENT 'Время ожидания, перед следующим заходом' AFTER `RecallAfterPeriod`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



