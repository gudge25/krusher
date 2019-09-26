CREATE TABLE IF NOT EXISTS `crmCompany` (
	`HIID` BIGINT(20) NULL DEFAULT '0',
	`coID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`coName` VARCHAR(100) NULL DEFAULT NULL,
	`coDescription` VARCHAR(100) NULL DEFAULT NULL,
	`isActive` BIT(1) NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`coID`),
	INDEX `HIID` (`HIID`),
	INDEX `coName` (`coName`),
	INDEX `isActive` (`isActive`),
	INDEX `coDescription` (`coDescription`),
	INDEX `Created` (`Created`),
	INDEX `Aid` (`Aid`)
)
ENGINE=MyISAM
;
--
call us_InsMessage(77116, 'Подобная запись уже существует!');
--
CREATE TABLE IF NOT EXISTS `usRank` (
	`HIID` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`Aid` INT(11) NOT NULL DEFAULT '0',
	`uID` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
	`type` INT(11) NOT NULL DEFAULT '103001',
	`uRank` VARCHAR(200) NULL DEFAULT NULL,
	`emID` INT(11) NULL DEFAULT NULL,
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `uID` (`uID`),
	INDEX `emEmploy` (`emID`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`),
	INDEX `uRank` (`uRank`),
	INDEX `type` (`type`),
	INDEX `Aid` (`Aid`),
	INDEX `HIID` (`HIID`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

call us_InsNewEnums(103001, 1030, 'stars', TRUE);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND COLUMN_NAME='coID'
    ) > 0,
    "SELECT '+127_54'",
    "ALTER TABLE `ccContact`
        ADD COLUMN `coID` INT NULL DEFAULT '0' AFTER `uID`,
        ADD INDEX `coID` (`coID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='coID'
    ) > 0,
    "SELECT '+127_67'",
    "ALTER TABLE `ast_trunk`
				ADD COLUMN `ManageID` INT NULL DEFAULT NULL AFTER `DIDs`,
				ADD COLUMN `coID` INT NULL DEFAULT NULL AFTER `ManageID`,
				ADD INDEX `ManageID` (`ManageID`),
				ADD INDEX `coID` (`coID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_trunk' AND COLUMN_NAME='transport'
    ) > 0,
    "SELECT '+127_81'",
    "ALTER TABLE `ast_trunk`
        ADD COLUMN `transport` VARCHAR(50) NULL DEFAULT '103102' AFTER `coID`,
        ADD COLUMN `encryption` BIT NULL DEFAULT b'0' AFTER `transport`,
        ADD COLUMN `avpf` BIT NULL DEFAULT b'0' AFTER `encryption`,
        ADD COLUMN `force_avp` BIT NULL DEFAULT b'0' AFTER `avpf`,
        ADD COLUMN `icesupport` BIT NULL DEFAULT b'0' AFTER `force_avp`,
        ADD COLUMN `videosupport` BIT NULL DEFAULT b'0' AFTER `icesupport`,
        ADD COLUMN `allow` VARCHAR(50) NULL DEFAULT '103201,103202,103203' AFTER `videosupport`,
        ADD COLUMN `dtlsenable` BIT NULL DEFAULT b'0' AFTER `allow`,
        ADD COLUMN `dtlsverify` BIT NULL DEFAULT b'0' AFTER `dtlsenable`,
        ADD COLUMN `dtlscertfile` VARCHAR(100) NULL DEFAULT NULL AFTER `dtlsverify`,
        ADD COLUMN `dtlscafile` VARCHAR(100) NULL DEFAULT NULL AFTER `dtlscertfile`,
        ADD COLUMN `dtlssetup` VARCHAR(100) NULL DEFAULT NULL AFTER `dtlscafile`,
        ADD INDEX `transport` (`transport`),
        ADD INDEX `encryption` (`encryption`),
        ADD INDEX `avpf` (`avpf`),
        ADD INDEX `force_avp` (`force_avp`),
        ADD INDEX `icesupport` (`icesupport`),
        ADD INDEX `videosupport` (`videosupport`),
        ADD INDEX `allow` (`allow`),
        ADD INDEX `dtlsenable` (`dtlsenable`),
        ADD INDEX `dtlsverify` (`dtlsverify`),
        ADD INDEX `dtlscertfile` (`dtlscertfile`),
        ADD INDEX `dtlscafile` (`dtlscafile`),
        ADD INDEX `dtlssetup` (`dtlssetup`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_sippeers' AND COLUMN_NAME='transport'
    ) > 0,
    "SELECT '+127_115'",
    "ALTER TABLE `ast_sippeers`
        ADD COLUMN `transport` VARCHAR(50) NULL DEFAULT '103102' AFTER `emID`,
        ADD COLUMN `encryption` BIT NULL DEFAULT b'0' AFTER `transport`,
        ADD COLUMN `avpf` BIT NULL DEFAULT b'0' AFTER `encryption`,
        ADD COLUMN `force_avp` BIT NULL DEFAULT b'0' AFTER `avpf`,
        ADD COLUMN `icesupport` BIT NULL DEFAULT b'0' AFTER `force_avp`,
        ADD COLUMN `videosupport` BIT NULL DEFAULT b'0' AFTER `icesupport`,
        ADD COLUMN `allow` VARCHAR(50) NULL DEFAULT '103201,103202,103203' AFTER `videosupport`,
        ADD COLUMN `dtlsenable` BIT NULL DEFAULT b'0' AFTER `allow`,
        ADD COLUMN `dtlsverify` BIT NULL DEFAULT b'0' AFTER `dtlsenable`,
        ADD COLUMN `dtlscertfile` VARCHAR(100) NULL DEFAULT NULL AFTER `dtlsverify`,
        ADD COLUMN `dtlscafile` VARCHAR(100) NULL DEFAULT NULL AFTER `dtlscertfile`,
        ADD COLUMN `dtlssetup` VARCHAR(100) NULL DEFAULT NULL AFTER `dtlscafile`,
        ADD INDEX `transport` (`transport`),
        ADD INDEX `encryption` (`encryption`),
        ADD INDEX `avpf` (`avpf`),
        ADD INDEX `force_avp` (`force_avp`),
        ADD INDEX `icesupport` (`icesupport`),
        ADD INDEX `videosupport` (`videosupport`),
        ADD INDEX `allow` (`allow`),
        ADD INDEX `dtlsenable` (`dtlsenable`),
        ADD INDEX `dtlsverify` (`dtlsverify`),
        ADD INDEX `dtlscertfile` (`dtlscertfile`),
        ADD INDEX `dtlscafile` (`dtlscafile`),
        ADD INDEX `dtlssetup` (`dtlssetup`);"
));
CALL query_exec(@s);

-- webrtc transport
call us_InsNewEnums(103101, 1031, 'tls', 1);
call us_InsNewEnums(103102, 1031, 'udp', 1);
call us_InsNewEnums(103103, 1031, 'ws', 1);
call us_InsNewEnums(103104, 1031, 'wss', 1);
-- webrtc allow
call us_InsNewEnums(103201, 1032, 'ulaw', 1);
call us_InsNewEnums(103202, 1032, 'alaw', 1);
call us_InsNewEnums(103203, 1032, 'gsm', 1);
call us_InsNewEnums(103204, 1032, 'vp8', 1);
call us_InsNewEnums(103205, 1032, 'h264', 1);
call us_InsNewEnums(103206, 1032, 'h263p', 1);
call us_InsNewEnums(103207, 1032, 'mpeg4', 1);
-- webrtc dtlssetup
call us_InsNewEnums(103301, 1033, 'actpass', 1);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_outgoing' AND COLUMN_NAME='coID'
    ) > 0,
    "SELECT '+127_165'",
    "ALTER TABLE `ast_route_outgoing`
        ADD COLUMN `coID` INT(11) NULL DEFAULT '0' AFTER `priority`,
        ADD INDEX `coID` (`coID`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_pools' AND COLUMN_NAME='coID'
    ) > 0,
    "SELECT '+127_177'",
    "ALTER TABLE `ast_pools`
        ADD COLUMN `coID` INT(11) NULL DEFAULT '0' AFTER `priority`,
        ADD INDEX `coID` (`coID`);"
));
CALL query_exec(@s);

call us_InsNewEnums(7008, 7, 'LIMIT', 1);
call us_InsNewEnums(7009, 7, 'BLOCKED', 1);
call us_InsNewEnums(7010, 7, 'CANCEL', 1);
call us_InsNewEnums(7011, 7, 'CHANUNAVAIL', 1);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND COLUMN_NAME='destination'
    ) > 0,
    "SELECT '+127_194'",
    "ALTER TABLE `ccContact`
        ADD COLUMN `destination` INT(11) NULL DEFAULT NULL AFTER `coID`,
        ADD COLUMN `destdata` INT(11) NULL DEFAULT NULL AFTER `destination`,
        ADD COLUMN `destdata2` VARCHAR(100) NULL DEFAULT NULL AFTER `destdata`,
        ADD INDEX `destination` (`destination`),
        ADD INDEX `destdata` (`destdata`),
        ADD INDEX `destdata2` (`destdata2`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ccContact' AND COLUMN_NAME='transferFrom'
    ) > 0,
    "SELECT '+127_210'",
    "ALTER TABLE `ccContact`
        ADD COLUMN `transferFrom` VARCHAR(250) NULL DEFAULT NULL AFTER `destdata2`,
        ADD COLUMN `transferTo` VARCHAR(250) NULL DEFAULT NULL AFTER `transferFrom`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT CHARACTER_MAXIMUM_LENGTH
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND COLUMN_NAME='ccName'
    ) > 50,
    "SELECT '+127_222'",
    "ALTER TABLE `crmContact`
	      ALTER `ccName` DROP DEFAULT;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT CHARACTER_MAXIMUM_LENGTH
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'crmContact' AND COLUMN_NAME='ccName'
    ) > 50,
    "SELECT '+127_233'",
    "ALTER TABLE `crmContact`
	      CHANGE COLUMN `ccName` `ccName` VARCHAR(250) NOT NULL AFTER `ffID`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_ivr_config' AND COLUMN_NAME='ttsID' AND DATA_TYPE='varchar'
    ) > 0,
    "SELECT '+127_244'",
    "ALTER TABLE `ast_ivr_config`
	      CHANGE COLUMN `ttsID` `ttsID` VARCHAR(250) NULL DEFAULT NULL AFTER `return_to_ivr_after_vm`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_Tts'
    ) = 0,
    "SELECT '+127_255'",
    "RENAME TABLE `ast_Tts` TO `ast_tts`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_tts' AND COLUMN_NAME='ttsFields'
    ) > 0,
    "SELECT '+127_265'",
    "ALTER TABLE `ast_tts`
        ADD COLUMN `ttsFields` VARCHAR(250) NULL DEFAULT NULL AFTER `ttsText`,
        ADD INDEX `ttsField` (`ttsFields`);"
));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `ast_tts` (
  `HIID` BIGINT(20) NOT NULL DEFAULT '0' COMMENT  'Уникальный ключ для обновления',
	`ttsID` INT(11) NOT NULL COMMENT 'Первичный ключ',
	`Aid` INT(11) NOT NULL DEFAULT '0' COMMENT 'ID клиента',
	`ttsName` VARCHAR(100) NOT NULL COMMENT 'Название настройки',
	`ttsText` TEXT NULL DEFAULT NULL COMMENT 'Текст для ТТСа, в приоритете от поле ТТСа',
	`ttsFields` VARCHAR(250) NULL DEFAULT NULL,
	`engID` INT(11) NULL DEFAULT NULL,
	`recIDBefore` VARCHAR(250) NULL DEFAULT NULL,
	`recIDAfter` VARCHAR(250) NULL DEFAULT NULL,
	`yandexApikey` VARCHAR(250) NULL DEFAULT NULL COMMENT 'API-ключ (если в настройках ключ не был указан, то в конструкторе его необходимо указать).',
	`yandexEmotion` INT(11) NULL DEFAULT NULL COMMENT 'Эмоциональная окраска голоса. Доступные значения: neutral;good, evil ',
	`yandexEmotions` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Массив эмоций вида [[\'emotion1\', weight1], [\'emotion2\', weight2]], предназначенный для взвешенного смешивания эмоций',
	`yandexFast` BIT(1) NULL DEFAULT b'0' COMMENT 'Использовать "быстрый" синтез, который ускоряет генерацию звука путём уменьшения его качества',
	`yandexGenders` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Массив полов вида [[\'gender1\', weight1], [\'gender2\', weight2]], предназначенный для взвешенного смешивания полов говорящего. weight может принимать значения от 1.0 до 3.0.',
	`yandexLang` VARCHAR(10) NULL DEFAULT NULL COMMENT 'Язык текста, который надо произнести. Доступные значения: \'ru-RU\', \'en-US\', \'tr-TR\', \'uk-UA\'.',
	`yandexSpeaker` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Голос для озвучивания. Список доступных значений можно получить вызвав функцию Tts.speakers',
	`yandexSpeakers` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Массив голосов вида [[\'speaker1\', weight1], [\'speaker2\', weight2]], предназначенный для взвешенного смешивания голосов. weight может принимать значения от 1.0 до 3.0. Например, [[\'omazh\', 1.5], [\'zahar\', 2.2]].',
	`yandexSpeed` FLOAT NULL DEFAULT NULL COMMENT 'Скорость синтеза речи. Принимает значения от 0.0 (медленно) до 2.0 (быстро).',
	`isActive` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'Признак активности записи',
	`Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи',
	`Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи',
	`settings` LONGTEXT NULL DEFAULT NULL COMMENT 'JSON с настройками',
	PRIMARY KEY (`ttsID`),
	INDEX `ttsName` (`ttsName`),
	INDEX `Aid` (`Aid`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`),
	INDEX `ttsField` (`ttsFields`),
	INDEX `HIID` (`HIID`)
)
COMMENT='Таблица для хранения настроек подключения к голосовым сервисам'
ENGINE=MyISAM
;

CREATE TABLE IF NOT EXISTS DUP_crmClient (
  RowID           BIGINT              NOT NULL auto_increment
  , OLD_HIID       BIGINT(20) UNSIGNED NULL
  , DUP_InsTime    DATETIME            NOT NULL
  , DUP_action     ENUM('I','U','D')   NOT NULL
  , DUP_HostName   VARCHAR(128)        NOT NULL
  , DUP_AppName    VARCHAR(128)        NOT NULL
  , `HIID` BIGINT(20) UNSIGNED NULL DEFAULT '0'
  , `clID` INT(11) NOT NULL
  , `Aid` INT(11) NOT NULL DEFAULT '0'
  , `clName` VARCHAR(200) NOT NULL
  , `IsPerson` BIT(1) NOT NULL DEFAULT b'0'
  , `Sex` INT(11) NULL DEFAULT NULL
  , `Comment` VARCHAR(1020) NULL DEFAULT NULL
  , `ParentID` INT(11) NULL DEFAULT NULL
  , `ffID` INT(11) NOT NULL DEFAULT '0'
  , `CompanyID` INT(11) NULL DEFAULT NULL
  , `uID` BIGINT(20) UNSIGNED NULL DEFAULT NULL
  , `isActual` BIT(1) NOT NULL DEFAULT b'0'
  , `ActualStatus` INT(11) NULL DEFAULT NULL
  , `Position` INT(11) NULL DEFAULT NULL
  , `responsibleID` INT(11) NULL DEFAULT NULL
  , `CreatedBy` INT(11) NOT NULL
  , `ChangedBy` INT(11) NULL DEFAULT NULL
  , `IsActive` BIT(1) NOT NULL DEFAULT b'0'
  , `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи'
  , `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время редактирования записи'
  , PRIMARY KEY (`RowID`),
	INDEX `OLD_HIID` (`OLD_HIID`),
	INDEX `DUP_InsTime` (`DUP_InsTime`),
	INDEX `DUP_action` (`DUP_action`),
	INDEX `DUP_HostName` (`DUP_HostName`),
	INDEX `DUP_AppName` (`DUP_AppName`),
	INDEX `HIID` (`HIID`),
	INDEX `clID` (`clID`),
	INDEX `Aid` (`Aid`),
	INDEX `clName` (`clName`),
	INDEX `IsPerson` (`IsPerson`),
	INDEX `Sex` (`Sex`),
	INDEX `Comment` (`Comment`),
	INDEX `ParentID` (`ParentID`),
	INDEX `ffID` (`ffID`),
	INDEX `CompanyID` (`CompanyID`),
	INDEX `uID` (`uID`),
	INDEX `isActual` (`isActual`),
	INDEX `ActualStatus` (`ActualStatus`),
	INDEX `Position` (`Position`),
	INDEX `responsibleID` (`responsibleID`),
	INDEX `CreatedBy` (`CreatedBy`),
	INDEX `ChangedBy` (`ChangedBy`),
	INDEX `IsActive` (`IsActive`),
	INDEX `Created` (`Created`)
);
--
CREATE TABLE IF NOT EXISTS `ast_tts_fields` (
	`HIID` BIGINT NULL DEFAULT '0',
	`ttsfID` INT NOT NULL,
	`Aid` INT NULL DEFAULT '0',
	`field` VARCHAR(50) NULL,
	`fieldName_ru` VARCHAR(100) NULL,
	`fieldName_en` VARCHAR(100) NULL,
	`fieldName_ua` VARCHAR(100) NULL,
	`isActive` BIT NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX `HIID` (`HIID`),
	PRIMARY KEY (`ttsfID`),
	INDEX `Aid` (`Aid`),
	INDEX `field` (`field`),
	INDEX `fieldName_ru` (`fieldName_ru`),
	INDEX `fieldName_en` (`fieldName_en`),
	INDEX `fieldName_ua` (`fieldName_ua`),
	INDEX `isActive` (`isActive`),
	INDEX `Created` (`Created`)
)
COMMENT='Поля для работы с tts'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emClient' AND COLUMN_NAME='client_contact'
    ) > 0,
    "SELECT '+127_393'",
    "ALTER TABLE `emClient`
	      ADD COLUMN `client_contact` VARCHAR(255) NOT NULL AFTER `client_name`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'fsFile' AND COLUMN_NAME='ttsID'
    ) = 0,
    "SELECT '+127_404'",
    "ALTER TABLE `fsFile`
	      DROP COLUMN `ttsID`;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND COLUMN_NAME='CompanyID'
    ) > 0,
    "SELECT '+127_415'",
    "ALTER TABLE `emEmploy`
	      ALTER `IsActive` DROP DEFAULT;"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'emEmploy' AND COLUMN_NAME='CompanyID'
    ) > 0,
    "SELECT '+127_426'",
    "ALTER TABLE `emEmploy`
        ADD COLUMN `CompanyID` INT NULL DEFAULT NULL COMMENT 'Внешний ID, для интеграции' AFTER `Queue`,
        CHANGE COLUMN `IsActive` `isActive` BIT(1) NOT NULL AFTER `CompanyID`,
        ADD INDEX `CompanyID` (`CompanyID`),
        ADD INDEX `emName` (`emName`);"
));
CALL query_exec(@s);

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario' AND COLUMN_NAME='roID'
    ) > 0,
    "SELECT '+127_440'",
    "ALTER TABLE `ast_scenario`
	      ADD COLUMN `roID` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Выбор роутов для данного сценария' AFTER `target`;"
));
CALL query_exec(@s);

CREATE TABLE IF NOT EXISTS `ast_conference` (
	`HIID` BIGINT(20) NULL DEFAULT '0',
	`cfID` INT(11) NOT NULL DEFAULT '0',
	`Aid` INT(11) NULL DEFAULT '0',
	`cfName` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Номер для создания конференции',
	`cfDesc` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Название',
	`userPin` INT(11) NULL DEFAULT NULL COMMENT 'Пароль для входа пользователя',
	`adminPin` INT(11) NULL DEFAULT NULL COMMENT 'Пароль для входа админа',
	`langID` INT(11) NULL DEFAULT NULL COMMENT 'Язык',
	`record_id` INT(11) NULL DEFAULT NULL COMMENT 'Приветствие при входе в конференцию',
	`leaderWait` BIT(1) NULL DEFAULT b'0' COMMENT 'Ожидание основного пользователя. который запустит конференцию',
	`leaderLeave` BIT(1) NULL DEFAULT b'0' COMMENT 'Окончить конференцию, если основной пользователь вышел',
	`talkerOptimization` BIT(1) NULL DEFAULT b'0' COMMENT 'Устанавливать режим ТИШИНА, для пользователей, которые не разговаривают в данный момент',
	`talkerDetection` BIT(1) NULL DEFAULT b'0' COMMENT 'Мониторить пользователей',
	`quiteMode` BIT(1) NULL DEFAULT b'0' COMMENT 'Не проигрывать запись, когда кто то заходит/выходит',
	`userCount` BIT(1) NULL DEFAULT b'0' COMMENT 'Озвучивание кол-ва пользователей при добавлении нового пользователя',
	`userJoinLeave` BIT(1) NULL DEFAULT b'0' COMMENT 'Озвучивание, когда кто то заходит / выходит в конференции',
	`moh` BIT(1) NULL DEFAULT b'0' COMMENT 'Проигрывать music on hold, пока первый ожидает остальных',
  `mohClass` INT(11) NULL DEFAULT NULL,
	`allowMenu` BIT(1) NULL DEFAULT b'0' COMMENT 'Активация меню',
	`recordConference` BIT(1) NULL DEFAULT b'0' COMMENT 'Сохранение записи конференции',
	`maxParticipants` INT(11) NULL DEFAULT NULL,
	`muteOnJoin` BIT(1) NULL DEFAULT b'0' COMMENT 'Режим тишина у только что подключенного участника',
	`isActive` BIT(1) NULL DEFAULT b'1',
	`Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`cfID`),
	INDEX `HIID` (`HIID`),
	INDEX `Aid` (`Aid`),
	INDEX `cfName` (`cfName`),
	INDEX `cfDesc` (`cfDesc`),
	INDEX `userPin` (`userPin`),
	INDEX `adminPin` (`adminPin`),
	INDEX `langID` (`langID`),
	INDEX `record_id` (`record_id`),
	INDEX `leaderWait` (`leaderWait`),
	INDEX `leaderLeave` (`leaderLeave`),
	INDEX `talkerOptimization` (`talkerOptimization`),
	INDEX `talkerDetection` (`talkerDetection`),
	INDEX `quiteMode` (`quiteMode`),
	INDEX `userCount` (`userCount`),
	INDEX `userJoinLeave` (`userJoinLeave`),
	INDEX `moh` (`moh`),
	INDEX `mohClass` (`mohClass`),
	INDEX `allowMenu` (`allowMenu`),
	INDEX `recordConference` (`recordConference`),
	INDEX `maxParticipants` (`maxParticipants`),
	INDEX `muteOnJoin` (`muteOnJoin`),
	INDEX `Created` (`Created`),
	INDEX `isActive` (`isActive`)
)
COMMENT='Настройка конференций'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;
--

call us_InsNewEnums(103401, 1034, 'Inherit', TRUE);
call us_InsNewEnums(103402, 1034, 'English', TRUE);
call us_InsNewEnums(103403, 1034, 'Russian', TRUE);
call us_InsNewEnums(103404, 1034, 'Ukrainian', TRUE);









