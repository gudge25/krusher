DROP VIEW IF EXISTS regPlan;
CREATE VIEW regPlan as
select
   rpID
  ,CodeDef
  ,RangeFrom
  ,RangeTo
  ,Capacity
  ,Operator
  ,Region
  ,rkName
  ,rkSocr
  ,rkCode
  ,raID
  ,GMT
from region.reg_plan;
--
