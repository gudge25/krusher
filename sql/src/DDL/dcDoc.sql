CREATE TABLE IF NOT EXISTS `dcDoc` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL,
	`dcID` INT(11) NOT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`dctID` TINYINT(4) NOT NULL,
	`dcNo` VARCHAR(35) NULL DEFAULT NULL,
	`dcState` SMALLINT(6) NOT NULL,
	`dcDate` DATE NOT NULL,
	`dcLink` INT(11) NULL DEFAULT NULL,
	`dcComment` VARCHAR(200) NULL DEFAULT NULL,
	`dcSum` DECIMAL(14,2) NULL DEFAULT NULL,
	`dcStatus` INT(11) NULL DEFAULT NULL,
	`dcRate` DECIMAL(14,4) NULL DEFAULT NULL,
	`crID` INT(11) NULL DEFAULT NULL,
	`clID` INT(11) NOT NULL,
	`ffID` INT(11) NOT NULL DEFAULT '0',
	`emID` INT(11) NOT NULL,
	`pcID` INT(11) NOT NULL,
	`CreatedBy` INT(11) NOT NULL,
	`ChangedBy` INT(11) NULL DEFAULT NULL,
	`uID` BIGINT(20) UNSIGNED NOT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`dcID`),
	INDEX `IX_dcDoc_dctID` (`dctID`),
	INDEX `IX_dcDoc_clID` (`clID`),
	INDEX `IX_dcDoc_CreatedBy` (`CreatedBy`),
	INDEX `IX_dcDoc_EditedBy` (`ChangedBy`),
	INDEX `IX_dcDoc_pcID` (`pcID`),
	INDEX `IX_dcDoc_dcStatus` (`dcStatus`),
	INDEX `IX_dcDoc_emID` (`emID`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `uID` (`uID`),
	INDEX `crID` (`crID`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`),
	INDEX `ffID` (`ffID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

/*--
CREATE INDEX IX_dcDoc_dctID on dcDoc (dctID ASC);
CREATE INDEX IX_dcDoc_clID on dcDoc (clID ASC);
CREATE INDEX IX_dcDoc_CreatedBy on dcDoc (CreatedBy ASC);
CREATE INDEX IX_dcDoc_EditedBy on dcDoc (EditedBy ASC);
CREATE INDEX IX_dcDoc_pcID on dcDoc (pcID);
CREATE INDEX IX_dcDoc_dcStatus on dcDoc(dcStatus);
CREATE INDEX IX_dcDoc_emID on dcDoc(emID);
--
CREATE TABLE IF NOT EXISTS DUP_dcDoc (
   RowID        bigint              NOT NULL auto_increment
  ,OLD_HIID     BIGINT(20) UNSIGNED NULL
  ,DUP_InsTime  DATETIME            NOT NULL
  ,DUP_action   ENUM('I','U','D')   NOT NULL
  ,DUP_UserName VARCHAR(16)         NOT NULL
  ,DUP_HostName VARCHAR(128)        NOT NULL
  ,DUP_AppName  VARCHAR(128)        NOT NULL
  ,HIID         BIGINT(20) UNSIGNED NOT NULL -- 'версия'
  ,dcID         INT                 NOT NULL -- 'ID документа'
  ,dctID        TINYINT             NOT NULL -- 'ID тип документа'
  ,dcNo         VARCHAR(35)         NULL -- 'Номер документа'
  ,dcState      SMALLINT            NOT NULL -- 'состояние документа'
  ,dcDate       DATE                NOT NULL -- 'дата документа'
  ,dcLink       INT                 NULL -- 'ID документа основания'
  ,dcComment    VARCHAR(200)        NULL -- 'комментарий'
  ,dcSum        DECIMAL(14,4)       NULL -- 'сумма документа'
  ,dcStatus     INT                 NULL -- 'статус документа'
  ,dcRate       DECIMAL(14,4)       NULL -- 'курс'
  ,crID         INT                 NULL -- 'валюта'
  ,clID         INT                 NOT NULL -- 'ID клиента'
  ,emID         INT                 NOT NULL -- 'ID владельца'
  ,draID        INT                 NULL -- 'ID направление деятельности'
  ,pcID         INT                 NOT NULL -- 'ID профитцентра'
  ,CreatedAt    DATETIME            NOT NULL -- 'дата cоздания'
  ,CreatedBy    INT                 NOT NULL -- 'автор создания'
  ,EditedAt     DATETIME            NULL -- 'дата редактирования'
  ,EditedBy     INT                 NULL -- 'автор редактирования'
  ,uID          BIGINT(20) UNSIGNED NOT NULL -- 'unique id'
  ,PRIMARY KEY (RowID)
  ,KEY (HIID,DUP_action)
);*/
--
