DROP PROCEDURE IF EXISTS fs_GetFileSummary;
DELIMITER $$
CREATE PROCEDURE fs_GetFileSummary(
    $token            VARCHAR(100)
    , $ffID           int
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $counter        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_GetFileSummary');
  ELSE
    /*SELECT COUNT(cl.clID)
    INTO $counter
    FROM crmClient cl
    WHERE cl.ffID = $ffID AND cl.Aid = $Aid;
    --
    if($counter > 0)THEN*/
      #Кол-во клиентов
      SELECT
        1001              FilterID
        , 'Клиентов'      Name
        , COUNT(cl.clID)  Qty
      FROM crmClient cl
      WHERE cl.ffID = $ffID AND cl.Aid = $Aid
      UNION ALL
      #Emails
      SELECT
        1002            FilterID
        , uev.Name        Name
        , COUNT(cc.ccID)  Qty
      FROM crmContact cc
             INNER JOIN usEnumValue uev ON uev.tvID = cc.ccType
      WHERE ffID = $ffID
        AND cc.Aid = $Aid AND uev.Aid = $Aid
      GROUP BY uev.Name
      UNION ALL
      # Не обзвоненные
      SELECT
        1003                  FilterID
        , cs.ccStatus
        , COUNT(cs.clID)
      FROM crmStatus cs
      WHERE cs.ffID = $ffID AND cs.clStatus != 103 AND cs.Aid = $Aid AND cs.clID>0
      GROUP BY cs.ccStatus
      UNION ALL
      # Прозвон
      SELECT
        1004                  FilterID
        , cs.clStatus
        , COUNT(cs.clID)
      FROM crmStatus cs
      WHERE cs.ffID = $ffID AND cs.Aid = $Aid AND cs.clID>0
      GROUP BY cs.clStatus
      UNION ALL
      #Хлам
      SELECT
        t.dctID               FilterID
        , t.dctName           FilterName
        , COUNT(d.dcID)       Qty
      FROM dcDoc d
             INNER JOIN dcType t ON t.dctID = d.dctID
      WHERE d.ffID = $ffID AND d.Aid = $Aid
      GROUP BY
        t.dctName
        , t.dctID;
    /*end if;*/
  END IF;
END $$
DELIMITER ;
--
