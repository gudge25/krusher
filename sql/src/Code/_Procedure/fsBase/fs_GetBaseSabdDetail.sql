DROP PROCEDURE IF EXISTS fs_GetBaseSabdDetail;
DELIMITER $$
CREATE PROCEDURE fs_GetBaseSabdDetail(
    $token            VARCHAR(100)
    , $ffID           int
)
BEGIN
  declare $emID      int;
  DECLARE $Aid       INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_GetBaseSabdDetail');
  ELSE
    SET $emID = fn_GetEmployID($token);
    select
       1001             as FilterID
      ,'Автообзвон'     as Name
      ,COUNT(cl.clID)   as Qty
      ,NULL             as clID
    from crmClient cl
      inner join crmClientEx ex on ex.clID = cl.clID
    where cl.ffID = $ffID
      and cl.isActual = 0
      and ex.isRobocall = 1
      AND cl.Aid = $Aid
    UNION ALL
    select
       1002             as FilterID
      ,'Ручной обзвон'  as Name
      ,COUNT(cl.clID)   as Qty
      ,NULL             as clID
    from crmClient cl
      inner join crmClientEx ex on ex.clID = cl.clID
    where cl.ffID = $ffID
      and cl.isActual = 0
      and ex.isRobocall = 0
      AND cl.Aid = $Aid
    UNION ALL
    select
       1003         as FilterID
      ,o.TaxCode    as Name
      ,NULL         as Qty
      ,cl.clID      as clID
    from crmClient cl
      inner join crmOrg o on o.clID = cl.clID
    where cl.ffID = $ffID
      and cl.isActual = 0
      AND cl.responsibleID = $emID
      AND cl.Aid = $Aid
    UNION ALL
    select
       1004         as FilterID
      ,v.Name       as Name
      ,COUNT(clID)  as Qty
      ,NULL         as clID
    from crmClient cl
      inner join usEnumValue v on v.tvID = cl.ActualStatus
    where cl.ffID = $ffID
      and cl.isActual = 1
      AND cl.Aid = $Aid
    group by v.Name;
  END IF;
END $$
DELIMITER ;
--
