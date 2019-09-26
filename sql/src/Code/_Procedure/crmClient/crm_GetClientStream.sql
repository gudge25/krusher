DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetClientStream;
CREATE PROCEDURE crm_GetClientStream(
    $token        VARCHAR(100)
    , $emID       INT
)
BEGIN
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetClientStream');
  ELSE
    SELECT
       cl.dup_action              dup_action
      ,cl.clID                    clID
      ,cl.clName                  clName
      ,cl.Comment                 Comment
      ,cl.ffID                    ffID
      ,cl.IsActive                isActive
      ,cl.IsPerson                isPerson
      ,cl.ParentID                ParentID
      ,CONVERT(cl.uID,CHAR(20))   uID
      ,cl.Changed                Changed
      ,cl.ChangedBy                ChangedBy
      ,h.clName                   OLD_clName
      ,h.Comment                  OLD_Comment
      ,h.ffID                     OLD_ffID
      ,h.isActive                 OLD_isActive
      ,h.isPerson                 OLD_isPerson
      ,h.ParentID                 OLD_ParentID
    FROM
      (
        SELECT
           cl.dup_action
          ,cl.OLD_HIID
          ,cl.clID
          ,cl.clName
          ,cl.Comment
          ,cl.ffID
          ,cl.IsActive
          ,cl.IsPerson
          ,cl.ParentID
          ,CONVERT(cl.uID,CHAR(20))             uID
          ,IFNULL(cl.ChangedBy,cl.CreatedBy)     ChangedBy
          ,IFNULL(cl.Changed,cl.Created)     Changed
        FROM DUP_crmClient cl
        WHERE IFNULL(cl.ChangedBy, cl.CreatedBy) = $emID
          OR $emID is NULL AND cl.Aid = $Aid
        GROUP BY
           cl.clID
          ,cl.clName
          ,cl.Comment
          ,cl.ffID
          ,cl.IsActive
          ,cl.IsPerson
          ,cl.ParentID
          ,CONVERT(cl.uID,CHAR(20))
        ORDER BY cl.RowID DESC
        LIMIT 200
      ) cl
      LEFT OUTER JOIN DUP_crmClient h ON (h.HIID = cl.OLD_HIID AND h.clID = cl.clID);
  END IF;
END $$
DELIMITER ;
--
