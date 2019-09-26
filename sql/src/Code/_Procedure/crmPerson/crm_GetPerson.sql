DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetPerson;
CREATE PROCEDURE crm_GetPerson(
  $clID int
) BEGIN
  if $clID is NULL then
    -- 'Параметр "ID клиента" должен иметь значение';
    call raise(77004, NULL);
  end if;
  select
     HIID
    ,pnID
    ,clID
    ,pnName
    ,Post
  from crmPerson
  where clID = $clID;
END $$
DELIMITER ;
--
