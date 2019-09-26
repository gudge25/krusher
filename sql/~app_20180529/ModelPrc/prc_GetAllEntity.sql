DELIMITER $$
DROP PROCEDURE IF EXISTS prc_GetAllEntity;
CREATE PROCEDURE prc_GetAllEntity()
BEGIN
  select
    %GetModel%
  from prcEntity
  where pfxID = $pfxID;
END $$
DELIMITER ;
--
