CREATE TABLE IF NOT EXISTS `crmClientEx` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`clID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`ffID` INT(11) NOT NULL DEFAULT '0',
	`CallDate` DATETIME NULL DEFAULT NULL,
    `isCallDate` BIT(1) NULL DEFAULT b'0',
	`ChangedBy` INT(11) NOT NULL,
	`isNotice` BIT(1) NOT NULL DEFAULT b'0',
	`isRobocall` BIT(1) NOT NULL DEFAULT b'0',
	`ActDate` DATE NULL DEFAULT NULL,
	`timeZone` SMALLINT(6) NULL DEFAULT NULL,
	`isCallback` BIT(1) NOT NULL DEFAULT b'0',
	`isDial` BIT(1) NOT NULL DEFAULT b'0',
	`curID` INT(11) NULL DEFAULT NULL,
	`langID` INT(11) NULL DEFAULT NULL,
	`sum` DECIMAL(14,2) NULL DEFAULT NULL,
	`ttsText` LONGTEXT NULL DEFAULT NULL,
	`cusID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'customer ID - некий ID клиента',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`clID`),
	INDEX `Aid` (`Aid`),
	INDEX `CallDate` (`CallDate`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `curID` (`curID`),
	INDEX `langID` (`langID`),
	INDEX `ChangedBy` (`ChangedBy`),
	INDEX `HIID` (`HIID`),
	INDEX `isDial` (`isDial`),
	INDEX `ffID` (`ffID`),
	INDEX `cusID` (`cusID`),
    INDEX `isCallDate` (`isCallDate`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--


/*--
CREATE TABLE IF NOT EXISTS DUP_crmClientEx (
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,clID           int               NOT NULL
  ,CallDate       datetime              NULL
  ,EditedAt       datetime          NOT NULL
  ,EditedBy       int               NOT NULL
  ,isNotice       bit               NOT NULL
  ,isRobocall     bit               NOT NULL
  ,ActDate        date                  NULL
  ,timeZone       smallint              NULL
  ,isCallback     bit               NOT NULL
  ,isDial         bit               NOT NULL
  ,PRIMARY KEY (RowID)
);
*/
--
