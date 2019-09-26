DROP VIEW IF EXISTS regArea;
CREATE VIEW regArea as
select
   raID
  ,raName
  ,rcID
  ,GMT
  ,rdID
  ,rkSocr
  ,rkCode
  ,isCIS
from region.reg_area;
--
