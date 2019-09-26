CREATE TABLE IF NOT EXISTS `sfInvoice` (
	`HIID` BIGINT(20) NOT NULL,
	`dcID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`Delivery` VARCHAR(255) NULL DEFAULT NULL,
	`VATSum` DECIMAL(14,2) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dcID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`),
	INDEX `Delivery` (`Delivery`),
	INDEX `VATSum` (`VATSum`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
/*CREATE TABLE IF NOT EXISTS DUP_sfInvoice(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- версия
  ,dcID           int               NOT NULL -- ID документа
  ,Delivery       varchar(255)          NULL -- адресс доставки
  ,VATSum         decimal(14,2)     NOT NULL -- НДС
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_slDeal (HIID,dcID)
);*/
--


