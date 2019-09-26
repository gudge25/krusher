CREATE TABLE IF NOT EXISTS `ast_ivr_entries` (
  `HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`entry_id` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента',
	`id_ivr_config` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID IVR настройки',
	`extension` VARCHAR(20) NOT NULL COMMENT 'Номер телефона для астериска',
	`destination` INT(11) NOT NULL,
	`destdata` INT(11) NULL DEFAULT NULL,
	`destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`return` BIT(1) NOT NULL DEFAULT b'0',
	`isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения',
	PRIMARY KEY (`entry_id`),
	UNIQUE INDEX `uniq_index` (`Aid`, `id_ivr_config`, `extension`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
