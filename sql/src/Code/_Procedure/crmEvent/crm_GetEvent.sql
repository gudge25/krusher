DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetEvent;
CREATE PROCEDURE crm_GetEvent(
  $dcID INT
) BEGIN
  /*--
  IF ($dcID is NULL) THEN
    -- Параметр "ID записи" должен иметь значение
    CALL RAISE(77021,NULL);
  END IF;
  --
  SELECT
     s.HIID                   HIID
    ,d.dcID                   dcID
    ,d.dcNo                   dcNo
    ,d.dcDate                 dcDate
    ,d.dcComment              dcComment
    ,d.dcStatus               dcStatus
    ,d.clID                   clID
    ,cl.clName                clName
    ,d.emID                   emID
    ,CONVERT(d.uID,CHAR(20))  uID
    ,d.dcLink                 dcLink
    ,t.dctName                dcLinkType
    ,l.dcDate                 dcLinkDate
    ,l.dcNo                   dcLinkNo
    ,d.Created              Created
    ,d.CreatedBy              CreatedBy
    ,d.Changed                Changed
    ,d.ChangedBy               ChangedBy
    ,s.metaID                 metaID
    ,s.title                  title
    ,s.endsAt                 endsAt
    ,s.location               location
    ,s.repeats                repeats
    ,s.isClosed               isClose
  FROM crmEvent s
    INNER JOIN dcDoc d ON d.dcID = s.dcID
    INNER JOIN crmClient cl ON d.clID = cl.clID
    LEFT OUTER JOIN dcDoc l ON l.dcID = d.dcLink
    LEFT OUTER JOIN dcType t ON t.dctID = l.dctID
  WHERE d.dcID = $dcID
    AND d.dctID = 9;*/
END $$
DELIMITER ;
--
