CREATE TABLE IF NOT EXISTS `crmClient` (
	`HIID` BIGINT(20) NOT NULL DEFAULT '0',
	`clID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`clName` VARCHAR(200) NOT NULL,
	`IsPerson` BIT(1) NOT NULL DEFAULT b'0',
	`Sex` INT(11) NULL DEFAULT NULL,
	`Comment` VARCHAR(1020) NULL DEFAULT NULL,
	`ParentID` INT(11) NULL DEFAULT NULL,
	`ffID` INT(11) NOT NULL DEFAULT '0',
	`CompanyID` INT(11) NULL DEFAULT NULL,
	`uID` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
	`isActual` BIT(1) NOT NULL DEFAULT b'0',
	`ActualStatus` INT(11) NULL DEFAULT NULL,
	`Position` INT(11) NULL DEFAULT NULL,
	`responsibleID` INT(11) NULL DEFAULT NULL,
	`CreatedBy` INT(11) NOT NULL,
	`ChangedBy` INT(11) NULL DEFAULT NULL,
	`IsActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`clID`),
	INDEX `FK_crmClient_fsFile` (`ffID`),
	INDEX `FK_crmClient_crmClient` (`ParentID`),
	INDEX `FK_crmClient_emEmploy_CreatedBy` (`CreatedBy`),
	INDEX `FK_crmClient_emEmploy_EditedBy` (`ChangedBy`),
	INDEX `Aid` (`Aid`),
	INDEX `clName` (`clName`),
	INDEX `IsActive` (`IsActive`),
	INDEX `isActual` (`isActual`),
	INDEX `Created` (`Created`),
	INDEX `uID` (`uID`),
	INDEX `IsPerson` (`IsPerson`),
	INDEX `HIID` (`HIID`),
	INDEX `CompanyID` (`CompanyID`),
	INDEX `responsibleID` (`responsibleID`),
	INDEX `Sex` (`Sex`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
CREATE TABLE IF NOT EXISTS DUP_crmClient (
  RowID            BIGINT               NOT NULL auto_increment
  , OLD_HIID       BIGINT(20) UNSIGNED  NULL
  , DUP_InsTime    DATETIME             NOT NULL
  , DUP_action     ENUM('I','U','D')    NOT NULL
  -- , DUP_UserName   VARCHAR(16)          NOT NULL
  , DUP_HostName   VARCHAR(128)         NOT NULL
  , DUP_AppName    INT(11)              NOT NULL
  , `HIID` BIGINT(20) UNSIGNED NULL DEFAULT '0'
  , `clID` INT(11) NOT NULL
  , `Aid` INT(11) NOT NULL DEFAULT '0'
  , `clName` VARCHAR(200) NOT NULL
  , `IsPerson` BIT(1) NOT NULL DEFAULT b'0'
  , `Sex` INT(11) NULL DEFAULT NULL
  , `Comment` VARCHAR(1020) NULL DEFAULT NULL
  , `ParentID` INT(11) NULL DEFAULT NULL
  , `ffID` INT(11) NOT NULL DEFAULT '0'
  , `CompanyID` INT(11) NULL DEFAULT NULL
  , `uID` BIGINT(20) UNSIGNED NULL DEFAULT NULL
  , `isActual` BIT(1) NOT NULL DEFAULT b'0'
  , `ActualStatus` INT(11) NULL DEFAULT NULL
  , `Position` INT(11) NULL DEFAULT NULL
  , `responsibleID` INT(11) NULL DEFAULT NULL
  , `CreatedBy` INT(11) NOT NULL
  , `ChangedBy` INT(11) NULL DEFAULT NULL
  , `IsActive` BIT(1) NOT NULL DEFAULT b'0'
  , `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
  , `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  , PRIMARY KEY (`RowID`),
	INDEX `OLD_HIID` (`OLD_HIID`),
	INDEX `DUP_InsTime` (`DUP_InsTime`),
	INDEX `DUP_action` (`DUP_action`),
	INDEX `DUP_HostName` (`DUP_HostName`),
	INDEX `DUP_AppName` (`DUP_AppName`),
	INDEX `HIID` (`HIID`),
	INDEX `clID` (`clID`),
	INDEX `Aid` (`Aid`),
	INDEX `clName` (`clName`),
	INDEX `IsPerson` (`IsPerson`),
	INDEX `Sex` (`Sex`),
	INDEX `Comment` (`Comment`),
	INDEX `ParentID` (`ParentID`),
	INDEX `ffID` (`ffID`),
	INDEX `CompanyID` (`CompanyID`),
	INDEX `uID` (`uID`),
	INDEX `isActual` (`isActual`),
	INDEX `ActualStatus` (`ActualStatus`),
	INDEX `Position` (`Position`),
	INDEX `responsibleID` (`responsibleID`),
	INDEX `CreatedBy` (`CreatedBy`),
	INDEX `ChangedBy` (`ChangedBy`),
	INDEX `IsActive` (`IsActive`),
	INDEX `Created` (`Created`)
)COLLATE='utf8_general_ci'
ENGINE=MyISAM;
--
