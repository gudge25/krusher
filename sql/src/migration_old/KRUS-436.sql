SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_autodial_process' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_6'",
    "ALTER TABLE `ast_autodial_process`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        CHANGE COLUMN `process` `process` INT(11) NOT NULL DEFAULT '0' COMMENT 'Статус процесса' AFTER `TimeUpdated`,
        ADD INDEX `process` (`process`),
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_20'",
    "ALTER TABLE `ast_ivr_config`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_entries' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_32'",
    "ALTER TABLE `ast_ivr_entries`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queues' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_44'",
    "ALTER TABLE `ast_queues`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queue_members' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_56'",
    "ALTER TABLE `ast_queue_members`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_record' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_68'",
    "ALTER TABLE `ast_record`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_80'",
    "ALTER TABLE `ast_route_incoming`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);



SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'trID'
    ) = 0,
    "SELECT '+436_126'",
    "ALTER TABLE `ast_route_outgoing`
        DROP COLUMN `trID`,
        DROP COLUMN `trunk`,
        DROP COLUMN `isReadable`,
        DROP INDEX `prefix_idTr`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_80'",
    "ALTER TABLE `ast_scenario`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `name_scenario` (`name_scenario`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_141'",
    "ALTER TABLE `ast_sippeers`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccComment' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_153'",
    "ALTER TABLE `ccComment`
	        ALTER `cccID` DROP DEFAULT;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccComment' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_164'",
    "ALTER TABLE `ccComment`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        CHANGE COLUMN `cccID` `cccID` INT(11) NOT NULL AFTER `HIID`,
        ADD INDEX `HIID` (`HIID`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `dcID` (`dcID`),
        ADD INDEX `comName` (`comName`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccCommentList' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_181'",
    "ALTER TABLE `ccCommentList`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_193'",
    "ALTER TABLE `crmClientEx`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`),
          ADD INDEX `isDial` (`isDial`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND column_name = 'HIID'
    ) = 0,
    "SELECT '+436_206'",
    "ALTER TABLE `crmStatus`
        DROP COLUMN `HIID`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND column_name = 'HIID'
    ) = 0,
    "SELECT '+436_217'",
    "ALTER TABLE `crmStatus`
        DROP COLUMN `HIID`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND column_name = 'isActive'
    ) = 0,
    "SELECT '+436_228'",
    "ALTER TABLE `crmStatus`
	      DROP COLUMN `isActive`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_240'",
    "ALTER TABLE `crmTag`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcType' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_243'",
    "ALTER TABLE `dcType`
	      ALTER `dctID` DROP DEFAULT;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcType' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_254'",
    "ALTER TABLE `dcType`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL FIRST,
        CHANGE COLUMN `dctID` `dctID` INT NOT NULL AFTER `HIID`,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmployEx' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_267'",
    "ALTER TABLE `emEmployEx`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsBase' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_279'",
    "ALTER TABLE `fsBase`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_291'",
    "ALTER TABLE `fsFile`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplate' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_303'",
    "ALTER TABLE `fsTemplate`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItem' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_315'",
    "ALTER TABLE `fsTemplateItem`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsTemplateItemCol' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_327'",
    "ALTER TABLE `fsTemplateItemCol`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'reg_cities' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_339'",
    "ALTER TABLE `reg_cities`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'reg_countries' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_351'",
    "ALTER TABLE `reg_countries`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'reg_operator' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_363'",
    "ALTER TABLE `reg_operator`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'reg_regions' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_375'",
    "ALTER TABLE `reg_regions`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'reg_validation' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_387'",
    "ALTER TABLE `reg_validation`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'stCategory' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_399'",
    "ALTER TABLE `stCategory`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usComment' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_436'",
    "ALTER TABLE `usComment`
          ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
          ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'usEnumValue' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_448'",
    "ALTER TABLE `usEnumValue`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND column_name = 'clID'
    ) = 0,
    "SELECT '+436_456'",
    "RENAME TABLE `crmTag` TO `crmTagL`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND column_name = 'clID'
    ) = 0,
    "SELECT '+436_466'",
    "RENAME TABLE `crmTag` TO `crmTagL`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTagList' AND column_name = 'clID'
    ) > 0,
    "SELECT '+436_476'",
    "RENAME TABLE `crmTagList` TO `crmTag`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTagL'
    ) = 0,
    "SELECT '+436_486'",
    "RENAME TABLE `crmTagL` TO `crmTagList`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTag' AND column_name = 'Aid'
    ) > 0,
    "SELECT '+436_497'",
    "ALTER TABLE `crmTag`
        ADD COLUMN `Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `tagID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи' AFTER `tagDesc`,
        ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи' AFTER `Created`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `tagName` (`tagName`),
        ADD INDEX `Created` (`Created`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmTagList' AND column_name = 'HIID'
    ) > 0,
    "SELECT '+436_231'",
    "ALTER TABLE `crmTagList`
        ADD COLUMN `HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0' FIRST,
        ADD INDEX `HIID` (`HIID`);"
));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `ast_custom_destination` (
	`HIID` BIGINT UNSIGNED NOT NULL DEFAULT '0',
	`cdID` INT UNSIGNED NOT NULL DEFAULT '0',
	`Aid` INT UNSIGNED NOT NULL DEFAULT '0',
	`description` VARCHAR(250) NULL DEFAULT NULL,
	`notes` TEXT NULL DEFAULT NULL,
	`return` BIT NOT NULL DEFAULT b'1',
	`destination` INT NULL DEFAULT NULL,
	`destdata` INT NULL DEFAULT NULL,
	`isActive` BIT NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `destdata` (`destdata`),
	INDEX `destination` (`destination`),
	INDEX `return` (`return`),
	INDEX `description` (`description`),
	INDEX `Aid` (`Aid`),
	INDEX `cdID` (`cdID`),
	INDEX `HIID` (`HIID`)
)
COMMENT='Индивидуальные настройки'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'poolID'
    ) = 0,
    "SELECT '+436_561'",
    "ALTER TABLE `ast_route_outgoing`
          DROP COLUMN `poolID`,
          DROP INDEX `prefix_idTr`;"
));
CALL query_exec(@s);


