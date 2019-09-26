CREATE TABLE IF NOT EXISTS `usFavorite` (
	`emID` INT(11) NOT NULL,
	`uID` BIGINT(20) UNSIGNED NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`faComment` VARCHAR(200) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`emID`, `uID`),
	INDEX `faComment` (`faComment`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
