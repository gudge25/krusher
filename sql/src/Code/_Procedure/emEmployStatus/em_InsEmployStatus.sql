DROP PROCEDURE IF EXISTS em_InsEmployStatus;
DELIMITER $$
CREATE PROCEDURE em_InsEmployStatus(
    $token              VARCHAR(100)
    , $emsID            INT(11)
    , $emID             INT(11)
    , $onlineStatus     INT(11)
    , $timeSpent        INT(11)
    , $isActive         BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $emsIDld        INT;
  DECLARE $Created        DATETIME;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_InsEmployStatus');
  ELSE
    SELECT emsID, Created
      INTO $emsIDld, $Created
    FROM emStatus
    WHERE emID = $emID
    ORDER BY emsID DESC
    LIMIT 1;
    --
    insert emStatus (
        HIID
        , Aid
        , emsID
        , isActive
        , emID
        , onlineStatus
        , timeSpent
    )
    values (
        fn_GetStamp()
        , $Aid
        , $emsID
        , IFNULL($isActive, 0)
        , $emID
        , $onlineStatus
        , $timeSpent
    );
    --
    IF($emsID IS NOT NULL)THEN
      UPDATE emStatus SET timeSpent = UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP($Created) WHERE emsID = $emsID;
    END IF;
  END IF;
END $$
DELIMITER ;
--
