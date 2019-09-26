DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelRouteOutgoing;
CREATE PROCEDURE ast_DelRouteOutgoing(
    $token          VARCHAR(100)
    , $roID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelRouteOutgoing');
  ELSE
    DELETE FROM ast_route_outgoing_items
    WHERE roID = $roID AND Aid = $Aid;
    --
    DELETE FROM ast_route_outgoing
    WHERE roID = $roID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
