DELIMITER $$
DROP PROCEDURE IF EXISTS setEnumsData;
CREATE PROCEDURE setEnumsData(
    $Aid                INT(11)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
    DELETE FROM usEnumValue WHERE Aid = $Aid;
    call us_IPInsEnum(0, 3, 1, 'Тип менеджера', 1);
    call us_IPInsEnum(0, 4, 1, 'Поля для типа контакта', 1);
    call us_IPInsEnum(0, 5, 1, 'Поля для шаблона', 1);
    call us_IPInsEnum(0, 6, 1, 'Статус сделки', 1);
    call us_IPInsEnum(0, 7, 1, 'Статус звонка', 1);
    call us_IPInsEnum(0, 8, 1, 'Unknown', 0);
    call us_IPInsEnum(0, 10, 1, 'Статус платежных документов', 1);
    call us_IPInsEnum(0, 11, 1, 'Статус платежных документов', 1);
    call us_IPInsEnum(0, 12, 1, 'Статус платежных документов', 1);
    call us_IPInsEnum(0, 13, 1, 'Тип адресов', 1);
    call us_IPInsEnum(0, 14, 1, 'Статус продукта', 1);
    call us_IPInsEnum(0, 15, 1, 'Статус телефона', 1);
    call us_IPInsEnum(0, 1008, 1, 'Актуализация', 0);
    call us_IPInsEnum(0, 1009, 1, 'Актуализация', 0);
    call us_IPInsEnum(0, 1011, 1, 'Актуализация', 0);
    call us_IPInsEnum(0, 1012, 1, 'Должность', 1);
    call us_IPInsEnum(0, 1013, 1, 'Тип обращения', 1);
    call us_IPInsEnum(0, 1014, 1, 'Тип destionation', 1);
    call us_IPInsEnum(0, 1015, 1, 'Очереди', 1);
    call us_IPInsEnum(0, 1016, 1, 'Статус обзвона', 1);
    call us_IPInsEnum(0, 1017, 1, 'Тип тарифа Krusher', 1);
    call us_IPInsEnum(0, 1018, 1, 'Валюты', 1);
    call us_IPInsEnum(0, 1019, 1, 'SIP настройки', 1);
    call us_IPInsEnum(0, 1020, 1, 'SIP настройки', 1);
    call us_IPInsEnum(0, 1021, 1, 'SIP настройки', 1);
    call us_IPInsEnum(0, 1022, 1, 'Часовые пояса', 1);
    call us_IPInsEnum(0, 1023, 1, 'Языки интерфейса', 1);
    call us_IPInsEnum(0, 1024, 1, 'TTS настройки', 1);

    call us_IPInsEnum(0, 1025, 1, 'nat list', 1);
    call us_IPInsEnum(0, 1026, 1, 'category for route outgoing', 1);
    call us_IPInsEnum(0, 1027, 1, 'SIP', 1);
    call us_IPInsEnum(0, 1028, 1, 'Queue Empty Options', 1);
    call us_IPInsEnum(0, 1029, 1, 'dtmfmode', 1);
    call us_IPInsEnum(0, 1030, 1, 'ranks', 1);
    call us_IPInsEnum(0, 1031, 1, 'webrtc transport', 1);
    call us_IPInsEnum(0, 1032, 1, 'webrtc allow', 1);
    call us_IPInsEnum(0, 1033, 1, 'webrtc dtlssetup', 1);
    call us_IPInsEnum(0, 1034, 1, 'languages', 1);
    call us_IPInsEnum(0, 1035, 1, 'emEmploy status', 1);
    call us_IPInsEnum(0, 1036, 1, 'ContactStatuses', 1);
    call us_IPInsEnum(0, 1037, 1, 'Recall type', 1);
    call us_IPInsEnum(0, 1038, 1, 'Records status ready', 1);
    call us_IPInsEnum(0, 1039, 1, 'MarketPlace types', 1);
    call us_IPInsEnum(0, 1040, 1, 'Formats of records', 1);

    -- call us_IPInsEnum($Aid, 1001,  1, 'Юр.особа', 1);
    -- call us_IPInsEnum($Aid, 1002,  1, 'Фіз.особа підприємець', 1);
    -- call us_IPInsEnum($Aid, 1003,  1, 'Нерезидент', 1);
    -- call us_IPInsEnum($Aid, 1004,  1, 'Фіз.особа', 1);
    -- call us_IPInsEnum($Aid, 2001,  2, 'ООО', 1);
    -- call us_IPInsEnum($Aid, 2002,  2, 'АКБ', 1);
    -- call us_IPInsEnum($Aid, 2003,  2, 'АО', 1);
    -- call us_IPInsEnum($Aid, 2004,  2, 'АОЗТ', 1);
    -- call us_IPInsEnum($Aid, 1010, 2, 'гос', 1);
    -- call us_IPInsEnum($Aid, 1011, 2, 'ДП', 1);
    -- call us_IPInsEnum($Aid, 1012, 2, 'ЗАО', 1);
    -- call us_IPInsEnum($Aid, 1013, 2, 'МП', 1);
    -- call us_IPInsEnum($Aid, 1015, 2, 'МЧП', 1);
    -- call us_IPInsEnum($Aid, 1016, 2, 'НКФ', 1);
    -- call us_IPInsEnum($Aid, 1017, 2, 'НПП', 1);
    -- call us_IPInsEnum($Aid, 1018, 2, 'НТК', 1);
    -- call us_IPInsEnum($Aid, 1019, 2, 'НТП', 1);
    -- call us_IPInsEnum($Aid, 1020, 2, 'НТЦ', 1);
    -- call us_IPInsEnum($Aid, 1021, 2, 'ПО', 1);
    -- call us_IPInsEnum($Aid, 1022, 2, 'СП', 1);
    -- call us_IPInsEnum($Aid, 1023, 2, 'ТОВ', 1);
    -- call us_IPInsEnum($Aid, 1025, 2, 'ЧП', 1);
    call us_IPInsEnum($Aid, 36, 4, 'Телефон', 1);
    CALL us_IPInsEnum($Aid, 37, 4, 'Email', 1);
    call us_IPInsEnum($Aid, 38, 4, 'Факс', 1);
    call us_IPInsEnum($Aid, 39, 4, 'Skype', 1);
    /*call us_IPInsEnum($Aid, 40, 4, 'Vk', 1);
    call us_IPInsEnum($Aid, 41, 4, 'FaceBook', 1);
    call us_IPInsEnum($Aid, 42, 4, 'LinkedIn', 1);*/
    call us_IPInsEnum($Aid, 43, 4, 'WebSite', 1);
    call us_IPInsEnum($Aid, 44, 4, 'Тел.Доп', 1);
    -- пункті шаблона
    call us_IPInsEnum($Aid, 45, 5, 'Наименование полное', 1);
    call us_IPInsEnum($Aid, 46, 5, 'ID', 1);
    call us_IPInsEnum($Aid, 47, 5, 'Телеф дозвона', 1);
    CALL us_IPInsEnum($Aid, 48, 5, 'Email', 1);
    call us_IPInsEnum($Aid, 49, 5, 'Факс', 1);
    call us_IPInsEnum($Aid, 50, 5, 'Skype', 1);
    -- call us_IPInsEnum($Aid, 51, 5, 'Vk', 1);
    -- call us_IPInsEnum($Aid, 52, 5, 'FaceBook', 1);
    -- call us_IPInsEnum($Aid, 53, 5, 'LinkedIn', 1);
    call us_IPInsEnum($Aid, 54, 5, 'WebSite', 1);
    call us_IPInsEnum($Aid, 55, 5, 'Тел.Доп', 1);
    call us_IPInsEnum($Aid, 56, 5, 'Комментарий', 1);
    call us_IPInsEnum($Aid, 57, 5, 'ИНН', 1);
    call us_IPInsEnum($Aid, 58, 5, 'Адрес', 1);
    call us_IPInsEnum($Aid, 59, 5, 'Наименование краткое', 1);
    call us_IPInsEnum($Aid, 60, 5, 'CompanyID', 1);
    /*call us_IPInsEnum($Aid, 61, 5, 'Руков Пол', 1);
    call us_IPInsEnum($Aid, 62, 5, 'КВЭД', 1);
    call us_IPInsEnum($Aid, 63, 5, 'КВЭД наим', 1);
    call us_IPInsEnum($Aid, 65, 5, 'Руков Должность', 1);
    call us_IPInsEnum($Aid, 66, 5, 'Руков ФИО', 1);
    call us_IPInsEnum($Aid, 67, 5, 'Руков ФамИО', 1);
    call us_IPInsEnum($Aid, 68, 5, 'Руков Имя Отч', 1);
    call us_IPInsEnum($Aid, 69, 5, 'Телеф код города', 1);
    call us_IPInsEnum($Aid, 70, 5, 'Оператор', 1);
    call us_IPInsEnum($Aid, 71, 5, 'ActDate', 1);
    call us_IPInsEnum($Aid, 72, 5, 'timeZone', 1);
    call us_IPInsEnum($Aid, 73, 5, 'Область', 1);
    call us_IPInsEnum($Aid, 74, 5, 'Примечание Адрес', 1);*/
    call us_IPInsEnum($Aid, 75, 5, 'Валюта', 1);
    call us_IPInsEnum($Aid, 76, 5, 'Язык', 1);
    call us_IPInsEnum($Aid, 77, 5, 'Сумма', 1);
    call us_IPInsEnum($Aid, 78, 5, 'Текст TTS', 1);
    call us_IPInsEnum($Aid, 79, 5, 'Пол', 1);
    --
    call us_IPInsEnum($Aid, 6001, 6, 'Переговоры', 1);
    call us_IPInsEnum($Aid, 6002, 6, 'Закрыта удачно', 1);
    call us_IPInsEnum($Aid, 6003, 6, 'Переговоры или отзыв', 1);
    call us_IPInsEnum($Aid, 6004, 6, 'Ценовое предложение', 1);
    call us_IPInsEnum($Aid, 6005, 6, 'Анализ ситуации', 1);
    call us_IPInsEnum($Aid, 6006, 6, 'Поиск принимающих решение', 1);
    call us_IPInsEnum($Aid, 6007, 6, 'Предложение', 1);
    call us_IPInsEnum($Aid, 6008, 6, 'Нуждается в анализе', 1);
    call us_IPInsEnum($Aid, 6009, 6, 'Оценка', 1);
    call us_IPInsEnum($Aid, 6010, 6, 'Закрыта неудачно', 1);
    --
    call us_IPInsEnum($Aid, 7001, 7, 'ANSWERED', 1);
    call us_IPInsEnum($Aid, 7002, 7, 'NO ANSWER', 1);
    call us_IPInsEnum($Aid, 7003, 7, 'BUSY', 1);
    call us_IPInsEnum($Aid, 7004, 7, 'FAILED', 1);
    call us_IPInsEnum($Aid, 7005, 7, 'CONGESTION', 1);
    call us_IPInsEnum($Aid, 7006, 7, 'RINGING', 1);
    call us_IPInsEnum($Aid, 7007, 7, 'UP', 1);
    call us_IPInsEnum($Aid, 7008, 7, 'LIMIT', 1);
    call us_IPInsEnum($Aid, 7009, 7, 'BLOCKED', 1);
    call us_IPInsEnum($Aid, 7010, 7, 'CANCEL', 1);
    call us_IPInsEnum($Aid, 7011, 7, 'CHANUNAVAIL', 1);
    call us_IPInsEnum($Aid, 7012, 7, 'WAITING', 1);
    call us_IPInsEnum($Aid, 7013, 7, 'SENT', 1);
    call us_IPInsEnum($Aid, 7014, 7, 'DELIVERED', 1);
    call us_IPInsEnum($Aid, 7015, 7, 'UNDELIVERED', 1);
    call us_IPInsEnum($Aid, 7016, 7, 'EXPIRED', 1);
    --
    call us_IPInsEnum($Aid, 100001, 8, 'Doc', 1);
    call us_IPInsEnum($Aid, 100002, 8, 'Client', 1);
    call us_IPInsEnum($Aid, 100003, 8, 'Product', 1);
    --
    call us_IPInsEnum($Aid, 100101, 10, 'Выполнен', 1);
    call us_IPInsEnum($Aid, 100102, 10, 'Заплонирован', 1);
    call us_IPInsEnum($Aid, 100103, 10, 'Отменен', 1);
    call us_IPInsEnum($Aid, 100104, 10, 'Просрочен', 1);
    --
    call us_IPInsEnum($Aid, 100201, 11, 'Приход', 1);
    call us_IPInsEnum($Aid, 100202, 11, 'Расход', 1);
    --
    call us_IPInsEnum($Aid, 100301, 12, 'Безналичный расчет', 1);
    call us_IPInsEnum($Aid, 100302, 12, 'Наличные', 1);
    --
    call us_IPInsEnum($Aid, 100401, 3, 'Аналитик', 1);
    call us_IPInsEnum($Aid, 100402, 3, 'Конкурент', 1);
    call us_IPInsEnum($Aid, 100403, 3, 'Клиент', 1);
    call us_IPInsEnum($Aid, 100404, 3, 'Интегратор', 1);
    call us_IPInsEnum($Aid, 100405, 3, 'Инвестор', 1);
    call us_IPInsEnum($Aid, 100406, 3, 'Партнер', 1);
    call us_IPInsEnum($Aid, 100407, 3, 'Пресса', 1);
    call us_IPInsEnum($Aid, 100408, 3, 'Перспективный', 1);
    call us_IPInsEnum($Aid, 100409, 3, 'Посредник', 1);
    call us_IPInsEnum($Aid, 100410, 3, 'Другое', 1);
    --
    call us_IPInsEnum($Aid, 100501, 13, 'Основной', 1);
    call us_IPInsEnum($Aid, 100502, 13, 'Рабочий', 1);
    call us_IPInsEnum($Aid, 100503, 13, 'Другой', 1);
    --
    call us_IPInsEnum($Aid, 100601, 14, 'В наличии', 1);
    call us_IPInsEnum($Aid, 100602, 14, 'На складе', 1);
    call us_IPInsEnum($Aid, 100603, 14, 'Под заказ', 1);
    call us_IPInsEnum($Aid, 100604, 14, 'Новый', 1);
    call us_IPInsEnum($Aid, 100605, 14, 'Бу', 1);
    call us_IPInsEnum($Aid, 100606, 14, 'Нет в наличии', 1);
    call us_IPInsEnum($Aid, 100607, 14, 'Ожидается', 1);
    call us_IPInsEnum($Aid, 100608, 14, 'Заблокирован', 1);
    --
    call us_IPInsEnum($Aid, 100701, 15, 'вне зоны', 1);
    call us_IPInsEnum($Aid, 100702, 15, 'номер отключен', 1);
    call us_IPInsEnum($Aid, 100703, 15, 'Автоответчик', 1);
    call us_IPInsEnum($Aid, 100704, 15, 'больше не звонить', 1);
    call us_IPInsEnum($Aid, 100705, 15, 'не номер клиента', 1);

    -- Для России и Казахстана:
    call us_IPInsEnum($Aid, 100801, 1008, 'ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100802, 1008, 'ГЕНЕРАЛЬНОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100803, 1008, 'ИСПОЛНИТЕЛЬНОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100804, 1008, 'КОММЕРЧЕСКОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100805, 1008, 'ФИНАНСОВОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100806, 1008, 'ЗАМЕСТИТЕЛЮ ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100807, 1008, 'ЗАМЕСТИТЕЛЮ ГЕНЕРАЛЬНОГО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100808, 1008, 'ИО ДИРЕКТОРА ', 1);
    call us_IPInsEnum($Aid, 100809, 1008, 'ИО ГЕНЕРАЛЬНОГО ДИРЕКТОРА ', 1);
    call us_IPInsEnum($Aid, 100810, 1008, 'ВРИО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100811, 1008, 'ВРИО ГЕНЕРАЛЬНОГО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100812, 1008, 'ПРЕДСЕДАТЕЛЮ ПРАВЛЕНИЯ', 1);
    call us_IPInsEnum($Aid, 100813, 1008, 'ПРЕДСЕДАТЕЛЮ', 1);
    call us_IPInsEnum($Aid, 100814, 1008, 'ИО ПРЕДСЕДАТЕЛЯ', 1);
    call us_IPInsEnum($Aid, 100815, 1008, 'ВРИО ПРЕДСЕДАТЕЛЯ', 1);
    call us_IPInsEnum($Aid, 100816, 1008, 'ГЛАВЕ', 1);
    call us_IPInsEnum($Aid, 100817, 1008, 'ГЛАВЕ ПРАВЛЕНИЯ', 1);
    call us_IPInsEnum($Aid, 100818, 1008, 'УЧРЕДИТЕЛЮ', 1);
    call us_IPInsEnum($Aid, 100819, 1008, 'ЗАВЕДУЮЩЕМУ', 1);
    call us_IPInsEnum($Aid, 100820, 1008, 'РЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100821, 1008, 'РУКОВОДИТЕЛЮ', 1);
    call us_IPInsEnum($Aid, 100822, 1008, 'НАЧАЛЬНИКУ', 1);
    call us_IPInsEnum($Aid, 100823, 1008, 'ГЛАВНОМУ ВРАЧУ', 1);
    call us_IPInsEnum($Aid, 100824, 1008, 'ПРЕЗИДЕНТУ', 1);
    call us_IPInsEnum($Aid, 100825, 1008, 'УПРАВЛЯЮЩЕМУ', 1);

    -- Для Украины
    call us_IPInsEnum($Aid, 100901, 1009, 'ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100902, 1009, 'ГЕНЕРАЛЬНОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100903, 1009, 'ВИКОНАВЧОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100904, 1009, 'КОМЕРЦІЙНОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100905, 1009, 'ФІНАНСОВОМУ ДИРЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100906, 1009, 'ЗАСТУПНИКУ ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100907, 1009, 'ЗАСТУПНИКУ ГЕНЕРАЛЬНОГО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100908, 1009, 'ВО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100909, 1009, 'ВО ГЕНЕРАЛЬНОГО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100910, 1009, 'ТВО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100911, 1009, 'ТВО ГЕНЕРАЛЬНОГО ДИРЕКТОРА', 1);
    call us_IPInsEnum($Aid, 100912, 1009, 'ГОЛОВІ', 1);
    call us_IPInsEnum($Aid, 100913, 1009, 'ГОЛОВІ ПРАВЛІННЯ', 1);
    call us_IPInsEnum($Aid, 100914, 1009, 'ВО ГОЛОВИ ПРАВЛІННЯ', 1);
    call us_IPInsEnum($Aid, 100915, 1009, 'ТВО ГОЛОВИ ПРАВЛІННЯ', 1);
    call us_IPInsEnum($Aid, 100916, 1009, 'ЗАСНОВНИКУ', 1);
    call us_IPInsEnum($Aid, 100917, 1009, 'ЗАВІДУЮЧОМУ', 1);
    call us_IPInsEnum($Aid, 100918, 1009, 'РЕКТОРУ', 1);
    call us_IPInsEnum($Aid, 100919, 1009, 'КЕРІВНИКУ', 1);
    call us_IPInsEnum($Aid, 100920, 1009, 'НАЧАЛЬНИКУ', 1);
    call us_IPInsEnum($Aid, 100921, 1009, 'ГОЛОВНОМУ ЛІКАРЮ', 1);
    call us_IPInsEnum($Aid, 100922, 1009, 'ПРЕЗИДЕНТУ', 1);
    call us_IPInsEnum($Aid, 100923, 1009, 'КЕРУЮЧОМУ', 1);

    -- -- примечание к проактуализированной компани
    -- call us_IPInsEnum($Aid, 101001, 1010, 'ФИО ВЕРНО', 1);
    -- call us_IPInsEnum($Aid, 101002, 1010, 'ФИО НЕ СКЛОНЯТЬ', 1);
    -- call us_IPInsEnum($Aid, 101003, 1010, 'АДРЕС ВЕРНО', 1);
    -- call us_IPInsEnum($Aid, 101004, 1010, 'НАЗВАНИЕ ВЕРНО', 1);
    -- call us_IPInsEnum($Aid, 101005, 1010, 'ПЕРЕИМЕНОВАЛИСЬ', 1);
    call us_IPInsEnum($Aid, 101006, 1010, 'М', 1);
    call us_IPInsEnum($Aid, 101007, 1010, 'Ж', 1);
    -- call us_IPInsEnum($Aid, 101008, 1010, 'КВЭД', 1);
    --
    call us_IPInsEnum($Aid, 101101, 1011, 'ДОЗВОН', 1);
    call us_IPInsEnum($Aid, 101102, 1011, 'НЕДОЗВОН', 1);
    call us_IPInsEnum($Aid, 101103, 1011, 'ЗВОНИЛ', 1);
    call us_IPInsEnum($Aid, 101104, 1011, 'ИСКАЛ', 1);
    call us_IPInsEnum($Aid, 101105, 1011, 'ВПД', 1);
    call us_IPInsEnum($Aid, 101106, 1011, 'ЛИКВИД', 1);
    call us_IPInsEnum($Aid, 101107, 1011, 'БЕЗ АДРЕСА', 1);
    call us_IPInsEnum($Aid, 101108, 1011, 'ИЗМГК', 1);
    call us_IPInsEnum($Aid, 101109, 1011, 'БАЗА', 1);
    --
    call us_IPInsEnum($Aid, 101201, 1012, 'Директор', 1);
    call us_IPInsEnum($Aid, 101202, 1012, 'Ген. Директор', 1);
    call us_IPInsEnum($Aid, 101203, 1012, 'Руководитель отдела продаж', 1);
    call us_IPInsEnum($Aid, 101204, 1012, 'Бухгалтер', 1);
    call us_IPInsEnum($Aid, 101205, 1012, 'Менеджер', 1);
    call us_IPInsEnum($Aid, 101206, 1012, 'Инженер', 1);
    call us_IPInsEnum($Aid, 101207, 1012, 'Тех. специалист', 1);
    call us_IPInsEnum($Aid, 101208, 1012, 'IТ Директор', 1);
    call us_IPInsEnum($Aid, 101209, 1012, 'Руководитель проекта', 1);
    call us_IPInsEnum($Aid, 101210, 1012, 'Маркетолог', 1);
    call us_IPInsEnum($Aid, 101211, 1012, 'Отдел HR', 1);
    --
    call us_IPInsEnum($Aid, 101311, 1013, 'Call', 1);
    call us_IPInsEnum($Aid, 101312, 1013, 'SMS', 1);
    call us_IPInsEnum($Aid, 101313, 1013, 'Viber', 1);
    call us_IPInsEnum($Aid, 101314, 1013, 'Email', 1);
    call us_IPInsEnum($Aid, 101315, 1013, 'HLR', 1);
    call us_IPInsEnum($Aid, 101316, 1013, 'Autocall', 1);
    call us_IPInsEnum($Aid, 101317, 1013, 'WebCall', 1);
    call us_IPInsEnum($Aid, 101318, 1013, 'ClickCall', 1);
    call us_IPInsEnum($Aid, 101319, 1013, 'Callback', 1);
    call us_IPInsEnum($Aid, 101320, 1013, 'LocalCall', 1);
    call us_IPInsEnum($Aid, 101321, 1013, 'Recalls', 1);

    call us_IPInsEnum($Aid, 101401, 1014, 'Queues', 1);
    call us_IPInsEnum($Aid, 101402, 1014, 'Extensions', 1);
    call us_IPInsEnum($Aid, 101403, 1014, 'Trunks', 1);
    call us_IPInsEnum($Aid, 101404, 1014, 'Terminate Call', 1);
    call us_IPInsEnum($Aid, 101405, 1014, 'IVR', 1);
    call us_IPInsEnum($Aid, 101406, 1014, 'Scenario', 1);
    call us_IPInsEnum($Aid, 101407, 1014, 'Record', 1);
    call us_IPInsEnum($Aid, 101408, 1014, 'Custom destination', 1);
    call us_IPInsEnum($Aid, 101409, 1014, 'Trunk pool', 1);
    call us_IPInsEnum($Aid, 101410, 1014, 'Time Group', 1);
    call us_IPInsEnum($Aid, 101411, 1014, 'Callback', 1);
    call us_IPInsEnum($Aid, 101412, 1014, 'Conference', 1);

    call us_IPInsEnum($Aid, 101501, 1015, 'ringall', 1);
    call us_IPInsEnum($Aid, 101502, 1015, 'leastrecent', 1);
    call us_IPInsEnum($Aid, 101503, 1015, 'fewestcalls', 1);
    call us_IPInsEnum($Aid, 101504, 1015, 'random', 1);
    call us_IPInsEnum($Aid, 101505, 1015, 'rrmemory', 1);
    call us_IPInsEnum($Aid, 101506, 1015, 'rrordered', 1);
    call us_IPInsEnum($Aid, 101507, 1015, 'wrandom', 1);
    call us_IPInsEnum($Aid, 101508, 1015, 'linear', 1);

    call us_IPInsEnum($Aid, 101601, 1016, 'New', 1);
    call us_IPInsEnum($Aid, 101602, 1016, 'Progress', 1);
    call us_IPInsEnum($Aid, 101603, 1016, 'Stoped', 1);
    call us_IPInsEnum($Aid, 101604, 1016, 'Finished', 1);

    call us_IPInsEnum($Aid, 101701, 1017, 'Telefony+', 1);
    call us_IPInsEnum($Aid, 101702, 1017, 'Telefony+Stat', 1);
    call us_IPInsEnum($Aid, 101703, 1017, 'CRM', 1);
    call us_IPInsEnum($Aid, 101704, 1017, 'Krusher5', 1);
    call us_IPInsEnum($Aid, 101705, 1017, 'Krusher10', 1);
    call us_IPInsEnum($Aid, 101706, 1017, 'Krusher20', 1);
    call us_IPInsEnum($Aid, 101707, 1017, 'Krusher50', 1);
    call us_IPInsEnum($Aid, 101708, 1017, 'Krusher100', 1);
    call us_IPInsEnum($Aid, 101709, 1017, 'Krusher+', 1);
    call us_IPInsEnum($Aid, 101710, 1017, 'Telefony5', 1);
    call us_IPInsEnum($Aid, 101711, 1017, 'Telefony10', 1);
    call us_IPInsEnum($Aid, 101712, 1017, 'Telefony20', 1);
    call us_IPInsEnum($Aid, 101713, 1017, 'Telefony50', 1);
    call us_IPInsEnum($Aid, 101714, 1017, 'Telefony100', 1);
    -- currency
    call us_IPInsEnum($Aid, 101801, 1018, 'USD', 1);
    call us_IPInsEnum($Aid, 101802, 1018, 'EUR', 1);
    call us_IPInsEnum($Aid, 101803, 1018, 'UAH', 1);
    call us_IPInsEnum($Aid, 101804, 1018, 'RUB', 1);
    -- insecure
    call us_IPInsEnum($Aid, 101901, 1019, 'port', 1);
    call us_IPInsEnum($Aid, 101902, 1019, 'invite', 1);
    call us_IPInsEnum($Aid, 101903, 1019, 'port,invite', 1);
    -- directmedia
    call us_IPInsEnum($Aid, 102001, 1020, 'yes', 1);
    call us_IPInsEnum($Aid, 102002, 1020, 'nonat', 1);
    call us_IPInsEnum($Aid, 102003, 1020, 'update', 1);
    call us_IPInsEnum($Aid, 102004, 1020, 'outgoing', 1);
    call us_IPInsEnum($Aid, 102005, 1020, 'nonat,update', 1);
    call us_IPInsEnum($Aid, 102006, 1020, 'no', 1);
    -- type
    call us_IPInsEnum($Aid, 102101, 1021, 'friend', 1);
    call us_IPInsEnum($Aid, 102102, 1021, 'peer', 1);
    call us_IPInsEnum($Aid, 102103, 1021, 'user', 1);
    -- GMT
    call us_IPInsEnum($Aid, 102201, 1022, 'GMT -12:00', 1);
    call us_IPInsEnum($Aid, 102202, 1022, 'GMT -11:00', 1);
    call us_IPInsEnum($Aid, 102203, 1022, 'GMT -10:00', 1);
    call us_IPInsEnum($Aid, 102204, 1022, 'GMT -09:00', 1);
    call us_IPInsEnum($Aid, 102205, 1022, 'GMT -08:00', 1);
    call us_IPInsEnum($Aid, 102206, 1022, 'GMT -07:00', 1);
    call us_IPInsEnum($Aid, 102207, 1022, 'GMT -06:00', 1);
    call us_IPInsEnum($Aid, 102208, 1022, 'GMT -05:00', 1);
    call us_IPInsEnum($Aid, 102209, 1022, 'GMT -04:00', 1);
    call us_IPInsEnum($Aid, 102210, 1022, 'GMT -03:30', 1);
    call us_IPInsEnum($Aid, 102211, 1022, 'GMT -03:00', 1);
    call us_IPInsEnum($Aid, 102212, 1022, 'GMT -02:00', 1);
    call us_IPInsEnum($Aid, 102213, 1022, 'GMT -01:00', 1);
    call us_IPInsEnum($Aid, 102214, 1022, 'GMT 00:00', 1);
    call us_IPInsEnum($Aid, 102215, 1022, 'GMT +01:00', 1);
    call us_IPInsEnum($Aid, 102216, 1022, 'GMT +02:00', 1);
    call us_IPInsEnum($Aid, 102217, 1022, 'GMT +03:00', 1);
    call us_IPInsEnum($Aid, 102218, 1022, 'GMT +03:30', 1);
    call us_IPInsEnum($Aid, 102219, 1022, 'GMT +04:00', 1);
    call us_IPInsEnum($Aid, 102220, 1022, 'GMT +04:30', 1);
    call us_IPInsEnum($Aid, 102221, 1022, 'GMT +05:00', 1);
    call us_IPInsEnum($Aid, 102222, 1022, 'GMT +05:30', 1);
    call us_IPInsEnum($Aid, 102223, 1022, 'GMT +05:45', 1);
    call us_IPInsEnum($Aid, 102224, 1022, 'GMT +06:00', 1);
    call us_IPInsEnum($Aid, 102225, 1022, 'GMT +06:30', 1);
    call us_IPInsEnum($Aid, 102226, 1022, 'GMT +07:00', 1);
    call us_IPInsEnum($Aid, 102227, 1022, 'GMT +08:00', 1);
    call us_IPInsEnum($Aid, 102228, 1022, 'GMT +09:00', 1);
    call us_IPInsEnum($Aid, 102229, 1022, 'GMT +09:30', 1);
    call us_IPInsEnum($Aid, 102230, 1022, 'GMT +10:00', 1);
    call us_IPInsEnum($Aid, 102231, 1022, 'GMT +11:00', 1);
    call us_IPInsEnum($Aid, 102232, 1022, 'GMT +12:00', 1);
    -- laguages
    call us_IPInsEnum($Aid, 102301, 1023, 'ru', 1);
    call us_IPInsEnum($Aid, 102302, 1023, 'ua', 1);
    call us_IPInsEnum($Aid, 102303, 1023, 'be', 1);
    call us_IPInsEnum($Aid, 102304, 1023, 'en', 1);
    call us_IPInsEnum($Aid, 102305, 1023, 'es', 1);
    call us_IPInsEnum($Aid, 102306, 1023, 'pt', 1);
    call us_IPInsEnum($Aid, 102307, 1023, 'de', 1);
    call us_IPInsEnum($Aid, 102308, 1023, 'fr', 1);
    call us_IPInsEnum($Aid, 102309, 1023, 'it', 1);
    call us_IPInsEnum($Aid, 102310, 1023, 'lt', 1);
    call us_IPInsEnum($Aid, 102311, 1023, 'pl', 1);
    call us_IPInsEnum($Aid, 102312, 1023, 'ja', 1);
    call us_IPInsEnum($Aid, 102313, 1023, 'lv', 1);
    call us_IPInsEnum($Aid, 102314, 1023, 'cz', 1);
    -- TTS Engines
    call us_IPInsEnum($Aid, 102401, 1024, 'Google', 1);
    call us_IPInsEnum($Aid, 102402, 1024, 'Yandex', 1);
    call us_IPInsEnum($Aid, 102403, 1024, 'Asterisk', 1);
    -- nat list
    call us_IPInsEnum($Aid, 102501, 1025, 'no', 1);
    call us_IPInsEnum($Aid, 102502, 1025, 'force_rport', 1);
    call us_IPInsEnum($Aid, 102503, 1025, 'comedia', 1);
    call us_IPInsEnum($Aid, 102504, 1025, 'auto_force_rport', 1);
    call us_IPInsEnum($Aid, 102505, 1025, 'auto_comedia', 1);
    call us_IPInsEnum($Aid, 102506, 1025, 'force_rport,comedia', 1);
    -- category for route outgoing
    call us_IPInsEnum($Aid, 102601, 1026, 'features', 1);
    call us_IPInsEnum($Aid, 102602, 1026, 'outgoing', 1);
    call us_IPInsEnum($Aid, 102603, 1026, 'testing', 1);
    call us_IPInsEnum($Aid, 102604, 1026, 'transfering', 1);
    -- yes no once
    call us_IPInsEnum($Aid, 102701, 1027, 'yes', 1);
    call us_IPInsEnum($Aid, 102702, 1027, 'no', 1);
    call us_IPInsEnum($Aid, 102703, 1027, 'once', 1);
    -- Queue Empty Options(параметры заполнения очереди)
    call us_IPInsEnum($Aid, 102801, 1028, 'paused', 1);
    call us_IPInsEnum($Aid, 102802, 1028, 'penalty', 1);
    call us_IPInsEnum($Aid, 102803, 1028, 'inuse', 1);
    call us_IPInsEnum($Aid, 102804, 1028, 'ringing', 1);
    call us_IPInsEnum($Aid, 102805, 1028, 'unavailable', 1);
    call us_IPInsEnum($Aid, 102806, 1028, 'invalid', 1);
    call us_IPInsEnum($Aid, 102807, 1028, 'unknown', 1);
    call us_IPInsEnum($Aid, 102808, 1028, 'wrapup', 1);
    -- dtmfmode
    call us_IPInsEnum($Aid, 102901, 1029, 'auto', 1);
    call us_IPInsEnum($Aid, 102902, 1029, 'info', 1);
    call us_IPInsEnum($Aid, 102903, 1029, 'rfc2833', 1);
    -- ranks
    call us_IPInsEnum($Aid, 103001, 1030, 'stars', 1);
    -- webrtc transport
    call us_IPInsEnum($Aid, 103101, 1031, 'tls', 1);
    call us_IPInsEnum($Aid, 103102, 1031, 'udp', 1);
    call us_IPInsEnum($Aid, 103103, 1031, 'ws', 1);
    call us_IPInsEnum($Aid, 103104, 1031, 'wss', 1);
    -- webrtc allow
    call us_IPInsEnum($Aid, 103201, 1032, 'ulaw', 1);
    call us_IPInsEnum($Aid, 103202, 1032, 'alaw', 1);
    call us_IPInsEnum($Aid, 103203, 1032, 'gsm', 1);
    call us_IPInsEnum($Aid, 103204, 1032, 'vp8', 1);
    call us_IPInsEnum($Aid, 103205, 1032, 'h264', 1);
    call us_IPInsEnum($Aid, 103206, 1032, 'h263p', 1);
    call us_IPInsEnum($Aid, 103207, 1032, 'mpeg4', 1);
    -- webrtc dtlssetup
    call us_IPInsEnum($Aid, 103301, 1033, 'actpass', 1);
    -- languages
    call us_IPInsEnum($Aid, 103401, 1034, 'Inherit', 1);
    call us_IPInsEnum($Aid, 103402, 1034, 'English', 1);
    call us_IPInsEnum($Aid, 103403, 1034, 'Russian', 1);
    call us_IPInsEnum($Aid, 103404, 1034, 'Ukrainian', 1);
    -- emEmploy status
    call us_IPInsEnum($Aid, 103501, 1035, 'Available', 1);
    call us_IPInsEnum($Aid, 103502, 1035, 'Unvailable', 1);
    call us_IPInsEnum($Aid, 103503, 1035, 'Pause', 1);
    call us_IPInsEnum($Aid, 103504, 1035, 'Dinner', 1);
    call us_IPInsEnum($Aid, 103505, 1035, 'Meeting', 1);
    call us_IPInsEnum($Aid, 103506, 1035, 'Other', 1);
    call us_IPInsEnum($Aid, 103507, 1035, 'Logout', 1);
    call us_IPInsEnum($Aid, 103508, 1035, 'Post Processing', 1);
    -- ContactStatuses of Calling card
    call us_IPInsEnum($Aid, 103601, 1036, 'Interesting', 1);
    call us_IPInsEnum($Aid, 103602, 1036, 'Lead', 1);
    call us_IPInsEnum($Aid, 103603, 1036, 'Blocked', 1);
    call us_IPInsEnum($Aid, 103604, 1036, 'Recall', 1);
    -- Recall type
    call us_IPInsEnum($Aid, 103701, 1037, 'client', 1);
    call us_IPInsEnum($Aid, 103702, 1037, 'contact', 1);
    -- Records status ready
    call us_IPInsEnum($Aid, 103801, 1038, 'new', 1);
    call us_IPInsEnum($Aid, 103802, 1038, 'working', 1);
    call us_IPInsEnum($Aid, 103803, 1038, 'ready', 1);
    -- MarketPlace types
    call us_IPInsEnum($Aid, 103901, 1039, 'All', 1);
    call us_IPInsEnum($Aid, 103902, 1039, 'Telefony', 1);
    call us_IPInsEnum($Aid, 103903, 1039, 'Autodial', 1);
    -- Records format
    call us_IPInsEnum($Aid, 104001, 1040, 'mp3', 1);
    call us_IPInsEnum($Aid, 104002, 1040, 'wav', 1);
    call us_IPInsEnum($Aid, 104003, 1040, 'ogg', 1);
END $$
DELIMITER ;
--




