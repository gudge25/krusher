DROP PROCEDURE IF EXISTS crm_InsSaveClient;
DELIMITER $$
CREATE PROCEDURE crm_InsSaveClient(
    $token            VARCHAR(100)
    , $clName         VARCHAR(200)
    , $IsPerson       bit
    , $IsActive       bit
    , $Comment        VARCHAR(200)
    , $ffID           int
    , $ParentID       int
    , $CompanyID      int
    , $Position       int
    , $TaxCode        VARCHAR(14)
    , $address        text
    , $contacts       text
    , $emIDEditor     INT(11)
    , $hostEditor     VARCHAR(50)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $emID       INT;
  DECLARE $clID       INT;
  DECLARE $ccType     INT;
  DECLARE $adsID      INT;
  DECLARE $Count      INT;
  DECLARE $ccID       INT;
  DECLARE $ccName     VARCHAR(50);
  DECLARE $ccComment  VARCHAR(100);
  DECLARE $Aid        INT;
  DECLARE $HIID       BIGINT;
  DECLARE $uID        BIGINT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsSaveClient');
  ELSE
    set $clID = NEXTVAL(clID);
    --
    SET $emID = fn_GetEmployID($token);
    --
    SET $HIID = fn_GetStamp();
    SET $uID = UUID_SHORT();
    --
    INSERT crmClient (
      clID
      , HIID
      , clName
      , IsPerson
      , IsActive
      , Comment
      , ffID
      , ParentID
      , CompanyID
      , Aid
      , CreatedBy
      , `Position`
      , uID
    )
    VALUES (
      $clID
      , $HIID
      , $clName
      , $IsPerson
      , $IsActive
      , $Comment
      , $ffID
      , $ParentID
      , $CompanyID
      , $Aid
      , $emID
      , $Position
      , $uID
    );
    --
    if $TaxCode is NOT NULL then
      insert crmOrg (
         clID
        ,HIID
        ,TaxCode
        ,CreatedBy
        ,Aid
      )
      values (
         $clID
         , fn_GetStamp()
        ,$TaxCode
        ,$emID
        ,$Aid
      );
    end if;
    --
    if $address is NOT NULL then
      set $adsID = NEXTVAL(adsID);
      insert crmAddress (
        clID
        , HIID
        , adsID
        , adsName
        , adtID
        , Aid
      )
      values (
        $clID
        , fn_GetStamp()
        , $adsID
        , $address
        , 1
        , $Aid
      );
    end if;
    --
    DROP TABLE IF EXISTS _temp;
    CREATE TEMPORARY TABLE _temp(
      ccID          int
      , ccName      varchar(50)
      , ccType      int
      , ccComment   varchar(100)
      , PRIMARY KEY(ccID)
    )ENGINE=MEMORY;
    --
    if NULLIF(TRIM($contacts), '') is NOT NULL then
      set $Count = common_schema.extract_json_value($contacts, 'count(/data/ccName)');
      --
      while $Count > 0 do
        set $ccID = common_schema.extract_json_value($contacts, CONCAT('/descendant-or-self::ccID[', CAST($Count as char),']'));
        set $ccName = common_schema.extract_json_value($contacts, TRIM(CONCAT('/descendant-or-self::ccName[', CAST($Count as char),']')));
        set $ccComment = common_schema.extract_json_value($contacts, TRIM(CONCAT('/descendant-or-self::ccComment[', CAST($Count as char),']')));
        set $ccType = common_schema.extract_json_value($contacts,CONCAT('/descendant-or-self::ccType[', CAST($Count as char),']'));
        --
        if IFNULL($ccID, 0) = 0 then
          /*set $ccID = us_GetNextSequence('ccID'); 11 04 2019*/
          set $ccID = NEXTVAL(ccID);
        end if;
        --
        insert into _temp (ccID, ccName, ccComment, ccType)
        values (
            $ccID
            , if($ccType = 36, fn_GetNumberByString($ccName), NULL)
            , NULLIF($ccComment, 'null')
            , $ccType
        );
        set $Count = $Count - 1;
      end while;
    end if;
    --
    insert crmContact (
      HIID
      , ccID
      , clID
      , ccName
      , ccType
      , ccComment
      , isActive
      , Aid
      , ffID
      , gmt
      , MCC
      , MNC
      , id_country
      , id_region
      , id_area
      , id_city
      , id_mobileProvider
    )
    select
      fn_GetStamp()
      , s.ccID
      , $clID
      , if(s.ccType = 36, fn_GetNumberByString(s.ccName), NULL)
      , s.ccType
      , s.ccComment
      , 1
      , $Aid
      , $ffID
      , if(s.ccType = 36, reg_GetGmtInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetMCCInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetMNCInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetCountryInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetRegionInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetAreaInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetCityInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
      , if(s.ccType = 36, reg_GetOperatorInfo($Aid, fn_GetNumberByString(s.ccName)), NULL)
    from _temp s
    where not exists (
      select 1
      from crmContact
      where ccID = s.ccID
        and clID = $clID
        AND Aid = $Aid);
    --
    call crm_IPInsClientStatus($clID, $Aid, $ffID);
    call crm_InsClientEx($token, $clID, NULL, FALSE, FALSE, FALSE, FALSE, NULL, NULL, NULL, NULL, TRUE);
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
      and not exists (
        select 1
        from _temp
        where ccID = t.ccID)
      AND Aid = $Aid;
    --
    DROP TABLE IF EXISTS _temp;
    --
    INSERT DUP_crmClient SET
      OLD_HIID          = NULL
      , DUP_InsTime     = NOW()
      , DUP_action      = 'I'
      , DUP_HostName    = $hostEditor
      , DUP_AppName     = $emIDEditor
      , HIID            = $HIID
      , clID            = $clID
      , Aid             = $Aid
      , clName          = $clName
      , IsPerson        = $IsPerson
      , Sex             = 0
      , Comment         = $Comment
      , ParentID        = $ParentID
      , ffID            = $ffID
      , CompanyID       = $CompanyID
      , uID             = $uID
      , isActual        = 0
      , ActualStatus    = NULL
      , IsActive        = $IsActive
      , Created         = NOW()
      , Changed         = NOW()
      , CreatedBy       = $emIDEditor
      , ChangedBy       = $emIDEditor
      , `Position`      = $Position;
    --
    select $clID as clID;
  END IF;
END $$
DELIMITER ;
--
