CREATE TABLE IF NOT EXISTS `ast_route_outgoing_items` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`roiID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`roID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`pattern` VARCHAR(50) NOT NULL DEFAULT '0' COMMENT 'префикс',
	`callerID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Caller ID для префикса',
	`prepend` VARCHAR(50) NULL DEFAULT NULL,
	`prefix` VARCHAR(50) NULL DEFAULT NULL,
	`priority` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`roiID`),
	UNIQUE INDEX `uniq` (`roID`, `pattern`, `callerID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `priority` (`priority`),
	INDEX `prepend` (`prepend`),
	INDEX `prefix` (`prefix`)
)
COMMENT='Префиксы исходящих роутов'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
