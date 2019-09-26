CREATE TABLE IF NOT EXISTS `crmContact` (
	`HIID` BIGINT(20) NOT NULL,
	`ccID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL COMMENT 'ID клиента',
	`clID` INT(11) NOT NULL,
	`ffID` INT(11) NOT NULL DEFAULT '0',
	`ccName` VARCHAR(250) NOT NULL,
	`ccType` INT(11) NOT NULL,
	`isPrimary` BIT(1) NOT NULL DEFAULT b'0',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`ccStatus` INT(11) NULL DEFAULT NULL,
	`ccComment` VARCHAR(100) NULL DEFAULT NULL,
	`gmt` INT(11) NULL DEFAULT NULL,
	`MCC` INT(11) NULL DEFAULT NULL COMMENT 'мобильный код страны',
	`MNC` INT(11) NULL DEFAULT NULL COMMENT 'мобильный код оператора',
	`id_country` INT(11) NULL DEFAULT NULL COMMENT 'id страны',
	`id_region` INT(11) NULL DEFAULT NULL COMMENT 'id региона',
	`id_area` INT(11) NULL DEFAULT NULL COMMENT 'id района',
	`id_city` INT(11) NULL DEFAULT NULL COMMENT 'id города',
	`id_mobileProvider` INT(11) NULL DEFAULT NULL COMMENT 'id мобильного оператора',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`ccID`),
	INDEX `FK_crmContacts_crmClient` (`clID`),
	INDEX `Aid` (`Aid`),
	INDEX `ccName` (`ccName`),
	INDEX `isActive` (`isActive`),
	INDEX `isPrimary` (`isPrimary`),
	INDEX `ccType` (`ccType`),
	INDEX `Created` (`Created`),
	INDEX `ccStatus` (`ccStatus`),
	INDEX `id_country` (`id_country`),
	INDEX `MNC` (`MNC`),
	INDEX `MCC` (`MCC`),
	INDEX `gmt` (`gmt`),
	INDEX `id_region` (`id_region`),
	INDEX `id_area` (`id_area`),
	INDEX `id_city` (`id_city`),
	INDEX `id_mobileProvider` (`id_mobileProvider`),
	INDEX `HIID` (`HIID`),
	INDEX `ffID` (`ffID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

/*CREATE TABLE IF NOT EXISTS DUP_crmContact (
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL
  ,ccID           int               NOT NULL
  ,clID           int               NOT NULL
  ,ccName         varchar(50)       NOT NULL
  ,ccType         int               NOT NULL
  ,isPrimary      bit               NOT NULL
  ,isActive       bit               NOT NULL
  ,ccStatus       int                   NULL
  ,ccComment      varchar(100)          NULL
  ,PRIMARY KEY (RowID)
);
--
*/