DROP PROCEDURE IF EXISTS crm_GetClientSabd;
DELIMITER $$
CREATE PROCEDURE crm_GetClientSabd(
    $token        VARCHAR(100)
    , $clID       INT
)
BEGIN
  declare $TaxCode    varchar(14);
  DECLARE $Aid        INT;
  DECLARE $emID       INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetClientSabd');
  ELSE
    SET $emID = fn_GetEmployID($token);
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call RAISE(77004,NULL);
    end if;
    --
    if exists (
      select 1
      from crmClient
      where clID = $clID
        and isActual = 1
        AND Aid = $Aid) then
      select
        TaxCode into $TaxCode
      from crmOrg
      where clID = $clID AND Aid = $Aid;
      -- Компания с инн %s уже проактуализированна
      call RAISE(77062,$TaxCode);
    end if;
    --
    select
       cl.HIID          as HIID
      ,cl.clID          as clID
      ,o.TaxCode        as inn
      ,cl.clName        as nameFull
      ,o.ShortName      as nameShort
      ,a.adsName        as adress
      ,o.headFIO        as fio
      ,o.headIO         as io
      ,o.headPost       as post
      ,o.headSex        as sex
      ,o.headFam        as famIO
      ,o.KVED           as kvedCode
      ,o.KVEDName       as kvedDescr
      ,o.orgNote        as orgNote
      ,ex.isNotice      as isNotice
      ,NULL             as CallDate
      ,e.ccName         as email
      ,cl.ActualStatus  as actualStatus
      ,cc.ccName        as phoneDialer
      ,cc.ccComment     as phoneComment
      ,CONCAT('[',GROUP_CONCAT(CONCAT(
        '{ "ccID": ',c.ccID,
        ', "ccName": "',c.ccName,'", ',
          '"ccComment": ',IFNULL(CONCAT('"',c.ccComment,'"'),'null'),' }') order by c.ccID asc separator ','),']') as phones
      ,b.dbPrefix       as dbPrefix
    from crmClient cl
      inner join fsFile f on f.ffID = cl.ffID
      inner join fsBase b on b.dbID = f.dbID
      left outer join crmOrg o on o.clID = cl.clID
      left outer join crmClientEx ex on ex.clID = cl.clID
      left outer join crmAddress a on a.clID = cl.clID
      left outer join crmContact cc on (cc.clID = cl.clID and cc.ccType = 36) # Телефон
      left outer join crmContact c on (c.clID = cl.clID and c.ccType = 44)    #Тел.Доп
      left outer join crmContact e on (e.clID = cl.clID and e.ccType = 37)    #Email
    where cl.clID = $clID AND cl.Aid = $Aid
    having clID is NOT NULL;
  END IF;
END $$
DELIMITER ;
--
