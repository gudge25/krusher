DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdPerson;
CREATE PROCEDURE crm_UpdPerson(
   $HIID   bigint
  ,$pnID   int
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
  if not exists (
    select 1
    from crmPerson
    where HIID = $HIID
      and pnID = $pnID) then
    -- Запись была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
    call RAISE(77003,NULL);
  end if;
  --
  set $pnName = TRIM($pnName);
  --
  update crmPerson set
     pnName = $pnName
    ,Post   = $Post
  where pnID = $pnID
    and clID = $clID;
END $$
DELIMITER ;
--
