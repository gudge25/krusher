call us_InsMessage(77067, 'Пользователя root изменять запрещено!');
UPDATE dcType SET dctName='Обращение' WHERE dctID=1;

CREATE TABLE IF NOT EXISTS `ast_pools` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`poolID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`poolName` VARCHAR(50) NULL DEFAULT NULL,
	`priority` INT(11) NULL DEFAULT '0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	PRIMARY KEY (`poolID`),
	INDEX `Aid` (`Aid`),
	INDEX `poolName` (`poolName`),
	INDEX `priority` (`priority`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

CREATE TABLE IF NOT EXISTS `ast_pool_list` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`plID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`poolID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`trID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`percent` INT(10) NOT NULL DEFAULT '0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	PRIMARY KEY (`plID`),
	INDEX `trID` (`trID`),
	INDEX `percent` (`percent`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `poolID` (`poolID`)
)
COMMENT='Транки в пулах'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
