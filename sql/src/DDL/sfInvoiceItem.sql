CREATE TABLE IF NOT EXISTS `sfInvoiceItem` (
	`HIID` BIGINT(20) NOT NULL,
	`iiID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`OwnerID` INT(11) NULL DEFAULT NULL,
	`dcID` INT(11) NOT NULL,
	`psID` INT(11) NULL DEFAULT NULL,
	`iNo` SMALLINT(6) NOT NULL,
	`iName` VARCHAR(1020) NULL DEFAULT NULL,
	`iPrice` DECIMAL(14,4) NOT NULL,
	`iQty` DECIMAL(14,4) NOT NULL,
	`iComments` VARCHAR(255) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`iiID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `OwnerID` (`OwnerID`),
	INDEX `dcID` (`dcID`),
	INDEX `psID` (`psID`),
	INDEX `iNo` (`iNo`),
	INDEX `iName` (`iName`(333)),
	INDEX `iPrice` (`iPrice`),
	INDEX `iQty` (`iQty`),
	INDEX `iComments` (`iComments`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

--
/*CREATE TABLE IF NOT EXISTS DUP_sfInvoiceItem(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- версия
  ,iiID           int               NOT NULL  -- PK
  ,OwnerID        int                   NULL  -- главная позиция
  ,dcID           int               NOT NULL  -- ID документа
  ,psID           int                   NULL  -- ID материала
  ,iNo            smallint          NOT NULL  -- номер позиции
  ,iName          varchar(1020)         NULL  -- наименование позиции
  ,iPrice         decimal(14,4)     NOT NULL
  ,iQty           decimal(14,4)     NOT NULL  -- количетсво
  ,iComments      varchar(255)          NULL  -- комментарии
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_sfInvoiceItem (HIID,iiID)
);*/
--
