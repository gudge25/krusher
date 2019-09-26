DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPUpdateRegionByClient;
CREATE PROCEDURE crm_IPUpdateRegionByClient(
  $clID int
)DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет регион клиента'
BEGIN
  /*declare $regName varchar(100);
  declare $GMT     int;
  declare $rpID    int;
  declare $raID    int;
  declare $regID   int;
  declare $rcID    int;
  --
  select
     rp.Region
    ,rp.GMT
    ,rp.rpID
    ,rp.raID
    ,189
  into
     $regName
    ,$GMT
    ,$rpID
    ,$raID
    ,$rcID
  from regPlan rp
    inner join crmContact cc on cc.ccType = 36
  where cc.clID = $clID
    and LEFT(cc.ccName,1) = '7'
    and SUBSTRING(cc.ccName,2,3) = rp.CodeDef
    and SUBSTRING(cc.ccName,5) between rp.RangeFrom and rp.RangeTo
  limit 1;
  --
  if $rpID is NULL then
    select
       rp.regName
      ,rp.GMT
      ,rp.regID
      ,rp.raID
      ,rp.rcID
    into
       $regName
      ,$GMT
      ,$regID
      ,$raID
      ,$rcID
    from regRegion rp
      inner join crmContact cc on cc.ccType = 36
    where cc.clID = $clID
      and LEFT(cc.ccName,1) = '7'
      and rp.rcID in (189,125) -- Россия, Казахстан
      and SUBSTRING(cc.ccName,2,3) = rp.Prefix
      and SUBSTRING(cc.ccName,5) between rp.RangeStart and rp.RangeEnd
    limit 1;
    --
    if $regID is NULL then
      select
         rp.regName
        ,rp.GMT
        ,rp.regID
        ,rp.raID
        ,rp.rcID
      into
         $regName
        ,$GMT
        ,$regID
        ,$raID
        ,$rcID
      from regRegion rp
        inner join crmContact cc on cc.ccType = 36
        inner join regCountry rc on rc.rcID = rp.rcID
      where cc.clID = $clID
        and LEFT(cc.ccName,3) = rc.rcCode
        and SUBSTRING(cc.ccName,4,2) = rp.Prefix
        and SUBSTRING(cc.ccName,6) between rp.RangeStart and rp.RangeEnd
        limit 1;
    end if;
  end if;
  --
  delete r
  from crmRegion r
  where r.clID = $clID;
  --
  if $regName is NOT NULL then
    insert crmRegion (
       clID
      ,RegName
      ,GMT
      ,rpID
      ,regID
      ,raID
      ,rcID)
    value (
       $clID
      ,$regName
      ,$GMT-2
      ,$rpID
      ,$regID
      ,$raID
      ,$rcID);
  end if;*/

END $$
DELIMITER ;
--
