DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsRouteIncoming;
CREATE PROCEDURE ast_InsRouteIncoming(
    $token                VARCHAR(100)
    , $rtID               INT(11)
    , $trID               INT(11)
    , $DID                VARCHAR(50)
    , $callerID           VARCHAR(50)
    , $exten              VARCHAR(500)
    , $context            VARCHAR(100)
    , $destination        INT(11)
    , $destdata           INT(11)
    , $destdata2          VARCHAR(100)
    , $stick_destination  INT(11)
    , $isCallback         BIT
    , $isFirstClient      BIT
    , $isActive           BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsRouteIncoming');
  ELSE
    if exists (
      select 1
      from ast_route_incoming
      where DID = $DID AND callerID = $callerID AND Aid = $Aid) then
      -- Такое уже есть
      call RAISE(77112, NULL);
    end if;
    --
    if NULLIF(TRIM($DID), '') is NULL then
      call raise(77117, NULL);
    end if;
    --
    INSERT INTO ast_route_incoming (
      rtID
      , Aid
      , trID
      , DID
      , callerID
      , exten
      , isActive
      , `context`
      , destination
      , destdata
      , destdata2
      , HIID
      , isCallback
      , isFirstClient
      , stick_destination
    )
    VALUES (
      $rtID
      , $Aid
      , $trID
      , $DID
      , $callerID
      , $exten
      , $isActive
      , $context
      , $destination
      , $destdata
      , $destdata2
      , fn_GetStamp()
      , IF($isCallback = TRUE, 1, 0)
      , IF($isFirstClient = TRUE, 1, 0)
      , $stick_destination
    );
  END IF;
END $$
DELIMITER ;
--
