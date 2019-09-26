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
--
