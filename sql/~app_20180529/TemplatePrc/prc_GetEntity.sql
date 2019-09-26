DELIMITER $$
DROP PROCEDURE IF EXISTS prc_GetEntity;
CREATE PROCEDURE prc_GetEntity (
  $pfxID  int
)
BEGIN
  if ($pfxID is NULL) then
    -- Параметр "ID записи" должен иметь значение
    call RAISE(77021,NULL);
  end if;
  --
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
