delete from reg_region;
delete from reg_operator;

insert reg_operator (ropID, ropName, ropKeywords, ropImage, rcID)
select
   o.opsos_id
  ,o.opsos_name
  ,o.opsos_keywords
  ,o.opsos_image
  ,IFNULL(rc.rcID,0)
from opsos o
  inner join reg_country rc on rc.rcShort = o.opsos_country
where rc.isCIS = 1
order by opsos_id;

select 
  MAX(rc.ropID)
into @ID
from reg_operator rc;
insert us_sequences (seqName, seqValue) values ('ropID', @ID);


insert reg_region (regID, regName, Prefix, gmtID, ropID, RangeStart, RangeEnd)
select 
  regID
  ,regName
  ,Prefix
  ,gmtID
  ,ropID
  ,LEFT(CONCAT(RangeStart,'0000000000000'), p.LenNumber - LENGTH(CONCAT(rcCode, Prefix))) as RangeStart
  ,LEFT(CONCAT(RangeEnd,'99999999999'), p.LenNumber - LENGTH(CONCAT(rcCode, Prefix))) as RangeEnd
from (
  select
     prefix_id as regID
    ,CONCAT(rc.rcName,'_',ro.ropName) as regName
    ,p.prefix_def as Prefix
    ,case rc.rcShort
      when 'RU' then 1
      when 'UA' then 2
      else null
     end as gmtID
    ,ro.ropID as ropID
    ,SUBSTRING(prefix_range_start, LENGTH(CONCAT(rc.rcCode,p.prefix_def))+1) as RangeStart
    ,SUBSTRING(p.prefix_range_end, LENGTH(CONCAT(rc.rcCode,p.prefix_def))+1) as RangeEnd
    ,rc.rcCode
    ,rc.LenNumber
  from opsos_prefix p
    inner join reg_operator ro on ro.ropID = p.prefix_opsos_id
    inner join reg_country rc on rc.rcID = ro.rcID
  where rc.isCIS = 1
) p;


select MAX(regID) into @row from reg_region rr;
insert reg_region (regID, regName, Prefix, ropID, RangeStart, RangeEnd, raID)
select
   @row := @row +1
  ,RegionName
  ,PrefixDef
  ,871
  ,RangeFrom
  ,REPLACE(RangeFrom,'0','9')
  ,raID
from numplan
where RangeFrom != '';
