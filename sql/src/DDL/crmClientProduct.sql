CREATE TABLE IF NOT EXISTS `crmClientProduct` (
	`HIID` BIGINT(20) NOT NULL,
	`cpID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`clID` INT(11) NOT NULL,
	`psID` INT(11) NOT NULL,
	`cpQty` DECIMAL(14,4) NULL DEFAULT NULL,
	`cpPrice` DECIMAL(14,2) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`cpID`),
	UNIQUE INDEX `UIX_crmClient_clID_psID` (`clID`, `psID`),
	INDEX `FK_crmClientProduct_stProduct` (`psID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
