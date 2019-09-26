DELIMITER $$
DROP PROCEDURE IF EXISTS prc_GetAllEntity;
CREATE PROCEDURE prc_GetAllEntity()
BEGIN
  select
     HIID
    ,pfxID
    ,pfxName
    ,isActive
    ,CreatedAt
    ,CreatedBy
    ,EditedAt
    ,EditedBy
  from prcEntity
  where pfxID = $pfxID;
END $$
DELIMITER ;
--
