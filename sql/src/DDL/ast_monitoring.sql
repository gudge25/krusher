CREATE TABLE IF NOT EXISTS `ast_monitoring` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`Aid` INT(11) NOT NULL COMMENT 'ID акаунта',
	`SIP` VARCHAR(30) NOT NULL COMMENT 'SIP',
	`eventName` VARCHAR(30) NOT NULL COMMENT 'Название события',
	`dev_status` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Статус устройства',
	`dev_state` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Состояние устройства',
	`pause` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Состояние паузы',
	`address` VARCHAR(20) NULL DEFAULT NULL COMMENT 'Адрес откуда подключаается усройство',
	`start_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время начала события',
	`end_time` DATETIME NULL DEFAULT NULL COMMENT 'Время окончания события',
	`spend_sec` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Потрачено времени в сек',
	PRIMARY KEY (`id`),
	INDEX `Aid` (`Aid`),
	INDEX `end_time` (`end_time`),
	INDEX `SIP` (`SIP`),
	INDEX `eventName` (`eventName`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;