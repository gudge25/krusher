CREATE TABLE IF NOT EXISTS `usComment`  (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`uID` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
	`uComment` VARCHAR(200) NULL DEFAULT NULL,
	`CreatedBy` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`id`),
	INDEX `IX_usComment_uID` (`uID`),
	INDEX `FK_usComment_emEmploy` (`CreatedBy`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `uComment` (`uComment`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
