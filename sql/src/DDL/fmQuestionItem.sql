CREATE TABLE IF NOT EXISTS `fmQuestionItem` (
	`HIID` BIGINT(20) NOT NULL,
	`qiID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`qID` INT(11) NOT NULL,
	`qiAnswer` VARCHAR(100) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`qiID`),
	INDEX `FK_fmQuestionItem_fmQuestion` (`qID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `qiAnswer` (`qiAnswer`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
