DROP PROCEDURE IF EXISTS crm_UpdSaveClient;
DELIMITER $$
CREATE PROCEDURE crm_UpdSaveClient(
    $HIID           bigint
    , $token        VARCHAR(100)
    , $clID         int
    , $clName       varchar(200)
    , $IsPerson     bit
    , $IsActive     bit
    , $Comment      varchar(200)
    , $ffID         int
    , $ParentID     int
    , $CompanyID    int
    , $Position     int
    , $TaxCode      varchar(14)
    , $address      text
    , $contacts     text
    , $emIDEditor   INT(11)
    , $hostEditor   VARCHAR(50)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $emID       int;
  declare $ccType     int;
  declare $adsID      int;
  declare $Count      int;
  declare $ccID       int;
  declare $ccName     varchar(50);
  declare $ccComment  varchar(100);
  DECLARE $Aid        INT;
  DECLARE $newHIID    BIGINT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdSaveClient');
  ELSE
    if not exists (
      select 1
      from crmClient
      where HIID = $HIID
        and clID = $clID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    set $emID = fn_GetEmployID($token);
    SET $newHIID = fn_GetStamp();
    --
    update crmClient set
      clName        = $clName
      , IsPerson    = $IsPerson
      , IsActive    = $IsActive
      , `Comment`   = $Comment
      , ffID        = $ffID
      , ParentID    = $ParentID
      , CompanyID   = $CompanyID
      , ChangedBy   = $emID
      , `Position`  = $Position
      , HIID        = $newHIID
      , `Changed`   = NOW()
    where clID = $clID AND Aid = $Aid;
    --
    if not exists (
      select 1
      from crmOrg
      where clID = $clID AND Aid = $Aid
    ) then
      insert crmOrg (
         clID
        ,TaxCode
        ,CreatedBy
        ,$Aid
      )
      values (
         $clID
        ,$TaxCode
        ,$emID
        , $Aid
      );
    else
      update crmOrg set
        TaxCode = $TaxCode
      where clID = $clID AND Aid = $Aid;
    end if;
    --
    if $address is NULL then
      delete from crmAddress
      where clID = $clID
        and adtID = $adtID AND Aid = $Aid;
    elseif not exists (
      select 1
      from crmAddress
      where clID = $clID
        and adtID = 1 AND Aid = $Aid
    ) then
      /*set $adsID = us_GetNextSequence('adsID'); 11 04 2019*/
      set $adsID = NEXTVAL(adsID);
      insert crmAddress (
         clID
        ,adsID
        ,adsName
        ,adtID
        ,Aid
      )
      values (
         $clID
        ,$adsID
        ,$address
        ,1
        ,$Aid
      );
    else
      update crmAddress set
        adsName = $address
      where clID = $clID
        and adtID = 1
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
    if NULLIF(TRIM($contacts),'') is NOT NULL then
      set $Count = common_schema.extract_json_value($contacts, 'count(/data/ccName)');
      --
      while $Count > 0 do
        set $ccID = common_schema.extract_json_value($contacts, CONCAT('/descendant-or-self::ccID[', CAST($Count as char),']'));
        set $ccName = common_schema.extract_json_value($contacts, TRIM(CONCAT('/descendant-or-self::ccName[', CAST($Count as char),']')));
        set $ccComment = common_schema.extract_json_value($contacts, TRIM(CONCAT('/descendant-or-self::ccComment[', CAST($Count as char),']')));
        set $ccType = common_schema.extract_json_value($contacts,CONCAT('/descendant-or-self::ccType[', CAST($Count as char),']'));
        --
        if IFNULL($ccID,0) = 0 then
          /*set $ccID = us_GetNextSequence('ccID');11042019*/
          set $ccID = NEXTVAL(ccID);
        end if;
        --
        insert into _temp (ccID, ccName, ccComment, ccType)
        values (
           $ccID
          ,$ccName
          ,NULLIF($ccComment, 'null')
          ,$ccType
        );
        set $Count = $Count - 1;
      end while;
    end if;
    --
    insert crmContact (
      ccID
      , clID
      , ccName
      , ccType
      , ccComment
      , isActive
      , Aid
      , ffID
      , HIID
    )
    select
      s.ccID
      , $clID
      , s.ccName
      , s.ccType
      , s.ccComment
      , 1
      , $Aid
      , $ffID
      , fn_GetStamp()
    from _temp s
    where not exists (
      select 1
      from crmContact
      where ccID = s.ccID
        and clID = $clID AND Aid = $Aid);
    --
    update crmContact t
      inner join _temp s on s.ccID = t.ccID
    set
       t.ccName    = s.ccName
      ,t.ccComment = s.ccComment
    where t.clID = $clID AND Aid = $Aid
      and (t.ccName != s.ccName
        or IFNULL(t.ccComment, '') != IFNULL(s.ccComment, ''));
    --
    delete t from crmContact t
    where t.clID = $clID AND Aid = $Aid
      and not exists (
        select 1
        from _temp
        where ccID = t.ccID);
    --
    DROP TABLE IF EXISTS _temp;
    --
    INSERT DUP_crmClient SET
      OLD_HIID          = $HIID
      , DUP_InsTime     = NOW()
      , DUP_action      = 'U'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = $newHIID
      , clID            = $clID
      , Aid             = $Aid
      , clName          = $clName
      , IsPerson        = $IsPerson
      , Sex             = 0
      , Comment         = $Comment
      , ParentID        = $ParentID
      , ffID            = $ffID
      , CompanyID       = $CompanyID
      , uID             = (SELECT uID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , isActual        = 0
      , ActualStatus    = NULL
      , IsActive        = $IsActive
      , Created         = (SELECT Created FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , Changed         = NOW()
      , CreatedBy       = (SELECT CreatedBy FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
      , ChangedBy       = $emIDEditor
      , `Position`      = $Position;
  END IF;
END $$
DELIMITER ;
--
