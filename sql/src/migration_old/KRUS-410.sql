SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND column_name = 'uID'
    ) > 0,
    "SELECT '+410_7'",
    "ALTER TABLE `crmClient` CHANGE COLUMN `uID` `uID` BIGINT(20) UNSIGNED NULL AFTER `isActual`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND column_name = 'uID'
    ) > 0,
    "SELECT '+410_15'",
    "ALTER TABLE `dcDoc` CHANGE COLUMN `uID` `uID` BIGINT(20) UNSIGNED NULL AFTER `rcID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
      WHERE TABLE_SCHEMA = 'krusher' AND TABLE_NAME = 'emEmploy' AND constraint_name = 'FK_emEmploy_emEmploy'
    ) = 0,
    "SELECT '+410_25'",
    "ALTER TABLE `emEmploy`
	      DROP FOREIGN KEY `FK_emEmploy_emEmploy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.`TRIGGERS`
     WHERE TRIGGER_SCHEMA = 'krusher' AND TRIGGER_NAME = 'tU_emEmploy'
    ) = 0,
    "SELECT '+410_36'",
    "DROP TRIGGER `tU_emEmploy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_46'",
    "ALTER TABLE `emEmploy`
        ADD COLUMN `Aid` INT(11) NOT NULL AFTER `emID`,
        ADD COLUMN `SipAccount` INT(11) NULL DEFAULT NULL AFTER `Aid`,
        ADD COLUMN `Password` VARCHAR(100) NOT NULL AFTER `LoginName`,
        ADD COLUMN `Token` VARCHAR(100) NULL AFTER `Password`,
        ADD COLUMN `TokenExpiredDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `Token`,
        ADD COLUMN `url` VARCHAR(250) NOT NULL COMMENT 'URL клиента' AFTER `IsActive`,
        ADD COLUMN `roleID` INT(11) NOT NULL AFTER `ManageID`,
        ADD COLUMN `sipID` INT(11) NULL DEFAULT NULL AFTER `roleID`,
        CHANGE COLUMN `SipNum` `sipName` VARCHAR(50) NULL DEFAULT NULL AFTER `sipID`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `Queue`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
        DROP INDEX `UIX_emEmploy_LoginName`,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `SipAccount` (`SipAccount`),
        ADD INDEX `Password` (`Password`),
        ADD INDEX `Token` (`Token`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `Queue` (`Queue`),
        ADD INDEX `sipName` (`sipName`),
        ADD INDEX `sipID` (`sipID`),
        ADD INDEX `roleID` (`roleID`),
        ADD UNIQUE INDEX `LoginName_url` (`LoginName`, `url`),
        ADD INDEX `LoginName` (`LoginName`),
        ADD INDEX `TokenExpiredDate` (`TokenExpiredDate`),
        ADD INDEX `IsActive` (`IsActive`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
      WHERE TABLE_SCHEMA = 'krusher' AND TABLE_NAME = 'emPassword' AND constraint_name = 'FK_emPassword_emEmploy_CreatedBy'
    ) = 0,
    "SELECT '+410_82'",
    "ALTER TABLE `emPassword`
        DROP FOREIGN KEY `FK_emPassword_emEmploy_emID`,
        DROP FOREIGN KEY `FK_emPassword_emEmploy_CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

/*
SET @s = (SELECT IF(
    (SELECT COUNT(*)
     FROM emEmploy
     WHERE emName = 'System' AND `Password` != ''
    ) > 0,
    "SELECT '+410_67'",
    "UPDATE emEmploy AS em
        INNER JOIN emPassword AS p ON em.LoginName = p.LoginName
        SET em.`Password` = p.`Password`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emPassword'
    ) = 0,
    "SELECT '+410_83"SELECT '+410_2432'",'",
    "DROP TABLE `emPassword`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;*/

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployRole' AND constraint_name = 'FK_emEmployRole_emEmploy'
    ) = 0,
    "SELECT '+410_97'",
    "ALTER TABLE `emEmployRole`
        DROP FOREIGN KEY `FK_emEmployRole_emEmploy`,
        DROP FOREIGN KEY `FK_emEmployRole_emRole`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;
/*
SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployRole' AND column_name = 'Created'
    ) > 0,
    "SELECT '+410_113'",
    "ALTER TABLE `emEmployRole`
	        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

*/
/*
SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployRole' AND column_name = 'Created'
    ) > 0,
    "SELECT '+410_128'",
    "ALTER TABLE `emEmployRole`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `emID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'1' COMMENT 'Активна ли запись' AFTER `roleID`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          DROP COLUMN `CreatedAt`,
          DROP COLUMN `CreatedBy`,
          DROP COLUMN `EditedAt`,
          DROP COLUMN `EditedBy`,
          ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;*/


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND constraint_name = 'FK_emRole_emEmploy_CreatedBy'
    ) = 0,
    "SELECT '+410_164'",
    "ALTER TABLE `emRole`
        DROP FOREIGN KEY `FK_emRole_emEmploy_CreatedBy`,
        DROP FOREIGN KEY `FK_emRole_emEmploy_EditedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
      FROM information_schema.`TABLES`
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_149'",
    "ALTER TABLE `emRole`
	      ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND column_name = 'CreatedBy'
    ) = 0,
    "SELECT '+410_180'",
    "ALTER TABLE `emRole`
        DROP COLUMN `CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND column_name = 'EditedBy'
    ) = 0,
    "SELECT '+410_180'",
    "ALTER TABLE `emRole`
        DROP COLUMN `EditedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

/*SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND column_name = 'Changed'
    ) > 0,
    "SELECT '+410_192'",
    "ALTER TABLE `emRole`
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `Permission`,
        CHANGE COLUMN `EditedAt` `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`;"
));
select @s;
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

*/

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND constraint_name = 'FK_ccContacts_dcDoc'
    ) = 0,
    "SELECT '+410_186'",
    "ALTER TABLE `ccContact`
	      DROP FOREIGN KEY `FK_ccContacts_dcDoc`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_201'",
    "ALTER TABLE `ccContact`
	      ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_216'",
    "ALTER TABLE `ccContact`
        ADD COLUMN `Aid` INT NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `HIID`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `IsMissed` (`IsMissed`),
        ADD INDEX `id_autodial` (`id_autodial`),
        ADD INDEX `id_scenario` (`id_scenario`),
        ADD INDEX `emID` (`emID`),
        ADD INDEX `clID` (`clID`),
        ADD INDEX `ffID` (`ffID`),
        ADD INDEX `IsOut` (`IsOut`),
        ADD INDEX `isAutocall` (`isAutocall`),
        ADD INDEX `channel` (`channel`),
        ADD INDEX `Queue` (`Queue`),
        ADD INDEX `CallType` (`CallType`);"
));


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_262'",
    "ALTER TABLE `ast_sippeers`
	      ALTER `name` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_262'",
    "ALTER TABLE `ast_sippeers`
          CHANGE COLUMN `id` `sipID` INT(11) NOT NULL AUTO_INCREMENT FIRST,
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' AFTER `sipID`,
          CHANGE COLUMN `name` `sipName` VARCHAR(50) NOT NULL AFTER `Aid`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
          DROP INDEX `id`,
          DROP PRIMARY KEY,
          ADD PRIMARY KEY (`sipID`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`),
          ADD INDEX `emID` (`emID`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `sipName` (`sipName`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
      FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_304'",
    "ALTER TABLE `ast_trunk`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_317'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `id`,
        ADD COLUMN `isReadable` BIT(1) NOT NULL DEFAULT b'1' AFTER `callbackextension`,
        ADD COLUMN `isActive` BIT NULL DEFAULT NULL COMMENT 'Признак активности записи' AFTER `callbackextension`,
        ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `isReadable` (`isReadable`),
	      ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccComment' AND constraint_name = 'FK_ccComment_ccCommentList'
    ) = 0,
    "SELECT '+410_304'",
    "ALTER TABLE `ccComment`
	      DROP FOREIGN KEY `FK_ccComment_ccCommentList`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccComment' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_353'",
    "ALTER TABLE `ccComment`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccComment' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_319'",
    "ALTER TABLE `ccComment`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID записи' AFTER `cccID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности' AFTER `comName`,
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
      FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccCommentList' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_339'",
    "ALTER TABLE `ccCommentList`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccCommentList' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_339'",
    "ALTER TABLE `ccCommentList`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID записи' AFTER `comID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `comName`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmAddress' AND constraint_name = 'FK_crmAddress_crmClient'
    ) = 0,
    "SELECT '+410_361'",
    "ALTER TABLE `crmAddress`
	      DROP FOREIGN KEY `FK_crmAddress_crmClient`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND constraint_name = 'FK_crmClientEx_crmClient'
    ) = 0,
    "SELECT '+410_376'",
    "ALTER TABLE `crmClientEx`
	      DROP FOREIGN KEY `FK_crmClientEx_crmClient`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_391'",
    "ALTER TABLE `crmClientEx`
        ENGINE=MyISAM"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_391'",
    "ALTER TABLE `crmClientEx`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `clID`,
        ADD COLUMN `isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `isDial`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        CHANGE COLUMN `EditedAt` `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `CallDate` (`CallDate`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmAddress' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_413'",
    "ALTER TABLE `crmAddress`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmAddress' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_413'",
    "ALTER TABLE `crmAddress`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `adsID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `RegionDesc`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        CHANGE COLUMN `Postcode` `Postcode` VARCHAR(10) NULL DEFAULT NULL AFTER `adtID`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `adsName` (`adsName`),
        ADD INDEX `adtID` (`adtID`),
        ADD INDEX `Postcode` (`Postcode`),
        ADD INDEX `pntID` (`pntID`),
        ADD INDEX `Region` (`Region`),
        ADD INDEX `RegionDesc` (`RegionDesc`),
        ADD INDEX `isActive` (`isActive`), ADD INDEX `HIID` (`HIID`), ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND constraint_name = 'FK_crmClient_crmClient'
    ) = 0,
    "SELECT '+410_441'",
    "ALTER TABLE `crmClient`
        DROP FOREIGN KEY `FK_crmClient_crmClient`,
        DROP FOREIGN KEY `FK_crmClient_emEmploy_CreatedBy`,
        DROP FOREIGN KEY `FK_crmClient_emEmploy_EditedBy`,
        DROP FOREIGN KEY `FK_crmClient_fsFile`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND constraint_name = 'FK_crmContacts_crmClient'
    ) = 0,
    "SELECT '+410_459'",
    "ALTER TABLE `crmContact`
	      DROP FOREIGN KEY `FK_crmContacts_crmClient`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_474'",
    "ALTER TABLE `crmContact`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_474'",
    "ALTER TABLE `crmContact`
        ADD COLUMN `Aid` INT(11) NOT NULL COMMENT 'ID клиента' AFTER `ccID`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создаания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `ccName` (`ccName`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `isPrimary` (`isPrimary`),
        ADD INDEX `ccType` (`ccType`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `ccStatus` (`ccStatus`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND constraint_name = 'FK_crmOrg_emEmploy_EditedBy'
    ) = 0,
    "SELECT '+410_499'",
    "ALTER TABLE `crmOrg`
        DROP FOREIGN KEY `FK_crmOrg_emEmploy_EditedBy`,
        DROP FOREIGN KEY `FK_crmOrg_emEmploy_CreatedBy`,
        DROP FOREIGN KEY `FK_crmOrg_crmClient`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_516'",
    "ALTER TABLE `crmOrg`
      	ALTER `CreatedBy` DROP DEFAULT;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


ALTER TABLE `crmOrg`
	CHANGE COLUMN `ShortName` `ShortName` VARCHAR(200) NULL DEFAULT NULL AFTER `OrgType`;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_531'",
    "ALTER TABLE `crmOrg`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_606'",
    "ALTER TABLE `crmOrg`
	      ALTER `CreatedBy` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_617'",
    "ALTER TABLE `crmOrg`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `clID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `orgNote`,
        CHANGE COLUMN `CreatedBy` `CreatedBy` INT(11) NOT NULL AFTER `isActive`,
        CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `CreatedBy`,
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `ChangedBy`,
        DROP COLUMN `EditedAt`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `SortCode` (`SortCode`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND column_name = 'Changed'
    ) > 0,
    "SELECT '+410_638'",
    "ALTER TABLE `crmOrg`
	      ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND constraint_name = 'FK_crmStatus_crmClient'
    ) = 0,
    "SELECT '+410_556'",
    "ALTER TABLE `crmStatus`
	      DROP FOREIGN KEY `FK_crmStatus_crmClient`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_572'",
    "ALTER TABLE `crmStatus`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_572'",
    "ALTER TABLE `crmStatus`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `clID`,
        ADD COLUMN `isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `isFixed`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        CHANGE COLUMN `EditedAt` `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `Created` (`Created`), ADD INDEX `isActive` (`isActive`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND constraint_name = 'FK_crmTag_crmClient'
    ) = 0,
    "SELECT '+410_592'",
    "ALTER TABLE `crmTag`
        DROP FOREIGN KEY `FK_crmTag_crmClient`,
        DROP FOREIGN KEY `FK_crmTag_crmTagList`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_608'",
    "ALTER TABLE `crmTag`
          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_608'",
    "ALTER TABLE `crmTag`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `clID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `Aid`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Created` (`Created`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Aid` (`Aid`), ADD INDEX `ctgID` (`ctgID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTagList' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_630'",
    "ALTER TABLE `crmTagList`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientProduct' AND constraint_name = 'FK_crmClientProduct_stProduct'
    ) = 0,
    "SELECT '+410_653'",
    "ALTER TABLE `crmClientProduct`
        DROP FOREIGN KEY `FK_crmClientProduct_stProduct`,
        DROP FOREIGN KEY `FK_crmClientProduct_clID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientProduct' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_669'",
    "ALTER TABLE `crmClientProduct`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientProduct' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_669'",
    "ALTER TABLE `crmClientProduct`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `cpID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `cpPrice`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Aid` (`Aid`), ADD INDEX `HIID` (`HIID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmPerson' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_691'",
    "ALTER TABLE `crmPerson`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `pnID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `Post`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Aid` (`Aid`),
        DROP FOREIGN KEY `FK_crmPerson_crmClient`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmPerson' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_691'",
    "ALTER TABLE `crmPerson`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmRegion' AND constraint_name = 'crmRegion_crmClient'
    ) = 0,
    "SELECT '+410_714'",
    "ALTER TABLE `crmRegion`
	      DROP FOREIGN KEY `crmRegion_crmClient`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND constraint_name = 'FK_dcDoc_mnCentre'
    ) = 0,
    "SELECT '+410_729'",
    "ALTER TABLE `dcDoc`
        DROP FOREIGN KEY `FK_dcDoc_mnCentre`,
        DROP FOREIGN KEY `FK_dcDoc_emEmploy_emID`,
        DROP FOREIGN KEY `FK_dcDoc_emEmploy_EditedBy`,
        DROP FOREIGN KEY `FK_dcDoc_emEmploy_CreatedBy`,
        DROP FOREIGN KEY `FK_dcDoc_dcType`,
        DROP FOREIGN KEY `FK_dcDoc_crmClient`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_749'",
    "ALTER TABLE `crmClient`
	      ALTER `CreatedBy` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_764'",
    "ALTER TABLE `crmClient`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND column_name = 'EditedAt'
    ) = 0,
    "SELECT '+410_764'",
    "ALTER TABLE `crmClient`
        DROP COLUMN `EditedAt`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_764'",
    "ALTER TABLE `crmClient`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `clID`,
        CHANGE COLUMN `CreatedBy` `CreatedBy` INT(11) NOT NULL AFTER `responsibleID`,
        CHANGE COLUMN `EditedBy` `EditedBy` INT(11) NULL DEFAULT NULL AFTER `CreatedBy`,
        CHANGE COLUMN `IsActive` `IsActive` BIT(1) NOT NULL DEFAULT b'0' AFTER `EditedBy`,
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `IsActive`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `clName` (`clName`),
        ADD INDEX `IsActive` (`IsActive`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `uID` (`uID`),
        ADD INDEX `IsPerson` (`IsPerson`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND column_name = 'Created'
    ) > 0,
    "SELECT '+410_764'",
    "ALTER TABLE `crmClient`
	      ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDocTemplate' AND constraint_name = 'FK_dcDocTemplate_dcType'
    ) = 0,
    "SELECT '+410_791'",
    "ALTER TABLE `dcDocTemplate`
	      DROP FOREIGN KEY `FK_dcDocTemplate_dcType`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDocTemplate' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_806'",
    "ALTER TABLE `dcDocTemplate`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDocTemplate' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_806'",
    "ALTER TABLE `dcDocTemplate`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dtID`,
        CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `isDefault`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `isDefault` (`isDefault`),
        ADD INDEX `HIID` (`HIID`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployEx' AND constraint_name = 'FK_emEmployEx_emEmploy'
    ) = 0,
    "SELECT '+410_830'",
    "ALTER TABLE `emEmployEx`
	      DROP FOREIGN KEY `FK_emEmployEx_emEmploy`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployEx' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_845'",
    "ALTER TABLE `emEmployEx`
	      ALTER `emID` DROP DEFAULT;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployEx' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_860'",
    "ALTER TABLE `emEmployEx`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployEx' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_860'",
    "ALTER TABLE `emEmployEx`
        CHANGE COLUMN `emID` `emID` INT(11) NOT NULL FIRST,
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `emID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `Settings`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormItem' AND constraint_name = 'FK_fmFormItem_fmForm'
    ) = 0,
    "SELECT '+410_883'",
    "ALTER TABLE `fmFormItem`
	      DROP FOREIGN KEY `FK_fmFormItem_fmForm`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



ALTER TABLE `fmFormItem`
	ALTER `qName` DROP DEFAULT;
ALTER TABLE `fmFormItem`
	CHANGE COLUMN `qName` `qName` VARCHAR(300) NOT NULL AFTER `qID`;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
      FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormItem' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_898'",
    "ALTER TABLE `fmFormItem`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormItem' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_898'",
    "ALTER TABLE `fmFormItem`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `fiID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `qiComment`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `qID` (`qID`),
        ADD INDEX `qName` (`qName`),
        ADD INDEX `qiID` (`qiID`),
        ADD INDEX `qiAnswer` (`qiAnswer`),
        ADD INDEX `qiComment` (`qiComment`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmForm' AND constraint_name = 'FK_fmForm_fmFormType'
    ) = 0,
    "SELECT '+410_925'",
    "ALTER TABLE `fmForm`
        DROP FOREIGN KEY `FK_fmForm_fmFormType`,
        DROP FOREIGN KEY `FK_fmForm_dcDoc`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmForm' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_941'",
    "ALTER TABLE `fmForm`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmForm' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_941'",
    "ALTER TABLE `fmForm`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dcID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `tpID`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_964'",
    "ALTER TABLE `emRole`
	      ALTER `isActive` DROP DEFAULT;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;




SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_979'",
    "ALTER TABLE `emRole`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `roleID`,
        CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL DEFAULT 0 AFTER `Permission`,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `roleName` (`roleName`),
        ADD INDEX `Permission` (`Permission`),
        ADD INDEX `isActive` (`isActive`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmQuestionItem' AND constraint_name = 'FK_fmQuestionItem_fmQuestion'
    ) = 0,
    "SELECT '+410_1002'",
    "ALTER TABLE `fmQuestionItem`
	      DROP FOREIGN KEY `FK_fmQuestionItem_fmQuestion`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmQuestionItem' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1017'",
    "ALTER TABLE `fmQuestionItem`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmQuestionItem' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1017'",
    "ALTER TABLE `fmQuestionItem`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `qiID`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `qiAnswer` (`qiAnswer`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `HIID` (`HIID`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;




SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmQuestion' AND constraint_name = 'FK_fmQuestion_fmFormType'
    ) = 0,
    "SELECT '+410_1040'",
    "ALTER TABLE `fmQuestion`
	      DROP FOREIGN KEY `FK_fmQuestion_fmFormType`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmQuestion' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1055'",
    "ALTER TABLE `fmQuestion`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `fmQuestion`
	ALTER `qName` DROP DEFAULT;
ALTER TABLE `fmQuestion`
	CHANGE COLUMN `qName` `qName` VARCHAR(300) NOT NULL AFTER `qID`;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmQuestion' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1055'",
    "ALTER TABLE `fmQuestion`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `qID`,
        CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL DEFAULT b'0' AFTER `tpID`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `qName` (`qName`),
        ADD INDEX `ParentID` (`ParentID`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormType' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1080'",
    "ALTER TABLE `fmFormType`
	      ALTER `isActive` DROP DEFAULT;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormType' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1095'",
    "ALTER TABLE `fmFormType`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormType' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1095'",
    "ALTER TABLE `fmFormType`
	        ALTER `isActive` DROP DEFAULT;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fmFormType' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1095'",
    "ALTER TABLE `fmFormType`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `tpID`,
        CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL AFTER `ffID`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `ffID` (`ffID`),
        ADD INDEX `tpName` (`tpName`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND constraint_name = 'FK_fsFile_fsBase'
    ) = 0,
    "SELECT '+410_1120'",
    "ALTER TABLE `fsFile`
	      DROP FOREIGN KEY `FK_fsFile_fsBase`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsContact' AND constraint_name = 'FK_fsContact_fsClient'
    ) = 0,
    "SELECT '+410_1255'",
    "ALTER TABLE `fsContact`
	        DROP FOREIGN KEY `FK_fsContact_fsClient`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsClient' AND constraint_name = 'FK_fsClient_fsFile'
    ) = 0,
    "SELECT '+410_1292'",
    "ALTER TABLE `fsClient`
	          DROP FOREIGN KEY `FK_fsClient_fsFile`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1135'",
    "ALTER TABLE `fsFile`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(*)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND column_name = 'ttsID'
    ) = 0,
    "SELECT '+410_1135'",
    "ALTER TABLE `fsFile`
        DROP COLUMN `ttsID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(*)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1135'",
    "ALTER TABLE `fsFile`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' AFTER `ffID`,
        CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL DEFAULT b'0' AFTER `status_not_successfull`,
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItemCol' AND constraint_name = 'FK_fsTemplateItemCol_fsTemplateItem'
    ) = 0,
    "SELECT '+410_1158'",
    "ALTER TABLE `fsTemplateItemCol`
	        DROP FOREIGN KEY `FK_fsTemplateItemCol_fsTemplateItem`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItemCol' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1173'",
    "ALTER TABLE `fsTemplateItemCol`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItemCol' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1173'",
    "ALTER TABLE `fsTemplateItemCol`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `ftiID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности клиента' AFTER `ColNumber`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItem' AND constraint_name = 'FK_fsTemplateItem_fsTemplate'
    ) =0,
    "SELECT '+410_1195'",
    "ALTER TABLE `fsTemplateItem`
	          DROP FOREIGN KEY `FK_fsTemplateItem_fsTemplate`;"
));


PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItem' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1210'",
    "ALTER TABLE `fsTemplateItem`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItem' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1210'",
    "ALTER TABLE `fsTemplateItem`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `ftiID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `ftDelim`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования файла' AFTER `Created`,
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`),
          ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplate' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1232'",
    "ALTER TABLE `fsTemplate`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplate' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1232'",
    "ALTER TABLE `fsTemplate`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `ftID`,
          ADD COLUMN `isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `isPerson`,
          CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Created` (`Created`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `ftName` (`ftName`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsContact' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1270'",
    "ALTER TABLE `fsContact`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsContact' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1270'",
    "ALTER TABLE `fsContact`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `fccID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `ftDelim`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`),
          ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;







SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsClient' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1307'",
    "ALTER TABLE `fsClient`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `fclID`,
          ADD COLUMN `isActive` VARCHAR(200) NOT NULL DEFAULT '0' COMMENT 'Признак активности записи' AFTER `RegionDesc`,
          CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
      FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsBase' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1328'",
    "ALTER TABLE `fsBase`
            ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsBase' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1328'",
    "ALTER TABLE `fsBase`
            ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dbID`,
            CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL DEFAULT b'0' AFTER `activeTo`,
            ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
            ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
            ADD INDEX `Aid` (`Aid`),
            ADD INDEX `dbName` (`dbName`),
            ADD INDEX `isActive` (`isActive`),
            ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'sfInvoice' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1351'",
    "ALTER TABLE `sfInvoice`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'sfInvoice' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1351'",
    "ALTER TABLE `sfInvoice`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dcID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `VATSum`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Created` (`Created`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `Delivery` (`Delivery`),
          ADD INDEX `VATSum` (`VATSum`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDealItem' AND constraint_name = 'FK_slDealItem_stProduct'
    ) =0,
    "SELECT '+410_1376'",
    "ALTER TABLE `slDealItem`
        DROP FOREIGN KEY `FK_slDealItem_stProduct`,
        DROP FOREIGN KEY `FK_slDealItem_slDeal`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDealItem' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1392'",
    "ALTER TABLE `slDealItem`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDealItem' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1392'",
    "ALTER TABLE `slDealItem`
	      ALTER `psName` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDealItem' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1392'",
    "ALTER TABLE `slDealItem`
	      CHANGE COLUMN `psName` `psName` VARCHAR(300) NOT NULL AFTER `psID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDealItem' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1392'",
    "ALTER TABLE `slDealItem`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `diID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `iQty`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `psName` (`psName`),
          ADD INDEX `Created` (`Created`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDeal' AND constraint_name = 'FK_slDeal_dcDoc'
    ) = 0,
    "SELECT '+410_1416'",
    "ALTER TABLE `slDeal`
	        DROP FOREIGN KEY `FK_slDeal_dcDoc`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDeal' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1431'",
    "ALTER TABLE `slDeal`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'slDeal' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1431'",
    "ALTER TABLE `slDeal`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dcID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `HasDocNo`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Created` (`Created`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `isHasDoc` (`isHasDoc`),
          ADD INDEX `HasDocNo` (`HasDocNo`),
          ADD INDEX `HIID` (`HIID`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usComment' AND constraint_name = 'FK_usComment_emEmploy'
    ) = 0,
    "SELECT '+410_1456'",
    "ALTER TABLE `usComment`
	        DROP FOREIGN KEY `FK_usComment_emEmploy`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usComment' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1471'",
      "ALTER TABLE `usComment`
            ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usComment' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1471'",
    "ALTER TABLE `usComment`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `id`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `CreatedBy`,
          CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
          ADD INDEX `Created` (`Created`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `uComment` (`uComment`),
          ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usComment' AND column_name = 'Created'
    ) > 0,
    "SELECT '+410_1494'",
    "ALTER TABLE `usEnumValue`
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Name` (`Name`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usFavorite' AND ENGINE = 'InnoDB'
    ) =0,
    "SELECT '+410_1513'",
    "ALTER TABLE `usFavorite`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usFavorite' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1513'",
    "ALTER TABLE `usFavorite`
        ADD COLUMN `Aid` INT NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `uID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `faComment`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `faComment` (`faComment`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `Aid` (`Aid`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usMeasure' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1536'",
    "ALTER TABLE `usMeasure`
          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usMeasure' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1536'",
    "ALTER TABLE `usMeasure`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `msID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `msName`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `msName` (`msName`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcType' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1560'",
    "ALTER TABLE `dcType`
	      ALTER `dctName` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcType' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1575'",
    "ALTER TABLE `dcType`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcType' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1575'",
    "ALTER TABLE `dcType`
          ADD COLUMN `Aid` INT NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dctID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `dctName`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
          CHANGE COLUMN `dctName` `dctName` VARCHAR(100) NOT NULL AFTER `Aid`,
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `dctName` (`dctName`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmEvent' AND constraint_name = 'FK_crmEvent_crmEventMeta'
    ) = 0,
    "SELECT '+410_1599'",
    "ALTER TABLE `crmEvent`
        DROP FOREIGN KEY `FK_crmEvent_dcDoc`,
        DROP FOREIGN KEY `FK_crmEvent_crmEventMeta`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1615'",
    "ALTER TABLE `dcDoc`
	      ALTER `dcID` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1630'",
    "ALTER TABLE `dcDoc`
	      ALTER `CreatedAt` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1630'",
    "ALTER TABLE `dcDoc`
          ADD COLUMN `Aid` INT(11) NOT NULL AFTER `dcID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' AFTER `uID`,
          CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `pcID`,
          CHANGE COLUMN `EditedAt` `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `CreatedBy`,
          CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `Changed`,
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `Created` (`Created`),
          ADD INDEX `uID` (`uID`),
          ADD INDEX `Aid` (`Aid`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'pchPayment' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1656'",
    "ALTER TABLE `pchPayment`
          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'pchPayment' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1656'",
    "ALTER TABLE `pchPayment`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `dcID`,
          ADD COLUMN `isActive` INT(11) NOT NULL DEFAULT '0' COMMENT 'Признак активности записи' AFTER `PayMethod`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `PayMethod` (`PayMethod`),
          ADD INDEX `PayType` (`PayType`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `HIID` (`HIID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_record' AND ENGINE = 'InnoDB'
    ) =0,
    "SELECT '+410_1680'",
    "ALTER TABLE `ast_record`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_record' AND column_name = 'Created'
    ) > 0,
    "SELECT '+410_1680'",
    "ALTER TABLE `ast_record`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `record_id`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `record_source`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`),
        ADD UNIQUE INDEX `Aid_record_name` (`Aid`, `record_name`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1704'",
    "ALTER TABLE `ast_ivr_config`
        CHANGE COLUMN `account_id` `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента' AFTER `id_ivr_config`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `ivr_name` (`ivr_name`),
        ADD INDEX `ivr_description` (`ivr_description`),
        ADD INDEX `record_id` (`record_id`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_entries' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1725'",
    "ALTER TABLE `ast_ivr_entries`
	        CHANGE COLUMN `account_id` `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID акаунта клиента' AFTER `entry_id`;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queues' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1740'",
    "ALTER TABLE `ast_queues`
          ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queues' AND column_name = 'Created'
    ) > 0,
    "SELECT '+410_1740'",
    "ALTER TABLE `ast_queues`
          CHANGE COLUMN `isActive` `isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активна запись или нет' AFTER `setinterfacevar`,
          ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
          ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1759'",
    "ALTER TABLE `ast_sippeers`
          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND constraint_name = 'FK_stProduct_stProduct'
    ) = 0,
    "SELECT '+410_1782'",
    "ALTER TABLE `stProduct`
        DROP FOREIGN KEY `FK_stProduct_stProduct`,
        DROP FOREIGN KEY `FK_stProduct_stCategory`,
        DROP FOREIGN KEY `FK_stProduct_stBrand`,
        DROP FOREIGN KEY `FK_stProduct_emEmploy_EditedBy`,
        DROP FOREIGN KEY `FK_stProduct_emEmploy_CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND column_name = 'Aid'
    ) = 0,
    "SELECT '+410_1801'",
    "ALTER TABLE `stProduct`
	      ALTER `psName` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND column_name = 'Aid'
    ) = 0,
    "SELECT '+410_1801'",
    "ALTER TABLE `stProduct`
	      CHANGE COLUMN `psName` `psName` VARCHAR(300) NOT NULL AFTER `psID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1801'",
    "ALTER TABLE `stProduct`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `psID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `uID`,
          CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
          DROP COLUMN `EditedAt`,
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `psName` (`psName`),
          ADD INDEX `psState` (`psState`),
          ADD INDEX `psCode` (`psCode`),
          ADD INDEX `msID` (`msID`),
          ADD INDEX `pcID` (`pcID`),
          ADD INDEX `Created` (`Created`),
          ADD INDEX `uID` (`uID`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `HIID` (`HIID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND column_name = 'Changed'
    ) > 0,
    "SELECT '+410_1801'",
    "ALTER TABLE `stProduct`
	      ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stBrand' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1830'",
    "ALTER TABLE `stBrand`
        ALTER `bID` DROP DEFAULT,
        ALTER `CreatedBy` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stBrand' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1846'",
    "ALTER TABLE `stBrand`
        ENGINE=MyISAM;"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stBrand' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1846'",
    "ALTER TABLE `stBrand`
        CHANGE COLUMN `bID` `bID` INT(11) NOT NULL AFTER `HIID`,
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `bID`,
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        CHANGE COLUMN `CreatedBy` `CreatedBy` INT(11) NOT NULL AFTER `Created`,
        CHANGE COLUMN `EditedAt` `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения запииси' AFTER `CreatedBy`,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `bName` (`bName`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stCategory' AND constraint_name = 'FK_stCategory_stCategory'
    ) = 0,
    "SELECT '+410_1871'",
    "ALTER TABLE `stCategory`
	      DROP FOREIGN KEY `FK_stCategory_stCategory`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stCategory' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1886'",
    "ALTER TABLE `stCategory`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stCategory' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1886'",
    "ALTER TABLE `stCategory`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `pctID`,
        ADD COLUMN `isActive` INT(11) NOT NULL DEFAULT '0' COMMENT 'Признак активности записи' AFTER `ParentID`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `pctName` (`pctName`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stCategory' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1909'",
    "ALTER TABLE `crmContact`
        ADD COLUMN `gmt` INT NULL DEFAULT NULL COMMENT 'Часовой пояс' AFTER `ccComment`,
        ADD COLUMN `MCC` INT NULL DEFAULT NULL COMMENT 'мобильный код страны' AFTER `gmt`,
        ADD COLUMN `MNC` INT NULL DEFAULT NULL COMMENT 'мобильный код оператора' AFTER `MCC`,
        ADD COLUMN `id_country` INT NULL DEFAULT NULL COMMENT 'id страны' AFTER `MNC`,
        ADD COLUMN `id_region` INT NULL DEFAULT NULL COMMENT 'id региона' AFTER `id_country`,
        ADD COLUMN `id_area` INT NULL DEFAULT NULL COMMENT 'id района' AFTER `id_region`,
        ADD COLUMN `id_city` INT NULL DEFAULT NULL COMMENT 'id города' AFTER `id_area`,
        ADD COLUMN `id_mobileProvider` INT NULL DEFAULT NULL COMMENT 'id мобильного оператора' AFTER `id_city`,
        CHANGE COLUMN `Created` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создаания записи' AFTER `id_mobileProvider`,
        CHANGE COLUMN `Changed` `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `id_country` (`id_country`),
        ADD INDEX `MNC` (`MNC`),
        ADD INDEX `MCC` (`MCC`),
        ADD INDEX `gmt` (`gmt`),
        ADD INDEX `id_region` (`id_region`),
        ADD INDEX `id_area` (`id_area`),
        ADD INDEX `id_city` (`id_city`),
        ADD INDEX `id_mobileProvider` (`id_mobileProvider`);"
));

PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


CREATE TABLE IF NOT EXISTS `emClient` (
	`HIID` BIGINT(20) NOT NULL DEFAULT '0',
	`id_client` INT(11) NOT NULL AUTO_INCREMENT,
	`url` VARCHAR(255) NULL DEFAULT NULL COMMENT 'домен',
	`IP` VARCHAR(255) NULL DEFAULT NULL COMMENT 'IP как альтернатива домену',
	`port` SMALLINT(6) NOT NULL DEFAULT '3000' COMMENT 'порт',
	`login` VARCHAR(50) NOT NULL COMMENT 'Логин',
	`password` VARCHAR(100) NOT NULL COMMENT 'Пароль',
	`phone` BIGINT(20) NOT NULL COMMENT 'Телефон',
	`mobile_phone` BIGINT(20) NULL DEFAULT NULL COMMENT 'Мобильный',
	`email_info` VARCHAR(255) NOT NULL COMMENT 'Почта для информации',
	`email_tech` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Почта для тех вопросов и уведомлений',
	`email_finance` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Почта для фин уведомлений',
	`tarrif` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'тариф',
	`hosting_type` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID типа хостинга... У нас или на сервере клиента',
	`balance_amount` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Текущий баланс',
	`id_currency` INT(11) NOT NULL COMMENT 'ID валюты',
	`payment_type` INT(11) NULL DEFAULT NULL COMMENT 'ID типа оплаты',
	`fee` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'абонплата',
	`date_fee` TINYINT(4) NOT NULL COMMENT 'день снятия абонплаты',
	`count_of_calls` TINYINT(4) NULL DEFAULT NULL COMMENT 'доступная скорость обзвона',
	`white_ip` TEXT NULL COMMENT 'Список белых IP',
	`user_type` ENUM('USER','RESELLER') NOT NULL DEFAULT 'USER' COMMENT 'Тип профиля... Клиент или реселлер',
	`client_count` SMALLINT(6) NULL DEFAULT NULL COMMENT 'Кол-во клиентов у реселлера',
	`id_manager` SMALLINT(6) NULL DEFAULT NULL COMMENT 'ID менеджера этого клиента',
	`authorization_type` ENUM('NO','GOOGLE') NULL DEFAULT NULL COMMENT 'Тип 2ФА',
	`comments` TEXT NULL COMMENT 'Комментарий',
	`logo_url` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Адрес лого для кастомизации',
	`client_name` VARCHAR(255) NOT NULL COMMENT 'Название клиента',
	`client_contact` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Имя контактного лица',
	`isActive` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'Признак активности акаунта (глобален)',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	PRIMARY KEY (`id_client`),
	UNIQUE INDEX `url` (`url`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `id_currency` (`id_currency`),
	INDEX `payment_type` (`payment_type`),
	INDEX `fee` (`fee`),
	INDEX `id_manager` (`id_manager`),
	INDEX `HIID` (`HIID`)
)
COMMENT='Настройки клиента'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stCategory' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+410_1988'",
    "ALTER TABLE `emEmploy`
        ADD COLUMN `SipAccount` INT(11) NULL DEFAULT NULL COMMENT 'Уникальный ID, служащий логином при подлкючении телефона' AFTER `Aid`,
        ADD INDEX `SipAccount` (`SipAccount`),
        ADD INDEX `roleID` (`roleID`),
        ADD INDEX `HIID` (`HIID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'trID'
    ) > 0,
    "SELECT '+410_2140'",
    "ALTER TABLE `ast_trunk`
        ALTER `id` DROP DEFAULT,
        ALTER `name` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'trID'
    ) > 0,
    "SELECT '+410_2156'",
    "ALTER TABLE `ast_trunk`
        CHANGE COLUMN `id` `trID` INT(11) NOT NULL FIRST,
        CHANGE COLUMN `name` `trName` VARCHAR(50) NOT NULL AFTER `Aid`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+410_2156'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `HIID` BIGINT NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'port'
    ) > 0,
    "SELECT '+410_2188'",
    "ALTER TABLE `ast_trunk`
          ADD COLUMN `port` INT NULL DEFAULT NULL AFTER `callbackextension`,
          ADD COLUMN `isServer` BIT NULL DEFAULT NULL AFTER `port`,
          ADD COLUMN `type` INT(10) NULL DEFAULT NULL AFTER `isServer`,
          ADD COLUMN `directmedia` INT NULL DEFAULT NULL AFTER `type`,
          ADD COLUMN `insecure` INT NULL DEFAULT NULL AFTER `directmedia`,
          ADD COLUMN `outboundproxy` VARCHAR(60) NULL DEFAULT NULL AFTER `insecure`,
          ADD INDEX `isServer` (`isServer`),
          ADD INDEX `type` (`type`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'acl'
    ) > 0,
    "SELECT '+410_2210'",
    "ALTER TABLE `ast_trunk`
	      ADD COLUMN `acl` VARCHAR(60) NULL DEFAULT NULL AFTER `outboundproxy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND column_name = 'langID'
    ) > 0,
    "SELECT '+410_2210'",
    "ALTER TABLE `crmClientEx`
        ADD COLUMN `curID` INT NULL DEFAULT NULL AFTER `isDial`,
        ADD COLUMN `langID` INT NULL DEFAULT NULL AFTER `curID`,
        ADD COLUMN `sum` DECIMAL(14,2) NULL DEFAULT NULL AFTER `langID`,
        ADD INDEX `curID` (`curID`),
        ADD INDEX `langID` (`langID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND column_name = 'ttsID'
    ) > 0,
    "SELECT '+410_2244'",
    "ALTER TABLE `fsFile`
          ADD COLUMN `ttsID` INT(11) NULL DEFAULT NULL AFTER `dbID`,
          ADD INDEX `ttsID` (`ttsID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsClient' AND column_name = 'langID'
    ) > 0,
    "SELECT '+410_2303'",
    "ALTER TABLE `fsClient`
        ADD COLUMN `langID` INT NULL DEFAULT NULL AFTER `RegionDesc`,
        ADD COLUMN `curID` INT NULL DEFAULT NULL AFTER `langID`,
        ADD COLUMN `sum` DECIMAL(14,2) NULL DEFAULT NULL AFTER `curID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND column_name = 'ttsText'
    ) > 0,
    "SELECT '+410_2318'",
    "ALTER TABLE `crmClientEx`
	      ADD COLUMN `ttsText` LONGTEXT NULL DEFAULT NULL AFTER `sum`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsClient' AND column_name = 'ttsText'
    ) > 0,
    "SELECT '+410_2332'",
    "ALTER TABLE `fsClient`
	      ADD COLUMN `ttsText` LONGTEXT NULL DEFAULT NULL AFTER `sum`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `ast_route_incoming`
	CHANGE COLUMN `callerID` `callerID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'ID абонента, к которому привязывается правило' AFTER `DID`;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'destdata'
    ) > 0,
    "SELECT '+410_2350'",
    "DELETE FROM `ast_route_incoming` WHERE rtID>=0;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'destdata'
    ) > 0,
    "SELECT '+410_2363'",
    "ALTER TABLE `ast_route_incoming`
	      CHANGE COLUMN `DestData` `DestData` INT NULL DEFAULT NULL COMMENT 'Варианты обработчика из поля Destination' AFTER `Destination`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'destdata'
    ) > 0,
    "SELECT '+410_2376'",
    "ALTER TABLE `ast_route_incoming`
        CHANGE COLUMN `Destination` `destination` INT(11) NULL DEFAULT NULL COMMENT 'Тип обработчика звонка' AFTER `context`,
        CHANGE COLUMN `DestData` `destdata` INT(11) NULL DEFAULT NULL COMMENT 'Варианты обработчика из поля Destination' AFTER `destination`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND column_name = 'destdata'
    ) > 0,
    "SELECT '+410_2584'",
    "DELETE FROM ast_ivr_entries;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND column_name = 'uID'
    ) > 0,
    "SELECT '+410_2404'",
    "ALTER TABLE `ast_ivr_entries`
        CHANGE COLUMN `destination` `destination` INT NULL DEFAULT NULL AFTER `extension`,
        CHANGE COLUMN `destdata` `destdata` INT NULL DEFAULT NULL AFTER `destination`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND column_name = 'destdata'
    ) > 0,
    "SELECT '+410_2419'",
    "DELETE FROM ast_scenario;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND column_name = 'destdata'
    ) > 0,
    "SELECT '+410_2617'",
    "ALTER TABLE `ast_scenario`
	      CHANGE COLUMN `destdata` `destdata` INT NULL COMMENT 'DestData' AFTER `destination`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND column_name = 'uID'
    ) > 0,
    "SELECT '+410_2446'",
    "ALTER TABLE `ccContact`
        ADD COLUMN `uID` BIGINT NULL DEFAULT NULL COMMENT 'Уникальный идентификатор звонка' AFTER `ffID`,
        ADD INDEX `uID` (`uID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2461'",
    "DELETE FROM ast_ivr_config WHERE id_ivr_config>=0;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2474'",
    "ALTER TABLE `ast_ivr_config`
        CHANGE COLUMN `invalid_destination` `invalid_destination` INT NULL DEFAULT NULL COMMENT 'Destination для ошибочного ввода' AFTER `invalid_record_id`,
        CHANGE COLUMN `invalid_destdata` `invalid_destdata` INT NULL DEFAULT NULL COMMENT 'DestData для ошибочного ввода' AFTER `invalid_destination`,
        CHANGE COLUMN `timeout_destination` `timeout_destination` INT NULL DEFAULT NULL COMMENT 'Destination для таймута' AFTER `timeout_record_id`,
        CHANGE COLUMN `timeout_destdata` `timeout_destdata` INT NULL DEFAULT NULL COMMENT 'DestData для таймаута' AFTER `timeout_destination`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2491'",
    "ALTER TABLE `ast_route_incoming`
	      ALTER `IsActive` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2505'",
    "ALTER TABLE `ast_scenario`
	      ALTER `callerID` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2519'",
    "ALTER TABLE `ast_scenario`
	        CHANGE COLUMN `callerID` `callerID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Номер выделенный в транке' AFTER `Aid`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2533'",
    "ALTER TABLE `ast_scenario`
	      CHANGE COLUMN `AutoDial` `AutoDial` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Информация, которую отображать при звонке на экране' AFTER `SleepTime`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND BINARY column_name = 'destionation'
    ) = 0,
    "SELECT '+410_2664'",
    "ALTER TABLE `ast_scenario`
          CHANGE COLUMN `destionation` `destionation` INT(11) NULL DEFAULT NULL COMMENT 'ID destination' AFTER `AllowPrefix`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND BINARY column_name = 'isActive'
    ) > 0,
    "SELECT '+410_2675'",
    "ALTER TABLE `ast_scenario`
          CHANGE COLUMN `AllowPrefix` `AllowPrefix` LONGTEXT NULL DEFAULT NULL COMMENT 'Префиксы разрешенные в обзвоне' AFTER `IsCheckCallFromOther`,
          CHANGE COLUMN `destdata` `destdata` INT(11) NULL DEFAULT NULL COMMENT 'DestData' AFTER `destination`,
          CHANGE COLUMN `target` `target` LONGTEXT NULL DEFAULT NULL COMMENT 'Описание метода достижения цели' AFTER `destdata`,
          CHANGE COLUMN `IsActive` `isActive` BIT(1) NOT NULL COMMENT 'Признак активности' AFTER `target`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND BINARY column_name = 'ChimeDate'
    ) = 0,
    "SELECT '+410_2594'",
    "ALTER TABLE `fsFile`
        DROP COLUMN `ChimeDate`,
        DROP COLUMN `Queue`,
        DROP COLUMN `DialOuts`,
        DROP COLUMN `rcID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `crmClient`
	      CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `dcDoc`
	    CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `stProduct`
	      CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmOrg' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `crmOrg`
	      CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `CreatedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `crmClientEx`
	      ALTER `EditedBy` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `crmClientEx`
    	CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NOT NULL AFTER `CallDate`,
      ADD INDEX `ChangedBy` (`ChangedBy`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stBrand' AND BINARY column_name = 'ChangedBy'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `stBrand`
      CHANGE COLUMN `EditedBy` `ChangedBy` INT(11) NULL DEFAULT NULL AFTER `Changed`,
      ADD INDEX `ChangedBy` (`ChangedBy`),
      ADD INDEX `Changed` (`Changed`),
      ADD INDEX `CreatedBy` (`CreatedBy`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND BINARY column_name = 'EditedAt'
    ) = 0,
    "SELECT '+410_2628'",
    "ALTER TABLE `emRole`
        DROP COLUMN `EditedAt`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND BINARY column_name = 'EditedBy'
    ) = 0,
    "SELECT '+410_2639'",
    "ALTER TABLE `emRole`
        DROP COLUMN `EditedBy`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND BINARY column_name = 'CreatedAt'
    ) = 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `emRole`
        CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
        ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emRole' AND BINARY column_name = 'Changed'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `emRole`
	      ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND BINARY column_name = 'gmt'
    ) > 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `crmContact`
        CHANGE COLUMN `ccStatus` `ccStatus` INT(11) NULL DEFAULT NULL AFTER `isActive`,
        CHANGE COLUMN `ccComment` `ccComment` VARCHAR(100) NULL DEFAULT NULL AFTER `ccStatus`,
        ADD COLUMN `gmt` INT NULL DEFAULT NULL AFTER `ccComment`,
        ADD COLUMN `MCC` INT NULL DEFAULT NULL AFTER `gmt`,
        ADD COLUMN `MNC` INT NULL DEFAULT NULL AFTER `MCC`,
        ADD COLUMN `id_country` INT NULL DEFAULT NULL AFTER `MNC`,
        ADD COLUMN `id_region` INT NULL DEFAULT NULL AFTER `id_country`,
        ADD COLUMN `id_area` INT NULL DEFAULT NULL AFTER `id_region`,
        ADD COLUMN `id_city` INT NULL DEFAULT NULL AFTER `id_area`,
        ADD COLUMN `id_mobileProvider` INT NULL DEFAULT NULL AFTER `id_city`,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `id_mobileProvider` (`id_mobileProvider`),
        ADD INDEX `id_city` (`id_city`),
        ADD INDEX `id_area` (`id_area`),
        ADD INDEX `id_region` (`id_region`),
        ADD INDEX `id_country` (`id_country`),
        ADD INDEX `MNC` (`MNC`),
        ADD INDEX `gmt` (`gmt`),
        ADD INDEX `MCC` (`MCC`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_autodial_process' AND BINARY column_name = 'idEmployer'
    ) = 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `ast_autodial_process`
	        ALTER `idEmployer` DROP DEFAULT;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_autodial_process' AND BINARY column_name = 'idEmployer'
    ) = 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `ast_autodial_process`
	      CHANGE COLUMN `idEmployer` `emID` INT(11) NULL COMMENT 'ID пользователя, запустившего обзвон' AFTER `id_scenario`,
	      CHANGE COLUMN `called` `called` INT(11) NULL DEFAULT '0' AFTER `factor`,
	      CHANGE COLUMN `targetCalls` `targetCalls` INT(11) NULL DEFAULT '0' AFTER `called`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND BINARY column_name = 'destionation'
    ) = 0,
    "SELECT '+410_2638'",
    "ALTER TABLE `ast_scenario`
	        CHANGE COLUMN `destionation` `destination` INT(11) NULL DEFAULT NULL COMMENT 'ID destination' AFTER `AllowPrefix`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND BINARY column_name = 'ttsID'
    ) > 0,
    "SELECT '+410_2993'",
    "ALTER TABLE `fsFile`
	      DROP COLUMN `ttsID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1988'",
    "ALTER TABLE `emEmploy`
        ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stProduct' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1801'",
    "ALTER TABLE `stProduct`
          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_1630'",
    "ALTER TABLE `dcDoc`
          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND BINARY column_name = 'Changed'
    ) > 0,
    "SELECT '+410_1630'",
    "ALTER TABLE `ccContact`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' AFTER `dcID`,
          ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' AFTER `ffID`,
          CHANGE COLUMN `Created` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
          DROP COLUMN `uID`,
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `ccID` (`ccID`),
          ADD INDEX `ccName` (`ccName`),
          ADD INDEX `IsOut` (`IsOut`),
          ADD INDEX `SIP` (`SIP`),
          ADD INDEX `channel` (`channel`),
          ADD INDEX `isAutocall` (`isAutocall`),
          ADD INDEX `Queue` (`Queue`),
          ADD INDEX `CallType` (`CallType`),
          ADD INDEX `IsMissed` (`IsMissed`),
          ADD INDEX `id_autodial` (`id_autodial`),
          ADD INDEX `id_scenario` (`id_scenario`),
          ADD INDEX `IsTarget` (`IsTarget`),
          ADD INDEX `ccStatus` (`ccStatus`),
          ADD INDEX `emID` (`emID`),
          ADD INDEX `clID` (`clID`),
          ADD INDEX `ffID` (`ffID`),
          ADD INDEX `isActive` (`isActive`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_record' AND BINARY column_name = 'Changed'
    ) > 0,
    "SELECT '+410_1630'",
    "ALTER TABLE `ast_record`
        CHANGE COLUMN `Updated` `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND BINARY column_name = 'Changed'
    ) > 0,
    "SELECT '+410_3072'",
    "ALTER TABLE `crmClient`
	        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

call us_InsMessage(77107, 'Превышен допустимый период - одни сутки!');
call us_InsMessage(77108, 'Превышен допустимый период - 30 дней!');
call us_InsMessage(77109, 'Превышен допустимый период - 1 год!');
call us_InsMessage(77110, 'Превышен допустимый период - 5 лет!');

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usEnumValue' AND BINARY column_name = 'Created'
    ) > 0,
    "SELECT '+410_3088'",
    "ALTER TABLE `usEnumValue`
        ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `Name` (`Name`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND BINARY column_name = 'ttsID'
    ) > 0,
    "SELECT '+410_3110'",
    "ALTER TABLE `ast_ivr_config`
        CHANGE COLUMN `ivr_description` `ivr_description` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Описание IVR' AFTER `ivr_name`,
        CHANGE COLUMN `enable_direct_dial` `enable_direct_dial` BIT(1) NULL DEFAULT b'0' AFTER `record_id`,
        CHANGE COLUMN `timeout` `timeout` INT(11) NULL DEFAULT NULL AFTER `enable_direct_dial`,
        CHANGE COLUMN `invalid_retries` `invalid_retries` INT(11) NULL DEFAULT NULL AFTER `volume`,
        CHANGE COLUMN `append_record_to_invalid` `append_record_to_invalid` BIT(1) NULL DEFAULT b'0' COMMENT 'Включить проигрывание записи при ошибочном вооде' AFTER `retry_record_id`,
        CHANGE COLUMN `return_on_invalid` `return_on_invalid` BIT(1) NULL DEFAULT b'0' COMMENT 'Включить возврата к родительскому IVR' AFTER `append_record_to_invalid`,
        CHANGE COLUMN `invalid_record_id` `invalid_record_id` INT(11) NULL DEFAULT NULL AFTER `return_on_invalid`,
        CHANGE COLUMN `timeout_retries` `timeout_retries` INT(11) NULL DEFAULT NULL AFTER `invalid_destdata`,
        CHANGE COLUMN `timeout_retry_record_id` `timeout_retry_record_id` INT(11) NULL DEFAULT NULL AFTER `timeout_retries`,
        CHANGE COLUMN `append_record_on_timeout` `append_record_on_timeout` BIT(1) NULL DEFAULT b'0' COMMENT 'Включить применение IVR записи, для таумаута' AFTER `timeout_retry_record_id`,
        CHANGE COLUMN `return_on_timeout` `return_on_timeout` BIT(1) NULL DEFAULT b'0' COMMENT 'Включить возврат к таймауту' AFTER `append_record_on_timeout`,
        CHANGE COLUMN `timeout_record_id` `timeout_record_id` INT(11) NULL DEFAULT NULL AFTER `return_on_timeout`,
        CHANGE COLUMN `return_to_ivr_after_vm` `return_to_ivr_after_vm` BIT(1) NULL DEFAULT b'0' COMMENT 'Включить возврат к IVR после VoiceMail' AFTER `timeout_destdata`,
        ADD COLUMN `ttsID` INT NULL DEFAULT NULL COMMENT 'ID связного TTS' AFTER `return_to_ivr_after_vm`,
        ADD INDEX `ttsID` (`ttsID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND ENGINE = 'InnoDB'
    ) = 0,
    "SELECT '+410_3142'",
    "ALTER TABLE `ast_ivr_config`
	          ENGINE=MyISAM;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `ast_ivr_entries`
	CHANGE COLUMN `return` `return` BIT(1) NULL DEFAULT b'0' AFTER `destdata`;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND BINARY column_name = 'uniqName'
    ) > 0,
    "SELECT '+410_3151'",
    "ALTER TABLE `ast_trunk`
	      ADD COLUMN `uniqName` VARCHAR(55) NULL AFTER `trName`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

call us_InsMessage(77111, 'Trunk с таким названием уже существует');
call us_InsMessage(77112, 'Такой DID уже используется');
call us_InsMessage(77113, 'Trunk не выбран');

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queue_members' AND BINARY column_name = 'Created'
    ) > 0,
    "SELECT '+410_3165'",
    "ALTER TABLE `ast_queue_members`
        ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `isActive` (`isActive`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND BINARY column_name = 'target'
    ) > 0,
    "SELECT '+410_3158'",
    "ALTER TABLE `ccContact`
          ADD COLUMN `target` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Данные о достижения цели (например последовательность нажатия цифр в IVR)' AFTER `IsTarget`,
          ADD INDEX `target` (`target`),
          ADD INDEX `duration` (`duration`),
          ADD INDEX `LinkFile` (`LinkFile`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS `ccContactStat` (
	`HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0',
	`statID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`Aid` INT UNSIGNED NOT NULL DEFAULT '0',
	`ccName` VARCHAR(50) NOT NULL,
	`callsDate` DATETIME NOT NULL,
	`calls` INT NOT NULL DEFAULT '0',
	`callsAutocall` INT NOT NULL DEFAULT '0',
	`callsOut` INT NOT NULL DEFAULT '0',
	`callsIn` INT NOT NULL DEFAULT '0',
	`callsRinging` INT NOT NULL DEFAULT '0',
	`callsUp` INT NOT NULL DEFAULT '0',
	`callsAnswered` INT NOT NULL DEFAULT '0',
	`callsNoanswered` INT NOT NULL DEFAULT '0',
	`callsBusy` INT NOT NULL DEFAULT '0',
	`callsFailed` INT NOT NULL DEFAULT '0',
	`callsCongestion` INT NOT NULL DEFAULT '0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `Created` (`Created`),
	INDEX `callsCongestion` (`callsCongestion`),
	INDEX `callsFailed` (`callsFailed`),
	INDEX `callsBusy` (`callsBusy`),
	INDEX `callsNoanswered` (`callsNoanswered`),
	INDEX `callsAnswered` (`callsAnswered`),
	INDEX `callsUp` (`callsUp`),
	INDEX `callsRinging` (`callsRinging`),
	INDEX `callsIn` (`callsIn`),
	INDEX `callsOut` (`callsOut`),
	INDEX `callsAutocall` (`callsAutocall`),
	INDEX `calls` (`calls`),
	INDEX `callsDate` (`callsDate`),
	INDEX `ccName` (`ccName`),
	INDEX `Aid` (`Aid`),
	INDEX `statID` (`statID`),
	INDEX `HIID` (`HIID`)
)
COMMENT='таблица хранящая информацию о звонках на номер'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

ALTER TABLE `ast_sippeers`
	CHANGE COLUMN `emID` `emID` INT(11) NULL DEFAULT NULL AFTER `RowVersion`;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usEnumValue' AND BINARY column_name = 'tvID' AND column_key='PRI'
    ) = 0,
    "SELECT '+410_3205'",
    "ALTER TABLE `usEnumValue`
	      DROP PRIMARY KEY;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'sfInvoiceItem' AND BINARY column_name = 'Aid'
    ) > 0,
    "SELECT '+410_3204'",
    "ALTER TABLE `sfInvoiceItem`
          ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' AFTER `iiID`,
          ADD COLUMN `isActive` BIT NULL DEFAULT b'1' AFTER `iComments`,
          ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `isActive`,
          ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `Created`,
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `Aid` (`Aid`),
          ADD INDEX `OwnerID` (`OwnerID`),
          ADD INDEX `dcID` (`dcID`),
          ADD INDEX `psID` (`psID`),
          ADD INDEX `iNo` (`iNo`),
          ADD INDEX `iName` (`iName`),
          ADD INDEX `iPrice` (`iPrice`),
          ADD INDEX `iQty` (`iQty`),
          ADD INDEX `iComments` (`iComments`),
          ADD INDEX `isActive` (`isActive`),
          ADD INDEX `Created` (`Created`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

call us_InsMessage(77114, 'Вы не выбрали ни одного параметра');

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_autodial_process' AND BINARY column_name = 'planDateBegin'
    ) > 0,
    "SELECT '+410_3232'",
    "ALTER TABLE `ast_autodial_process`
          ADD COLUMN `planDateBegin` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `targetCalls`,
          ADD COLUMN `planDateEnd` DATETIME NULL DEFAULT NULL AFTER `planDateBegin`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND BINARY column_name = 'HIID'
    ) > 0,
    "SELECT '+410_3244'",
    "ALTER TABLE `crmTag`
      ADD COLUMN `HIID` BIGINT NOT NULL DEFAULT '0' FIRST,
      ADD INDEX `HIID` (`HIID`);"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;


