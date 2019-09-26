DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsPerson;
CREATE PROCEDURE crm_InsPerson(
   $pnID   int
  ,$clID   int
  ,$pnName varchar(200)
  ,$Post   int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  if $pnID is NULL then
    -- 'Параметр "ID содрудника" должен иметь значение';
    call raise(77007, NULL);
  end if;
  --
  set $pnName = TRIM($pnName);
  insert crmPerson (
     HIID
    ,pnID
    ,clID
    ,pnName
    ,Post)
  values (
     0
    ,$pnID
    ,$clID
    ,$pnName
    ,$Post);
END $$
DELIMITER ;
--
