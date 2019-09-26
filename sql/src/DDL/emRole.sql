CREATE TABLE IF NOT EXISTS `emRole` (
	`HIID` BIGINT(20) NOT NULL,
	`roleID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`roleName` VARCHAR(50) NOT NULL,
	`Permission` INT(11) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`CreatedBy` INT(11) NULL,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP ,
	PRIMARY KEY (`roleID`),
	INDEX `FK_emRole_emEmploy_CreatedBy` (`CreatedBy`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `roleName` (`roleName`),
	INDEX `Permission` (`Permission`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
/*
--
CREATE TABLE IF NOT EXISTS DUP_emRole (
   RowID      bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL
  ,roleID         int               NOT NULL
  ,roleName       varchar(50)       NOT NULL
  ,isActive       bit               NOT NULL
  ,Permission     int               NOT NULL
  ,CreatedAt      datetime          NOT NULL
  ,CreatedBy      int               NOT NULL
  ,EditedAt       datetime              NULL
  ,EditedBy       int                   NULL
  ,PRIMARY KEY (RowID)
  ,INDEX (HIID,DUP_action)
);
--
*/