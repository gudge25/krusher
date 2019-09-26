DROP VIEW IF EXISTS regOperator;
CREATE VIEW regOperator as
select
   ropID
  ,ropName
  ,ropKeywords
  ,ropImage
  ,rcID
from region.reg_operator;
--
