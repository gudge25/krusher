DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelTimeGroupItems;
CREATE PROCEDURE ast_DelTimeGroupItems(
    $token          VARCHAR(100)
    , $tgiID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelTimeGroupItems');
  ELSE
    DELETE FROM ast_time_group_items
    WHERE tgiID = $tgiID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
