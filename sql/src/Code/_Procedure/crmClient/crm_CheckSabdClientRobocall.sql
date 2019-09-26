DROP PROCEDURE IF EXISTS crm_CheckSabdClientRobocall;
DELIMITER $$
CREATE PROCEDURE crm_CheckSabdClientRobocall(
    $token          VARCHAR(100)
    , $phone        VARCHAR(50)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_CheckSabdClientRobocall');
  ELSE
    IF(SUBSTRING($phone, 1, 3) = '000') THEN
      SET $phone = SUBSTRING($phone, 4, 14);
    END IF;
    --
    IF(SUBSTRING($phone, 1, 2) = '00') THEN
      SET $phone = SUBSTRING($phone, 3, 14);
    END IF;
    --
    select
      cl.clID
      , cl.clName
    from crmClient cl
      inner join crmClientEx ex on ex.clID = cl.clID
    where ex.isRobocall = 1
      and cl.isActual = 0
      and ex.isDial = 0
      and (ex.CallDate is NULL or ex.CallDate < NOW())
      AND cl.Aid = $Aid
      and exists (
        select 1
        from crmContact
        where ccType = 36
          and clID = cl.clID
          and ccName = $phone
          AND Aid = $Aid);
  END IF;
END $$
DELIMITER ;
--
