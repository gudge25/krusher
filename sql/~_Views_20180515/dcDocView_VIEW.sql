DROP VIEW IF EXISTS dcDocView;
CREATE VIEW dcDocView AS
  select
     d.HIID         as HIID
    ,d.dcID         as dcID
    ,d.dctID        as dctID
    ,d.dcNo         as dcNo
    ,d.dcDate       as dcDate
    ,d.dcLink       as dcLink
    ,d.dcComment    as dcComment
    ,d.dcSum        as dcSum
    ,d.dcStatus     as dcStatus
    ,v.Name         as dcStatusName
    ,d.clID         as clID
    ,cl.clName      as clName
    ,d.emID         as emID
    ,em.emName      as emName
    ,d.CreatedAt    as CreatedAt
    ,d.CreatedBy    as CreatedBy
    ,c.emName       as CreatedName
    ,d.EditedAt     as EditedAt
    ,d.EditedBy     as EditedBy
    ,e.emName       as EditedName
  from dcDoc d
    inner join crmClient cl on cl.clID = d.clID
    inner join emEmploy em on em.emID = d.emID
    inner join emEmploy c on d.CreatedBy = c.emID
    left outer join emEmploy e on d.EditedBy = e.emID
    left outer join usEnumValue v on v.tvID = d.dcStatus;
--
