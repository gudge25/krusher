DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelRouteIncoming;
CREATE PROCEDURE ast_DelRouteIncoming(
    $token        VARCHAR(100)
    , $rtID       INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelRouteIncoming');
  ELSE
    DELETE FROM ast_route_incoming
    WHERE rtID = $rtID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
