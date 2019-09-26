DROP PROCEDURE IF EXISTS crm_UpdClientSabd;
DELIMITER $$
CREATE PROCEDURE crm_UpdClientSabd(
    $token              VARCHAR(100)
    , $HIID             bigint
    , $clID             int
    , $inn              varchar(14)
    , $nameFull         varchar(400)
    , $nameShort        varchar(400)
    , $adress           varchar(200)
    , $fio              varchar(100)
    , $io               varchar(100)
    , $post             varchar(50)
    , $sex              varchar(10)
    , $famIO            varchar(50)
    , $kvedCode         varchar(7)
    , $kvedDescr        varchar(250)
    , $orgNote          varchar(100)
    , $isNotice         bit
    , $callDate         datetime
    , $email            varchar(50)
    , $actualStatus     int
    , $phoneDialer      varchar(50)
    , $phoneComment     varchar(100)
    , $phones           text
)
BEGIN
  declare $emID       int;
  declare $Count      int;
  declare $data       text;
  declare $ccID       int;
  declare $ccName     varchar(50);
  declare $ccComment  varchar(100);
  declare $callDateV  varchar(20);
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdClientSabd');
  ELSE
    set $phoneComment = NULLIF(TRIM($phoneComment),'');
    --
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call RAISE(77004,NULL);
    end if;
    --
    if $callDate is NOT NULL and TIME_TO_SEC(TIMEDIFF($callDate, NOW())) < 300 then
      -- Дата и время перезвона "%s", не может быть меньше чем текущее время
      call RAISE(77066,$callDate);
    end if;
    if not exists (
      select 1
      from crmClient
      where HIID = $HIID
        and clID = $clID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    set $emID = fn_GetEmployID($token);
    --
    update crmClient set
       clName       = $nameFull
       ,ActualStatus = $actualStatus
    where clID = $clID AND Aid = $Aid;
    --
    update crmOrg set
       TaxCode        = $inn
      ,ShortName      = $nameShort
      ,headFIO        = $fio
      ,headIO         = $io
      ,headPost       = $post
      ,headSex        = $sex
      ,headFam        = $famIO
      ,KVED           = $kvedCode
      ,KVEDName       = $kvedDescr
      ,orgNote        = $orgNote
    where clID = $clID AND Aid = $Aid;
    --
    if $callDate is NOT NULL then
      update crmClientEx set
         isNotice = $isNotice
        ,CallDate = $callDate
      where clID = $clID AND Aid = $Aid;
    else
      update crmClientEx set
        isNotice = $isNotice
      where clID = $clID
        and isNotice != $isNotice
        AND Aid = $Aid;
    end if;
    --
    DROP TABLE IF EXISTS _temp;
    CREATE TEMPORARY TABLE _temp(
       ccID       int
      ,ccName     varchar(50)
      ,ccType     int
      ,ccComment  varchar(100)
      ,PRIMARY KEY(ccID)
    )ENGINE=MEMORY;
    --
    if $phoneDialer is NOT NULL then
      insert _temp
      select
         ccID
        ,$phoneDialer
        ,36
        ,$phoneComment
      from crmContact
      where ccType = 36
        and clID = $clID
        AND Aid = $Aid
      limit 1;
    end if;
    --
    if $email is NOT NULL then
      /*set $ccID = us_GetNextSequence('ccID'); 11 04 2019*/
      set $ccID = NEXTVAL(ccID);
      insert _temp
      values (
         $ccID
        ,$email
        ,37
        ,NULL);
    end if;
    --
    update crmAddress set
      adsName = $adress
    where clID = $clID AND Aid = $Aid;
    --
    if NULLIF(TRIM($phones),'') is NOT NULL then
      set $Count = common_schema.extract_json_value($phones, 'count(/data/ccID)');
      --
      while $Count > 0 do
        set $ccID = common_schema.extract_json_value($phones, CONCAT('/descendant-or-self::ccID[', CAST($Count as char),']'));
        set $ccName = common_schema.extract_json_value($phones, TRIM(CONCAT('/descendant-or-self::ccName[', CAST($Count as char),']')));
        set $ccComment = common_schema.extract_json_value($phones, TRIM(CONCAT('/descendant-or-self::ccComment[', CAST($Count as char),']')));
        --
        insert into _temp (ccID, ccName, ccComment, ccType)
        values (
           $ccID
          ,$ccName
          ,NULLIF($ccComment,'null')
          ,44
        );
        set $Count = $Count - 1;
      end while;
    end if;
    --
    insert crmContact (
       ccID
      ,clID
      ,ccName
      ,ccType
      ,ccComment
      ,isActive
      ,Aid
    )
    select
       s.ccID
      ,$clID
      ,s.ccName
      ,s.ccType
      ,s.ccComment
      ,1
      ,$Aid
    from _temp s
    where not exists (
      select 1
      from crmContact
      where ccID = s.ccID
        and clID = $clID
        AND Aid = $Aid);
    --
    update crmContact t
      inner join _temp s on s.ccID = t.ccID
    set
       t.ccName    = s.ccName
      ,t.ccComment = s.ccComment
    where t.clID = $clID AND Aid = $Aid
      and (t.ccName != s.ccName
        or IFNULL(t.ccComment,'') != IFNULL(s.ccComment,''));
    --
    delete t from crmContact t
    where t.clID = $clID
      and  not exists (
        select 1
        from _temp
        where ccID = t.ccID
        AND t.Aid = $Aid);
    --
    DROP TABLE IF EXISTS _temp;
  END IF;
END $$
DELIMITER ;
--
