DROP VIEW IF EXISTS regSocr;
CREATE VIEW regSocr AS
select
   rsID
  ,rsLevel
  ,rsSocr
  ,rsName
  ,rsCode
from region.reg_socr;
--
