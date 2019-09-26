DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelRouteOutgoingItems;
CREATE PROCEDURE ast_DelRouteOutgoingItems(
    $token          VARCHAR(100)
    , $roiID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelRouteOutgoingItems');
  ELSE
    DELETE FROM ast_route_outgoing_items
    WHERE roiID = $roiID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
