CREATE TABLE IF NOT EXISTS `crmAddress` (
	`HIID` BIGINT(20) NOT NULL,
	`adsID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`adsName` VARCHAR(200) NOT NULL,
	`adtID` INT(11) NOT NULL,
	`Postcode` VARCHAR(10) NULL DEFAULT NULL,
	`clID` INT(11) NOT NULL,
	`pntID` INT(11) NULL DEFAULT NULL,
	`Region` VARCHAR(100) NULL DEFAULT NULL,
	`RegionDesc` VARCHAR(200) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`adsID`),
	INDEX `FK_crmAddress_crmClient` (`clID`),
	INDEX `Aid` (`Aid`),
	INDEX `adsName` (`adsName`),
	INDEX `adtID` (`adtID`),
	INDEX `Postcode` (`Postcode`),
	INDEX `pntID` (`pntID`),
	INDEX `Region` (`Region`),
	INDEX `RegionDesc` (`RegionDesc`),
	INDEX `isActive` (`isActive`),
	INDEX `HIID` (`HIID`),
	INDEX `Created` (`Created`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
/*CREATE TABLE IF NOT EXISTS DUP_crmAddress (
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL
  ,adsID          int               NOT NULL
  ,adsName        varchar(200)      NOT NULL
  ,adtID          int               NOT NULL
  ,Postcode       varchar(5)            NULL
  ,clID           int               NOT NULL
  ,pntID          int                   NULL
  ,Region         varchar(100)          NULL
  ,RegionDesc     varchar(200)          NULL
  ,PRIMARY KEY (RowID)
);*/
--

