-- phpMyAdmin SQL Dump
-- version 2.6.1
-- http://www.phpmyadmin.net
-- 
-- Хост: localhost
-- Время создания: Дек 27 2006 г., 21:58
-- Версия сервера: 5.0.18
-- Версия PHP: 4.3.10
-- 
-- БД: `mkechinov`
-- 

-- --------------------------------------------------------

-- 
-- Структура таблицы `Sample_CountryPhoneCode`
-- 

CREATE TABLE `Sample_CountryPhoneCode` (
  `ID` int(11) NOT NULL auto_increment,
  `TitleRU` varchar(60) default NULL,
  `TitleEN` varchar(60) default NULL,
  `PhoneCode` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 AUTO_INCREMENT=239 ;

-- 
-- Дамп данных таблицы `Sample_CountryPhoneCode`
-- 

INSERT INTO `Sample_CountryPhoneCode` VALUES (1, 'Афганистан', 'Afghanistan', '93');
INSERT INTO `Sample_CountryPhoneCode` VALUES (2, 'Албания', 'Albania', '355');
INSERT INTO `Sample_CountryPhoneCode` VALUES (3, 'Алжир', 'Algeria', '21');
INSERT INTO `Sample_CountryPhoneCode` VALUES (4, 'Американское Самоа', 'American Samoa', '684');
INSERT INTO `Sample_CountryPhoneCode` VALUES (5, 'Андорра', 'Andorra', '376');
INSERT INTO `Sample_CountryPhoneCode` VALUES (6, 'Ангола', 'Angola', '244');
INSERT INTO `Sample_CountryPhoneCode` VALUES (7, 'Ангуилла', 'Anguilla', '1-264');
INSERT INTO `Sample_CountryPhoneCode` VALUES (8, 'Антигуа и Барбуда', 'Antigua and Barbuda', '1-268');
INSERT INTO `Sample_CountryPhoneCode` VALUES (9, 'Аргентина', 'Argentina', '54');
INSERT INTO `Sample_CountryPhoneCode` VALUES (10, 'Армения', 'Armenia', '374');
INSERT INTO `Sample_CountryPhoneCode` VALUES (11, 'Аруба', 'Aruba', '297');
INSERT INTO `Sample_CountryPhoneCode` VALUES (12, 'Асеньон', 'Ascension', '247');
INSERT INTO `Sample_CountryPhoneCode` VALUES (13, 'Австралия', 'Australia', '61');
INSERT INTO `Sample_CountryPhoneCode` VALUES (14, 'Австралийские внешние территории', 'Australian External Territories', '672');
INSERT INTO `Sample_CountryPhoneCode` VALUES (15, 'Австрия', 'Austria', '43');
INSERT INTO `Sample_CountryPhoneCode` VALUES (16, 'Азербайджан', 'Azerbaijan', '994');
INSERT INTO `Sample_CountryPhoneCode` VALUES (17, 'Азорские о-ва', 'Azores', '351');
INSERT INTO `Sample_CountryPhoneCode` VALUES (18, 'Багамы', 'Bahamas', '1-242');
INSERT INTO `Sample_CountryPhoneCode` VALUES (19, 'Бахрейн', 'Bahrain', '973');
INSERT INTO `Sample_CountryPhoneCode` VALUES (20, 'Бангладеш', 'Bangladesh', '880');
INSERT INTO `Sample_CountryPhoneCode` VALUES (21, 'Барбадос', 'Barbados', '1-246');
INSERT INTO `Sample_CountryPhoneCode` VALUES (22, 'Белоруссия', 'Belarus', '375');
INSERT INTO `Sample_CountryPhoneCode` VALUES (23, 'Бельгия', 'Belgium', '32');
INSERT INTO `Sample_CountryPhoneCode` VALUES (24, 'Белиз', 'Belize', '501');
INSERT INTO `Sample_CountryPhoneCode` VALUES (25, 'Бенин', 'Benin', '229');
INSERT INTO `Sample_CountryPhoneCode` VALUES (26, 'Бермудские о-ва', 'Bermuda', '1-441');
INSERT INTO `Sample_CountryPhoneCode` VALUES (27, 'Бутан', 'Bhutan', '975');
INSERT INTO `Sample_CountryPhoneCode` VALUES (28, 'Боливия', 'Bolivia', '591');
INSERT INTO `Sample_CountryPhoneCode` VALUES (29, 'Босния и Герцеговина', 'Bosnia and Herzegovina', '387');
INSERT INTO `Sample_CountryPhoneCode` VALUES (30, 'Ботсвана', 'Botswana', '267');
INSERT INTO `Sample_CountryPhoneCode` VALUES (31, 'Бразилия', 'Brazil', '55');
INSERT INTO `Sample_CountryPhoneCode` VALUES (32, 'Британские Вирджинские о-ва', 'British Virgin Islands', '1-284');
INSERT INTO `Sample_CountryPhoneCode` VALUES (33, 'Бруней', 'Brunei', '673');
INSERT INTO `Sample_CountryPhoneCode` VALUES (34, 'Болгария', 'Bulgaria', '359');
INSERT INTO `Sample_CountryPhoneCode` VALUES (35, 'Буркина Фасо', 'Burkina Faso', '226');
INSERT INTO `Sample_CountryPhoneCode` VALUES (36, 'Бурунди', 'Burundi', '257');
INSERT INTO `Sample_CountryPhoneCode` VALUES (38, 'Камбоджа', 'Cambodia', '855');
INSERT INTO `Sample_CountryPhoneCode` VALUES (39, 'Камерун', 'Cameroon', '237');
INSERT INTO `Sample_CountryPhoneCode` VALUES (40, 'Капе Верде', 'Cape Verde', '238');
INSERT INTO `Sample_CountryPhoneCode` VALUES (41, 'Каймановы о-ва', 'Cayman Islands', '1-345');
INSERT INTO `Sample_CountryPhoneCode` VALUES (42, 'ЦАР', 'Central African Republic', '236');
INSERT INTO `Sample_CountryPhoneCode` VALUES (43, 'Чад', 'Chad', '235');
INSERT INTO `Sample_CountryPhoneCode` VALUES (44, 'Чили', 'Chile', '56');
INSERT INTO `Sample_CountryPhoneCode` VALUES (45, 'Китай', 'China', '86');
INSERT INTO `Sample_CountryPhoneCode` VALUES (46, 'Рождественсткие о-ва', 'Christmas Island', '672');
INSERT INTO `Sample_CountryPhoneCode` VALUES (47, 'Кокосовые о-ва', 'Cocos Islands', '672');
INSERT INTO `Sample_CountryPhoneCode` VALUES (48, 'Колумбия', 'Colombia', '57');
INSERT INTO `Sample_CountryPhoneCode` VALUES (49, 'Содружество северных Мариански', 'Commonwealth of the Northern M', '1-670');
INSERT INTO `Sample_CountryPhoneCode` VALUES (50, 'Коморские о-ва', 'Comoros and Mayotte Island', '269');
INSERT INTO `Sample_CountryPhoneCode` VALUES (51, 'Конго', 'Congo', '242');
INSERT INTO `Sample_CountryPhoneCode` VALUES (52, 'Дем. респ. Конго (бывш. Заир)', 'Democratic Republic (ex. Zaire)', '243');
INSERT INTO `Sample_CountryPhoneCode` VALUES (53, 'О-ва Кука', 'Cook Islands', '682');
INSERT INTO `Sample_CountryPhoneCode` VALUES (54, 'Коста Рика', 'Costa Rica', '506');
INSERT INTO `Sample_CountryPhoneCode` VALUES (55, 'Хорватия', 'Croatia', '385');
INSERT INTO `Sample_CountryPhoneCode` VALUES (56, 'Куба', 'Cuba', '53');
INSERT INTO `Sample_CountryPhoneCode` VALUES (57, 'Кипр', 'Cyprus', '357');
INSERT INTO `Sample_CountryPhoneCode` VALUES (58, 'Чехия', 'Czech Republic', '420');
INSERT INTO `Sample_CountryPhoneCode` VALUES (59, 'Дания', 'Denmark', '45');
INSERT INTO `Sample_CountryPhoneCode` VALUES (60, 'Диего Гарсиа', 'Diego Garcia', '246');
INSERT INTO `Sample_CountryPhoneCode` VALUES (61, 'Джибути', 'Djibouti', '253');
INSERT INTO `Sample_CountryPhoneCode` VALUES (62, 'Доминика', 'Dominica', '1-767');
INSERT INTO `Sample_CountryPhoneCode` VALUES (63, 'Доминиканская республика', 'Dominican Republic', '1-809');
INSERT INTO `Sample_CountryPhoneCode` VALUES (64, 'Восточный Тимор', 'East Timor', '62');
INSERT INTO `Sample_CountryPhoneCode` VALUES (65, 'Эквадор', 'Ecuador', '593');
INSERT INTO `Sample_CountryPhoneCode` VALUES (66, 'Египет', 'Egypt', '20');
INSERT INTO `Sample_CountryPhoneCode` VALUES (67, 'Сальвадор', 'El Salvador', '503');
INSERT INTO `Sample_CountryPhoneCode` VALUES (68, 'Экваториальная Гвинея', 'Equatorial Guinea', '240');
INSERT INTO `Sample_CountryPhoneCode` VALUES (69, 'Эритрия', 'Eritrea', '291');
INSERT INTO `Sample_CountryPhoneCode` VALUES (70, 'Эстония', 'Estonia', '372');
INSERT INTO `Sample_CountryPhoneCode` VALUES (71, 'Эфиопия', 'Ethiopia', '251');
INSERT INTO `Sample_CountryPhoneCode` VALUES (72, 'Фарерские о-ва', 'Faeroe Islands', '298');
INSERT INTO `Sample_CountryPhoneCode` VALUES (73, 'Фолклендские о-ва', 'Falkland Islands', '500');
INSERT INTO `Sample_CountryPhoneCode` VALUES (74, 'Фиджи', 'Fiji', '679');
INSERT INTO `Sample_CountryPhoneCode` VALUES (75, 'Финляндия', 'Finland', '358');
INSERT INTO `Sample_CountryPhoneCode` VALUES (76, 'Франция', 'France', '33');
INSERT INTO `Sample_CountryPhoneCode` VALUES (77, 'Французские Антиллы', 'French Antilles', '590');
INSERT INTO `Sample_CountryPhoneCode` VALUES (78, 'Французская Гвиана', 'French Guiana', '594');
INSERT INTO `Sample_CountryPhoneCode` VALUES (79, 'Французская полинезия', 'French Polynesia', '689');
INSERT INTO `Sample_CountryPhoneCode` VALUES (80, 'Габон', 'Gabonese Republic', '241');
INSERT INTO `Sample_CountryPhoneCode` VALUES (81, 'Гамбия', 'Gambia', '220');
INSERT INTO `Sample_CountryPhoneCode` VALUES (82, 'Грузия', 'Georgia', '995');
INSERT INTO `Sample_CountryPhoneCode` VALUES (83, 'Германия', 'Germany', '49');
INSERT INTO `Sample_CountryPhoneCode` VALUES (84, 'Гана', 'Ghana', '233');
INSERT INTO `Sample_CountryPhoneCode` VALUES (85, 'Гибралтар', 'Gibraltar', '350');
INSERT INTO `Sample_CountryPhoneCode` VALUES (86, 'Греция', 'Greece', '30');
INSERT INTO `Sample_CountryPhoneCode` VALUES (87, 'Гренландия', 'Greenland', '299');
INSERT INTO `Sample_CountryPhoneCode` VALUES (88, 'Гренада', 'Grenada', '1-473');
INSERT INTO `Sample_CountryPhoneCode` VALUES (89, 'Гуам', 'Guam', '671');
INSERT INTO `Sample_CountryPhoneCode` VALUES (90, 'Гватемала', 'Guatemala', '502');
INSERT INTO `Sample_CountryPhoneCode` VALUES (91, 'Гвинея', 'Guinea', '224');
INSERT INTO `Sample_CountryPhoneCode` VALUES (92, 'Гвинея Биссау', 'Guinea-Bissau', '245');
INSERT INTO `Sample_CountryPhoneCode` VALUES (93, 'Гайана', 'Guyana', '592');
INSERT INTO `Sample_CountryPhoneCode` VALUES (94, 'Гаити', 'Haiti', '509');
INSERT INTO `Sample_CountryPhoneCode` VALUES (95, 'Гондурас', 'Honduras', '504');
INSERT INTO `Sample_CountryPhoneCode` VALUES (96, 'Гонконг', 'Hong Kong', '852');
INSERT INTO `Sample_CountryPhoneCode` VALUES (97, 'Венгрия', 'Hungary', '36');
INSERT INTO `Sample_CountryPhoneCode` VALUES (98, 'Исландия', 'Iceland', '354');
INSERT INTO `Sample_CountryPhoneCode` VALUES (99, 'Индия', 'India', '91');
INSERT INTO `Sample_CountryPhoneCode` VALUES (100, 'Индонезия', 'Indonesia', '62');
INSERT INTO `Sample_CountryPhoneCode` VALUES (101, 'Иран', 'Iran', '98');
INSERT INTO `Sample_CountryPhoneCode` VALUES (102, 'Ирак', 'Iraq', '964');
INSERT INTO `Sample_CountryPhoneCode` VALUES (103, 'Ирландия', 'Irish Republic', '353');
INSERT INTO `Sample_CountryPhoneCode` VALUES (104, 'Израиль', 'Israel', '972');
INSERT INTO `Sample_CountryPhoneCode` VALUES (105, 'Италия', 'Italy', '39');
INSERT INTO `Sample_CountryPhoneCode` VALUES (106, 'Берег слоновой кости', 'Ivory Coast', '225');
INSERT INTO `Sample_CountryPhoneCode` VALUES (107, 'Ямайка', 'Jamaica', '1-876');
INSERT INTO `Sample_CountryPhoneCode` VALUES (108, 'Япония', 'Japan', '81');
INSERT INTO `Sample_CountryPhoneCode` VALUES (109, 'Иордания', 'Jordan', '962');
INSERT INTO `Sample_CountryPhoneCode` VALUES (110, 'Казахстан', 'Kazakhstan', '7');
INSERT INTO `Sample_CountryPhoneCode` VALUES (111, 'Кения', 'Kenya', '254');
INSERT INTO `Sample_CountryPhoneCode` VALUES (112, 'Кирибати', 'Kiribati Republic', '686');
INSERT INTO `Sample_CountryPhoneCode` VALUES (113, 'Северная Корея', 'Korea, Dem. Peoples Republic', '850');
INSERT INTO `Sample_CountryPhoneCode` VALUES (114, 'Южная Корея', 'Korea Republic', '82');
INSERT INTO `Sample_CountryPhoneCode` VALUES (115, 'Кувейт', 'Kuwait', '965');
INSERT INTO `Sample_CountryPhoneCode` VALUES (116, 'Киргизстан', 'Kyrgyzstan', '996');
INSERT INTO `Sample_CountryPhoneCode` VALUES (117, 'Лаос', 'Laos', '856');
INSERT INTO `Sample_CountryPhoneCode` VALUES (118, 'Латвия', 'Latvia', '371');
INSERT INTO `Sample_CountryPhoneCode` VALUES (119, 'Ливан', 'Lebanon', '961');
INSERT INTO `Sample_CountryPhoneCode` VALUES (120, 'Лессото', 'Lesotho', '266');
INSERT INTO `Sample_CountryPhoneCode` VALUES (121, 'Либерия', 'Liberia', '231');
INSERT INTO `Sample_CountryPhoneCode` VALUES (122, 'Ливия', 'Libya', '21');
INSERT INTO `Sample_CountryPhoneCode` VALUES (123, 'Лихтенштейн', 'Liechtenstein', '41');
INSERT INTO `Sample_CountryPhoneCode` VALUES (124, 'Литва', 'Lithuania', '370');
INSERT INTO `Sample_CountryPhoneCode` VALUES (125, 'Люксембург', 'Luxembourg', '352');
INSERT INTO `Sample_CountryPhoneCode` VALUES (126, 'Макао', 'Macau', '853');
INSERT INTO `Sample_CountryPhoneCode` VALUES (127, 'Македония', 'Macedonia', '389');
INSERT INTO `Sample_CountryPhoneCode` VALUES (128, 'Мадагаскар', 'Madagascar', '261');
INSERT INTO `Sample_CountryPhoneCode` VALUES (129, 'Малави', 'Malawi', '265');
INSERT INTO `Sample_CountryPhoneCode` VALUES (130, 'Малайзия', 'Malaysia', '60');
INSERT INTO `Sample_CountryPhoneCode` VALUES (131, 'Мальдивские о-ва', 'Maldives', '960');
INSERT INTO `Sample_CountryPhoneCode` VALUES (132, 'Мали', 'Mali', '223');
INSERT INTO `Sample_CountryPhoneCode` VALUES (133, 'Мальта', 'Malta', '356');
INSERT INTO `Sample_CountryPhoneCode` VALUES (134, 'Маршалловы о-ва', 'Marshall Islands', '692');
INSERT INTO `Sample_CountryPhoneCode` VALUES (135, 'Мартиника', 'Martinique', '596');
INSERT INTO `Sample_CountryPhoneCode` VALUES (136, 'Мавритания', 'Mauritania', '222');
INSERT INTO `Sample_CountryPhoneCode` VALUES (137, 'Маврикий', 'Mauritius', '230');
INSERT INTO `Sample_CountryPhoneCode` VALUES (138, 'Мексика', 'Mexico', '52');
INSERT INTO `Sample_CountryPhoneCode` VALUES (139, 'Микронезия', 'Micronesia', '691');
INSERT INTO `Sample_CountryPhoneCode` VALUES (140, 'Монако', 'Monaco', '377');
INSERT INTO `Sample_CountryPhoneCode` VALUES (141, 'Монголия', 'Mongolia', '976');
INSERT INTO `Sample_CountryPhoneCode` VALUES (142, 'Монсеррат', 'Montserrat', '1-664');
INSERT INTO `Sample_CountryPhoneCode` VALUES (143, 'Молдавия', 'Moldova', '373');
INSERT INTO `Sample_CountryPhoneCode` VALUES (144, 'Марокко', 'Morocco', '212');
INSERT INTO `Sample_CountryPhoneCode` VALUES (145, 'Мозамбик', 'Mozambique', '258');
INSERT INTO `Sample_CountryPhoneCode` VALUES (146, 'Мьянма', 'Myanmar', '95');
INSERT INTO `Sample_CountryPhoneCode` VALUES (147, 'Намибия', 'Namibia', '264');
INSERT INTO `Sample_CountryPhoneCode` VALUES (148, 'Науру', 'Nauru', '674');
INSERT INTO `Sample_CountryPhoneCode` VALUES (149, 'Непал', 'Nepal', '977');
INSERT INTO `Sample_CountryPhoneCode` VALUES (150, 'Нидерланды', 'Netherlands', '31');
INSERT INTO `Sample_CountryPhoneCode` VALUES (151, 'Нидерландские Антиллы', 'Netherlands Antilles', '599');
INSERT INTO `Sample_CountryPhoneCode` VALUES (152, 'Новая Каледония', 'New Caledonia', '687');
INSERT INTO `Sample_CountryPhoneCode` VALUES (153, 'Новая Зеландия', 'New Zealand', '64');
INSERT INTO `Sample_CountryPhoneCode` VALUES (154, 'Никарагуа', 'Nicaragua', '505');
INSERT INTO `Sample_CountryPhoneCode` VALUES (155, 'Нигер', 'Niger', '227');
INSERT INTO `Sample_CountryPhoneCode` VALUES (156, 'Нигерия', 'Nigeria', '234');
INSERT INTO `Sample_CountryPhoneCode` VALUES (157, 'НИУЭ', 'Niue Islands', '683');
INSERT INTO `Sample_CountryPhoneCode` VALUES (158, 'Норфолкские о-ва', 'Norfolk Island', '672');
INSERT INTO `Sample_CountryPhoneCode` VALUES (159, 'Северо-Марианские о-ва', 'Northern Mariana Islands', '670');
INSERT INTO `Sample_CountryPhoneCode` VALUES (160, 'Норвегия', 'Norway', '47');
INSERT INTO `Sample_CountryPhoneCode` VALUES (161, 'Оман', 'Oman', '968');
INSERT INTO `Sample_CountryPhoneCode` VALUES (162, 'Пакистан', 'Pakistan', '92');
INSERT INTO `Sample_CountryPhoneCode` VALUES (163, 'Палау', 'Palau', '680');
INSERT INTO `Sample_CountryPhoneCode` VALUES (164, 'Панама', 'Panama', '507');
INSERT INTO `Sample_CountryPhoneCode` VALUES (165, 'Папуа Новая Гвинея', 'Papua New Guinea', '675');
INSERT INTO `Sample_CountryPhoneCode` VALUES (166, 'Парагвай', 'Paraguay', '595');
INSERT INTO `Sample_CountryPhoneCode` VALUES (167, 'Перу', 'Peru', '51');
INSERT INTO `Sample_CountryPhoneCode` VALUES (168, 'Филипины', 'Philippines', '63');
INSERT INTO `Sample_CountryPhoneCode` VALUES (169, 'Польша', 'Poland', '48');
INSERT INTO `Sample_CountryPhoneCode` VALUES (170, 'Португалия', 'Portugal', '351');
INSERT INTO `Sample_CountryPhoneCode` VALUES (171, 'Пуэрто Рико', 'Puerto Rico', '1-787');
INSERT INTO `Sample_CountryPhoneCode` VALUES (172, 'Катар', 'Qatar', '974');
INSERT INTO `Sample_CountryPhoneCode` VALUES (173, 'Сан Марино', 'Republic of San Marino', '378');
INSERT INTO `Sample_CountryPhoneCode` VALUES (174, 'Реюнион', 'Reunion Islands', '262');
INSERT INTO `Sample_CountryPhoneCode` VALUES (175, 'Румыния', 'Romania', '40');
INSERT INTO `Sample_CountryPhoneCode` VALUES (176, 'Россия', 'Russia', '7');
INSERT INTO `Sample_CountryPhoneCode` VALUES (177, 'Руанда', 'Rwandese Republic', '250');
INSERT INTO `Sample_CountryPhoneCode` VALUES (178, 'О-ва Святой Елены', 'Saint Helena and Ascension Isl', '247');
INSERT INTO `Sample_CountryPhoneCode` VALUES (179, 'Сент Пьер', 'Saint Pierre et Miquelon', '508');
INSERT INTO `Sample_CountryPhoneCode` VALUES (180, 'Сан Марино', 'San Marino', '39');
INSERT INTO `Sample_CountryPhoneCode` VALUES (181, 'Сент Том и Принцип', 'Sao Tome e Principe', '239');
INSERT INTO `Sample_CountryPhoneCode` VALUES (182, 'Саудовская Аравия', 'Saudi Arabia', '966');
INSERT INTO `Sample_CountryPhoneCode` VALUES (183, 'Сенегал', 'Senegal', '221');
INSERT INTO `Sample_CountryPhoneCode` VALUES (184, 'Сейшельские о-ва', 'Seychelles', '248');
INSERT INTO `Sample_CountryPhoneCode` VALUES (185, 'Сьерра Леоне', 'Sierra Leone', '232');
INSERT INTO `Sample_CountryPhoneCode` VALUES (186, 'Сингапур', 'Singapore', '65');
INSERT INTO `Sample_CountryPhoneCode` VALUES (187, 'Словакия', 'Slovak Republic', '421');
INSERT INTO `Sample_CountryPhoneCode` VALUES (188, 'Словения', 'Slovenia', '386');
INSERT INTO `Sample_CountryPhoneCode` VALUES (189, 'Соломоновы о-ва', 'Solomon Islands', '677');
INSERT INTO `Sample_CountryPhoneCode` VALUES (190, 'Сомали', 'Somalia', '252');
INSERT INTO `Sample_CountryPhoneCode` VALUES (191, 'ЮАР', 'South Africa', '27');
INSERT INTO `Sample_CountryPhoneCode` VALUES (192, 'Испания', 'Spain', '34');
INSERT INTO `Sample_CountryPhoneCode` VALUES (193, 'Шри Ланка', 'Sri Lanka', '94');
INSERT INTO `Sample_CountryPhoneCode` VALUES (194, 'Сент-Китс и Невис', 'St. Kitts and Nevis', '1-869');
INSERT INTO `Sample_CountryPhoneCode` VALUES (195, 'Санта Лючия', 'St. Lucia', '1-758');
INSERT INTO `Sample_CountryPhoneCode` VALUES (196, 'Сент Винцент и Гренадины', 'St. Vincent and the Grenadines', '1-784');
INSERT INTO `Sample_CountryPhoneCode` VALUES (197, 'Судан', 'Sudan', '249');
INSERT INTO `Sample_CountryPhoneCode` VALUES (198, 'Суринам', 'Suriname', '597');
INSERT INTO `Sample_CountryPhoneCode` VALUES (199, 'Свалбард', 'Svalbard and Jan Mayen Islands', '47');
INSERT INTO `Sample_CountryPhoneCode` VALUES (200, 'Свазиленд', 'Swaziland', '268');
INSERT INTO `Sample_CountryPhoneCode` VALUES (201, 'Швеция', 'Sweden', '46');
INSERT INTO `Sample_CountryPhoneCode` VALUES (202, 'Швейцария', 'Switzerland', '41');
INSERT INTO `Sample_CountryPhoneCode` VALUES (203, 'Сирия', 'Syria', '963');
INSERT INTO `Sample_CountryPhoneCode` VALUES (204, 'Тайвань', 'Taiwan', '886');
INSERT INTO `Sample_CountryPhoneCode` VALUES (205, 'Таджикистан', 'Tajikistan', '992');
INSERT INTO `Sample_CountryPhoneCode` VALUES (206, 'Танзания', 'Tanzania', '255');
INSERT INTO `Sample_CountryPhoneCode` VALUES (207, 'Тайланд', 'Thailand', '66');
INSERT INTO `Sample_CountryPhoneCode` VALUES (208, 'Тоголезе', 'Togolese Republic', '228');
INSERT INTO `Sample_CountryPhoneCode` VALUES (209, 'Токелау', 'Tokelau', '690');
INSERT INTO `Sample_CountryPhoneCode` VALUES (210, 'Тонго', 'Tonga', '676');
INSERT INTO `Sample_CountryPhoneCode` VALUES (211, 'Тринидад и Тобаго', 'Trinidad and Tobago', '1-868');
INSERT INTO `Sample_CountryPhoneCode` VALUES (212, 'Тунис', 'Tunisia', '21');
INSERT INTO `Sample_CountryPhoneCode` VALUES (213, 'Турция', 'Turkey', '90');
INSERT INTO `Sample_CountryPhoneCode` VALUES (214, 'Туркменистан', 'Turkmenistan', '993');
INSERT INTO `Sample_CountryPhoneCode` VALUES (215, 'Текс и Каикос Айландс', 'Turks & Caicos Islands', '1-649');
INSERT INTO `Sample_CountryPhoneCode` VALUES (216, 'Тувалу', 'Tuvalu', '688');
INSERT INTO `Sample_CountryPhoneCode` VALUES (217, 'Уганда', 'Uganda', '256');
INSERT INTO `Sample_CountryPhoneCode` VALUES (218, 'Украина', 'Ukraine', '380');
INSERT INTO `Sample_CountryPhoneCode` VALUES (219, 'ОАЭ', 'United Arab Emirates', '971');
INSERT INTO `Sample_CountryPhoneCode` VALUES (220, 'Великобритания', 'United Kingdom', '44');
INSERT INTO `Sample_CountryPhoneCode` VALUES (221, 'Уругвай', 'Uruguay', '598');
INSERT INTO `Sample_CountryPhoneCode` VALUES (222, 'Вирджинские о-ва', 'US Virgin Islands', '1-340');
INSERT INTO `Sample_CountryPhoneCode` VALUES (223, 'США', 'USА', '1');
INSERT INTO `Sample_CountryPhoneCode` VALUES (224, 'Узбекистан', 'Uzbekistan', '998');
INSERT INTO `Sample_CountryPhoneCode` VALUES (225, 'Вануату', 'Vanuatu', '678');
INSERT INTO `Sample_CountryPhoneCode` VALUES (226, 'Ватикан', 'Vatican City State', '39');
INSERT INTO `Sample_CountryPhoneCode` VALUES (227, 'Венесуэла', 'Venezuela', '58');
INSERT INTO `Sample_CountryPhoneCode` VALUES (228, 'Вьетнам', 'Vietnam', '84');
INSERT INTO `Sample_CountryPhoneCode` VALUES (229, 'Эллис и Футуна острова', 'Wallis and Futuna', '681');
INSERT INTO `Sample_CountryPhoneCode` VALUES (230, 'Западная Сахара', 'Western Sahara', '21');
INSERT INTO `Sample_CountryPhoneCode` VALUES (231, 'Западное Самоа', 'Western Samoa', '685');
INSERT INTO `Sample_CountryPhoneCode` VALUES (232, 'Северный Йемен', 'Yemen, North', '967');
INSERT INTO `Sample_CountryPhoneCode` VALUES (233, 'Южный Йемен', 'Yemen, South', '969');
INSERT INTO `Sample_CountryPhoneCode` VALUES (234, 'Югославия', 'Yugoslavia', '381');
INSERT INTO `Sample_CountryPhoneCode` VALUES (235, 'Заир', 'Zaire', '243');
INSERT INTO `Sample_CountryPhoneCode` VALUES (236, 'Замбия', 'Zambia', '260');
INSERT INTO `Sample_CountryPhoneCode` VALUES (237, 'Занзибар', 'Zanzibar', '259');
INSERT INTO `Sample_CountryPhoneCode` VALUES (238, 'Зимбабве', 'Zimbabwe', '263');
