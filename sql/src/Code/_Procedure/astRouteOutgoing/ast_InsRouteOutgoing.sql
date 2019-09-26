DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsRouteOutgoing;
CREATE PROCEDURE ast_InsRouteOutgoing(
    $token                          VARCHAR(100)
    , $roID                         INT(11)
    , $roName                       VARCHAR(50)
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $category                     INT(11)
    ,	$prepend                      VARCHAR(50)
	  , $prefix                       VARCHAR(50)
    , $callerID                     VARCHAR(50)
    , $priority                     INT(11)
    , $coID                         INT(11)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsRouteOutgoing');
  ELSE
    if NULLIF(TRIM($roName), '') is NULL OR $roName IS NULL then
      call raise(77117, NULL);
    end if;
    --
    INSERT INTO ast_route_outgoing (
        HIID
        , roID
        , isActive
        , Aid
        , destination
        , destdata
        , destdata2
        , category
        , prepend
        , prefix
        , callerID
        , roName
        , priority
        , coID
    )
    VALUES
    (
      fn_GetStamp()
      , $roID
      , $isActive
      , $Aid
      , $destination
      , $destdata
      , $destdata2
      , $category
      , $prepend
      , $prefix
      , $callerID
      , $roName
      , $priority
      , IF($destination = 101409, (SELECT coID FROM ast_pools WHERE poolID = $destdata AND Aid = $Aid), NULL)
    );
  END IF;
END $$
DELIMITER ;
--
