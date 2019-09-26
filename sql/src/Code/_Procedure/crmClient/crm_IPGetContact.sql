DELIMITER $$
DROP FUNCTION IF EXISTS crm_IPGetContact;
CREATE FUNCTION crm_IPGetContact (
    $clID       varchar(50)
    , $ccType   int
) RETURNS varchar(50)
BEGIN
  declare $ccName varchar(50);
  --
  select
    ccName
  into
    $ccName
  from crmContact
  where clID = $clID
    and ccType = $ccType
  limit 1;
  --
  RETURN $ccName;
END $$
DELIMITER ;
--
