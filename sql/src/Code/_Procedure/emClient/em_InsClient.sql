DELIMITER $$
DROP PROCEDURE IF EXISTS em_InsClient;
CREATE PROCEDURE em_InsClient(
    $LoginName            VARCHAR(30)
    , $Password           VARCHAR(100)
    , $url                VARCHAR(255)
    , $IP                 VARCHAR(255)
    , $port               SMALLINT
    , $phone              BIGINT
    , $mobile_phone       BIGINT
    , $email_info         VARCHAR(255)
    , $email_tech         VARCHAR(255)
    , $email_finance      VARCHAR(255)
    , $hosting_type       INT
    , $clientName         VARCHAR(255)
    , $clientContact      VARCHAR(255)
    , $id_currency        INT
    , $isActive           BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid              INT;
  DECLARE $emID             INT;
  DECLARE $emID2            INT;
  DECLARE $ftID             INT;
  DECLARE $ftiID            INT;
  DECLARE $dbID             INT;
  DECLARE $trID             INT;
  DECLARE $sipID            INT;
  DECLARE $queID            INT;
  DECLARE $quemID           INT;
  DECLARE $rtID             INT;
  DECLARE $roID             INT;
  DECLARE $LenNumber1       INT;
  DECLARE $LenNumber2       INT;
  DECLARE $clID             INT;
  DECLARE $ffID             INT;
  DECLARE $roleID           INT;

  SET $url = NULLIF(TRIM($url), '');
  SET $IP = NULLIF(TRIM($IP), '');
  SET $id_currency = IF($id_currency IS NULL, 101801, $id_currency);
  SET $hosting_type = IF($hosting_type IS NULL, 101704, $hosting_type);
  --
  IF $clientName IS NULL THEN
    SET $clientName = $LoginName;
  END IF;
  --
  IF($LoginName = 'root') THEN
    call RAISE(77067, NULL);
  END IF;
  --
  IF ($LoginName is NULL) THEN
    -- Параметр "Логин" должен иметь значение
    call RAISE(77024, NULL);
  END IF;
  SET $Password = NULLIF(TRIM($Password), '');
  IF (($Password is NULL) or (LENGTH($Password) < 12)) THEN
    -- Параметр "Пароль" должен иметь значение
    call RAISE(77025, NULL);
  END IF;
  --
  IF(($url is NULL) AND ($IP is NULL)) THEN
    call RAISE(77072, NULL);
  END IF;
  --
  IF $port IS NULL THEN
    SET $port = 443;
  END IF;
  --
  if exists (
    SELECT 1
    FROM emClient
    WHERE url = $url) THEN
      -- Логин "%s", уже используется для другого сотрудника
      call RAISE(77071, $url);
  END IF;
  --
  IF ($isActive = TRUE) THEN
    SET $isActive = 1;
  ELSE
    SET $isActive = 0;
  END IF;
  --
  SET @s = (SELECT IF(
      (SELECT COUNT(1)
       FROM emEmploy WHERE LoginName='system'
      ) > 0,
      "SELECT '+Ins_206'",
      "INSERT INTO emEmploy (HIID, emID, Aid, SipAccount, emName, IsActive, LoginName, Password, ManageID, sipName, Queue, url, roleID, sipID)
        VALUES (fn_GetStamp(), /*us_GetNextSequence('emID'), */NEXTVAL(emID), 0, 100000, 'System', 1, 'system', PASSWORD('GajQFtnlejJwdEGby73Z7MBlnktMwc'), null, 'System', NULL, 'krusher', 1, NULL);"
  ));

  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  --
  INSERT INTO emClient (
    HIID
    , url
    , IP
    , `port`
    , login
    , `password`
    , phone
    , mobile_phone
    , email_info
    , email_tech
    , email_finance
    , tarrif
    , fee
    , hosting_type
    , date_fee
    , client_name
    , client_contact
    , id_currency
    , isActive
    , pauseDelay
    , count_of_calls
  )
  VALUES (
    fn_GetStamp()
    , $url
    , $IP
    , $port
    , $LoginName
    , PASSWORD($Password)
    , $phone
    , $mobile_phone
    , $email_info
    , $email_tech
    , $email_finance
    , 75
    , 75
    , $hosting_type
    , DAY(NOW())
    , $clientName
    , $clientContact
    , $id_currency
    , $isActive
    , 60
    , 5
  );
  --
  SET $Aid = LAST_INSERT_ID();
  --
  call setEnumsData($Aid);

  SET $emID = NEXTVAL(emID);
  SET $sipID = NEXTVAL(sipID);
  SET $roleID = NEXTVAL(roleID);
  INSERT INTO emRole (HIID, roleID, roleName, isActive, Permission, Aid)
    VALUES (fn_GetStamp(), $roleID, 'Admin', 1, 1, $Aid),
            (fn_GetStamp(),  NEXTVAL(roleID), 'Supervisor', 1, 2, $Aid),
            (fn_GetStamp(),  NEXTVAL(roleID), 'Client', 1, 5, $Aid),
            (fn_GetStamp(),  NEXTVAL(roleID), 'Operator', 1, 3, $Aid),
            (fn_GetStamp(),  NEXTVAL(roleID), 'Developer', 1, 4, $Aid),
            (fn_GetStamp(),  NEXTVAL(roleID), 'Client', 1, 5, $Aid),
            (fn_GetStamp(),  NEXTVAL(roleID), 'Validator', 1, 6, $Aid);
  --
  INSERT INTO emEmploy (emID, HIID, Aid, SipAccount, emName, LoginName, Password, IsActive, url, roleID, sipID, sipName)
        VALUES ($emID, fn_GetStamp(), $Aid, (100000+$emID), $LoginName, LOWER($LoginName), PASSWORD($Password), 1, $url, $roleID, $sipID, $LoginName);
  INSERT INTO `ast_sippeers` (`HIID`, `sipID`, `Aid`, `sipName`, `template`, `secret`, `context`, `callgroup`, `pickupgroup`, `callerid`, `nat`, `lines`, `dtmfmode`, `RowVersion`, `avpf`, `force_avp`, `icesupport`, `videosupport`, `dtlsenable`, `dtlsverify`, `isPrimary`, `isActive`) VALUES
                            (fn_GetStamp(), $sipID, $Aid, $LoginName, 'users', $Password, CONCAT('office_', $Aid), '1', '1', $LoginName, '102506', '2', '102903', NOW(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE);

  --
  SET $emID2 = NEXTVAL(emID);
  INSERT INTO emEmploy (HIID, emID, Aid, SipAccount, emName, IsActive, LoginName, Password, ManageID, sipName, Queue, url, roleID, sipID)
    VALUES (fn_GetStamp(), $emID2, $Aid, (100000+$emID2), 'SuperAdmin', 1, 'superadmin', PASSWORD('sn3dcxt56vt47p23o9b561t700au'), null, 'SuperAdmin', NULL, IF($url IS NULL, (SELECT url FROM emClient WHERE id_client=$Aid), $url), 1, NULL);
    --
  INSERT ccCommentList (comID, Aid, comName, isActive, HIID) VALUES
    (0, $Aid, 'Закрыта неудачно', 1, fn_GetStamp())
    , (1, $Aid, 'Оценка', 1, fn_GetStamp())
    , (2, $Aid, 'Нуждается в анализе', 1, fn_GetStamp())
    , (3, $Aid, 'Предложение', 1, fn_GetStamp())
    , (4, $Aid, 'Поиск принимающих решений', 1, fn_GetStamp())
    , (5, $Aid, 'Анализ ситуации', 1, fn_GetStamp())
    , (6, $Aid, 'Ценовое предложение', 1, fn_GetStamp())
    , (7, $Aid, 'Переговоры или отзыв', 1, fn_GetStamp())
    , (8, $Aid, 'Закрыта удачно', 1, fn_GetStamp())
    , (9, $Aid, 'Переговоры', 1, fn_GetStamp());
    --
  SET $ftID = NEXTVAL(ftID);
  INSERT INTO fsTemplate (ftID, Aid, ftName, delimiter, Encoding, isActive, HIID)
    VALUES ($ftID, $Aid, 'default csv', ';', 'cp1251', b'1', fn_GetStamp());
  SET $ftiID = NEXTVAL(ftiID);
  INSERT INTO fsTemplateItem (ftiID, Aid, ftID, ftType, isActive, HIID)
    VALUES ($ftiID, $Aid, $ftID, '45', b'1', fn_GetStamp());
  INSERT INTO fsTemplateItemCol (ftiID, Aid, ColNumber, isActive, HIID)
    VALUES ($ftiID, $Aid, '1', b'1', fn_GetStamp());
  SET $ftiID = NEXTVAL(ftiID);
  INSERT INTO fsTemplateItem (ftiID, Aid, ftID, ftType, isActive, HIID)
    VALUES ($ftiID, $Aid, $ftID, '47', b'1', fn_GetStamp());
  INSERT INTO fsTemplateItemCol (ftiID, Aid, ColNumber, isActive, HIID)
    VALUES ($ftiID, $Aid, '2', b'1', fn_GetStamp());
  --
  SET $ftID = NEXTVAL(ftID);
  INSERT INTO fsTemplate (ftID, Aid, ftName, delimiter, Encoding, isActive, HIID)
    VALUES ($ftID, $Aid, 'default xlsx,xls', ',', 'utf8', b'1', fn_GetStamp());
  SET $ftiID = NEXTVAL(ftiID);
  INSERT INTO fsTemplateItem (ftiID, Aid, ftID, ftType, isActive, HIID)
    VALUES ($ftiID, $Aid, $ftID, '45', b'1', fn_GetStamp());
  INSERT INTO fsTemplateItemCol (ftiID, Aid, ColNumber, isActive, HIID)
    VALUES ($ftiID, $Aid, '1', b'1', fn_GetStamp());
  SET $ftiID = NEXTVAL(ftiID);
  INSERT INTO fsTemplateItem (ftiID, Aid, ftID, ftType, isActive, HIID)
    VALUES ($ftiID, $Aid, $ftID, '47', b'1', fn_GetStamp());
  INSERT INTO fsTemplateItemCol (ftiID, Aid, ColNumber, isActive, HIID)
    VALUES ($ftiID, $Aid, '2', b'1', fn_GetStamp());
  --
  INSERT IGNORE INTO dcType (dctID, Aid, dctName, isActive, HIID)
    VALUES (1, 0, 'Обращение', b'1', fn_GetStamp()),
          (2, 0, 'Сделка', b'1', fn_GetStamp()),
          (4, 0, 'Анкета', b'1', fn_GetStamp()),
          (5, 0, 'Счет', b'1', fn_GetStamp()),
          (6, 0, 'Платеж', b'1', fn_GetStamp()),
          (7, 0, 'Договор', b'1', fn_GetStamp()),
          (8, 0, 'Акт В/Р', b'1', fn_GetStamp()),
          (9, 0, 'Событие', b'1', fn_GetStamp());
  --
  SET $trID = NEXTVAL(trID);
  INSERT INTO `ast_trunk` (`HIID`, `trID`, `Aid`, `trName`, `uniqName`, `template`, `secret`, `context`, `callgroup`, `pickupgroup`, `callerid`, `host`, `nat`, `fromuser`, `fromdomain`, `callbackextension`, `isServer`, `type`, `directmedia`, `insecure`, `Comment`, isActive) VALUES
                                  (fn_GetStamp(), $trID, $Aid, 'trunk', CONCAT('trunk_', $Aid), 'peers', 'tralala', CONCAT('incoming_', $Aid), '1', '1', 'trunk', 'hostname', '102506', 'trunk', 'hostname', 'trunk', b'1', '102102', '102006', '101903', 'trunk template', FALSE);
  --
  SET $queID = NEXTVAL(queID);
  SET $quemID = NEXTVAL(quemID);
  INSERT INTO `ast_queues` (`queID`, `HIID`, `Aid`, `name`, `timeout`, `retry`, `wrapuptime`, `servicelevel`, `strategy`, `timeoutrestart`) VALUES
          ($queID, fn_GetStamp(), $Aid, 'Default', '0', '0', '0', '0', 'ringall', '0');
  INSERT INTO `ast_queue_members` (`HIID`, `quemID`, `Aid`, `emID`, `queID`, `membername`, `queue_name`, `interface`, `penalty`, `paused`, `isActive`) VALUES
          (fn_GetStamp(), $quemID, $Aid, $emID, $queID, $LoginName, 'Default', CONCAT('SIP/', $LoginName), '0', '0', b'1');
  --
  SET $rtID = NEXTVAL(rtID);
  INSERT INTO `ast_route_incoming` (`HIID`, `rtID`, `Aid`, `trID`, `DID`, `exten`, `context`, `destination`, `destdata`, `isActive`) VALUES
        (fn_GetStamp(), $rtID, $Aid, $trID, '_X.', '_X.', 'incoming', '101401', $queID, b'1');
  --
  SET $roID = NEXTVAL(roID);
  INSERT INTO `ast_route_outgoing` (`HIID`, `roID`, `roName`, `Aid`, `destination`, `destdata`, `category`, `prepend`, `prefix`, `priority`, `isActive`) VALUES
        (fn_GetStamp(), $roID, 'Any', $Aid, '101403', $trID, '102602', NULL, NULL, NULL, b'1');
  SELECT LenNumber1, LenNumber2
  INTO $LenNumber1, $LenNumber2
  FROM reg_countries
  WHERE country_id = reg_GetCountryInfo($Aid, fn_GetNumberByString($phone));
  --
  IF($LenNumber1 IS NOT NULL) THEN
    INSERT INTO `ast_route_outgoing_items` (`HIID`, `roiID`, `Aid`, `roID`, `pattern`, `isActive`) VALUES
            (fn_GetStamp(), NEXTVAL(roiID), $Aid, $roID, RPAD('_', ($LenNumber1+1), 'X'), b'1');
  END IF;
  IF($LenNumber2 IS NOT NULL) THEN
    INSERT INTO `ast_route_outgoing_items` (`HIID`, `roiID`, `Aid`, `roID`, `pattern`, `isActive`) VALUES
            (fn_GetStamp(), NEXTVAL(roiID), $Aid, $roID, RPAD('_', ($LenNumber2+1), 'X'), b'1');
  END IF;
  --
  SET $dbID = NEXTVAL(dbID);
  INSERT INTO fsBase (dbID, Aid, dbName, dbPrefix, isActive, activeTo, HIID) VALUES ($dbID, $Aid, 'Category', 'df', 1, NULL, fn_GetStamp());
  --
  INSERT INTO ast_scenario (id_scenario, name_scenario, Aid, DaysCall, RecallCount, RecallAfterMin, RecallCountPerDay, RecallDaysCount, RecallAfterPeriod, SleepTime, destination, destdata, isActive, HIID) VALUES
                      ( NEXTVAL(id_scenario), 'Default', $Aid, '1,2,3,4,5,6,7', '10', '60', '2', '7', '1', '2', '101403', $trID, b'1', fn_GetStamp());
  --
  INSERT INTO crmClient (HIID, clID, Aid, clName, IsPerson, `Comment`, ParentID, ffID, CompanyID, uID, isActual, ActualStatus, `Position`, responsibleID, CreatedBy, ChangedBy, IsActive) VALUES
                      (fn_GetStamp(), 0, $Aid, '[Default]', 0, '', 0, '0', NULL, UUID_SHORT(), 0, NULL, NULL, 0, 0, 0, 1);
  --
  INSERT INTO fsFile (HIID, ffID, Aid, ffName, Priority, dbID, clients_count, phones_count, trash_count, status_answered_and_comment, status_answered, status_no_answered, status_busy, status_not_successfull, isActive) VALUES
                      (fn_GetStamp(), 0,  $Aid, '[Default]', 0, $dbID, 0, 0, 0, 0, 0, 0, 0, 0, 1);
  SET $ffID = NEXTVAL(ffID);
  SET $clID = NEXTVAL(clID);
  INSERT INTO fsFile (HIID, ffID, Aid, ffName, Priority, dbID, clients_count, phones_count, trash_count, status_answered_and_comment, status_answered, status_no_answered, status_busy, status_not_successfull, isActive) VALUES
                      (fn_GetStamp(), $ffID,  $Aid, 'New', 0, $dbID, 0, 0, 0, 0, 0, 0, 0, 0, 1);
  INSERT INTO crmClient (HIID, clID, Aid, clName, IsPerson, `Comment`, ParentID, ffID, CompanyID, uID, isActual, ActualStatus, `Position`, responsibleID, CreatedBy, ChangedBy, IsActive) VALUES
                      (fn_GetStamp(), $clID, $Aid, $LoginName, 1, '', 0, $ffID, NULL, UUID_SHORT(), 0, NULL, NULL, 0, 0, 0, 1);
  INSERT INTO `crmClientEx` (`HIID`, `clID`, `Aid`, `ffID`, `CallDate`, `ChangedBy`, `isNotice`, `isRobocall`, `isCallback`, `isDial`) VALUES
                      (fn_GetStamp(), $clID , $Aid, $ffID, NULL, 0, FALSE, FALSE, FALSE, FALSE);
  --
  INSERT INTO crmContact (HIID, ccID, Aid, clID, ccName, ccType, isPrimary, isActive, ccStatus, ccComment, gmt, MCC, MNC, id_country, id_region, id_area, id_city, id_mobileProvider, ffID) VALUES
                      (fn_GetStamp(), NEXTVAL(ccID), $Aid, $clID, $phone, 36, 1, 1, NULL, NULL, reg_GetGmtInfo($Aid, $phone), reg_GetMCCInfo($Aid, $phone), reg_GetMNCInfo($Aid, $phone), reg_GetCountryInfo($Aid, $phone), reg_GetRegionInfo($Aid, $phone), reg_GetAreaInfo($Aid, $phone), reg_GetCityInfo($Aid, $phone), reg_GetOperatorInfo($Aid, $phone), $ffID);
  call crm_IPUpdFileRegion($ffID);
  call crm_IPUpdStatusFile($ffID);
  --
END $$
DELIMITER ;
--
