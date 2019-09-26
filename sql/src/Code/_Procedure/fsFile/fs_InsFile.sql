DROP PROCEDURE IF EXISTS fs_InsFile;
DELIMITER $$
CREATE PROCEDURE fs_InsFile(
    $token            VARCHAR(100)
    , $ffID           int
    , $isRobocall     bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $emID     int;
  declare $fccName  varchar(250);
  declare $ftType   int;
  declare $ftDelim  varchar(12);
  declare $clID     int;
  DECLARE $Aid      INT;
  declare $n        int;
  declare $i        int;

  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_InsFile');
  ELSE
    SET $emID = fn_GetEmployID($token);
    DROP TABLE IF EXISTS `tmpContacts`;
    CREATE TABLE `tmpContacts` (
      i               int          NOT NULL auto_increment
      , clID          int          NOT NULL
      , fccName       varchar(250) NOT NULL
      , ftType        int          NOT NULL
      , ftDelim       varchar(12)  NOT NULL
      , Aid        int          NOT NULL
      , PRIMARY KEY (i)
      , INDEX `Aid` (`Aid`)
    )ENGINE=MEMORY;

    update fsClient set
      clID = NEXTVAL(clID)
    where clID is NULL
      and ffID = $ffID
      AND Aid = $Aid;
    --
    if $isRobocall = 1 then
      update fsClient cl set
        isRobocall = 1
      where ffID = $ffID
        AND Aid = $Aid
        and exists (
          select 1
          from fsContact
          where fclID = cl.fclID
            and ftType = 36
            AND Aid = $Aid);
    end if;
    --
    insert crmClient (
      HIID
      , clID
      , clName
      , IsPerson
      , IsActive
      , Comment
      , ffID
      , CompanyID
      , Aid
      , CreatedBy
      , uID)
    select
      fn_GetStamp()
      , fs.clID
      , fs.fclName
      , isPerson
      , 1
      , fs.Comments
      , $ffID
      , CompanyID
      , $Aid
      , $emID
      , UUID_SHORT()
    from fsClient fs
    where fs.ffID = $ffID
      AND Aid = $Aid
      and not exists (
        select 1
        from crmClient
        where clID = fs.clID
          AND Aid = $Aid);
    --
    insert crmOrg (
       clID
      ,Account
      ,Bank
      ,TaxCode
      ,SortCode
      ,RegCode
      ,CertNumber
      ,OrgType
      ,CreatedBy
      ,ShortName
      ,Aid
      ,isActive
      , HIID
    )
    select
       cl.clID
      ,NULL       as Account
      ,NULL       as Bank
      ,cl.TaxCode as TaxCode
      ,NULL       as SortCode
      ,NULL       as RegCode
      ,NULL       as CertNumber
      ,NULL       as OrgType
      ,$emID
      ,cl.ShortName
      ,Aid
      ,1
      , fn_GetStamp()
    from fsClient cl
    where cl.ffID = $ffID
      AND cl.Aid = $Aid
      and (cl.RegCode is NOT NULL
        or cl.TaxCode is NOT NULL
        or cl.ShortName is NOT NULL);
    --
    insert crmClientEx (
      clID
      , CallDate
      , Aid
      , ChangedBy
      , isRobocall
      , ActDate
      , isActive
      , curID
      , langID
      , `sum`
      , ttsText
      , ffID
    )
    select
      clID
      , NULL
      , $Aid
      , $emID
      , isRobocall
      , ActDate
      , 1
      , curID
      , langID
      , `sum`
      , ttsText
      , $ffID
    from fsClient f
    where ffID = $ffID
      AND Aid = $Aid;
    --
    insert crmAddress (
      HIID
      , clID
      , adsID
      , adsName
      , adtID
      , Postcode
      , pntID
      , isActive
      , Aid
    )
    select
      fn_GetStamp()
      , clID
      , NEXTVAL(adsID)
      , Address
      , 1
      , NULL
      , NULL
      , 1
      , $Aid
    from fsClient
    where Address is NOT NULL
      and ffID = $ffID
      AND Aid = $Aid;
    --
    insert crmContact (
      HIID
      , ccID
      , clID
      , ccName
      , ccType
      , isActive
      , isPrimary
      , ccComment
      , Aid
      , gmt
      , MCC
      , MNC
      , id_country
      , id_region
      , id_area
      , id_city
      , id_mobileProvider
      , ffID)
    select
      fn_GetStamp()
      , NEXTVAL(ccID)
      , cl.clID
      , if(fc.ftType = 36, fn_GetNumberByString(fc.fccName), fc.fccName)
      , fc.ftType
      , 1
      , 1
      , if(fc.ftType = 36, fn_GetStringByNumber(fc.fccName), NULL)
      , $Aid
      , if(fc.ftType = 36, reg_GetGmtInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetMCCInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetMNCInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetCountryInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetRegionInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetAreaInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetCityInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , if(fc.ftType = 36, reg_GetOperatorInfo($Aid, fn_GetNumberByString(fc.fccName)), NULL)
      , $ffID
    from fsContact fc
      inner join fsClient cl on fc.fclID = cl.fclID
    where cl.ffID = $ffID
      and fc.ftDelim is NULL
      AND cl.Aid = $Aid
      and not exists (
        select 1
        from crmContact cc
        where clID = cl.clID
          and ccName = fc.fccName
          and ccType = fc.ftType
          AND Aid = $Aid);
    --
    insert tmpContacts (
       clID
      ,fccName
      ,ftType
      ,ftDelim
      , Aid
    )
    select
       cl.clID
      ,fc.fccName
      ,fc.ftType
      ,fc.ftDelim
      , cl.Aid
    from fsContact fc
      inner join fsClient cl on fc.fclID = cl.fclID
    where fc.ftDelim is NOT NULL
      and cl.ffID = $ffID
      AND cl.Aid = $Aid;
    --
    set $n = ROW_COUNT();
    set $i = 1;
    while $i <= $n do
      select
         clID
        ,fccName
        ,ftType
        ,ftDelim
      into
         $clID
        ,$fccName
        ,$ftType
        ,$ftDelim
      from tmpContacts
      where i = $i AND Aid = $Aid;
      --
      DROP TABLE IF EXISTS tmpVariable;
      CREATE TEMPORARY TABLE tmpVariable (
        `variable` varchar(150)
        , Aid        int          NOT NULL
        , INDEX `Aid` (`Aid`)
      )ENGINE=MEMORY;
      --
      DROP TABLE IF EXISTS tmpPhones;
      CREATE TEMPORARY TABLE tmpPhones (
          ccName    varchar(50)
          , ccComment varchar(100)
          , Aid        int          NOT NULL
          , INDEX `Aid` (`Aid`)
      )ENGINE=MEMORY;
      --
      call sp_split($fccName, $ftDelim, 'tmpVariable', $Aid);
      --
      IF($ftType = 36) THEN
        insert tmpPhones (ccName, ccComment, Aid)
        select
          fn_GetNumberByString(`variable`) ccName
          , fn_GetStringByNumber(`variable`) ccComment
          , Aid
        from tmpVariable;
        --
        insert crmContact (
          ccID
          , clID
          , ccName
          , ccType
          , isActive
          , ccComment
          , Aid
          , HIID
          , gmt
          , MCC
          , MNC
          , id_country
          , id_region
          , id_area
          , id_city
          , id_mobileProvider
          , ffID)
        select
          NEXTVAL(ccID)
          , $clID
          , s.ccName
          , $ftType
          , 1
          , s.ccComment
          , $Aid
          , fn_GetStamp()
          , reg_GetGmtInfo($Aid, s.ccName)
          , reg_GetMCCInfo($Aid, s.ccName)
          , reg_GetMNCInfo($Aid, s.ccName)
          , reg_GetCountryInfo($Aid, s.ccName)
          , reg_GetRegionInfo($Aid, s.ccName)
          , reg_GetAreaInfo($Aid, s.ccName)
          , reg_GetCityInfo($Aid, s.ccName)
          , reg_GetOperatorInfo($Aid, s.ccName)
          , $ffID
        from (
          select
            p.ccName
            , p.ccComment
          from tmpPhones p
          where p.ccName is NOT NULL AND Aid = $Aid
          group by p.ccName
          order by p.ccComment) s
        where not exists (
          select 1
          from crmContact
          where clID = $clID
            and ccName = s.ccName
            and ccType = $ftType
            AND Aid = $Aid);
      ELSE
        insert tmpPhones (ccName, ccComment, Aid)
        SELECT
          `variable` ccName
          , fn_GetStringByNumber(`variable`) ccComment
          , Aid
        from tmpVariable;
        insert crmContact (
          ccID
          , clID
          , ccName
          , ccType
          , isActive
          , ccComment
          , Aid
          , HIID
          , ffID)
        select
          NEXTVAL(ccID)
          , $clID
          , s.ccName
          , $ftType
          , 1
          , s.ccComment
          , $Aid
          , fn_GetStamp()
          , $ffID
        from (
          select
            p.ccName
            , p.ccComment
          from tmpPhones p
          where p.ccName is NOT NULL AND Aid = $Aid
          group by p.ccName
          order by p.ccComment) s
        where not exists (
          select 1
          from crmContact
          where clID = $clID
            and ccName = s.ccName
            and ccType = $ftType
            AND Aid = $Aid);
      END IF;
      --
      DROP TABLE IF EXISTS `tmpPhones`;
      DROP TABLE IF EXISTS `tmpVariable`;
      set $i = $i + 1;
    end while;
    --
    call crm_IPUpdStatusFile($ffID);
    --
    DROP TABLE IF EXISTS `tmpContacts`;
    --
    DELETE FROM fsContact WHERE Aid = $Aid AND fclID IN (SELECT fclID FROM fsClient WHERE Aid = $Aid AND ffID = $ffID);
    DELETE FROM fsClient WHERE ffID = $ffID AND Aid = $Aid;
    --
  END IF;
END $$
DELIMITER ;
--
