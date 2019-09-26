DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPDelClient;
CREATE PROCEDURE crm_IPDelClient(
    $clID         INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  if $clID is NULL then
    -- 'Параметр ID клиента должен иметь значение';
    call raise(77004, NULL);
  end if;
  --
  if $clID = 0 then
    -- Запрещено изменять клиента [Not Defined]
    call RAISE(77040, NULL);
  end if;
  --
  delete c from ccContact c
    inner join dcDoc d on d.dcID = c.dcID
  where d.clID = $clID;
  --
  delete c from fmFormItem c
    inner join dcDoc d on d.dcID = c.dcID
  where d.clID = $clID;
  --
  delete c from fmForm c
    inner join dcDoc d on d.dcID = c.dcID
  where d.clID = $clID;
  --
  delete c from slDealItem c
    inner join dcDoc d on d.dcID = c.dcID
  where d.clID = $clID;
  --
  delete c from slDeal c
    inner join dcDoc d on d.dcID = c.dcID
  where d.clID = $clID;
  --
  delete from dcDoc
  where clID = $clID;
  --
  delete from crmPerson
  where clID = $clID;
  --
  delete from crmContact
  where clID = $clID;
  --
  delete from crmStatus
  where clID = $clID;
  --
  delete from crmOrg
  where clID = $clID;
  --
  delete from crmClientEx
  where clID = $clID;
  --
  /*delete from crmRegion
  where clID = $clID;*/
  --
  delete from crmTagList
  where clID = $clID;
  --
  delete from crmAddress
  where clID = $clID;
  --
  delete from crmClient
  where clID = $clID;
END $$
DELIMITER ;
--
