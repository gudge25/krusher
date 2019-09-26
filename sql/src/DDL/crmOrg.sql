CREATE TABLE IF NOT EXISTS `crmOrg` (
	`HIID` BIGINT(20) NOT NULL,
	`clID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`Account` BIGINT(20) NULL DEFAULT NULL,
	`Bank` VARCHAR(100) NULL DEFAULT NULL,
	`TaxCode` VARCHAR(14) NULL DEFAULT NULL,
	`SortCode` INT(11) NULL DEFAULT NULL,
	`RegCode` INT(11) NULL DEFAULT NULL,
	`CertNumber` INT(11) NULL DEFAULT NULL,
	`OrgType` INT(11) NULL DEFAULT NULL,
	`ShortName` VARCHAR(200) NULL DEFAULT NULL,
	`KVED` VARCHAR(7) NULL DEFAULT NULL,
	`KVEDName` VARCHAR(250) NULL DEFAULT NULL,
	`headPost` VARCHAR(200) NULL DEFAULT NULL,
	`headFIO` VARCHAR(100) NULL DEFAULT NULL,
	`headFam` VARCHAR(50) NULL DEFAULT NULL,
	`headIO` VARCHAR(100) NULL DEFAULT NULL,
	`headSex` VARCHAR(10) NULL DEFAULT NULL,
	`orgNote` VARCHAR(100) NULL DEFAULT NULL,
	`CreatedBy` INT(11) NOT NULL,
	`ChangedBy` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`clID`),
	INDEX `FK_crmOrg_emEmploy_CreatedBy` (`CreatedBy`),
	INDEX `FK_crmOrg_emEmploy_EditedBy` (`ChangedBy`),
	INDEX `Aid` (`Aid`),
	INDEX `Created` (`Created`),
	INDEX `ShortName` (`ShortName`),
	INDEX `isActive` (`isActive`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

--
/*CREATE TABLE IF NOT EXISTS DUP_crmOrg(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL
  ,clID           int                   NULL
  ,Account        bigint                NULL
  ,Bank           varchar(100)          NULL
  ,TaxCode        varchar(14)           NULL
  ,SortCode       int                   NULL
  ,RegCode        int                   NULL
  ,CertNumber     int                   NULL
  ,OrgType        int                   NULL
  ,CreatedAt      datetime          NOT NULL
  ,CreatedBy      int               NOT NULL
  ,EditedAt       datetime              NULL
  ,EditedBy       int                   NULL
  ,ShortName      varchar(50)           NULL
  ,KVED           varchar(7)            NULL
  ,KVEDName       varchar(250)          NULL
  ,headPost       varchar(200)          NULL
  ,headFIO        varchar(50)           NULL
  ,headFam        varchar(50)           NULL
  ,headIO         varchar(100)          NULL
  ,headSex        varchar(10)           NULL
  ,orgNote        varchar(100)          NULL
  ,PRIMARY KEY (RowID)
);
--
*/