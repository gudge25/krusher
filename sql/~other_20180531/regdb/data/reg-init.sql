delete from reg_region;
delete from reg_operator;
delete from reg_country;
--
delete from us_sequences where seqName = 'ropID';
delete from us_sequences where seqName = 'rcID';
delete from us_sequences where seqName = 'regID';

insert reg_country (rcID, rcShort, rcName, rcNameEng, rcCode)
select 
   c.id
  ,c.short
  ,c.full_rus 
  ,c.full_eng
  ,0 -- IFNULL(op.prefix_country,0)
from countries c
--   left outer join opsos o on o.opsos_country = c.short
--   left outer join opsos_prefix op on op.prefix_opsos_id = o.opsos_id

order by c.full_rus;
-- 
select 
  MAX(rc.rcID)
into @ID
from reg_country rc;
insert us_sequences (seqName, seqValue) values ('rcID', @ID);
--
insert reg_operator (ropID, ropName, ropKeywords, ropImage, rcID)
select
   o.opsos_id
  ,o.opsos_name
  ,o.opsos_keywords
  ,o.opsos_image
  ,IFNULL(rc.rcID,0)
from opsos o
  inner join reg_country rc on rc.rcShort = o.opsos_country
order by opsos_id;
--
select 
  MAX(rc.ropID)
into @ID
from reg_operator rc;
insert us_sequences (seqName, seqValue) values ('ropID', @ID);
--
insert reg_region (regID, regName, Prefix, gmtID, ropID, RangeStart, RangeEnd)
select
   prefix_id
  ,CONCAT(rc.rcName,'_',prefix_range_start)
  ,p.prefix_def
  ,case rc.rcShort
    when 'RU' then 1
    when 'UA' then 2
    else null
   end as gmtID
  ,ro.ropID
  ,prefix_range_start 
  ,prefix_range_end
from opsos_prefix p
  inner join reg_operator ro on ro.ropID = p.prefix_opsos_id
  inner join reg_country rc on rc.rcID = ro.rcID
where rc.rcShort in ('RU','UA','BY','KZ','UZ') ;
--
select 
  MAX(rc.regID)
into @ID
from reg_region rc;
insert us_sequences (seqName, seqValue) values ('regID', @ID);
--
/*
truncate table reg_kladr;
LOAD DATA LOCAL INFILE 'C:/Users/dima/Documents/crmua/sql/data/kladr.csv'
INTO TABLE reg_kladr
CHARACTER SET cp1251
COLUMNS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES (rkName,rkSocr,rkCode,rkIndex,rkGninmb,rkUno,rkOcatd,rkStatus);
--
truncate table reg_socr;
LOAD DATA LOCAL INFILE 'C:/Users/dima/Documents/crmua/sql/data/socrbase.csv'
INTO TABLE reg_socr
CHARACTER SET cp1251
COLUMNS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES (rsLevel,rsSocr,rsName,rsCode);
*/