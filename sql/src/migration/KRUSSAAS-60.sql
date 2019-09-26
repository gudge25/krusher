CREATE TABLE IF NOT EXISTS `ast_route_outgoing` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`roID` INT(11) NOT NULL,
	`roName` VARCHAR(50) NULL DEFAULT NULL,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`destination` INT(11) NULL DEFAULT NULL,
	`destdata` INT(11) NULL DEFAULT NULL,
	`category` INT(11) NULL DEFAULT NULL,
	`prepend` VARCHAR(50) NULL DEFAULT NULL,
	`prefix` VARCHAR(50) NULL DEFAULT NULL,
	`callerID` VARCHAR(50) NULL DEFAULT NULL,
	`priority` INT(11) NULL DEFAULT '1',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
	PRIMARY KEY (`roID`),
	UNIQUE INDEX `Aid_category_callerID` (`Aid`, `category`, `callerID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `destination` (`destination`),
	INDEX `destdata` (`destdata`),
	INDEX `HIID` (`HIID`),
	INDEX `roName` (`roName`),
	INDEX `priority` (`priority`),
	INDEX `prepend` (`prepend`),
	INDEX `prefix` (`prefix`)
)
COMMENT='Схема трафика для голоса'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND column_name = 'nat'
    ) > 0,
    "SELECT '+60_6'",
    "ALTER TABLE `ast_sippeers`
        ADD COLUMN `nat` INT NULL DEFAULT NULL AFTER `callerid`,
        ADD INDEX `nat` (`nat`),
        ADD INDEX `callerid` (`callerid`),
        ADD INDEX `callgroup` (`callgroup`),
        ADD INDEX `pickupgroup` (`pickupgroup`),
        ADD INDEX `context` (`context`),
        ADD INDEX `secret` (`secret`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'nat' AND DATA_TYPE = 'varchar'
    ) = 0,
    "SELECT '+60_23'",
    "ALTER TABLE `ast_trunk`
	      CHANGE COLUMN `Aid` `Aid` INT(11) NOT NULL DEFAULT '0' AFTER `trID`;"
));
PREPARE stmt FROM @s; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'Comment'
    ) > 0,
    "SELECT '+60_34'",
    "ALTER TABLE `ast_trunk`
        CHANGE COLUMN `Changed` `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `Created`,
        ADD COLUMN `Comment` VARCHAR(50) NULL DEFAULT NULL AFTER `isReadable`,
        ADD INDEX `uniqName` (`uniqName`),
        ADD INDEX `template` (`template`),
        ADD INDEX `secret` (`secret`),
        ADD INDEX `context` (`context`),
        ADD INDEX `callgroup` (`callgroup`),
        ADD INDEX `pickupgroup` (`pickupgroup`),
        ADD INDEX `callerid` (`callerid`),
        ADD INDEX `host` (`host`),
        ADD INDEX `nat` (`nat`),
        ADD INDEX `fromuser` (`fromuser`),
        ADD INDEX `fromdomain` (`fromdomain`),
        ADD INDEX `callbackextension` (`callbackextension`),
        ADD INDEX `port` (`port`),
        ADD INDEX `directmedia` (`directmedia`),
        ADD INDEX `outboundproxy` (`outboundproxy`),
        ADD INDEX `insecure` (`insecure`),
        ADD INDEX `acl` (`acl`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'nat' AND DATA_TYPE = 'varchar'
    ) = 0,
    "SELECT '+60_63'",
    "UPDATE ast_trunk SET `Comment`=nat;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'nat' AND DATA_TYPE = 'varchar'
    ) = 0,
    "SELECT '+60_73'",
    "UPDATE `ast_trunk` SET nat=NULL;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND column_name = 'nat' AND DATA_TYPE = 'varchar'
    ) = 0,
    "SELECT '+60_83'",
    "ALTER TABLE `ast_trunk`
	      CHANGE COLUMN `nat` `nat` INT NULL DEFAULT NULL AFTER `host`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM ast_trunk
     WHERE nat IS NULL
    ) = 0,
    "SELECT '+60_94'",
    "UPDATE ast_trunk t SET nat = (SELECT tvID FROM usEnumValue WHERE tyID=1025 AND Name=t.`Comment` LIMIT 1);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'category'
    ) > 0,
    "SELECT '+60_104'",
    "ALTER TABLE `ast_route_outgoing`
          ADD COLUMN `category` INT(11) NULL DEFAULT NULL AFTER `destdata`,
          ADD COLUMN `callerID` VARCHAR(50) NULL DEFAULT NULL AFTER `category`,
          DROP INDEX `Aid`,
          DROP INDEX `prefix`,
          ADD UNIQUE INDEX `Aid_prefix_category_callerID` (`Aid`, `prefix`, `category`, `callerID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_custom_destination' AND column_name = 'cdName'
    ) > 0,
    "SELECT '+60_119'",
    "ALTER TABLE `ast_custom_destination`
          ADD COLUMN `cdName` VARCHAR(50) NULL DEFAULT NULL AFTER `Aid`,
          ADD COLUMN `context` VARCHAR(50) NULL DEFAULT NULL AFTER `cdName`,
          ADD INDEX `cdName` (`cdName`),
          ADD INDEX `context` (`context`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'roName'
    ) > 0,
    "SELECT '+60_133'",
    "ALTER TABLE `ast_route_outgoing`
          ADD COLUMN `roName` VARCHAR(50) NULL DEFAULT NULL AFTER `roID`,
          ADD INDEX `roName` (`roName`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'idGroup'
    ) = 0,
    "SELECT '+60_145'",
    "ALTER TABLE `ast_route_outgoing`
        DROP COLUMN `MCC`,
        DROP COLUMN `MNC`,
        DROP COLUMN `prefix`,
        DROP COLUMN `idGroup`,
        DROP INDEX `Aid_prefix_category_callerID`,
        ADD UNIQUE INDEX `Aid_category_callerID` (`Aid`, `category`, `callerID`);"
));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `ast_route_outgoing_items` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`roiID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`roID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`pattern` VARCHAR(50) NOT NULL DEFAULT '0' COMMENT 'префикс',
	`callerID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Caller ID для префикса',
	`isActive` BIT(1) NOT NULL DEFAULT b'0',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`roiID`),
	UNIQUE INDEX `uniq` (`roID`, `pattern`, `callerID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COMMENT='Префиксы исходящих роутов'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'priority'
    ) > 0,
    "SELECT '+60_185'",
    "ALTER TABLE `ast_route_outgoing`
          ADD COLUMN `priority` INT NULL DEFAULT '1' AFTER `callerID`,
          ADD INDEX `priority` (`priority`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'dcDoc' AND column_name = 'ffID'
    ) > 0,
    "SELECT '+60_197'",
    "ALTER TABLE `dcDoc`
        ADD COLUMN `ffID` INT(11) NOT NULL DEFAULT '0' AFTER `clID`,
        ADD INDEX `ffID` (`ffID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND column_name = 'ffID'
    ) > 0,
    "SELECT '+60_209'",
    "ALTER TABLE `crmContact`
      ADD COLUMN `ffID` INT(11) NOT NULL DEFAULT '0' AFTER `clID`,
      ADD INDEX `ffID` (`ffID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClientEx' AND column_name = 'ffID'
    ) > 0,
    "SELECT '+60_221'",
    "ALTER TABLE `crmClientEx`
          ADD COLUMN `ffID` INT(11) NOT NULL DEFAULT '0' AFTER `Aid`,
          ADD COLUMN `cusID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'customer ID - некий ID клиента' AFTER `ttsText`,
          ADD INDEX `ffID` (`ffID`),
          ADD INDEX `cusID` (`cusID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmStatus' AND column_name = 'ffID'
    ) > 0,
    "SELECT '+60_233'",
    "ALTER TABLE `crmStatus`
        ADD COLUMN `ffID` INT(11) NOT NULL DEFAULT '0' AFTER `Aid`,
        ADD INDEX `ffID` (`ffID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND TABLE_NAME = 'crmClient'  AND CONSTRAINT_NAME = 'clID_Aid'
    ) > 0,
    "SELECT '+60_280'",
    "ALTER TABLE `crmClient`
        DROP PRIMARY KEY,
        ADD INDEX `clID` (`clID`),
        ADD UNIQUE INDEX `clID_Aid` (`clID`, `Aid`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND TABLE_NAME = 'fsFile'  AND CONSTRAINT_NAME = 'ffID_Aid'
    ) > 0,
    "SELECT '+60_293'",
    "ALTER TABLE `fsFile`
          DROP PRIMARY KEY,
          ADD UNIQUE INDEX `ffID_Aid` (`ffID`, `Aid`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM information_schema.table_constraints
     WHERE TABLE_SCHEMA = 'krusher' AND TABLE_NAME = 'crmClient' AND CONSTRAINT_NAME = 'clID_ffID'
    ) = 0,
    "SELECT '+60_305'",
    "ALTER TABLE `crmClient`
	      DROP INDEX `clID_ffID`;"
));
CALL query_exec(@s);

call us_InsMessage(77115, 'Данные не найдены');

UPDATE emEmploy SET Aid=0 WHERE LoginName='system';

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_custom_destination' AND column_name = 'exten'
    ) > 0,
    "SELECT '+60_320'",
    "ALTER TABLE `ast_custom_destination`
        ADD COLUMN `exten` VARCHAR(50) NULL DEFAULT NULL AFTER `context`,
        ADD COLUMN `priority` INT(11) NULL DEFAULT '1' AFTER `destdata`,
        DROP INDEX `cdID`,
        ADD INDEX `exten` (`exten`),
        ADD INDEX `priority` (`priority`),
        ADD PRIMARY KEY (`cdID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND column_name = 'prepend'
    ) > 0,
    "SELECT '+60_336'",
    "ALTER TABLE `ast_route_outgoing`
        ADD COLUMN `prepend` VARCHAR(50) NULL DEFAULT NULL AFTER `category`,
        ADD COLUMN `prefix` VARCHAR(50) NULL DEFAULT NULL AFTER `prepend`,
        ADD INDEX `prepend` (`prepend`),
        ADD INDEX `prefix` (`prefix`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing_items' AND column_name = 'pattern'
    ) > 0,
    "SELECT '+60_350'",
    "ALTER TABLE `ast_route_outgoing_items`
        CHANGE COLUMN `prefix` `pattern` VARCHAR(50) NOT NULL DEFAULT '0' COMMENT 'префикс' AFTER `roID`,
        DROP COLUMN `annexe`,
        DROP COLUMN `template`,
        DROP INDEX `roID_annexe_prefix_template_callerID`,
        ADD UNIQUE INDEX `uniq` (`roID`, `pattern`, `callerID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND COLUMN_NAME='record_id' AND DATA_TYPE='varchar'
    ) > 0,
    "SELECT '+60_364'",
    "ALTER TABLE `ast_ivr_config`
        CHANGE COLUMN `record_id` `record_id` VARCHAR(250) NULL DEFAULT NULL AFTER `ivr_description`,
        CHANGE COLUMN `retry_record_id` `retry_record_id` VARCHAR(250) NULL DEFAULT NULL AFTER `invalid_retries`,
        CHANGE COLUMN `invalid_record_id` `invalid_record_id` VARCHAR(250) NULL DEFAULT NULL AFTER `return_on_invalid`,
        CHANGE COLUMN `timeout_retry_record_id` `timeout_retry_record_id` VARCHAR(250) NULL DEFAULT NULL AFTER `timeout_retries`,
        CHANGE COLUMN `timeout_record_id` `timeout_record_id` VARCHAR(250) NULL DEFAULT NULL AFTER `return_on_timeout`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_autodial_process' AND COLUMN_NAME='TimeBegin'
    ) = 0,
    "SELECT '+60_379'",
    "ALTER TABLE `ast_autodial_process`
        DROP COLUMN `TimeBegin`,
        DROP COLUMN `TimeUpdated`,
        ADD INDEX `planDateBegin` (`planDateBegin`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND COLUMN_NAME='invalid_destdata2'
    ) > 0,
    "SELECT '+60_392'",
    "ALTER TABLE `ast_ivr_config`
        ADD COLUMN `invalid_destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `invalid_destdata`,
        ADD COLUMN `timeout_destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `timeout_destdata`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_entries' AND COLUMN_NAME='destdata2'
    ) > 0,
    "SELECT '+60_404'",
    "ALTER TABLE `ast_ivr_entries`
	      ADD COLUMN `destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `destdata`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_custom_destination' AND COLUMN_NAME='destdata2'
    ) > 0,
    "SELECT '+60_415'",
    "ALTER TABLE `ast_custom_destination`
        ADD COLUMN `destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `destdata`,
        ADD INDEX `destdata2` (`destdata2`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND COLUMN_NAME='destdata2'
    ) > 0,
    "SELECT '+60_427'",
    "ALTER TABLE `ast_scenario`
	      ADD COLUMN `destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `destdata`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND COLUMN_NAME='destdata2'
    ) > 0,
    "SELECT '+60_438'",
    "ALTER TABLE `ast_route_incoming`
	      ADD COLUMN `destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `destdata`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND COLUMN_NAME='destdata2'
    ) > 0,
    "SELECT '+60_449'",
    "ALTER TABLE `ast_route_outgoing`
        ADD COLUMN `destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `destdata`,
        ADD INDEX `destdata2` (`destdata2`);"
));
CALL query_exec(@s);

call us_InsNewEnums(102901, 1029, 'auto', TRUE);
call us_InsNewEnums(102902, 1029, 'info', TRUE);
call us_InsNewEnums(102903, 1029, 'rfc2833', TRUE);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND COLUMN_NAME='dtmfmode'
    ) > 0,
    "SELECT '+60_465'",
    "ALTER TABLE `ast_sippeers`
        ADD COLUMN `dtmfmode` INT(11) NULL DEFAULT NULL AFTER `nat`,
        ADD INDEX `dtmfmode` (`dtmfmode`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='dtmfmode'
    ) > 0,
    "SELECT '+60_477'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `dtmfmode` INT NULL DEFAULT NULL AFTER `acl`,
        ADD INDEX `dtmfmode` (`dtmfmode`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing_items' AND COLUMN_NAME='priority'
    ) > 0,
    "SELECT '+60_489'",
    "ALTER TABLE `ast_route_outgoing_items`
        ADD COLUMN `priority` INT NULL DEFAULT NULL AFTER `callerID`,
        ADD INDEX `priority` (`priority`);"
));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `ast_time_group` (
	`HIID` BIGINT NULL DEFAULT '0',
	`tgID` INT NOT NULL DEFAULT '0',
	`Aid` INT NULL DEFAULT '0',
	`tgName` VARCHAR(50) NULL DEFAULT NULL,
	`destination` INT(11) NULL DEFAULT NULL,
	`destdata` INT(11) NULL DEFAULT NULL,
	`destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`invalid_destination` INT(11) NULL DEFAULT NULL,
	`invalid_destdata` INT(11) NULL DEFAULT NULL,
	`invalid_destdata2` VARCHAR(100) NULL DEFAULT NULL,
	`isActive` BIT NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	PRIMARY KEY (`tgID`),
	INDEX `Aid` (`Aid`),
	INDEX `tgName` (`tgName`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `destination` (`destination`),
	INDEX `destdata` (`destdata`),
	INDEX `destdata2` (`destdata2`),
	INDEX `invalid_destination` (`invalid_destination`),
	INDEX `invalid_destdata` (`invalid_destdata`),
	INDEX `invalid_destdata2` (`invalid_destdata2`)
)
COMMENT='Таблица категорий временных настроек'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

CREATE TABLE IF NOT EXISTS `ast_time_group_items` (
	`HIID` BIGINT(20) NULL DEFAULT '0',
	`tgiID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`tgID` INT(11) NULL DEFAULT '0',
	`TimeStart` TIME NULL DEFAULT NULL,
	`TimeFinish` TIME NULL DEFAULT NULL,
	`DayNumStart` INT(11) NULL DEFAULT NULL,
	`DayNumFinish` INT(11) NULL DEFAULT NULL,
	`DayStart` VARCHAR(10) NULL DEFAULT NULL,
	`DayFinish` VARCHAR(10) NULL DEFAULT NULL,
	`MonthStart` VARCHAR(10) NULL DEFAULT NULL,
	`MonthFinish` VARCHAR(10) NULL DEFAULT NULL,
	`isActive` BIT(1) NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`tgiID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `TimeStart` (`TimeStart`),
	INDEX `TimeFinish` (`TimeFinish`),
	INDEX `DayStart` (`DayStart`),
	INDEX `DayFinish` (`DayFinish`),
	INDEX `MonthStart` (`MonthStart`),
	INDEX `MonthFinish` (`MonthFinish`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `tgID` (`tgID`),
	INDEX `DayNumStart` (`DayNumStart`),
	INDEX `DayNumFinish` (`DayNumFinish`)
)
COMMENT='Конфиги для временных настроек'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing_items' AND COLUMN_NAME='prepend'
    ) > 0,
    "SELECT '+60_632'",
    "ALTER TABLE `ast_route_outgoing_items`
        ADD COLUMN `prepend` VARCHAR(50) NULL DEFAULT NULL AFTER `callerID`,
        ADD COLUMN `prefix` VARCHAR(50) NULL DEFAULT NULL AFTER `prepend`,
        ADD INDEX `prepend` (`prepend`),
        ADD INDEX `prefix` (`prefix`);"
));
CALL query_exec(@s);

call us_InsNewEnums(101410, 1014, 'Time Group', TRUE);

call us_InsNewEnums(38, 4, 'Факс', TRUE);
call us_InsNewEnums(39, 4, 'Skype', TRUE);
call us_InsNewEnums(43, 4, 'WebSite', TRUE);

call us_InsNewEnums(49, 5, 'Факс', TRUE);
call us_InsNewEnums(50, 5, 'Skype', TRUE);
call us_InsNewEnums(54, 5, 'WebSite', TRUE);
call us_InsNewEnums(58, 5, 'Адрес', TRUE);
call us_InsNewEnums(59, 5, 'Наименование краткое', TRUE);

call us_InsNewEnums(101006, 1010, 'М', TRUE);
call us_InsNewEnums(101007, 1010, 'Ж', TRUE);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmClient' AND COLUMN_NAME='Sex'
    ) > 0,
    "SELECT '+60_600'",
    "ALTER TABLE `crmClient`
          ADD COLUMN `Sex` INT NULL DEFAULT NULL AFTER `IsPerson`,
          ADD INDEX `Sex` (`Sex`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='lines'
    ) > 0,
    "SELECT '+60_612'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `lines` INT(11) NULL DEFAULT '1' AFTER `dtmfmode`,
        ADD INDEX `lines` (`lines`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queues' AND COLUMN_NAME='max_wait_time'
    ) > 0,
    "SELECT '+60_624'",
    "ALTER TABLE `ast_queues`
        ADD COLUMN `max_wait_time` INT NULL DEFAULT NULL AFTER `setinterfacevar`,
        ADD COLUMN `fail_destination` INT NULL DEFAULT NULL AFTER `max_wait_time`,
        ADD COLUMN `fail_destdata` INT NULL DEFAULT NULL AFTER `fail_destination`,
        ADD COLUMN `fail_destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `fail_destdata`,
        ADD INDEX `fail_destdata2` (`fail_destdata2`),
        ADD INDEX `fail_destdata` (`fail_destdata`),
        ADD INDEX `fail_destination` (`fail_destination`),
        ADD INDEX `max_wait_time` (`max_wait_time`),
        ADD INDEX `setinterfacevar` (`setinterfacevar`),
        ADD INDEX `ringinuse` (`ringinuse`),
        ADD INDEX `periodic_announce_frequency` (`periodic_announce_frequency`),
        ADD INDEX `timeoutrestart` (`timeoutrestart`),
        ADD INDEX `periodic_announce` (`periodic_announce`),
        ADD INDEX `weight` (`weight`),
        ADD INDEX `memberdelay` (`memberdelay`),
        ADD INDEX `reportholdtime` (`reportholdtime`),
        ADD INDEX `eventwhencalled` (`eventwhencalled`),
        ADD INDEX `eventmemberstatus` (`eventmemberstatus`),
        ADD INDEX `leavewhenempty` (`leavewhenempty`),
        ADD INDEX `joinempty` (`joinempty`),
        ADD INDEX `strategy` (`strategy`),
        ADD INDEX `maxlen` (`maxlen`),
        ADD INDEX `servicelevel` (`servicelevel`),
        ADD INDEX `wrapuptime` (`wrapuptime`),
        ADD INDEX `retry` (`retry`),
        ADD INDEX `announce_round_seconds` (`announce_round_seconds`),
        ADD INDEX `announce_holdtime` (`announce_holdtime`),
        ADD INDEX `announce_frequency` (`announce_frequency`),
        ADD INDEX `queue_reporthold` (`queue_reporthold`),
        ADD INDEX `queue_lessthan` (`queue_lessthan`),
        ADD INDEX `queue_thankyou` (`queue_thankyou`),
        ADD INDEX `queue_minutes` (`queue_minutes`),
        ADD INDEX `queue_seconds` (`queue_seconds`),
        ADD INDEX `queue_holdtime` (`queue_holdtime`),
        ADD INDEX `queue_callswaiting` (`queue_callswaiting`),
        ADD INDEX `queue_thereare` (`queue_thereare`),
        ADD INDEX `queue_youarenext` (`queue_youarenext`),
        ADD INDEX `monitor_format` (`monitor_format`),
        ADD INDEX `monitor_join` (`monitor_join`),
        ADD INDEX `timeout` (`timeout`),
        ADD INDEX `context` (`context`),
        ADD INDEX `announce` (`announce`),
        ADD INDEX `musiconhold` (`musiconhold`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='defaultuser'
    ) > 0,
    "SELECT '+60_677'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `defaultuser` VARCHAR(40) NULL DEFAULT NULL AFTER `nat`,
        ADD INDEX `defaultuser` (`defaultuser`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM ast_trunk
     WHERE defaultuser IS NOT NULL
    ) > 0,
    "SELECT '+60_689'",
    "UPDATE ast_trunk SET defaultuser=fromuser;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND COLUMN_NAME='lines'
    ) > 0,
    "SELECT '+60_699'",
    "ALTER TABLE `ast_sippeers`
        ADD COLUMN `lines` INT(11) NULL DEFAULT '1' AFTER `nat`,
        ADD INDEX `lines` (`lines`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='DIDs'
    ) > 0,
    "SELECT '+60_711'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `DIDs` VARCHAR(250) NULL DEFAULT NULL AFTER `lines`,
        ADD INDEX `DIDs` (`DIDs`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND COLUMN_NAME='isFirstClient'
    ) > 0,
    "SELECT '+60_723'",
    "ALTER TABLE `ast_scenario`
      ADD COLUMN `isFirstClient` BIT NULL DEFAULT b'1' AFTER `target`,
      ADD INDEX `isFirstClient` (`isFirstClient`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND COLUMN_NAME='isCallback'
    ) > 0,
    "SELECT '+60_735'",
    "ALTER TABLE `ast_route_incoming`
        ADD COLUMN `isCallback` BIT NULL DEFAULT b'0' AFTER `destdata2`,
        ADD COLUMN `isFirstClient` BIT NULL DEFAULT b'1' AFTER `isCallback`,
        ADD INDEX `isCallback` (`isCallback`),
        ADD INDEX `isFirstClient` (`isFirstClient`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming' AND COLUMN_NAME='stick_destination'
    ) > 0,
    "SELECT '+60_749'",
    "ALTER TABLE `ast_route_incoming`
        ADD COLUMN `stick_destination` INT NULL DEFAULT NULL AFTER `destdata2`,
        ADD INDEX `stick_destination` (`stick_destination`);"
));
CALL query_exec(@s);

call us_InsNewEnums(101319, 1013, 'Callback', TRUE);
call us_InsNewEnums(101411, 1014, 'Callback', TRUE);
call us_InsNewEnums(101412, 1014, 'Conference', TRUE);

CREATE TABLE IF NOT EXISTS `ast_callback` (
  `HIID` BIGINT NULL DEFAULT '0',
  `cbID` INT NULL AUTO_INCREMENT,
  `Aid` INT(11) NOT NULL DEFAULT '0',
  `cbName` VARCHAR(50) NULL DEFAULT NULL,
  `timeout` INT NULL DEFAULT '0',
  `isFirstClient` BIT NULL DEFAULT b'1',
  `destination` INT NULL DEFAULT NULL,
  `destdata` INT NULL DEFAULT NULL,
  `destdata2` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` BIT NULL DEFAULT b'1',
  `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `HIID` (`HIID`),
  INDEX `cbID` (`cbID`),
  INDEX `cbName` (`cbName`),
  INDEX `timeout` (`timeout`),
  INDEX `isFirstClient` (`isFirstClient`),
  INDEX `destination` (`destination`),
  INDEX `destdata` (`destdata`),
  INDEX `destdata2` (`destdata2`),
  INDEX `isActive` (`isActive`),
  INDEX `Created` (`Created`),
  INDEX `Aid` (`Aid`)
)
  COLLATE='utf8_general_ci'
  ENGINE=MyISAM
;
--

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emClient' AND COLUMN_NAME='vTigerID'
    ) > 0,
    "SELECT '+60_794'",
    "ALTER TABLE `emClient`
          ADD COLUMN `vTigerID` INT NULL DEFAULT NULL COMMENT 'ID клиента из vTiger' AFTER `client_name`,
          ADD INDEX `vTigerID` (`vTigerID`),
          ADD INDEX `login` (`login`),
          ADD INDEX `password` (`password`),
          ADD INDEX `IP` (`IP`);"
));
CALL query_exec(@s);

call us_InsNewEnums(101710, 1017, 'Telefony5', TRUE);
call us_InsNewEnums(101711, 1017, 'Telefony10', TRUE);
call us_InsNewEnums(101712, 1017, 'Telefony20', TRUE);
call us_InsNewEnums(101713, 1017, 'Telefony50', TRUE);
call us_InsNewEnums(101714, 1017, 'Telefony100', TRUE);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emClient' AND COLUMN_NAME='purchaseDate'
    ) > 0,
    "SELECT '+60_815'",
    "ALTER TABLE `emClient`
	      ADD COLUMN `purchaseDate` DATE NULL DEFAULT NULL AFTER `date_fee`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='ManageID'
    ) > 0,
    "SELECT '+60_826'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `ManageID` INT NULL DEFAULT NULL AFTER `DIDs`,
        ADD INDEX `ManageID` (`ManageID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='coID'
    ) > 0,
    "SELECT '+60_838'",
    "ALTER TABLE `ast_trunk`
          ADD COLUMN `coID` INT(11) NULL DEFAULT NULL AFTER `ManageID`,
          ADD INDEX `coID` (`coID`);"
));
CALL query_exec(@s);
