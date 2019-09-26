DROP VIEW IF EXISTS regGmt;
CREATE VIEW regGmt as
select
   gmtID
  ,GMT
  ,gmtComment
from region.reg_gmt;
--
