CREATE TABLE IF NOT EXISTS `pchPayment` (
	`HIID` BIGINT(20) NOT NULL,
	`dcID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`PayType` INT(11) NOT NULL,
	`PayMethod` INT(11) NOT NULL,
	`isActive` INT(11) NOT NULL DEFAULT '0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dcID`),
	INDEX `isActive` (`isActive`),
	INDEX `PayMethod` (`PayMethod`),
	INDEX `PayType` (`PayType`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
/*CREATE TABLE IF NOT EXISTS DUP_pchPayment(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- версия
  ,dcID           int               NOT NULL -- ID документа
  ,PayType        int               NOT NULL -- тип оплаты
  ,PayMethod      int               NOT NULL -- способ оплаты
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_pchPayment (HIID,dcID)
);*/
--
