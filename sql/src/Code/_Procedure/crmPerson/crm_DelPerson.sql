DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelPerson;
CREATE PROCEDURE crm_DelPerson(
   $pnID  int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  if $pnID is NULL then
    -- 'Параметр "ID содрудника" должен иметь значение';
    call raise(77007, NULL);
  end if;
  --
  delete from crmPerson
  where pnID = $pnID;
END $$
DELIMITER ;
--
