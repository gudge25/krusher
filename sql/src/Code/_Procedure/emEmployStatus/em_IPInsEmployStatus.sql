DROP PROCEDURE IF EXISTS em_IPInsEmployStatus;
DELIMITER $$
CREATE PROCEDURE em_IPInsEmployStatus(
    $Aid                INT(11)
    , $emID             INT(11)
    , $onlineStatus     INT(11)
    , $isActive         BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $emsIDld        INT;
  DECLARE $Created        DATETIME;
  --
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_IPInsEmployStatus');
  ELSE
    SELECT emsID, Created
      INTO $emsIDld, $Created
    FROM emStatus
    WHERE emID = $emID 
      AND Aid = $Aid
      AND timeSpent IS NULL
    ORDER BY emsID DESC
    LIMIT 1;
    --
    IF($emsIDld IS NOT NULL)THEN
      UPDATE emStatus SET isCurrent = FALSE, timeSpent = UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP($Created) WHERE emsID = $emsIDld AND Aid = $Aid;
    END IF;
        insert emStatus (HIID
                        , Aid
                        , isActive
                        , emID
                        , onlineStatus
                        , isCurrent)
        values (fn_GetStamp()
               , $Aid
               , IFNULL($isActive, 0)
               , $emID
               , $onlineStatus
               , TRUE);
  END IF;
END $$
DELIMITER ;
--
