DROP PROCEDURE IF EXISTS dc_GetDocStream;
DELIMITER $$
CREATE PROCEDURE dc_GetDocStream(
    $token          VARCHAR(100)
    , $emID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SELECT NULL;
  /*SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_GetDocStream');
  ELSE
    SELECT
       d.dup_action             dup_action
      ,d.dcID                   dcID
      ,d.dctID                  dctID
      ,t.dctName                dctName
      ,d.dcDate                 dcDate
      ,d.dcNo                   dcNo
      ,d.dcSum                  dcSum
      ,d.dcStatus               dcStatus
      ,e.Name                   dcStatusName
      ,d.emID                   emID
      ,em.emName                emName
      ,cl.clID                  clID
      ,CONVERT(d.uID,CHAR(20))  uID
      ,cl.clName                clName
      ,d.EditedAt               EditedAt
      ,d.EditedBy               EditedBy
      ,h.dcNo                   OLD_dcNo
      ,h.dcDate                 OLD_dcDate
      ,h.dcSum                  OLD_dcSum
      ,h.dcStatus               OLD_dcStatus
      ,h.emID                   OLD_emID
      ,h.clID                   OLD_clID
    FROM
      (
        SELECT
           d.RowID                                              RowID
          ,d.dup_action                                         dup_action
          ,d.OLD_HIID                                           OLD_HIID
          ,d.dcID                                               dcID
          ,d.dctID                                              dctID
          ,d.dcDate                                             dcDate
          ,d.dcNo                                               dcNo
          ,d.dcSum                                              dcSum
          ,d.dcStatus                                           dcStatus
          ,d.emID                                               emID
          ,CONVERT(d.uID,CHAR(20))                              uID
          ,d.clID                                               clID
          ,IF(d.EditedAt is NOT NULL, d.EditedAt, d.Created)  Created
          ,IF(d.EditedBy is NOT NULL, d.Editedby, d.CreatedBy)  EditedBy
        FROM DUP_dcDoc d
        WHERE d.dctID != 1
          AND (IFNULL(d.EditedBy,d.CreatedBy) = $emID OR $emID is NULL) AND d.Aid = $Aid
        GROUP BY
           d.dcID
          ,d.dctID
          ,d.dcNo
          ,d.dcSum
          ,d.dcStatus
          ,d.emID
          ,d.clID
          ,CONVERT(d.uID,CHAR(20))
          ,if(dup_action = 'D', dup_action, 1)
        ORDER BY d.RowID DESC
        LIMIT 200
      ) d
      INNER JOIN dcType t ON t.dctID = d.dctID
      INNER JOIN emEmploy em ON em.emID = d.emID
      INNER JOIN crmClient cl ON cl.clID = d.clID
      LEFT OUTER JOIN usEnumValue e ON e.tvID = d.dcStatus
      LEFT OUTER JOIN DUP_dcDoc h ON (h.HIID = d.OLD_HIID AND h.dcID = d.dcID)
      WHERE  em.Aid = $Aid
      ORDER BY d.RowID DESC;
  END IF;*/
END $$
DELIMITER ;
--
