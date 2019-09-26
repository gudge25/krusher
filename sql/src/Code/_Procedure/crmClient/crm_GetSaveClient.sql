DROP PROCEDURE IF EXISTS crm_GetSaveClient;
DELIMITER $$
CREATE PROCEDURE crm_GetSaveClient(
    $token        VARCHAR(100)
    , $clID       int
)
BEGIN
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetSaveClient');
  ELSE
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call RAISE(77004,NULL);
    end if;
    --
    select
       cl.HIID          HIID
      ,cl.clID          clID
      ,cl.clName        clName
      ,cl.IsPerson      IsPerson
      ,cl.IsActive      IsActive
      ,cl.Comment       Comment
      ,cl.ffID          ffID
      ,cl.ParentID      ParentID
      ,cl.CompanyID     CompanyID
      ,cl.Position      Position
      ,o.TaxCode        TaxCode
      ,a.adsName        address
      ,CONCAT('[',GROUP_CONCAT(CONCAT(
        '{ "ccID": ',c.ccID,
        ', "ccName": "',c.ccName,'", ',
        '"ccType": ',c.ccType,
        ', "ccComment": ',IFNULL(CONCAT('"',c.ccComment,'"'),'null'),' }') order by c.ccID asc separator ','),']') as contacts
    from crmClient cl
      inner join fsFile f on f.ffID = cl.ffID
      left outer join crmOrg o on o.clID = cl.clID
      left outer join crmAddress a on a.clID = cl.clID
      left outer join crmContact c on c.clID = cl.clID    #Тел.Доп
    where cl.clID = $clID AND cl.Aid = $Aid
    having clID is NOT NULL;
  END IF;
END $$
DELIMITER ;
--
