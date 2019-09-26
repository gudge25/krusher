SET @s = (SELECT IF(
    (SELECT COUNT(*)
     FROM fsFile
     WHERE ffID=-1
    ) > 0,
    "SELECT '+366_6'",
    "INSERT IGNORE INTO `fsFile` (`ffID`, `ffName`, `isActive`, `dbID`) VALUES ('-1', '[Missed]', b'1', '1');"
));
PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

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
ENGINE=InnoDB
;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ast_monitoring'
           AND column_name = 'address'
    ) > 0,
    "SELECT '+366_55'",
    "ALTER TABLE `ast_monitoring`
        CHANGE COLUMN `emID` `SIP` VARCHAR(30) NOT NULL COMMENT 'SIP' AFTER `Aid`,
        CHANGE COLUMN `eventID` `eventName` VARCHAR(30) NOT NULL COMMENT 'Название события' AFTER `SIP`,
        ADD COLUMN `dev_status` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Статус устройства' AFTER `eventName`,
        ADD COLUMN `dev_state` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Состояние устройства' AFTER `dev_status`,
        ADD COLUMN `pause` BIT NOT NULL DEFAULT b'0' COMMENT 'Состояние паузы' AFTER `dev_state`,
        ADD COLUMN `address` VARCHAR(20) NULL DEFAULT NULL COMMENT 'Адрес откуда подключаается усройство' AFTER `pause`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'fsFile'
           AND column_name = 'clients_count'
    ) > 0,
    "SELECT '+366_76'",
    "ALTER TABLE `fsFile`
        ADD COLUMN `clients_count` INT(11) NULL DEFAULT '0' AFTER `rcID`,
        ADD COLUMN `phones_count` INT(11) NULL DEFAULT '0' AFTER `clients_count`,
        ADD COLUMN `trash_count` INT(11) NULL DEFAULT '0' AFTER `phones_count`,
        ADD COLUMN `status_answered_and_comment` INT(11) NULL DEFAULT '0' AFTER `trash_count`,
        ADD COLUMN `status_answered` INT(11) NULL DEFAULT '0' AFTER `status_answered_and_comment`,
        ADD COLUMN `status_no_answered` INT(11) NULL DEFAULT '0' AFTER `status_answered`,
        ADD COLUMN `status_busy` INT(11) NULL DEFAULT '0' AFTER `status_no_answered`,
        ADD COLUMN `status_not_successfull` INT(11) NULL DEFAULT '0' AFTER `status_busy`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
