CREATE TABLE IF NOT EXISTS `fsFile`(
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`ffID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`ffName` VARCHAR(200) NOT NULL,
	`Priority` INT(11) NOT NULL DEFAULT '0',
	`dbID` INT(11) NULL DEFAULT NULL,
	`clients_count` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`phones_count` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`trash_count` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`status_answered_and_comment` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`status_answered` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`status_no_answered` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`status_busy` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`status_not_successfull` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Время редактирования записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	UNIQUE INDEX `ffID_Aid` (`ffID`, `Aid`),
	INDEX `FK_fsFile_fsBase` (`dbID`),
	INDEX `ffID` (`ffID`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`),
	INDEX `ffName` (`ffName`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
