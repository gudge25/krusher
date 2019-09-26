DROP VIEW IF EXISTS regRegion;
CREATE VIEW regRegion as
select
   regID
  ,regName
  ,Prefix
  ,ropID
  ,RangeStart
  ,RangeEnd
  ,raID
  ,isGSM
  ,rcID
  ,GMT
from region.reg_region;
--
