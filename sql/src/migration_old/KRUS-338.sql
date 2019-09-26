CREATE TABLE IF NOT EXISTS `ast_ivr_entries` (
	`entry_id` INT(11) NOT NULL,
	`account_id` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента',
	`id_ivr_config` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID IVR настройки',
	`extension` VARCHAR(20) NOT NULL COMMENT 'Номер телефона для астериска',
	`destination` VARCHAR(255) NOT NULL,
	`destdata` VARCHAR(255) NULL DEFAULT NULL,
	`return` BIT(1) NOT NULL DEFAULT b'0',
	`isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения',
	PRIMARY KEY (`entry_id`),
	UNIQUE INDEX `uniq_index` (`account_id`, `id_ivr_config`, `extension`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM;


CREATE TABLE IF NOT EXISTS `ast_ivr_config` (
	`id_ivr_config` INT(11) NOT NULL,
	`account_id` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента',
	`ivr_name` VARCHAR(255) NOT NULL COMMENT 'Название IVR',
	`ivr_description` VARCHAR(1000) NULL DEFAULT NULL COMMENT 'Описание IVR',
	`record_id` INT(11) NULL DEFAULT NULL COMMENT 'ID записи для IVR',
	`enable_direct_dial` BIT(1) NOT NULL DEFAULT b'0',
	`timeout` INT(11) NOT NULL DEFAULT '5' COMMENT 'Ожидание',
	`alert_info` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Важное уведомление',
	`volume` INT(11) NULL DEFAULT NULL COMMENT 'Громкость',
	`invalid_retries` INT(11) NOT NULL DEFAULT '3' COMMENT 'Кол-во попыток повторов, при ошибочном вводе',
	`retry_record_id` INT(11) NULL DEFAULT NULL COMMENT 'ID записи для IVR при повтороном ошибочном вводе',
	`append_record_to_invalid` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Включить проигрывание записи при ошибочном вооде',
	`return_on_invalid` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Включить возврата к родительскому IVR',
	`invalid_record_id` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID записи для IVR при ошибочном вводе',
	`invalid_destination` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Destination для ошибочного ввода',
	`invalid_destdata` VARCHAR(255) NULL DEFAULT NULL COMMENT 'DestData для ошибочного ввода',
	`timeout_retries` INT(11) NOT NULL DEFAULT '3' COMMENT 'Ожидание между повторным проигрыванием',
	`timeout_retry_record_id` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID записи для IVR повторов',
	`append_record_on_timeout` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Включить применение IVR записи, для таумаута',
	`return_on_timeout` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Включить возврат к таймауту',
	`timeout_record_id` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID записи для IVR после таймаута',
	`timeout_destination` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Destination для таймута',
	`timeout_destdata` VARCHAR(255) NULL DEFAULT NULL COMMENT 'DestData для таймаута',
	`return_to_ivr_after_vm` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Включить возврат к IVR после VoiceMail',
	`isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`id_ivr_config`)
)
COMMENT='Настройка IVR'
COLLATE='utf8_general_ci'
ENGINE=MyISAM;

ALTER TABLE `ast_ivr_entries`
	ALTER `entry_id` DROP DEFAULT;
ALTER TABLE `ast_ivr_entries`
	CHANGE COLUMN `entry_id` `entry_id` INT(11) NOT NULL FIRST;

ALTER TABLE `ast_ivr_config`
	ALTER `id_ivr_config` DROP DEFAULT;
ALTER TABLE `ast_ivr_config`
	CHANGE COLUMN `id_ivr_config` `id_ivr_config` INT(11) NOT NULL FIRST;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ast_ivr_config'
           AND column_name = 'Aid'
    ) > 0,
    "SELECT '+338_85'",
    "ALTER TABLE `ast_ivr_config`
	    CHANGE COLUMN `account_id` `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента' AFTER `id_ivr_config`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ast_ivr_entries'
           AND column_name = 'Aid'
    ) > 0,
    "SELECT '+338_101'",
    "ALTER TABLE `ast_ivr_entries`
	    CHANGE COLUMN `account_id` `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента' AFTER `entry_id`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(*)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_entries'
           AND column_name = 'answer'
    ) = 0,
    "SELECT '+338_164'",
    "ALTER TABLE `ast_ivr_entries`
	    ALTER `answer` DROP DEFAULT;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_entries'
           AND column_name = 'extension'
    ) > 0,
    "SELECT '+338_179'",
    "ALTER TABLE `ast_ivr_entries`
	      CHANGE COLUMN `answer` `extension` VARCHAR(20) NOT NULL COMMENT 'Номер телефона для астериска' AFTER `id_ivr_config`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_entries'
           AND column_name = 'Created'
    ) > 0,
    "SELECT '+338_195'",
    "ALTER TABLE `ast_ivr_entries`
        ADD COLUMN `isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности записи' AFTER `return`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения' AFTER `Created`,
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config'
           AND column_name = 'Created'
    ) > 0,
    "SELECT '+338_215'",
    "ALTER TABLE `ast_ivr_config`
        ADD COLUMN `isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности записи' AFTER `return_to_ivr_after_vm`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;






