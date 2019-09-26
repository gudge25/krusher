CREATE TABLE IF NOT EXISTS `ast_pools` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`poolID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`poolName` VARCHAR(50) NULL DEFAULT NULL,
	`priority` INT(11) NULL DEFAULT '0',
	`coID` INT(11) NULL DEFAULT '0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	PRIMARY KEY (`poolID`),
	INDEX `Aid` (`Aid`),
	INDEX `poolName` (`poolName`),
	INDEX `priority` (`priority`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `coID` (`coID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
