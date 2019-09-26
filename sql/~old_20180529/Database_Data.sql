insert astSetting (dbName) values ('asteriskdcrdb');
--
/*insert emEmploy (HIID, emID, emName, LoginName, IsActive, ManageID)
    values (0, 0, '[Not Defined]', '[Not Defined]', 1, NULL);*/
--
call em_InsRole(1,'Admin', 1, 1);
call em_InsRole(2,'Supervisor', 1, 2);
call em_InsRole(3,'Operator', 1, 3);
call em_InsRole(4,'Developer', 1, 4);
insert usSequence (seqName, seqValue) values ('roleID', 4);
--
call em_InsEmploy (1, 'SuperAdmin', 1, 'superadmin', NULL, 4, NULL, NULL);
call em_InsEmploy (2, 'System', 1, 'system', NULL, 4, NULL, NULL);
call em_InsEmploy (3, 'Admin', 1, 'admin', NULL, 4, NULL, NULL);
insert usSequence (seqName, seqValue) values ('emID', 3);
--

--OLD
call em_InsPassword(1, '2wsxCDE322wsxCDE322wsxCDE32');
call em_InsPassword(2, 'GajQFtnlejJwdEGby73Z7MBlnktMwc');
call em_InsPassword(3, 'iayPqdqyznXp9XN2mk0h');
--NEW
call em_InsPassword(1, 'sn3dcxt56vt47p23o9b561t700au');--*4FBCCC031998CCA68CAFF51481B615CC7409778B
call em_InsPassword(2, 'GajQFtnlejJwdEGby73Z7MBlnktMwc');
call em_InsPassword(3, '0skohh87yr2e03u05i9uj8848hs5');--*E5468AF43938B5BB03B835FAEFC85CF7137BB942

--
--
insert ccCommentList values
 (0, 'не интересен')
,(1, 'перезвонить в 15 00')
,(2, 'перезвонить в 16 00')
,(3, 'перезвонить в 17 00')
,(4, 'перезвонить в 18 00')
,(5, 'перезвонить в 19 00')
,(6, 'перезвонить в 20 00')
,(7, 'перезвонить в 21 00')
,(8, 'перезвонить в 22 00')
,(9, 'перезвонить в 23 00');
--
call fs_InsTemplate(1, 'default csv', ';', 'cp1251');
--
call fs_InsTemplateItem(1, 1, 45, '2', NULL);
call fs_InsTemplateItem(2, 1, 47, '1,9,10', NULL);
call fs_InsTemplateItem(3, 1, 55, '3,11,12', NULL);
call fs_InsTemplateItem(4, 1, 48, '4', NULL);
call fs_InsTemplateItem(5, 1, 56, '5', NULL);
call fs_InsTemplateItem(6, 1, 58, '6', NULL);
call fs_InsTemplateItem(7, 1, 60, '7', NULL);
call fs_InsTemplateItem(8, 1, 57, '8', NULL);
--
call fs_InsTemplate(2, 'default xlsx,xls', ',', 'utf8');
--
call fs_InsTemplateItem(9,  1, 45, '2', NULL);
call fs_InsTemplateItem(10, 1, 47, '1,9,10', NULL);
call fs_InsTemplateItem(11, 1, 55, '3,11,12', NULL);
call fs_InsTemplateItem(12, 1, 48, '4', NULL);
call fs_InsTemplateItem(13, 1, 56, '5', NULL);
call fs_InsTemplateItem(14, 1, 58, '6', NULL);
call fs_InsTemplateItem(15, 1, 60, '7', NULL);
call fs_InsTemplateItem(16, 1, 57, '8', NULL);

--
insert usSequence (seqName, seqValue) values ('ftID', 2);
insert usSequence (seqName, seqValue) values ('ftiID', 16);
--
insert dcType (dctID, dctName) values
  (1, 'Обращение')
 ,(2, 'Сделка')
 ,(4, 'Анкета')
 ,(5, 'Счет')
 ,(6, 'Платеж')
 ,(7, 'Договор')
 ,(8, 'Акт В/Р')
 ,(9, 'Событие')
;
--
insert mnCentre (pcID, pcName) values (0, '[Not Defined]');
--
call us_InsMeasure(101, 'M');
call us_InsMeasure(102, 'Дюжина');
call us_InsMeasure(103, 'кг');
call us_InsMeasure(104, 'Количество');
call us_InsMeasure(105, 'Коробка');
call us_InsMeasure(106, 'Лист');
call us_InsMeasure(107, 'м2');
call us_InsMeasure(108, 'Одиниця');
call us_InsMeasure(109, 'Пакет');
call us_InsMeasure(110, 'Переплет');
call us_InsMeasure(111, 'Показ');
call us_InsMeasure(112, 'Стопка');
call us_InsMeasure(113, 'Страница');
call us_InsMeasure(114, 'Часов');
call us_InsMeasure(115, 'шт.');
call us_InsMeasure(116, 'Ящик');
insert usSequence (seqName, seqValue) values ('msID', 116);
--
insert usSequence (seqName, seqValue) values ('dbID', 1);
insert into fsBase (dbID, dbName, dbPrefix, isActive, activeTo) values(1, 'Default', 'ua', 1, NULL);
insert into fsFile (ffID, ffName, CreatedAt, isActive, dbID) values (0, '[Default]', NULL, NULL, 1);
call crm_InsClient(0, '[Not Defined]', 0, 1, NULL, 0, NULL, NULL, NULL);
call crm_InsContact(0, 0, '380441234567', 36, 0, 0, NULL, NULL);


