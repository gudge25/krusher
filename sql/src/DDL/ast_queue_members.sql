CREATE TABLE IF NOT EXISTS `ast_queue_members` (
  `HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`quemID` INT(10) UNSIGNED NOT NULL,
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`emID` INT(10) UNSIGNED NOT NULL COMMENT 'ID сотрудника',
	`queID` INT(10) UNSIGNED NOT NULL COMMENT 'ID очереди',
	`membername` VARCHAR(40) NULL DEFAULT NULL,
	`queue_name` VARCHAR(128) NULL DEFAULT NULL,
	`interface` VARCHAR(128) NULL DEFAULT NULL,
	`penalty` INT(11) NULL DEFAULT NULL,
	`paused` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активна запись или нет',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения',
	PRIMARY KEY (`quemID`),
	UNIQUE INDEX `queue_interface` (`queue_name`, `interface`, `Aid`),
	INDEX `emID` (`emID`),
	INDEX `Aid` (`Aid`),
	INDEX `queID` (`queID`),
	INDEX `membername` (`membername`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
