DELIMITER $$
DROP PROCEDURE IF EXISTS cc_GetForSip;
CREATE PROCEDURE cc_GetForSip(
    $token        VARCHAR(100)
    , $sip        VARCHAR(50)
)
BEGIN
  declare $dcID int;
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetForSip');
  ELSE
    /*set $dcID = us_GetNextSequence('dcID'); 11 04 20192*/

    set $dcID = NEXTVAL(dcID);
    -- для очереди, если есть дата перезвона (ChimeDate) и в истории звонков нет статуса "ANSWER"
    select
       cc.ccName    as ccName
      ,cc.ccID      as ccID
      ,cl.clID      as clID
      ,fs.Priority  as Priority
      ,1            as NotAnswer
      ,cl.clName    as clName
      ,$dcID        as dcID
    from fsFile fs
      inner join crmClient cl on cl.ffID = fs.ffID
      inner join crmContact cc on cc.clID = cl.clID
    where
      fs.Aid = $Aid
      AND fs.isActive = 1
      and cl.isActive = 1
      and cc.ccType = 36
      and not exists (
        select 1
        from crmClientEx
        where clID = cl.clID
          and isDial = 1)
      /*and exists (
          select 1
          from emEmploy
          where Queue = fs.Queue
            and SipName = $sip)*/
      and exists (
        select 1
        from crmStatus s
        where s.clID = cc.clID
          and s.clStatus = 101)
      and not exists (
        select 1
        from ccContact c
          inner join dcDoc d on d.dcID = c.dcID
        where c.ccName = cc.ccName
          and d.clID = cl.clID
          and d.dcStatus = 7001)
      and not exists (
        select 1
        from ccContact c
          inner join dcDoc d on d.dcID = c.dcID
        where c.ccName = cc.ccName
          and d.clID = cl.clID)
    UNION ALL
    -- для очереди, в истории звонков нет статуса "ANSWER"
    select
       cc.ccName    as ccName
      ,cc.ccID      as ccID
      ,cl.clID      as clID
      ,fs.Priority  as Priority
      ,2            as NotAnswer
      ,cl.clName    as clName
      ,$dcID        as dcID
    from fsFile fs
      inner join crmClient cl on cl.ffID = fs.ffID
      inner join crmContact cc on cc.clID = cl.clID
    where
      fs.Aid = $Aid
      AND fs.isActive = 1
      and cl.isActive = 1
      and cc.ccType = 36
      and LENGTH(cc.ccName) in (11,12)
      and not exists (
        select 1
        from crmClientEx
        where clID = cl.clID
          and isDial = 1)
      /*and exists (
          select 1
          from emEmploy
          where Queue = fs.Queue
            and SipName = $sip)*/
      and exists (
        select 1
        from crmStatus s
        where s.clID = cc.clID
          and s.clStatus = 101)
      and not exists (
        select 1
        from ccContact c
          inner join dcDoc d on d.dcID = c.dcID
        where c.ccName = cc.ccName
          and d.clID = cl.clID)
    UNION ALL
    -- для ответственных, если есть дата перезвона (ChimeDate) и в истории звонков нет статуса "ANSWER"
    select
       cc.ccName    as ccName
      ,cc.ccID      as ccID
      ,cl.clID      as clID
      ,fs.Priority  as Priority
      ,1            as NotAnswer
      ,cl.clName    as clName
      ,$dcID        as dcID
    from fsFile fs
      inner join crmClient cl on cl.ffID = fs.ffID
      inner join crmContact cc on cc.clID = cl.clID
    where
      fs.Aid = $Aid
      AND fs.isActive = 1
      and cl.isActive = 1
      and cc.ccType = 36
      and not exists (
        select 1
        from crmClientEx
        where clID = cl.clID
          and isDial = 1)
      and exists (
          select 1
          from emEmploy
          WHERE emID = cl.responsibleID
            and SipName = $sip)
      and exists (
        select 1
        from crmStatus s
        where s.clID = cc.clID
          and s.clStatus = 101)
      and not exists (
        select 1
        from ccContact c
          inner join dcDoc d on d.dcID = c.dcID
        where c.ccName = cc.ccName
          and d.dcStatus = 7001
          and d.clID = cl.clID)
      and not exists (
        select 1
        from ccContact c
          inner join dcDoc d on d.dcID = c.dcID
        where c.ccName = cc.ccName
          and d.clID = cl.clID)
    -- для ответственных, в истории звонков нет статуса "ANSWER"
    UNION ALL
    select
       cc.ccName    as ccName
      ,cc.ccID      as ccID
      ,cl.clID      as clID
      ,fs.Priority  as Priority
      ,2            as NotAnswer
      ,cl.clName    as clName
      ,$dcID        as dcID
    from fsFile fs
      inner join crmClient cl on cl.ffID = fs.ffID
      inner join crmContact cc on cc.clID = cl.clID
    where
      fs.Aid = $Aid
      AND fs.isActive = 1
      and cl.isActive = 1
      and cc.ccType = 36
      and not exists (
        select 1
        from crmClientEx
        where clID = cl.clID
          and isDial = 1)
      and exists (
          select 1
          from emEmploy
          where emID = cl.responsibleID
            and SipName = $sip)
      and exists (
        select 1
        from crmStatus s
        where s.clID = cc.clID
          and s.clStatus = 101)
      and not exists (
        select 1
        from ccContact c
          inner join dcDoc d on d.dcID = c.dcID
        where c.ccName = cc.ccName
          and d.clID = cl.clID)
    order by RAND(), NotAnswer, Priority asc
    limit 1;
  END IF;
END $$
DELIMITER ;
--
