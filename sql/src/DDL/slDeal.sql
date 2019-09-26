CREATE TABLE IF NOT EXISTS `slDeal` (
	`HIID` BIGINT(20) NOT NULL,
	`dcID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`isHasDoc` BIT(1) NOT NULL,
	`HasDocNo` VARCHAR(35) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dcID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `Aid` (`Aid`),
	INDEX `isHasDoc` (`isHasDoc`),
	INDEX `HasDocNo` (`HasDocNo`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--
/*CREATE TABLE IF NOT EXISTS DUP_slDeal(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- 'версия'
  ,dcID           int               NOT NULL -- 'ID документа'
  ,isHasDoc       bit               NOT NULL -- 'признак имеет официальный документ'
  ,HasDocNo       varchar(35)           NULL -- 'номер официального документа'
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_slDeal (HIID,dcID)
);*/
--
