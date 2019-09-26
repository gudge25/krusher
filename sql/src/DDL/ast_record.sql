CREATE TABLE IF NOT EXISTS `ast_record` (
  `HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`record_id` INT(11) NOT NULL AUTO_INCREMENT,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`record_name` VARCHAR(255) NOT NULL COMMENT 'Название записи',
	`record_source` VARCHAR(500) NOT NULL COMMENT 'Путь записи',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`record_id`),
	UNIQUE INDEX `Aid_record_name` (`Aid`, `record_name`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COMMENT='Информация о записи, которая будет использоваться'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
