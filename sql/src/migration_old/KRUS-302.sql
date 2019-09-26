  CREATE TABLE IF NOT EXISTS `ast_autodial_process` (
	`id_autodial` INT(11) NOT NULL,
	`TimeBegin` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания',
	`TimeUpdated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления',
	`process` INT(11) NOT NULL COMMENT 'Статус процесса',
	`ffID` INT(11) NOT NULL COMMENT 'ID базы обзвона',
	`id_scenario` INT(11) NOT NULL COMMENT 'ID сценария',
	`emID` INT(11) NOT NULL COMMENT 'ID пользователя, запустившего обзвон',
	`Aid` INT(11) NOT NULL COMMENT 'ID клиента',
	`factor` INT(11) NOT NULL COMMENT 'Фактор обзвона',
	`called` INT(11) NOT NULL DEFAULT '0' COMMENT 'Кол-во осуществленных звонков',
	`targetCalls` INT(11) NOT NULL DEFAULT '0' COMMENT 'Кол-во звонков, достигших цели',
	`errorDescription` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Описание последней ошибки',
	`description` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Описание',
	PRIMARY KEY (`id_autodial`)
)
COMMENT='Текущие автообзвоны'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

call us_InsMessage(77100, 'Обзвон по данной базе, с выбранным сценарием уже запущен.');
call us_InsMessage(77101, 'Обзвон не возможен, так как отсутствует сценарий обзвона!');
call us_InsMessage(77102, 'Выбранный сценарий НЕ АКТИВЕН!');
call us_InsMessage(77103, 'Данный сценарий не попадает в диапазон времени обзвона');
call us_InsMessage(77104, 'Сценарий должен быть запущен в другой день');
call us_InsMessage(77105, 'Не корректно установлен фактор!');
call us_InsMessage(77106, 'Нет свободных менеджеров!');

