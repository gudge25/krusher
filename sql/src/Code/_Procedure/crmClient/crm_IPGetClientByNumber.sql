DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPGetClientByNumber;
CREATE PROCEDURE crm_IPGetClientByNumber(
    $token          VARCHAR(100)
    , $ccName       varchar(50)
)
BEGIN
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_IPGetClientByNumber');
  ELSE
    select
       c.ccID
      ,c.clID
    from crmContact c
    where c.ccName = $ccName AND Aid = $Aid
      and exists (
        select 1
        from crmClient cl
          inner join fsFile fs on fs.ffID = cl.ffID
        where cl.clID = c.clID
          and cl.isActive = 1
          and fs.isActive = 1
           AND Aid = $Aid)
    order by c.clID desc
    limit 1;
  END IF;
END $$
DELIMITER ;
--
