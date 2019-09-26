CREATE TABLE IF NOT EXISTS `slDealItem` (
	`HIID` BIGINT(20) NOT NULL,
	`diID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`dcID` INT(11) NOT NULL,
	`psID` INT(11) NOT NULL,
	`psName` VARCHAR(1020) NOT NULL,
	`iPrice` DECIMAL(14,2) NOT NULL,
	`iQty` DECIMAL(14,4) NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`diID`),
	INDEX `FK_slDealItem_slDeal` (`dcID`),
	INDEX `FK_slDealItem_stProduct` (`psID`),
	INDEX `HIID` (`HIID`),
	INDEX `psName` (`psName`(333)),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
/*CREATE TABLE IF NOT EXISTS DUP_slDealItem(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- 'версия'
  ,diID           int               NOT NULL -- 'ID записи'
  ,dcID           int               NOT NULL -- 'ID документа'
  ,psID           int               NOT NULL -- 'ID продукта'
  ,psName         varchar(1020)     NOT NULL -- 'название продукта'
  ,iPrice         decimal(14,2)     NOT NULL -- 'цена'
  ,iQty           decimal(14,4)     NOT NULL -- 'количество'
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_slDeal (HIID,diID)
);*/
--
