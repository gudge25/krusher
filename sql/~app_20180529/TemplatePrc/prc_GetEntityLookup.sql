DELIMITER $$
DROP PROCEDURE IF EXISTS prc_GetEntityLookup;
CREATE PROCEDURE prc_GetEntityLookup()
BEGIN
  select
     pfxID
    ,pfxName
  from prcEntity
  where isActive = 1;
END $$
DELIMITER ;
--
