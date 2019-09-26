DROP PROCEDURE IF EXISTS fs_GetFileExport;
DELIMITER $$
CREATE PROCEDURE fs_GetFileExport(
    $token            VARCHAR(100)
    , $ffID           int
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_GetFileExport');
  ELSE
    SELECT
        cl.clID               orgID
        , o.TaxCode           inn
        , cl.clName           nameFull
        , IF(cl.clID IS NOT NULL, (IF(s.clStatus = 101, "В прозвоне", IF(s.clStatus = 102, "На проверке", "Хлам"))), NULL) ClientStatus
        , IF(cl.clID IS NOT NULL, (IF(s.ccStatus = 201, "Отвечен и с комментарием", IF(s.clStatus = 202, "Отвечен", IF(s.clStatus = 203, "Не отвечен", IF(s.clStatus = 204, "Занят", IF(s.clStatus = 205, "Не удачный", "Не обзвонен")))))), NULL) ClientStatus
        , ex.CallDate         CallDate
        , IF(cl.ActualStatus IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = cl.ActualStatus AND Aid = cl.Aid LIMIT 1), NULL) ActualStatus
        , GROUP_CONCAT(distinct uss.uComment separator ',')  Comments
        , o.ShortName         nameShort
        , o.KVED              kvedCode
        , o.KVEDName          kvedDescr
        , a.adsName           address
        , CONCAT(cc.ccName,IFNULL(CONCAT(' (',cc.ccComment,')'),''))  phoneDialer
        , GROUP_CONCAT(distinct CONCAT(c.ccName,IFNULL(CONCAT(' (',c.ccComment,')'),'')) order by c.ccName asc separator '; ')  phones
        , e.ccName            email
        , UPPER(em.emName)    operator
        , o.orgNote           orgNote
        , IFNULL(v.Name, 'BASE')  Status
        , fs.ffName
        , cl.Created
        , cl.Comment          Comment
    FROM crmClient cl
      inner join fsFile fs on fs.ffID = cl.ffID
      inner join fsBase b on b.dbID = fs.dbID
      inner join crmClientEx ex on ex.clID = cl.clID
      inner join crmStatus s on s.clID = cl.clID
      left join usComment uss on uss.uID = cl.uID
      left join crmOrg o on o.clID = cl.clID
      left join usEnumValue v on v.tvID =  cl.ActualStatus
      left join crmContact cc on (cc.clID = cl.clID and cc.ccType = 36) # Телефон
      left join crmContact c on (c.clID = cl.clID and c.ccType = 44)    #Тел.Доп
      left join crmContact e on (e.clID = cl.clID and e.ccType = 37)    #Email
      left join crmAddress a on a.clID = cl.clID
      left join emEmploy em on em.emID = cl.ChangedBy
    where cl.ffID = $ffID AND cl.Aid = $Aid
    group by cl.clID
    order by cl.Changed;
  END IF;
END $$
DELIMITER ;
--
