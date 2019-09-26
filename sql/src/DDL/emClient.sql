CREATE TABLE IF NOT EXISTS `emClient` (
	`HIID` BIGINT(20) NOT NULL DEFAULT '0',
	`id_client` INT(11) NOT NULL AUTO_INCREMENT,
	`url` VARCHAR(255) NULL DEFAULT NULL COMMENT 'домен',
	`IP` VARCHAR(255) NULL DEFAULT NULL COMMENT 'IP как альтернатива домену',
	`port` SMALLINT(6) NOT NULL DEFAULT '3000' COMMENT 'порт',
	`login` VARCHAR(50) NOT NULL COMMENT 'Логин',
	`password` VARCHAR(100) NOT NULL COMMENT 'Пароль',
	`phone` BIGINT(20) NOT NULL COMMENT 'Телефон',
	`mobile_phone` BIGINT(20) NULL DEFAULT NULL COMMENT 'Мобильный',
	`email_info` VARCHAR(255) NOT NULL COMMENT 'Почта для информации',
	`email_tech` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Почта для тех вопросов и уведомлений',
	`email_finance` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Почта для фин уведомлений',
	`tarrif` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'тариф',
	`hosting_type` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID типа хостинга... У нас или на сервере клиента',
	`balance_amount` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Текущий баланс',
	`id_currency` INT(11) NOT NULL COMMENT 'ID валюты',
	`payment_type` INT(11) NULL DEFAULT NULL COMMENT 'ID типа оплаты',
	`fee` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'абонплата',
	`date_fee` TINYINT(4) NOT NULL COMMENT 'день снятия абонплаты',
	`purchaseDate` DATE NULL DEFAULT NULL,
	`count_of_calls` TINYINT(4) NULL DEFAULT NULL COMMENT 'доступная скорость обзвона',
	`white_ip` TEXT NULL COMMENT 'Список белых IP',
	`user_type` ENUM('USER','RESELLER') NOT NULL DEFAULT 'USER' COMMENT 'Тип профиля... Клиент или реселлер',
	`client_count` SMALLINT(6) NULL DEFAULT NULL COMMENT 'Кол-во клиентов у реселлера',
	`id_manager` SMALLINT(6) NULL DEFAULT NULL COMMENT 'ID менеджера этого клиента',
	`authorization_type` ENUM('NO','GOOGLE') NULL DEFAULT NULL COMMENT 'Тип 2ФА',
	`comments` TEXT NULL COMMENT 'Комментарий',
	`logo_url` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Адрес лого для кастомизации',
	`client_name` VARCHAR(255) NOT NULL COMMENT 'Название клиента',
	`client_contact` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Имя контактного лица',
	`vTigerID` INT(11) NULL DEFAULT NULL COMMENT 'ID клиента из vTiger',
    `pauseDelay` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности акаунта (глобален)',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`id_client`),
	UNIQUE INDEX `url` (`url`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `id_currency` (`id_currency`),
	INDEX `payment_type` (`payment_type`),
	INDEX `fee` (`fee`),
	INDEX `id_manager` (`id_manager`),
	INDEX `HIID` (`HIID`),
	INDEX `vTigerID` (`vTigerID`),
	INDEX `login` (`login`),
	INDEX `password` (`password`),
	INDEX `IP` (`IP`),
    INDEX `pauseDelay` (`pauseDelay`)
)
COMMENT='Настройки клиента'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--