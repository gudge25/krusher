CREATE TABLE IF NOT EXISTS `stProduct` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL,
	`psID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`psName` VARCHAR(1020) NOT NULL,
	`psState` INT(11) NULL DEFAULT NULL,
	`psCode` VARCHAR(25) NULL DEFAULT NULL,
	`msID` INT(11) NOT NULL,
	`pctID` INT(11) NULL DEFAULT NULL,
	`ParentID` INT(11) NULL DEFAULT NULL,
	`pcID` INT(11) NOT NULL,
	`CreatedBy` INT(11) NOT NULL,
	`ChangedBy` INT(11) NULL DEFAULT NULL,
	`bID` INT(11) NULL DEFAULT NULL,
	`uID` BIGINT(20) UNSIGNED NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`psID`),
	INDEX `FK_stProduct_emEmploy_CreatedBy` (`CreatedBy`),
	INDEX `FK_stProduct_emEmploy_EditedBy` (`ChangedBy`),
	INDEX `FK_stProduct_stProduct` (`ParentID`),
	INDEX `FK_stProduct_stCategory` (`pctID`),
	INDEX `FK_stProduct_stBrand` (`bID`),
	INDEX `Aid` (`Aid`),
	INDEX `psName` (`psName`(333)),
	INDEX `psState` (`psState`),
	INDEX `psCode` (`psCode`),
	INDEX `msID` (`msID`),
	INDEX `pcID` (`pcID`),
	INDEX `Created` (`Created`),
	INDEX `uID` (`uID`),
	INDEX `isActive` (`isActive`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

--
/*CREATE TABLE IF NOT EXISTS DUP_stProduct (
   RowID          BIGINT              NOT NULL auto_increment
  ,OLD_HIID       BIGINT(20) UNSIGNED NULL
  ,DUP_InsTime    DATETIME            NOT NULL
  ,DUP_action     ENUM('I','U','D')   NOT NULL
  ,DUP_UserName   VARCHAR(16)         NOT NULL
  ,DUP_HostName   VARCHAR(128)        NOT NULL
  ,DUP_AppName    VARCHAR(128)        NOT NULL
  ,HIID           BIGINT(20) UNSIGNED NOT NULL  -- версия
  ,psID           INT                 NOT NULL  -- ID записи
  ,psName         VARCHAR(1020)       NOT NULL  -- название продукта
  ,psState        INT                 NULL  -- статусы товара
  ,psCode         VARCHAR(25)         NULL  -- шрихкод
  ,msID           INT                 NOT NULL  -- единицы измерения
  ,pctID          INT                 NULL  -- ID категории товара
  ,ParentID       INT                 NULL  -- ID родителя
  ,pcID           INT                 NOT NULL  -- ID профитцентра
  ,CreatedAt      DATETIME            NOT NULL  -- дата создания
  ,CreatedBy      INT                 NOT NULL  -- автор создания
  ,EditedAt       DATETIME            NULL  -- дата изменения
  ,EditedBy       INT                 NULL  -- автор изменений
  ,bID            INT                 NULL  -- бренд
  ,uID            BIGINT(20) UNSIGNED NOT NULL  --
  ,PRIMARY KEY (RowID)
);
*/