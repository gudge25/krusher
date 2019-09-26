DROP PROCEDURE IF EXISTS crm_GetClientByParent;
DElIMITER $$
CREATE PROCEDURE crm_GetClientByParent(
    $token        VARCHAR(100)
    , $clID       INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetClientByParent');
  ELSE
    SELECT
      cl.clID                                                                     clID
      , cl.clName                                                                 clName
      , cl.IsPerson                                                               IsPerson
      , cl.IsActive                                                               isActive
      , cl.`Comment`                                                              `Comment`
      , cl.Position                                                               `Position`
      , GROUP_CONCAT(distinct cc.ccName order by cc.ccType asc separator ',')     Contacts
      , cl.responsibleID                                                          Responsibles
      , GROUP_CONCAT(distinct a.adsName order by a.adtID asc separator ',')       Addresses
    from crmClient cl
      left outer join crmContact cc on cc.clID = cl.clID
      left outer join crmAddress a on a.clID = cl.clID
    where cl.ParentID = $clID AND cl.Aid = $Aid
    group by cl.clID
    having MAX(cl.clID) is NOT NULL;
  END IF;
END $$
DELIMITER ;
--
